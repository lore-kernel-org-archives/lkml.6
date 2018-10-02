Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F274C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F81D206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F81D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbeJBUO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbeJBUOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:25 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BACEEC2A;
        Tue,  2 Oct 2018 13:31:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 216/228] ata: ftide010: Add a quirk for SQ201
Date:   Tue,  2 Oct 2018 06:25:13 -0700
Message-Id: <20181002132512.196763730@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 46cb52ad414ac829680d0bb8cc7090ac2b577ca7 ]

The DMA is broken on this specific device for some unknown
reason (probably badly designed or plain broken interface
electronics) and will only work with PIO. Other users of
the same hardware does not have this problem.

Add a specific quirk so that this Gemini device gets
DMA turned off. Also fix up some code around passing the
port information around in probe while we're at it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/pata_ftide010.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -256,14 +256,12 @@ static struct ata_port_operations pata_f
 	.qc_issue	= ftide010_qc_issue,
 };
 
-static struct ata_port_info ftide010_port_info[] = {
-	{
-		.flags		= ATA_FLAG_SLAVE_POSS,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA6,
-		.pio_mask	= ATA_PIO4,
-		.port_ops	= &pata_ftide010_port_ops,
-	},
+static struct ata_port_info ftide010_port_info = {
+	.flags		= ATA_FLAG_SLAVE_POSS,
+	.mwdma_mask	= ATA_MWDMA2,
+	.udma_mask	= ATA_UDMA6,
+	.pio_mask	= ATA_PIO4,
+	.port_ops	= &pata_ftide010_port_ops,
 };
 
 #if IS_ENABLED(CONFIG_SATA_GEMINI)
@@ -349,6 +347,7 @@ static int pata_ftide010_gemini_cable_de
 }
 
 static int pata_ftide010_gemini_init(struct ftide010 *ftide,
+				     struct ata_port_info *pi,
 				     bool is_ata1)
 {
 	struct device *dev = ftide->dev;
@@ -373,7 +372,13 @@ static int pata_ftide010_gemini_init(str
 
 	/* Flag port as SATA-capable */
 	if (gemini_sata_bridge_enabled(sg, is_ata1))
-		ftide010_port_info[0].flags |= ATA_FLAG_SATA;
+		pi->flags |= ATA_FLAG_SATA;
+
+	/* This device has broken DMA, only PIO works */
+	if (of_machine_is_compatible("itian,sq201")) {
+		pi->mwdma_mask = 0;
+		pi->udma_mask = 0;
+	}
 
 	/*
 	 * We assume that a simple 40-wire cable is used in the PATA mode.
@@ -435,6 +440,7 @@ static int pata_ftide010_gemini_init(str
 }
 #else
 static int pata_ftide010_gemini_init(struct ftide010 *ftide,
+				     struct ata_port_info *pi,
 				     bool is_ata1)
 {
 	return -ENOTSUPP;
@@ -446,7 +452,7 @@ static int pata_ftide010_probe(struct pl
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	const struct ata_port_info pi = ftide010_port_info[0];
+	struct ata_port_info pi = ftide010_port_info;
 	const struct ata_port_info *ppi[] = { &pi, NULL };
 	struct ftide010 *ftide;
 	struct resource *res;
@@ -490,6 +496,7 @@ static int pata_ftide010_probe(struct pl
 		 * are ATA0. This will also set up the cable types.
 		 */
 		ret = pata_ftide010_gemini_init(ftide,
+				&pi,
 				(res->start == 0x63400000));
 		if (ret)
 			goto err_dis_clk;


