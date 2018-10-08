Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB0C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A44020C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYWYxU+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A44020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeJIBvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIBvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:51:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1978D2064A;
        Mon,  8 Oct 2018 18:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023877;
        bh=3+DS57TJoW3tPd5/BrFuwgcqoTXlucE1AWj21W+iX1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYWYxU+NqMCezv1LYlXfhkfNlnsi7b30wW/CfenN1QEuhaI74yqYTi5QiWasPQtxz
         yxvUSXA2TORhNkLDvq/nhp8GaJYTnrVNnLOkF/tTpHoBEwfIdYMllkW/uirQTYh4zn
         tyJHifxHkDyW9hz0XQLPlt0fOZQ42hu+YeHM39kM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 103/113] r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENABLED
Date:   Mon,  8 Oct 2018 20:31:44 +0200
Message-Id: <20181008175537.020891674@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 6ad569019999300afd8e614d296fdc356550b77f ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -759,7 +759,7 @@ struct rtl8169_tc_offsets {
 };
 
 enum rtl_flag {
-	RTL_FLAG_TASK_ENABLED,
+	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_SLOW_PENDING,
 	RTL_FLAG_TASK_RESET_PENDING,
 	RTL_FLAG_TASK_PHY_PENDING,
@@ -7618,7 +7618,8 @@ static int rtl8169_close(struct net_devi
 	rtl8169_update_counters(dev);
 
 	rtl_lock_work(tp);
-	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
 
 	rtl8169_down(dev);
 	rtl_unlock_work(tp);
@@ -7795,7 +7796,9 @@ static void rtl8169_net_suspend(struct n
 
 	rtl_lock_work(tp);
 	napi_disable(&tp->napi);
-	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
+
 	rtl_unlock_work(tp);
 
 	rtl_pll_power_down(tp);


