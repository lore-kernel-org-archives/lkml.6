Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F35C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5CB2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zh2qj7wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5CB2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeKAIGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeKAIGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F4802084A;
        Wed, 31 Oct 2018 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027170;
        bh=h8ZgqYChEDLjxdtBXxa9iMcaCugKcEZUbEqxY+Wl6z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zh2qj7wx/wL9MpTL0qUkYn7uQsyrDBf5nDI7Wazscx5+vfGwqwUyAiwr1pJBKVGqY
         TeTtfmslqLIDZwHob5j5b014WiBdYm3EovA7jmA2QqVBngTQ4Uxodbp93QPBqkr9Dd
         lcghlGGuiKQdL/UQQJWRFPyDB4vsPPmCeR5HyzoI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Eyal Reizer <eyalr@ti.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 031/146] wlcore: Fix BUG with clear completion on timeout
Date:   Wed, 31 Oct 2018 19:03:46 -0400
Message-Id: <20181031230541.28822-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 4e651bad848955d88b29a568bfbfb4b831270e16 ]

We do not currently clear wl->elp_compl on ELP timeout and we have bogus
lingering pointer that wlcore_irq then will try to access after recovery
is done:

BUG: spinlock bad magic on CPU#1, irq/255-wl12xx/580
...
(spin_dump) from [<c01b9344>] (do_raw_spin_lock+0xc8/0x124)
(do_raw_spin_lock) from [<c09b3970>] (_raw_spin_lock_irqsave+0x68/0x74)
(_raw_spin_lock_irqsave) from [<c01a02f0>] (complete+0x24/0x58)
(complete) from [<bf572610>] (wlcore_irq+0x48/0x17c [wlcore])
(wlcore_irq [wlcore]) from [<c01c5efc>] (irq_thread_fn+0x2c/0x64)
(irq_thread_fn) from [<c01c623c>] (irq_thread+0x148/0x290)
(irq_thread) from [<c016b4b0>] (kthread+0x160/0x17c)
(kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
...

After that the system will hang. Let's fix this by adding a flag for
recovery and moving the recovery work call to to the error handling
section.

And we want to set WL1271_FLAG_INTENDED_FW_RECOVERY and actually clear
it too in wl1271_recovery_work() and just downgrade the error to a
warning to prevent overly verbose output.

Cc: Eyal Reizer <eyalr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 89b0d0fade9f..19e3c5a0b715 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -957,6 +957,8 @@ static void wl1271_recovery_work(struct work_struct *work)
 	BUG_ON(wl->conf.recovery.bug_on_recovery &&
 	       !test_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags));
 
+	clear_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags);
+
 	if (wl->conf.recovery.no_recovery) {
 		wl1271_info("No recovery (chosen on module load). Fw will remain stuck.");
 		goto out_unlock;
@@ -6710,6 +6712,7 @@ static int __maybe_unused wlcore_runtime_resume(struct device *dev)
 	int ret;
 	unsigned long start_time = jiffies;
 	bool pending = false;
+	bool recovery = false;
 
 	/* Nothing to do if no ELP mode requested */
 	if (!test_bit(WL1271_FLAG_IN_ELP, &wl->flags))
@@ -6726,7 +6729,7 @@ static int __maybe_unused wlcore_runtime_resume(struct device *dev)
 
 	ret = wlcore_raw_write32(wl, HW_ACCESS_ELP_CTRL_REG, ELPCTRL_WAKE_UP);
 	if (ret < 0) {
-		wl12xx_queue_recovery_work(wl);
+		recovery = true;
 		goto err;
 	}
 
@@ -6734,11 +6737,12 @@ static int __maybe_unused wlcore_runtime_resume(struct device *dev)
 		ret = wait_for_completion_timeout(&compl,
 			msecs_to_jiffies(WL1271_WAKEUP_TIMEOUT));
 		if (ret == 0) {
-			wl1271_error("ELP wakeup timeout!");
-			wl12xx_queue_recovery_work(wl);
+			wl1271_warning("ELP wakeup timeout!");
 
 			/* Return no error for runtime PM for recovery */
-			return 0;
+			ret = 0;
+			recovery = true;
+			goto err;
 		}
 	}
 
@@ -6753,6 +6757,12 @@ static int __maybe_unused wlcore_runtime_resume(struct device *dev)
 	spin_lock_irqsave(&wl->wl_lock, flags);
 	wl->elp_compl = NULL;
 	spin_unlock_irqrestore(&wl->wl_lock, flags);
+
+	if (recovery) {
+		set_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags);
+		wl12xx_queue_recovery_work(wl);
+	}
+
 	return ret;
 }
 
-- 
2.17.1

