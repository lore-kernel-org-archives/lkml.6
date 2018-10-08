Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A5FC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E342156F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zXoPwHry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E342156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbeJHWjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbeJHWjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F01E21565;
        Mon,  8 Oct 2018 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012440;
        bh=j9b68dN/K7hRPh5ACE2kSoDAIJwTzIy2l3qVMRhodoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXoPwHryi3eS1ND6fXunnLL5JmInut/72ZWpVFH3Wb2maPYRpKDNxjABedjGWtRGt
         RqnLyTRMYcx/cZhmTnES2jzqChNKsUa1c5KUEQtELTVe5JwEL7WrLijr0TsUQfzzvC
         ObSmmjDPndiZXwgIzS7U24Adx81s846k1nddGa4Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 16/23] ravb: do not write 1 to reserved bits
Date:   Mon,  8 Oct 2018 11:26:56 -0400
Message-Id: <20181008152703.70891-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152703.70891-1-sashal@kernel.org>
References: <20181008152703.70891-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

[ Upstream commit 2fe397a3959de8a472f165e6d152f64cb77fa2cc ]

EtherAVB hardware requires 0 to be written to status register bits in
order to clear them, however, care must be taken not to:

1. Clear other bits, by writing zero to them
2. Write one to reserved bits

This patch corrects the ravb driver with respect to the second point above.
This is done by defining reserved bit masks for the affected registers and,
after auditing the code, ensure all sites that may write a one to a
reserved bit use are suitably masked.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  5 +++++
 drivers/net/ethernet/renesas/ravb_main.c | 11 ++++++-----
 drivers/net/ethernet/renesas/ravb_ptp.c  |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index f1109661a533..410399070639 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -421,6 +421,7 @@ enum EIS_BIT {
 	EIS_CULF1	= 0x00000080,
 	EIS_TFFF	= 0x00000100,
 	EIS_QFS		= 0x00010000,
+	EIS_RESERVED	= (GENMASK(31, 17) | GENMASK(15, 11)),
 };
 
 /* RIC0 */
@@ -465,6 +466,7 @@ enum RIS0_BIT {
 	RIS0_FRF15	= 0x00008000,
 	RIS0_FRF16	= 0x00010000,
 	RIS0_FRF17	= 0x00020000,
+	RIS0_RESERVED	= GENMASK(31, 18),
 };
 
 /* RIC1 */
@@ -521,6 +523,7 @@ enum RIS2_BIT {
 	RIS2_QFF16	= 0x00010000,
 	RIS2_QFF17	= 0x00020000,
 	RIS2_RFFF	= 0x80000000,
+	RIS2_RESERVED	= GENMASK(30, 18),
 };
 
 /* TIC */
@@ -537,6 +540,7 @@ enum TIS_BIT {
 	TIS_FTF1	= 0x00000002,	/* Undocumented? */
 	TIS_TFUF	= 0x00000100,
 	TIS_TFWF	= 0x00000200,
+	TIS_RESERVED	= (GENMASK(31, 20) | GENMASK(15, 12) | GENMASK(7, 4))
 };
 
 /* ISS */
@@ -610,6 +614,7 @@ enum GIC_BIT {
 enum GIS_BIT {
 	GIS_PTCF	= 0x00000001,	/* Undocumented? */
 	GIS_PTMF	= 0x00000004,
+	GIS_RESERVED	= GENMASK(15, 10),
 };
 
 /* GIE (R-Car Gen3 only) */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 307ecd500dac..71836a7f56b0 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -717,10 +717,11 @@ static void ravb_error_interrupt(struct net_device *ndev)
 	u32 eis, ris2;
 
 	eis = ravb_read(ndev, EIS);
-	ravb_write(ndev, ~EIS_QFS, EIS);
+	ravb_write(ndev, ~(EIS_QFS | EIS_RESERVED), EIS);
 	if (eis & EIS_QFS) {
 		ris2 = ravb_read(ndev, RIS2);
-		ravb_write(ndev, ~(RIS2_QFF0 | RIS2_RFFF), RIS2);
+		ravb_write(ndev, ~(RIS2_QFF0 | RIS2_RFFF | RIS2_RESERVED),
+			   RIS2);
 
 		/* Receive Descriptor Empty int */
 		if (ris2 & RIS2_QFF0)
@@ -773,7 +774,7 @@ static bool ravb_timestamp_interrupt(struct net_device *ndev)
 	u32 tis = ravb_read(ndev, TIS);
 
 	if (tis & TIS_TFUF) {
-		ravb_write(ndev, ~TIS_TFUF, TIS);
+		ravb_write(ndev, ~(TIS_TFUF | TIS_RESERVED), TIS);
 		ravb_get_tx_tstamp(ndev);
 		return true;
 	}
@@ -908,7 +909,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 		/* Processing RX Descriptor Ring */
 		if (ris0 & mask) {
 			/* Clear RX interrupt */
-			ravb_write(ndev, ~mask, RIS0);
+			ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
 			if (ravb_rx(ndev, &quota, q))
 				goto out;
 		}
@@ -916,7 +917,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 		if (tis & mask) {
 			spin_lock_irqsave(&priv->lock, flags);
 			/* Clear TX interrupt */
-			ravb_write(ndev, ~mask, TIS);
+			ravb_write(ndev, ~(mask | TIS_RESERVED), TIS);
 			ravb_tx_free(ndev, q, true);
 			netif_wake_subqueue(ndev, q);
 			mmiowb();
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index eede70ec37f8..9e3222fd69f9 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -319,7 +319,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 		}
 	}
 
-	ravb_write(ndev, ~gis, GIS);
+	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
 }
 
 void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
-- 
2.17.1

