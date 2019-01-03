Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B097FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8551F21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfACN0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:26:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbfACN0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:26:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DQR6D1387436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:26:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DQRQh1387433;
        Thu, 3 Jan 2019 05:26:27 -0800
Date:   Thu, 3 Jan 2019 05:26:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b25756df5b28cd7b6e91200fc5012e7c76e8ec69@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        jolsa@kernel.org, acme@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20181221120620.9659-9-adrian.hunter@intel.com>
References: <20181221120620.9659-9-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf session: Add comment for
 perf_session__register_idle_thread()
Git-Commit-ID: b25756df5b28cd7b6e91200fc5012e7c76e8ec69
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

Commit-ID:  b25756df5b28cd7b6e91200fc5012e7c76e8ec69
Gitweb:     https://git.kernel.org/tip/b25756df5b28cd7b6e91200fc5012e7c76e8ec69
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 21 Dec 2018 14:06:20 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 2 Jan 2019 11:05:06 -0300

perf session: Add comment for perf_session__register_idle_thread()

Add a comment to perf_session__register_idle_thread() to bring attention to
a pitfall with the idle task thread structure. The pitfall is that there
should really be a 'struct thread' for the idle task of each cpu, but there
is only one that can have pid == tid == 0.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 78a067777144..5456c84c7dd1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1527,6 +1527,13 @@ struct thread *perf_session__findnew(struct perf_session *session, pid_t pid)
 	return machine__findnew_thread(&session->machines.host, -1, pid);
 }
 
+/*
+ * Threads are identified by pid and tid, and the idle task has pid == tid == 0.
+ * So here a single thread is created for that, but actually there is a separate
+ * idle task per cpu, so there should be one 'struct thread' per cpu, but there
+ * is only 1. That causes problems for some tools, requiring workarounds. For
+ * example get_idle_thread() in builtin-sched.c, or thread_stack__per_cpu().
+ */
 int perf_session__register_idle_thread(struct perf_session *session)
 {
 	struct thread *thread;
