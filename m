Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81807C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7B5255AE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7B5255AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964910AbeGARJi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:09:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37354 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032018AbeGAQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:41:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5C48EACD;
        Sun,  1 Jul 2018 16:41:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.17 102/220] mtd: rawnand: fix return value check for bad block status
Date:   Sun,  1 Jul 2018 18:22:06 +0200
Message-Id: <20180701160912.660607212@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhishek Sahu <absahu@codeaurora.org>

commit e9893e6fa932f42c90c4ac5849fa9aa0f0f00a34 upstream.

Positive return value from read_oob() is making false BAD
blocks. For some of the NAND controllers, OOB bytes will be
protected with ECC and read_oob() will return number of bitflips.
If there is any bitflip in ECC protected OOB bytes for BAD block
status page, then that block is getting treated as BAD.

Fixes: c120e75e0e7d ("mtd: nand: use read_oob() instead of cmdfunc() for bad block check")
Cc: <stable@vger.kernel.org>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/nand_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -440,7 +440,7 @@ static int nand_block_bad(struct mtd_inf
 
 	for (; page < page_end; page++) {
 		res = chip->ecc.read_oob(mtd, chip, page);
-		if (res)
+		if (res < 0)
 			return res;
 
 		bad = chip->oob_poi[chip->badblockpos];


