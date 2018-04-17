Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49CjyPAb8UMIKWIRYu1c0k6SGFRLrsIwqzfbBLrdwn6IybY2RkeSnrkIS/DQTXNdIc1fBCX
ARC-Seal: i=1; a=rsa-sha256; t=1523980840; cv=none;
        d=google.com; s=arc-20160816;
        b=uxhimOAvJlGGSX4hBfuWxOtb67+YmZYihVF2hT2QbDVEur4cSJIX0iqZ4W0WDylORC
         YrycI7qn7QZdwWw2UqfAsCCjWuRBv5LE3jBhDdXao9S+hXvB6JWqOitKex8fVZ+U2HjO
         p6OvyReqZIc9grus14XYJ7scCc2vsmwrb20tpJoj6un6iMTHNLJDSKoVNLUmMfJW5tE9
         f3izED082GE4zVtsA5CjX95Yu4kJGWIF8e2g+MiPmtZzmzGkqwpr9X+lBPbVM2+QwZqK
         +T+ksFbAYZrBGeRGYrbiAE1YvU8FAb9RX7pkOTPwOiJB13U7DZorqzF5tTfg6es4bt1R
         Gp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MXZH1Z7gKeh1lY3PrFt+OztBSydpuZwkqPEWRBsn1bA=;
        b=0vh/ISY7mTxlVs8Q0GohpuU0lAjwBkrj197Tk/qfxXsZ/O8wFzj2tGPTU3ib2LQopC
         5U71q1xzBOs+K6JyFCQvWJU7W1BBea1rRn1Ixomq/okzZEZ8gQzRHUn1e/FED0jS41d5
         aaJAAYNMGsQG3VboxIDTD2R38QxsvLVY/n7XlrgGf10ZGS1DmDl21YpUSl12q1AVz0Ec
         cbylAlzdAFp0D8bjLMmT1lbP/OgOBBulqjf5RTFhnOxOIdaIWcpAQMHG+KB6e4tIMTJp
         jpUSbPe0zxolwc9GpUABaoXnCT/hHIFI45A2F9+d+kVmTs6Cv9b1o/kE9Pmw7LZx7DRr
         82+A==
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
Subject: [PATCH 4.16 23/68] perf intel-pt: Fix sync_switch
Date: Tue, 17 Apr 2018 17:57:36 +0200
Message-Id: <20180417155750.286806154@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009733898369925?=
X-GMAIL-MSGID: =?utf-8?q?1598009733898369925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -143,6 +143,7 @@ struct intel_pt_queue {
 	bool stop;
 	bool step_through_buffers;
 	bool use_buffer_pid_tid;
+	bool sync_switch;
 	pid_t pid, tid;
 	int cpu;
 	int switch_state;
@@ -963,10 +964,12 @@ static int intel_pt_setup_queue(struct i
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
@@ -1549,7 +1552,7 @@ static int intel_pt_sample(struct intel_
 	if (pt->synth_opts.last_branch)
 		intel_pt_update_last_branch_rb(ptq);
 
-	if (!pt->sync_switch)
+	if (!ptq->sync_switch)
 		return 0;
 
 	if (intel_pt_is_switch_ip(ptq, state->to_ip)) {
@@ -1630,6 +1633,21 @@ static u64 intel_pt_switch_ip(struct int
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
@@ -1646,7 +1664,7 @@ static int intel_pt_run_decoder(struct i
 			if (pt->switch_ip) {
 				intel_pt_log("switch_ip: %"PRIx64" ptss_ip: %"PRIx64"\n",
 					     pt->switch_ip, pt->ptss_ip);
-				pt->sync_switch = true;
+				intel_pt_enable_sync_switch(pt);
 			}
 		}
 	}
@@ -1662,9 +1680,9 @@ static int intel_pt_run_decoder(struct i
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
@@ -1690,7 +1708,7 @@ static int intel_pt_run_decoder(struct i
 				     state->timestamp, state->est_timestamp);
 			ptq->timestamp = state->est_timestamp;
 		/* Use estimated TSC in unknown switch state */
-		} else if (pt->sync_switch &&
+		} else if (ptq->sync_switch &&
 			   ptq->switch_state == INTEL_PT_SS_UNKNOWN &&
 			   intel_pt_is_switch_ip(ptq, state->to_ip) &&
 			   ptq->next_tid == -1) {
@@ -1837,7 +1855,7 @@ static int intel_pt_sync_switch(struct i
 		return 1;
 
 	ptq = intel_pt_cpu_to_ptq(pt, cpu);
-	if (!ptq)
+	if (!ptq || !ptq->sync_switch)
 		return 1;
 
 	switch (ptq->switch_state) {
