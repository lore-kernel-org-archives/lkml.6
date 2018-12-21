Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D373C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EDC218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390285AbeLUMIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:08:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:34218 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388320AbeLUMIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:08:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 04:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; 
   d="scan'208";a="131862529"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2018 04:08:16 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] perf session: Add comment for perf_session__register_idle_thread()
Date:   Fri, 21 Dec 2018 14:06:20 +0200
Message-Id: <20181221120620.9659-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221120620.9659-1-adrian.hunter@intel.com>
References: <20181221120620.9659-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment to perf_session__register_idle_thread() to bring attention to
a pitfall with the idle task thread structure. The pitfall is that there
should really be a 'struct thread' for the idle task of each cpu, but there
is only one that can have pid == tid == 0.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
-- 
2.17.1

