Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078E4C004D1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C2321533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C2321533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeI0EXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:23:17 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57982 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeI0EXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:23:15 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42LBs63tdjz1qxy2;
        Thu, 27 Sep 2018 00:08:10 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42LBs63QBxz1qql9;
        Thu, 27 Sep 2018 00:08:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Xw99BNNE2cJ7; Thu, 27 Sep 2018 00:08:08 +0200 (CEST)
X-Auth-Info: RTW0KObLlgTB2RenOxqEUUWGX3ReabjVPGTaVElirp0=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Sep 2018 00:08:08 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr,
        Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 5/9] mtd: spi: Provide LUT entry to perform DUAL read
Date:   Thu, 27 Sep 2018 00:07:35 +0200
Message-Id: <20180926220739.620-6-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180926220739.620-1-lukma@denx.de>
References: <20180926220739.620-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds LUT sequence to perform DUAL read (as opposite to the
default QUAD for this controller).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 4f0c78ba6fcb..0c381cdfb39f 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -207,6 +207,7 @@
 #define SEQID_RDCR		9
 #define SEQID_EN4B		10
 #define SEQID_BRWR		11
+#define SEQID_DUAL_READ	12
 
 #define QUADSPI_MIN_IOMAP SZ_4M
 
@@ -482,6 +483,15 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 	qspi_writel(q, LUT0(CMD, PAD1, SPINOR_OP_BRWR),
 			base + QUADSPI_LUT(lut_base));
 
+	/* Dual Read */
+	lut_base = SEQID_DUAL_READ * 4;
+
+	qspi_writel(q, LUT0(CMD, PAD1, SPINOR_OP_READ_1_1_2) |
+		    LUT1(ADDR, PAD1, addrlen), base + QUADSPI_LUT(lut_base));
+	qspi_writel(q, LUT0(DUMMY, PAD1, read_dm) |
+		    LUT1(FSL_READ, PAD2, rxfifo),
+			base + QUADSPI_LUT(lut_base + 1));
+
 	fsl_qspi_lock_lut(q);
 }
 
@@ -513,6 +523,8 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 		return SEQID_EN4B;
 	case SPINOR_OP_BRWR:
 		return SEQID_BRWR;
+	case SPINOR_OP_READ_1_1_2:
+		return SEQID_DUAL_READ;
 	default:
 		if (cmd == q->nor[0].erase_opcode)
 			return SEQID_SE;
-- 
2.11.0

