Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC652222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404691AbfBNLPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:15:46 -0500
Received: from 61-228-47-100.dynamic-ip.hinet.net ([61.228.47.100]:48278 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731242AbfBNLPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:15:46 -0500
X-Greylist: delayed 1109 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Feb 2019 06:15:46 EST
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id 16FBAC05C4;
        Thu, 14 Feb 2019 19:15:45 +0800 (CST)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org
Subject: [PATCH v3] PM / suspend: measure the time of filesystem syncing
Date:   Thu, 14 Feb 2019 19:15:43 +0800
Message-Id: <20190214111543.22137-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190206154214.576-1-harry.pan@intel.com>
References: <20190206154214.576-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gives the reader an intuitive metric of the time cost by
the kernel issuing a filesystem sync during suspend; although developer
can guess by the timestamp of next log or enable the ftrace power event
for manual calculation, this manner is easier to read and benefits the
automatic script.

v2: simplify the variables, apply the simplest form of ktime API.
v3: reduce conditional compilation, rectify profiling in better syntax

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 kernel/power/suspend.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..4844fc6a796d 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -568,13 +568,20 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
-#ifndef CONFIG_SUSPEND_SKIP_SYNC
-	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-	pr_info("Syncing filesystems ... ");
-	ksys_sync();
-	pr_cont("done.\n");
-	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
-#endif
+	if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
+		ktime_t start;
+		unsigned int elapsed_msecs;
+
+		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
+		pr_info("Syncing filesystems ... ");
+		start = ktime_get();
+		ksys_sync();
+		elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
+		pr_cont("(elapsed %d.%03d seconds) done.\n",
+			elapsed_msecs / MSEC_PER_SEC,
+			elapsed_msecs % MSEC_PER_SEC);
+		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
 	pm_suspend_clear_flags();
-- 
2.18.1

