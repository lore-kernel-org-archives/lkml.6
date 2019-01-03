Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B62AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1298B2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfACNWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:22:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53095 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfACNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:22:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DMO1T1385341
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:22:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DMOiv1385338;
        Thu, 3 Jan 2019 05:22:24 -0800
Date:   Thu, 3 Jan 2019 05:22:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-03b32cb2810814756095dbd91fce0c77617d096b@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, acme@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20181221120620.9659-2-adrian.hunter@intel.com>
References: <20181221120620.9659-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf thread-stack: Simplify some code in
 thread_stack__process()
Git-Commit-ID: 03b32cb2810814756095dbd91fce0c77617d096b
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

Commit-ID:  03b32cb2810814756095dbd91fce0c77617d096b
Gitweb:     https://git.kernel.org/tip/03b32cb2810814756095dbd91fce0c77617d096b
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 21 Dec 2018 14:06:13 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 2 Jan 2019 10:42:45 -0300

perf thread-stack: Simplify some code in thread_stack__process()

In preparation for fixing thread stack processing for the idle task,
simplify some code in thread_stack__process().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 61a4286a74dc..115dc4b27a1b 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -593,17 +593,13 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	struct thread_stack *ts = thread->ts;
 	int err = 0;
 
-	if (ts) {
-		if (!ts->crp) {
-			/* Supersede thread_stack__event() */
-			thread_stack__free(thread);
-			thread->ts = thread_stack__new(thread, crp);
-			if (!thread->ts)
-				return -ENOMEM;
-			ts = thread->ts;
-			ts->comm = comm;
-		}
-	} else {
+	if (ts && !ts->crp) {
+		/* Supersede thread_stack__event() */
+		thread_stack__free(thread);
+		ts = NULL;
+	}
+
+	if (!ts) {
 		thread->ts = thread_stack__new(thread, crp);
 		if (!thread->ts)
 			return -ENOMEM;
