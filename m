Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC1C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 05:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A892083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 05:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfBCF3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 00:29:30 -0500
Received: from 61-228-33-44.dynamic-ip.hinet.net ([61.228.33.44]:49342 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbfBCF33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 00:29:29 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Feb 2019 00:29:28 EST
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id 070A1C0559;
        Sun,  3 Feb 2019 13:20:10 +0800 (CST)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org
Subject: [PATCH] PM / suspend: measure the time of filesystem syncing
Date:   Sun,  3 Feb 2019 13:20:07 +0800
Message-Id: <20190203052007.27392-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gives the reader an intuitive metric of the time cost by
the kernel issuing a filesystem sync during suspend; although developer
can guess by the timestamp of next log or enable the ftrace power event
for manual calculation, this manner is easier to read and benefits the
automatic script.

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 kernel/power/suspend.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..f3b7c64f2242 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -550,6 +550,8 @@ static void suspend_finish(void)
 static int enter_state(suspend_state_t state)
 {
 	int error;
+	ktime_t start, end, elapsed;
+	unsigned int elapsed_msecs;
 
 	trace_suspend_resume(TPS("suspend_enter"), state, true);
 	if (state == PM_SUSPEND_TO_IDLE) {
@@ -570,9 +572,14 @@ static int enter_state(suspend_state_t state)
 
 #ifndef CONFIG_SUSPEND_SKIP_SYNC
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
+	start = ktime_get_boottime();
 	pr_info("Syncing filesystems ... ");
 	ksys_sync();
-	pr_cont("done.\n");
+	end = ktime_get_boottime();
+	elapsed = ktime_sub(end, start);
+	elapsed_msecs = ktime_to_ms(elapsed);
+	pr_cont("(elapsed %d.%03d seconds) done.\n", elapsed_msecs / 1000,
+		elapsed_msecs % 1000);
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 #endif
 
-- 
2.18.1

