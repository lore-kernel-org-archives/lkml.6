Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F36AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CA32070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfACNXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:23:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58915 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfACNXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:23:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DN0iB1385391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:23:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DN0Hn1385388;
        Thu, 3 Jan 2019 05:23:00 -0800
Date:   Thu, 3 Jan 2019 05:23:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-e0b8951190c11797971864c845e0909561525621@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, tglx@linutronix.de,
        adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          adrian.hunter@intel.com, tglx@linutronix.de, jolsa@kernel.org,
          acme@redhat.com
In-Reply-To: <20181221120620.9659-3-adrian.hunter@intel.com>
References: <20181221120620.9659-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf thread-stack: Tidy thread_stack__bottom()
 usage
Git-Commit-ID: e0b8951190c11797971864c845e0909561525621
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

Commit-ID:  e0b8951190c11797971864c845e0909561525621
Gitweb:     https://git.kernel.org/tip/e0b8951190c11797971864c845e0909561525621
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 21 Dec 2018 14:06:14 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 2 Jan 2019 10:45:26 -0300

perf thread-stack: Tidy thread_stack__bottom() usage

In preparation for fixing thread stack processing for the idle task,
tidy thread_stack__bottom() usage. Specifically, the parameter 'thread'
is not needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 115dc4b27a1b..068c7c8db4be 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -449,7 +449,7 @@ static int thread_stack__pop_cp(struct thread *thread, struct thread_stack *ts,
 	return 1;
 }
 
-static int thread_stack__bottom(struct thread *thread, struct thread_stack *ts,
+static int thread_stack__bottom(struct thread_stack *ts,
 				struct perf_sample *sample,
 				struct addr_location *from_al,
 				struct addr_location *to_al, u64 ref)
@@ -474,7 +474,7 @@ static int thread_stack__bottom(struct thread *thread, struct thread_stack *ts,
 	if (!cp)
 		return -ENOMEM;
 
-	return thread_stack__push_cp(thread->ts, ip, sample->time, ref, cp,
+	return thread_stack__push_cp(ts, ip, sample->time, ref, cp,
 				     true, false);
 }
 
@@ -617,8 +617,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 
 	/* If the stack is empty, put the current symbol on the stack */
 	if (!ts->cnt) {
-		err = thread_stack__bottom(thread, ts, sample, from_al, to_al,
-					   ref);
+		err = thread_stack__bottom(ts, sample, from_al, to_al, ref);
 		if (err)
 			return err;
 	}
