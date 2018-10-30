Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F79C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616BD2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNdWkP87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616BD2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeJ3WVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbeJ3WVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3FAA2080A;
        Tue, 30 Oct 2018 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906067;
        bh=AjA0b1yhVYV1VKsugCiBMOCNw0HlAnMD649f/fQSV18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNdWkP874J29aV0UQi9gjITZ25aUgBCkX9f0ebPKQG38IbVKwlaj85+A1Hj+V2GOY
         OStrttYqSVdyBLFUnsmXRevOv/Ozy+X5nGNvjozVI8yhXM/1lgmuBVkeRKlXIZr6Tb
         1xqk2xPhpyBJfWN4V9xQti/O7kaQ4ZdlC0MSf/Jc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fugang Duan <fugang.duan@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 17/33] net: fec: don't dump RX FIFO register when not available
Date:   Tue, 30 Oct 2018 09:26:41 -0400
Message-Id: <20181030132657.217970-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

[ Upstream commit ec20a63aa8b8ec3223fb25cdb2a49f9f9dfda88c ]

Commit db65f35f50e0 ("net: fec: add support of ethtool get_regs") introduce
ethool "--register-dump" interface to dump all FEC registers.

But not all silicon implementations of the Freescale FEC hardware module
have the FRBR (FIFO Receive Bound Register) and FRSR (FIFO Receive Start
Register) register, so we should not be trying to dump them on those that
don't.

To fix it we create a quirk flag, FEC_QUIRK_HAS_RFREG, and check it before
dump those RX FIFO registers.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec.h      |  4 ++++
 drivers/net/ethernet/freescale/fec_main.c | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 4778b663653e..bf80855dd0dd 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -452,6 +452,10 @@ struct bufdesc_ex {
  * initialisation.
  */
 #define FEC_QUIRK_MIB_CLEAR		(1 << 15)
+/* Only i.MX25/i.MX27/i.MX28 controller supports FRBR,FRSR registers,
+ * those FIFO receive registers are resolved in other platforms.
+ */
+#define FEC_QUIRK_HAS_FRREG		(1 << 16)
 
 struct bufdesc_prop {
 	int qid;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c729665107f5..ae274b30c618 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -90,14 +90,16 @@ static struct platform_device_id fec_devtype[] = {
 		.driver_data = 0,
 	}, {
 		.name = "imx25-fec",
-		.driver_data = FEC_QUIRK_USE_GASKET | FEC_QUIRK_MIB_CLEAR,
+		.driver_data = FEC_QUIRK_USE_GASKET | FEC_QUIRK_MIB_CLEAR |
+			       FEC_QUIRK_HAS_FRREG,
 	}, {
 		.name = "imx27-fec",
-		.driver_data = FEC_QUIRK_MIB_CLEAR,
+		.driver_data = FEC_QUIRK_MIB_CLEAR | FEC_QUIRK_HAS_FRREG,
 	}, {
 		.name = "imx28-fec",
 		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_SWAP_FRAME |
-				FEC_QUIRK_SINGLE_MDIO | FEC_QUIRK_HAS_RACC,
+				FEC_QUIRK_SINGLE_MDIO | FEC_QUIRK_HAS_RACC |
+				FEC_QUIRK_HAS_FRREG,
 	}, {
 		.name = "imx6q-fec",
 		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
@@ -2163,7 +2165,13 @@ static void fec_enet_get_regs(struct net_device *ndev,
 	memset(buf, 0, regs->len);
 
 	for (i = 0; i < ARRAY_SIZE(fec_enet_register_offset); i++) {
-		off = fec_enet_register_offset[i] / 4;
+		off = fec_enet_register_offset[i];
+
+		if ((off == FEC_R_BOUND || off == FEC_R_FSTART) &&
+		    !(fep->quirks & FEC_QUIRK_HAS_FRREG))
+			continue;
+
+		off >>= 2;
 		buf[off] = readl(&theregs[off]);
 	}
 }
-- 
2.17.1

