Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCCBC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6697A21480
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1NWyWxG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6697A21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeJQBEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJQBET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:19 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DE772098A;
        Tue, 16 Oct 2018 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709977;
        bh=ro1MEA2yZJtCMwuiy3MH6yQ5/Pkko4aUt6xuDx0hw9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1NWyWxG8Xwu4BjO9gu1/4zpA2RPb+CZaTxZP5hhwNpETHp0ARlFihcESfi//TNQr+
         GyYgSqLlEKyW1cGc9bdGXMNKMLcnUKPkGFVgMbMvH7FR/AgO7sDd/I01o+HT9vcC1o
         ey3xfZN9OqBB52sXy8mwbeo15Kdcsc/IOb0DKwCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Clayton <chris2553@googlemail.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 061/135] r8169: set RX_MULTI_EN bit in RxConfig for 8168F-family chips
Date:   Tue, 16 Oct 2018 19:04:51 +0200
Message-Id: <20181016170518.720362924@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

[ Upstream commit 511cfd580f23b0e0fcd5659931ef14c6e2c062b0 ]

It has been reported that since
commit 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices")
at least RTL_GIGA_MAC_VER_38 NICs work erratically after a resume from
suspend.
The problem has been traced to a missing RX_MULTI_EN bit in the RxConfig
register.
We already set this bit for RTL_GIGA_MAC_VER_35 NICs of the same 8168F
chip family so let's do it also for its other siblings: RTL_GIGA_MAC_VER_36
and RTL_GIGA_MAC_VER_38.

Curiously, the NIC seems to work fine after a system boot without having
this bit set as long as the system isn't suspended and resumed.

Fixes: 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices")
Reported-by: Chris Clayton <chris2553@googlemail.com>
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Tested-by: Chris Clayton <chris2553@googlemail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4788,8 +4788,8 @@ static void rtl_init_rxcfg(struct rtl816
 		RTL_W32(tp, RxConfig, RX_FIFO_THRESH | RX_DMA_BURST);
 		break;
 	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
-	case RTL_GIGA_MAC_VER_34:
-	case RTL_GIGA_MAC_VER_35:
+	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_36:
+	case RTL_GIGA_MAC_VER_38:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST);
 		break;
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:


