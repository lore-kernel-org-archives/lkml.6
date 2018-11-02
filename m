Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65D5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEDA20847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VadzG8ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEDA20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbeKCDvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbeKCDvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:51:48 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A102084D;
        Fri,  2 Nov 2018 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184215;
        bh=AOFdCdAIU56gen96Gz+K6qpNQ2vXF2pSfCVDYA+EWi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VadzG8ulE6sEvMcVzI6MhIecx4Ew636WB/srqmFF8fg8KAHUzqjDzAVktGGchLD8w
         L+QeWN5S8w8ajI9XbxsD/1u/ePJxWAsqEdP0rOA8TuJrT5j2WPHJ5X3nAnOejK+0Qt
         vf7aKQgM/cNFw3hqqCTEhoV94bnBchBwUV1A6tmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 108/150] net: fec: dont dump RX FIFO register when not available
Date:   Fri,  2 Nov 2018 19:34:30 +0100
Message-Id: <20181102182910.756919963@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec.h      |    4 ++++
 drivers/net/ethernet/freescale/fec_main.c |   16 ++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

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
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -90,14 +90,16 @@ static struct platform_device_id fec_dev
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
@@ -2163,7 +2165,13 @@ static void fec_enet_get_regs(struct net
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


