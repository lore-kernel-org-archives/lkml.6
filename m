Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeCIItt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:49:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbeCIIts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:49:48 -0500
Date: Fri, 9 Mar 2018 00:49:41 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1c071c80d9661c263b043969fd92305037bf9773@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org, jolsa@redhat.com,
        acme@redhat.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, adrian.hunter@intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        jolsa@redhat.com
In-Reply-To: <1520431349-30689-7-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-7-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Get rid of
 intel_pt_use_buffer_pid_tid()
Git-Commit-ID: 1c071c80d9661c263b043969fd92305037bf9773
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1c071c80d9661c263b043969fd92305037bf9773
Gitweb:     https://git.kernel.org/tip/1c071c80d9661c263b043969fd92305037bf9773
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 7 Mar 2018 16:02:26 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:57 -0300

perf intel-pt: Get rid of intel_pt_use_buffer_pid_tid()

With the new way sampling support will be implemented,
intel_pt_use_buffer_pid_tid() will not be needed. Get rid of it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520431349-30689-7-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
@@ -311,10 +285,6 @@ next:
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
