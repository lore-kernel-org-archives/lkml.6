Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48tGKBk+3FbIYdCiubfSrXEaSFbvS5WOczqbvChj2q1EvRvOx8zxwhj4TafISBOASqBoMYl
ARC-Seal: i=1; a=rsa-sha256; t=1523981163; cv=none;
        d=google.com; s=arc-20160816;
        b=F6dmvpcRYr2omBhXWIP0J8wL0ao088SMcsR9XL7sgXMRsOSBHzZP/Rwu5CrPI6H4Nc
         hvkaixLXWAfgXDrC4nisvU8FDCSboJjvAHkSnxC7j0LctPc7b0nSvCVXAk5CwhwEtwxL
         OzWYFtLBe6qrZvhkfeJIsN0vZkyNS5XfvVKO18igwO5abh5JSsk0Y5D7zF5q+o92kw0C
         DW6eb+ArLTSjVCkByR58SaO4mEwxhXPqpp1KS8ZA+oZgDA4y3u5isUcrCD59QtVIlGhv
         yoflmR/5mI9zxW2aWKDhgehk19ahmE/cDVWreHRXyF4P7FOi4X7t1ypJdFlZGBqlZEkC
         FDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BPVNjgrOyFr83eb5h+5ktHftGj/XgjhILFpiSEaWbQQ=;
        b=x0M+4C6rj7MfbWZAoPXRFsfQkIoVNSnNDjGuf8O4JlYQc1iMXJfBL5GtGMczgk+47M
         gjvLDquaA8hk2NRFxzKbYg5wg7a7rZN2ttztiyDlKoCg5WB09575XuYLR9D+aQBz8TGh
         vYZZumwBuZgCyyP5YYMHH6zjuklBNEO7zRkXcPGkYywbJ9pgXymOHM8vNqIRuvBlEYm3
         AvNpL9vL9Sc155iC1ZohStah4JEd/c/yiAhxMIH1BN97nIYBfcnaphp9CTZOJwfXC3bz
         rpAnG8RuT2kxcXCnu3Z6hAJ2h9FAGpcKo/tGeJY2sn+NSshHOg95892uK1NUPm696hcI
         xSRQ==
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
Subject: [PATCH 4.14 16/49] perf intel-pt: Fix sync_switch
Date: Tue, 17 Apr 2018 17:58:55 +0200
Message-Id: <20180417155715.793115075@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009733898369925?=
X-GMAIL-MSGID: =?utf-8?q?1598010072954373509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -145,6 +145,7 @@ struct intel_pt_queue {
 	bool stop;
 	bool step_through_buffers;
 	bool use_buffer_pid_tid;
+	bool sync_switch;
 	pid_t pid, tid;
 	int cpu;
 	int switch_state;
@@ -965,10 +966,12 @@ static int intel_pt_setup_queue(struct i
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
@@ -1552,7 +1555,7 @@ static int intel_pt_sample(struct intel_
 	if (pt->synth_opts.last_branch)
 		intel_pt_update_last_branch_rb(ptq);
 
-	if (!pt->sync_switch)
+	if (!ptq->sync_switch)
 		return 0;
 
 	if (intel_pt_is_switch_ip(ptq, state->to_ip)) {
@@ -1633,6 +1636,21 @@ static u64 intel_pt_switch_ip(struct int
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
@@ -1649,7 +1667,7 @@ static int intel_pt_run_decoder(struct i
 			if (pt->switch_ip) {
 				intel_pt_log("switch_ip: %"PRIx64" ptss_ip: %"PRIx64"\n",
 					     pt->switch_ip, pt->ptss_ip);
-				pt->sync_switch = true;
+				intel_pt_enable_sync_switch(pt);
 			}
 		}
 	}
@@ -1665,9 +1683,9 @@ static int intel_pt_run_decoder(struct i
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
@@ -1693,7 +1711,7 @@ static int intel_pt_run_decoder(struct i
 				     state->timestamp, state->est_timestamp);
 			ptq->timestamp = state->est_timestamp;
 		/* Use estimated TSC in unknown switch state */
-		} else if (pt->sync_switch &&
+		} else if (ptq->sync_switch &&
 			   ptq->switch_state == INTEL_PT_SS_UNKNOWN &&
 			   intel_pt_is_switch_ip(ptq, state->to_ip) &&
 			   ptq->next_tid == -1) {
@@ -1840,7 +1858,7 @@ static int intel_pt_sync_switch(struct i
 		return 1;
 
 	ptq = intel_pt_cpu_to_ptq(pt, cpu);
-	if (!ptq)
+	if (!ptq || !ptq->sync_switch)
 		return 1;
 
 	switch (ptq->switch_state) {
