Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D04FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0412175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfBFPmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:42:18 -0500
Received: from 36-231-43-191.dynamic-ip.hinet.net ([36.231.43.191]:57372 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727082AbfBFPmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:42:18 -0500
X-Greylist: delayed 3555 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 10:42:17 EST
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id 9B915C0559;
        Wed,  6 Feb 2019 23:42:16 +0800 (CST)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] PM / suspend: measure the time of filesystem syncing
Date:   Wed,  6 Feb 2019 23:42:14 +0800
Message-Id: <20190206154214.576-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190203052007.27392-1-harry.pan@intel.com>
References: <20190203052007.27392-1-harry.pan@intel.com>
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

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 kernel/power/suspend.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..87c0073f0c9d 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -550,6 +550,8 @@ static void suspend_finish(void)
 static int enter_state(suspend_state_t state)
 {
 	int error;
+	ktime_t start;
+	unsigned int elapsed_msecs;
 
 	trace_suspend_resume(TPS("suspend_enter"), state, true);
 	if (state == PM_SUSPEND_TO_IDLE) {
@@ -570,9 +572,12 @@ static int enter_state(suspend_state_t state)
 
 #ifndef CONFIG_SUSPEND_SKIP_SYNC
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
+	start = ktime_get();
 	pr_info("Syncing filesystems ... ");
 	ksys_sync();
-	pr_cont("done.\n");
+	elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
+	pr_cont("(elapsed %d.%03d seconds) done.\n", elapsed_msecs / 1000,
+		elapsed_msecs % 1000);
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 #endif
 
-- 
2.18.1

