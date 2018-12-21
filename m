Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC52C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47159218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbeLUMIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:08:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:34195 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390242AbeLUMIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:08:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 04:08:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; 
   d="scan'208";a="131862498"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2018 04:08:09 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] perf thread-stack: Allow for a thread stack array
Date:   Fri, 21 Dec 2018 14:06:16 +0200
Message-Id: <20181221120620.9659-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221120620.9659-1-adrian.hunter@intel.com>
References: <20181221120620.9659-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for fixing thread stack processing for the idle task,
allow for a thread stack array.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 40 +++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index e13127755293..e59f6fa4c67d 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -60,6 +60,7 @@ struct thread_stack_entry {
  * @last_time: last timestamp
  * @crp: call/return processor
  * @comm: current comm
+ * @arr_sz: size of array if this is the first element of an array
  */
 struct thread_stack {
 	struct thread_stack_entry *stack;
@@ -71,6 +72,7 @@ struct thread_stack {
 	u64 last_time;
 	struct call_return_processor *crp;
 	struct comm *comm;
+	unsigned int arr_sz;
 };
 
 static int thread_stack__grow(struct thread_stack *ts)
@@ -100,6 +102,8 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 	if (!ts)
 		return NULL;
 
+	ts->arr_sz = 1;
+
 	if (thread_stack__grow(ts)) {
 		free(ts);
 		return NULL;
@@ -234,11 +238,19 @@ static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
 int thread_stack__flush(struct thread *thread)
 {
 	struct thread_stack *ts = thread->ts;
+	unsigned int pos;
+	int err = 0;
 
-	if (ts)
-		return __thread_stack__flush(thread, ts);
+	if (ts) {
+		for (pos = 0; pos < ts->arr_sz; pos++) {
+			int ret = __thread_stack__flush(thread, ts + pos);
 
-	return 0;
+			if (ret)
+				err = ret;
+		}
+	}
+
+	return err;
 }
 
 int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
@@ -314,13 +326,29 @@ void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr)
 	}
 }
 
+static void __thread_stack__free(struct thread *thread, struct thread_stack *ts)
+{
+	__thread_stack__flush(thread, ts);
+	zfree(&ts->stack);
+}
+
+static void thread_stack__reset(struct thread *thread, struct thread_stack *ts)
+{
+	unsigned int arr_sz = ts->arr_sz;
+
+	__thread_stack__free(thread, ts);
+	memset(ts, 0, sizeof(*ts));
+	ts->arr_sz = arr_sz;
+}
+
 void thread_stack__free(struct thread *thread)
 {
 	struct thread_stack *ts = thread->ts;
+	unsigned int pos;
 
 	if (ts) {
-		__thread_stack__flush(thread, ts);
-		zfree(&ts->stack);
+		for (pos = 0; pos < ts->arr_sz; pos++)
+			__thread_stack__free(thread, ts + pos);
 		zfree(&thread->ts);
 	}
 }
@@ -611,7 +639,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 
 	if (ts && !ts->crp) {
 		/* Supersede thread_stack__event() */
-		thread_stack__free(thread);
+		thread_stack__reset(thread, ts);
 		ts = NULL;
 	}
 
-- 
2.17.1

