Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330DDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06059218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390297AbeLUMI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:08:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:34195 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390242AbeLUMIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:08:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 04:08:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; 
   d="scan'208";a="131862512"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2018 04:08:13 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] perf thread-stack: Allocate an array of thread stacks
Date:   Fri, 21 Dec 2018 14:06:18 +0200
Message-Id: <20181221120620.9659-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221120620.9659-1-adrian.hunter@intel.com>
References: <20181221120620.9659-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for fixing thread stack processing for the idle task,
allocate an array of thread stacks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 4340381d54c2..a896d89fe5f7 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -114,20 +114,26 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
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
+		if (thread->ts)
+			zfree(&thread->ts);
+		thread->ts = new_ts;
+		ts = new_ts;
 	}
 
-	thread->ts = ts;
+	if (!ts->stack &&
+	    thread_stack__init(ts, thread, crp))
+		return NULL;
 
 	return ts;
 }
-- 
2.17.1

