Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E49B2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbeLUMIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:08:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:34195 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390081AbeLUMII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:08:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 04:08:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; 
   d="scan'208";a="131862478"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2018 04:08:06 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] perf thread-stack: Tidy thread_stack__bottom() usage
Date:   Fri, 21 Dec 2018 14:06:14 +0200
Message-Id: <20181221120620.9659-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221120620.9659-1-adrian.hunter@intel.com>
References: <20181221120620.9659-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for fixing thread stack processing for the idle task,
tidy thread_stack__bottom() usage. Specifically, the parameter 'thread' is
not needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
-- 
2.17.1

