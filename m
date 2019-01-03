Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC90C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EDA2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfACNYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:24:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38815 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbfACNYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:24:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DOA1s1387240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:24:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DOApI1387237;
        Thu, 3 Jan 2019 05:24:10 -0800
Date:   Thu, 3 Jan 2019 05:24:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-f6060ac60190c625101a0b94c2d96e9ca14a7d73@git.kernel.org>
Cc:     acme@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          adrian.hunter@intel.com, acme@redhat.com
In-Reply-To: <20181221120620.9659-5-adrian.hunter@intel.com>
References: <20181221120620.9659-5-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf thread-stack: Allow for a thread stack array
Git-Commit-ID: f6060ac60190c625101a0b94c2d96e9ca14a7d73
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f6060ac60190c625101a0b94c2d96e9ca14a7d73
Gitweb:     https://git.kernel.org/tip/f6060ac60190c625101a0b94c2d96e9ca14a7d73
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 21 Dec 2018 14:06:16 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 2 Jan 2019 10:49:51 -0300

perf thread-stack: Allow for a thread stack array

In preparation for fixing thread stack processing for the idle task,
allow for a thread stack array.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index d93cd286b048..a5f7b9d8fc23 100644
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
 
