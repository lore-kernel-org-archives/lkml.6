Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F979C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B6623F9F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B6623F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934505AbeGFF4S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:56:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33534 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934415AbeGFFvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:49 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B211AC3C;
        Fri,  6 Jul 2018 05:51:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.14 44/61] mtd: rawnand: fix return value check for bad block status
Date:   Fri,  6 Jul 2018 07:47:08 +0200
Message-Id: <20180706054714.024064715@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
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
[backported to 4.14.y]
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/nand_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -440,7 +440,7 @@ static int nand_block_bad(struct mtd_inf
 
 	for (; page < page_end; page++) {
 		res = chip->ecc.read_oob(mtd, chip, page);
-		if (res)
+		if (res < 0)
 			return res;
 
 		bad = chip->oob_poi[chip->badblockpos];


