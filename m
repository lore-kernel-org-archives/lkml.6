Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+oJ6QJ8dAOmpyafM5PWFVxAS6/mOOCdHfrjGGZp2wS25L/Kz2PURx9NDkM3ZdCkk9TFeHe
ARC-Seal: i=1; a=rsa-sha256; t=1523981353; cv=none;
        d=google.com; s=arc-20160816;
        b=0w1GHBOBVxgtJoxXDNMNLDsRgYMpdoWMGqllASIppumUsP4VX9Hta2HNcwT2Ud5jXM
         o5K7Jdmg6+y7hLgjTsGwU+d0OGRqT/1QUZ/7h3H9dk1GwN5M/nafitymRhXHus9Ul7lF
         k4RlC1DGY7xb8UTCi6DrD8T7HSwOhKPKGDruiHPsAbwTV+TPllssDdoxf/kiOshR4P7k
         CrXyop4F9A+GF7lR6QUq6tfo+RgpVjvEUuX1snWwY4cng1G230MTxqg0iXvCjfpfGILC
         uEpzKIfc/oBTE779ksbQ+VHqcRIvjAk7LKItspxHcKoPvLmVI3LSciw1ex9SPyLIViGd
         oxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=edKyC8vMlYA67lnxUmhCGXtnsvN0KGkOJbJkNAAfiFI=;
        b=PjzhWtjygd6a9WA4ZMCq4PJh//gyNBamS5xYNcsA/YPPFDwS0g/pPWnPZLreFwD/NO
         0EOvpCjHJFMgbpifDKBRFUdERJKJMjKVXKqMZRKKGxZZGrNqlr40EIHnNIEpW2PJI+U4
         fPWOObo2cghkjk3fhU/CtnUV16T+acroI1YyEUCZFKHt3BBC+YIuocT4w839J3R9iLR0
         egCN5ni7ys+TL17+yIMRHmjN9kk3sda3Sof4nTTuEnGXNwL//KdcI4oDfQUzOWtipJhr
         k0aDujPa5Wiebjb9MYsmwnqVqE1oq6i86cxbI9lPcyxBRsbl9FTT/LgxBLIhkx376I7p
         hDWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 05/66] perf intel-pt: Fix sync_switch
Date: Tue, 17 Apr 2018 17:58:38 +0200
Message-Id: <20180417155646.082034660@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009733898369925?=
X-GMAIL-MSGID: =?utf-8?q?1598010271516366520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 63d8e38f6ae6c36dd5b5ba0e8c112e8861532ea2 upstream.

sync_switch is a facility to synchronize decoding more closely with the
point in the kernel when the context actually switched.

The flag when sync_switch is enabled was global to the decoding, whereas
it is really specific to the CPU.

The trace data for different CPUs is put on different queues, so add
sync_switch to the intel_pt_queue structure and use that in preference
to the global setting in the intel_pt structure.

That fixes problems decoding one CPU's trace because sync_switch was
disabled on a different CPU's queue.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt.c |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -131,6 +131,7 @@ struct intel_pt_queue {
 	bool stop;
 	bool step_through_buffers;
 	bool use_buffer_pid_tid;
+	bool sync_switch;
 	pid_t pid, tid;
 	int cpu;
 	int switch_state;
@@ -931,10 +932,12 @@ static int intel_pt_setup_queue(struct i
 			if (pt->timeless_decoding || !pt->have_sched_switch)
 				ptq->use_buffer_pid_tid = true;
 		}
+
+		ptq->sync_switch = pt->sync_switch;
 	}
 
 	if (!ptq->on_heap &&
-	    (!pt->sync_switch ||
+	    (!ptq->sync_switch ||
 	     ptq->switch_state != INTEL_PT_SS_EXPECTING_SWITCH_EVENT)) {
 		const struct intel_pt_state *state;
 		int ret;
@@ -1336,7 +1339,7 @@ static int intel_pt_sample(struct intel_
 	if (pt->synth_opts.last_branch)
 		intel_pt_update_last_branch_rb(ptq);
 
-	if (!pt->sync_switch)
+	if (!ptq->sync_switch)
 		return 0;
 
 	if (intel_pt_is_switch_ip(ptq, state->to_ip)) {
@@ -1417,6 +1420,21 @@ static u64 intel_pt_switch_ip(struct int
 	return switch_ip;
 }
 
+static void intel_pt_enable_sync_switch(struct intel_pt *pt)
+{
+	unsigned int i;
+
+	pt->sync_switch = true;
+
+	for (i = 0; i < pt->queues.nr_queues; i++) {
+		struct auxtrace_queue *queue = &pt->queues.queue_array[i];
+		struct intel_pt_queue *ptq = queue->priv;
+
+		if (ptq)
+			ptq->sync_switch = true;
+	}
+}
+
 static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 {
 	const struct intel_pt_state *state = ptq->state;
@@ -1433,7 +1451,7 @@ static int intel_pt_run_decoder(struct i
 			if (pt->switch_ip) {
 				intel_pt_log("switch_ip: %"PRIx64" ptss_ip: %"PRIx64"\n",
 					     pt->switch_ip, pt->ptss_ip);
-				pt->sync_switch = true;
+				intel_pt_enable_sync_switch(pt);
 			}
 		}
 	}
@@ -1449,9 +1467,9 @@ static int intel_pt_run_decoder(struct i
 		if (state->err) {
 			if (state->err == INTEL_PT_ERR_NODATA)
 				return 1;
-			if (pt->sync_switch &&
+			if (ptq->sync_switch &&
 			    state->from_ip >= pt->kernel_start) {
-				pt->sync_switch = false;
+				ptq->sync_switch = false;
 				intel_pt_next_tid(pt, ptq);
 			}
 			if (pt->synth_opts.errors) {
@@ -1477,7 +1495,7 @@ static int intel_pt_run_decoder(struct i
 				     state->timestamp, state->est_timestamp);
 			ptq->timestamp = state->est_timestamp;
 		/* Use estimated TSC in unknown switch state */
-		} else if (pt->sync_switch &&
+		} else if (ptq->sync_switch &&
 			   ptq->switch_state == INTEL_PT_SS_UNKNOWN &&
 			   intel_pt_is_switch_ip(ptq, state->to_ip) &&
 			   ptq->next_tid == -1) {
@@ -1624,7 +1642,7 @@ static int intel_pt_sync_switch(struct i
 		return 1;
 
 	ptq = intel_pt_cpu_to_ptq(pt, cpu);
-	if (!ptq)
+	if (!ptq || !ptq->sync_switch)
 		return 1;
 
 	switch (ptq->switch_state) {
