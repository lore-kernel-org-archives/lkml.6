Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C0C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EF22070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfACNZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:25:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbfACNZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:25:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DPJs11387360
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:25:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DPJGi1387357;
        Thu, 3 Jan 2019 05:25:19 -0800
Date:   Thu, 3 Jan 2019 05:25:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-139f42f3b3b495e61bb2cfef40e1dd5e845e3052@git.kernel.org>
Cc:     adrian.hunter@intel.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
          jolsa@kernel.org
In-Reply-To: <20181221120620.9659-7-adrian.hunter@intel.com>
References: <20181221120620.9659-7-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf thread-stack: Allocate an array of thread
 stacks
Git-Commit-ID: 139f42f3b3b495e61bb2cfef40e1dd5e845e3052
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

Commit-ID:  139f42f3b3b495e61bb2cfef40e1dd5e845e3052
Gitweb:     https://git.kernel.org/tip/139f42f3b3b495e61bb2cfef40e1dd5e845e3052
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 21 Dec 2018 14:06:18 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 2 Jan 2019 10:55:55 -0300

perf thread-stack: Allocate an array of thread stacks

In preparation for fixing thread stack processing for the idle task,
allocate an array of thread stacks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-7-adrian.hunter@intel.com
[ No need to check for NULL when calling zfree(), noticed by Jiri Olsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 03770af9e5cd..248ed3945bec 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -114,20 +114,25 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 static struct thread_stack *thread_stack__new(struct thread *thread,
 					      struct call_return_processor *crp)
 {
-	struct thread_stack *ts;
-
-	ts = zalloc(sizeof(struct thread_stack));
-	if (!ts)
-		return NULL;
-
-	ts->arr_sz = 1;
-
-	if (thread_stack__init(ts, thread, crp)) {
-		free(ts);
-		return NULL;
+	struct thread_stack *ts = thread->ts, *new_ts;
+	unsigned int old_sz = ts ? ts->arr_sz : 0;
+	unsigned int new_sz = 1;
+
+	if (!ts || new_sz > old_sz) {
+		new_ts = calloc(new_sz, sizeof(*ts));
+		if (!new_ts)
+			return NULL;
+		if (ts)
+			memcpy(new_ts, ts, old_sz * sizeof(*ts));
+		new_ts->arr_sz = new_sz;
+		zfree(&thread->ts);
+		thread->ts = new_ts;
+		ts = new_ts;
 	}
 
-	thread->ts = ts;
+	if (!ts->stack &&
+	    thread_stack__init(ts, thread, crp))
+		return NULL;
 
 	return ts;
 }
