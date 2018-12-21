Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FF4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8788E218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390272AbeLUMIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:08:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:34195 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390255AbeLUMIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:08:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 04:08:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; 
   d="scan'208";a="131862504"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2018 04:08:11 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] perf thread-stack: Factor out thread_stack__init()
Date:   Fri, 21 Dec 2018 14:06:17 +0200
Message-Id: <20181221120620.9659-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221120620.9659-1-adrian.hunter@intel.com>
References: <20181221120620.9659-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for fixing thread stack processing for the idle task,
factor out thread_stack__init().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index e59f6fa4c67d..4340381d54c2 100644
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
-- 
2.17.1

