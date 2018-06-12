Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 88456C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487E420693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487E420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbeFLHwB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:52:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:47405 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933537AbeFLHv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:51:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 00:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="56615856"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2018 00:51:55 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 6/6] perf: Allow set-output for task contexts of different types
Date:   Tue, 12 Jun 2018 10:51:17 +0300
Message-Id: <20180612075117.65420-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Set-output must be limited to events that cannot be active on different
cpus at the same time.  Thus either the event cpu must be the same, or
the event task must be the same.  Current logic does not check the task
directly but checks whether the perf_event_context is the same, however
there are separate contexts for hardware and software events so in that
case the perf_event_context is different even though the task is the same.
This patch changes the logic to check the task directly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9bf5c7abb621..9ab9f21f58da 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9848,9 +9848,21 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 		goto out;
 
 	/*
-	 * If its not a per-cpu rb, it must be the same task.
+	 * If it's not a per-cpu rb, it must be the same task.
+	 *
+	 * Since output_event is a per-task event, ->ctx is stable
+	 * and should be around for as long as the file is around.
+	 *
+	 * The context switch optimization doesn't apply to output_event
+	 * as well, so we can look at its ctx->task, which will be either
+	 * a valid task or TASK_TOMBSTONE.
+	 *
+	 * The source event's task can also be TASK_TOMBSTONE, so look out
+	 * for that also.
 	 */
-	if (output_event->cpu == -1 && output_event->ctx != event->ctx)
+	if (output_event->cpu == -1 &&
+	    (output_event->ctx->task != event->ctx->task ||
+	     output_event->ctx->task == TASK_TOMBSTONE))
 		goto out;
 
 	/*
-- 
2.17.1

