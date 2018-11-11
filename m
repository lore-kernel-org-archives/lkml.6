Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CC4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5A72084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTcaZNoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5A72084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbeKLKEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:04:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbeKLIRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:14 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 560AE215EA;
        Sun, 11 Nov 2018 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975238;
        bh=IlcIFchbqj0e5+EjQVQ68duHljTyg53ea/P0LbuuaJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTcaZNoLIQkpwzdbcdUBW+d8TkbeSjn7KeKgYVd6TWevvDrMUKaBSTloN4SkwMwMy
         3epG9Wc4mF31nw3sRp/2ebGPx32MKbD0k5OqV1issXV7KOKHGXkansW5VBuH3hAxwA
         xGp9Irk5cyCn7uFYdrHwE7ve2pVYzGnNlZQh3U6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eyal Reizer <eyalr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/361] wlcore: Fix BUG with clear completion on timeout
Date:   Sun, 11 Nov 2018 14:17:04 -0800
Message-Id: <20181111221630.803995370@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ti/wlcore/main.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -957,6 +957,8 @@ static void wl1271_recovery_work(struct
 	BUG_ON(wl->conf.recovery.bug_on_recovery &&
 	       !test_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags));
 
+	clear_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags);
+
 	if (wl->conf.recovery.no_recovery) {
 		wl1271_info("No recovery (chosen on module load). Fw will remain stuck.");
 		goto out_unlock;
@@ -6710,6 +6712,7 @@ static int __maybe_unused wlcore_runtime
 	int ret;
 	unsigned long start_time = jiffies;
 	bool pending = false;
+	bool recovery = false;
 
 	/* Nothing to do if no ELP mode requested */
 	if (!test_bit(WL1271_FLAG_IN_ELP, &wl->flags))
@@ -6726,7 +6729,7 @@ static int __maybe_unused wlcore_runtime
 
 	ret = wlcore_raw_write32(wl, HW_ACCESS_ELP_CTRL_REG, ELPCTRL_WAKE_UP);
 	if (ret < 0) {
-		wl12xx_queue_recovery_work(wl);
+		recovery = true;
 		goto err;
 	}
 
@@ -6734,11 +6737,12 @@ static int __maybe_unused wlcore_runtime
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
 
@@ -6753,6 +6757,12 @@ err:
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
 


