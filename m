Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA39C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B41F20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B41F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeIJWrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:47:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35982 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:47:07 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fzQLk-0005DN-CT; Mon, 10 Sep 2018 17:51:48 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     nic_swsd@realtek.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENABLED
Date:   Tue, 11 Sep 2018 01:51:43 +0800
Message-Id: <20180910175143.23878-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After system suspend, sometimes the r8169 doesn't work when ethernet
cable gets pluggued.

This issue happens because rtl_reset_work() doesn't get called from
rtl8169_runtime_resume(), after system suspend.

In rtl_task(), RTL_FLAG_TASK_* only gets cleared if this condition is
met:
if (!netif_running(dev) ||
    !test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
    ...

If RTL_FLAG_TASK_ENABLED was cleared during system suspend while
RTL_FLAG_TASK_RESET_PENDING was set, the next rtl_schedule_task() won't
schedule task as the flag is still there.

So in addition to clearing RTL_FLAG_TASK_ENABLED, also clears other
flags.

Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Use bitmap_zero(), suggested by Florian Fainelli.
- Assign zero to first enum member in rtl_flag, just in case.

 drivers/net/ethernet/realtek/r8169.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index b08d51bf7a20..a1bc6404d1d4 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -631,7 +631,7 @@ struct rtl8169_tc_offsets {
 };
 
 enum rtl_flag {
-	RTL_FLAG_TASK_ENABLED,
+	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_SLOW_PENDING,
 	RTL_FLAG_TASK_RESET_PENDING,
 	RTL_FLAG_MAX
@@ -6655,7 +6655,8 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_update_counters(tp);
 
 	rtl_lock_work(tp);
-	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
 
 	rtl8169_down(dev);
 	rtl_unlock_work(tp);
@@ -6838,7 +6839,9 @@ static void rtl8169_net_suspend(struct net_device *dev)
 
 	rtl_lock_work(tp);
 	napi_disable(&tp->napi);
-	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
+
 	rtl_unlock_work(tp);
 
 	rtl_pll_power_down(tp);
-- 
2.17.1

