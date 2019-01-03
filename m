Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AA2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41E32070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfACNYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:24:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40339 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbfACNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:24:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DOiT01387268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:24:44 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DOidq1387265;
        Thu, 3 Jan 2019 05:24:44 -0800
Date:   Thu, 3 Jan 2019 05:24:44 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-2e9e8688763ff80f032d9a78c3b4b951fb6dd7a4@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
          jolsa@kernel.org
In-Reply-To: <20181221120620.9659-6-adrian.hunter@intel.com>
References: <20181221120620.9659-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf thread-stack: Factor out
 thread_stack__init()
Git-Commit-ID: 2e9e8688763ff80f032d9a78c3b4b951fb6dd7a4
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

Commit-ID:  2e9e8688763ff80f032d9a78c3b4b951fb6dd7a4
Gitweb:     https://git.kernel.org/tip/2e9e8688763ff80f032d9a78c3b4b951fb6dd7a4
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 21 Dec 2018 14:06:17 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 2 Jan 2019 10:53:41 -0300

perf thread-stack: Factor out thread_stack__init()

In preparation for fixing thread stack processing for the idle task,
factor out thread_stack__init().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index a5f7b9d8fc23..03770af9e5cd 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -93,6 +93,24 @@ static int thread_stack__grow(struct thread_stack *ts)
 	return 0;
 }
 
+static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
+			      struct call_return_processor *crp)
+{
+	int err;
+
+	err = thread_stack__grow(ts);
+	if (err)
+		return err;
+
+	if (thread->mg && thread->mg->machine)
+		ts->kernel_start = machine__kernel_start(thread->mg->machine);
+	else
+		ts->kernel_start = 1ULL << 63;
+	ts->crp = crp;
+
+	return 0;
+}
+
 static struct thread_stack *thread_stack__new(struct thread *thread,
 					      struct call_return_processor *crp)
 {
@@ -104,17 +122,11 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 
 	ts->arr_sz = 1;
 
-	if (thread_stack__grow(ts)) {
+	if (thread_stack__init(ts, thread, crp)) {
 		free(ts);
 		return NULL;
 	}
 
-	if (thread->mg && thread->mg->machine)
-		ts->kernel_start = machine__kernel_start(thread->mg->machine);
-	else
-		ts->kernel_start = 1ULL << 63;
-	ts->crp = crp;
-
 	thread->ts = ts;
 
 	return ts;
