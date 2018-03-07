Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeCGODd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:03:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:30695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933647AbeCGOD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:03:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="36206833"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] perf intel-pt: Get rid of intel_pt_use_buffer_pid_tid()
Date: Wed,  7 Mar 2018 16:02:26 +0200
Message-Id: <1520431349-30689-7-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new way sampling support will be implemented,
intel_pt_use_buffer_pid_tid() will not be needed. Get rid of it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 0979a6e8b2b7..cfb3614f5def 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -222,32 +222,6 @@ static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *
 	return 0;
 }
 
-static void intel_pt_use_buffer_pid_tid(struct intel_pt_queue *ptq,
-					struct auxtrace_queue *queue,
-					struct auxtrace_buffer *buffer)
-{
-	if (queue->cpu == -1 && buffer->cpu != -1)
-		ptq->cpu = buffer->cpu;
-
-	ptq->pid = buffer->pid;
-	ptq->tid = buffer->tid;
-
-	intel_pt_log("queue %u cpu %d pid %d tid %d\n",
-		     ptq->queue_nr, ptq->cpu, ptq->pid, ptq->tid);
-
-	thread__zput(ptq->thread);
-
-	if (ptq->tid != -1) {
-		if (ptq->pid != -1)
-			ptq->thread = machine__findnew_thread(ptq->pt->machine,
-							      ptq->pid,
-							      ptq->tid);
-		else
-			ptq->thread = machine__find_thread(ptq->pt->machine, -1,
-							   ptq->tid);
-	}
-}
-
 /* This function assumes data is processed sequentially only */
 static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 {
@@ -311,10 +285,6 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 		b->consecutive = true;
 	}
 
-	if (ptq->use_buffer_pid_tid && (ptq->pid != buffer->pid ||
-					ptq->tid != buffer->tid))
-		intel_pt_use_buffer_pid_tid(ptq, queue, buffer);
-
 	if (ptq->step_through_buffers)
 		ptq->stop = true;
 
@@ -958,12 +928,9 @@ static int intel_pt_setup_queue(struct intel_pt *pt,
 			ptq->cpu = queue->cpu;
 		ptq->tid = queue->tid;
 
-		if (pt->sampling_mode) {
-			if (pt->timeless_decoding)
-				ptq->step_through_buffers = true;
-			if (pt->timeless_decoding || !pt->have_sched_switch)
-				ptq->use_buffer_pid_tid = true;
-		}
+		if (pt->sampling_mode && !pt->snapshot_mode &&
+		    pt->timeless_decoding)
+			ptq->step_through_buffers = true;
 
 		ptq->sync_switch = pt->sync_switch;
 	}
-- 
1.9.1
