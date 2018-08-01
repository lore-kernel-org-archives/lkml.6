Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1890C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B8120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B8120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405587AbeHATIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404058AbeHATIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:12 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1226ECE6;
        Wed,  1 Aug 2018 17:21:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jane Wan <Jane.Wan@nokia.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 155/246] mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all ONFI parameter pages
Date:   Wed,  1 Aug 2018 18:51:05 +0200
Message-Id: <20180801165019.144936700@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jane Wan <Jane.Wan@nokia.com>

[ Upstream commit a75bbe71a27875fdc61cde1af6d799037cef6bed ]

Per ONFI specification (Rev. 4.0), if the CRC of the first parameter page
read is not valid, the host should read redundant parameter page copies.
Fix FSL NAND driver to read the two redundant copies which are mandatory
in the specification.

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/fsl_ifc_nand.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -342,9 +342,16 @@ static void fsl_ifc_cmdfunc(struct mtd_i
 
 	case NAND_CMD_READID:
 	case NAND_CMD_PARAM: {
+		/*
+		 * For READID, read 8 bytes that are currently used.
+		 * For PARAM, read all 3 copies of 256-bytes pages.
+		 */
+		int len = 8;
 		int timing = IFC_FIR_OP_RB;
-		if (command == NAND_CMD_PARAM)
+		if (command == NAND_CMD_PARAM) {
 			timing = IFC_FIR_OP_RBCD;
+			len = 256 * 3;
+		}
 
 		ifc_out32((IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
 			  (IFC_FIR_OP_UA  << IFC_NAND_FIR0_OP1_SHIFT) |
@@ -354,12 +361,8 @@ static void fsl_ifc_cmdfunc(struct mtd_i
 			  &ifc->ifc_nand.nand_fcr0);
 		ifc_out32(column, &ifc->ifc_nand.row3);
 
-		/*
-		 * although currently it's 8 bytes for READID, we always read
-		 * the maximum 256 bytes(for PARAM)
-		 */
-		ifc_out32(256, &ifc->ifc_nand.nand_fbcr);
-		ifc_nand_ctrl->read_bytes = 256;
+		ifc_out32(len, &ifc->ifc_nand.nand_fbcr);
+		ifc_nand_ctrl->read_bytes = len;
 
 		set_addr(mtd, 0, 0, 0);
 		fsl_ifc_run_command(mtd);


