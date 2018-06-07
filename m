Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 87+ADUFKGVudVAAAmS7hNA
	; Thu, 07 Jun 2018 15:08:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0CD20608BA; Thu,  7 Jun 2018 15:08:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 83FC76074D;
	Thu,  7 Jun 2018 15:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83FC76074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935942AbeFGPDl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:03:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41515 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935753AbeFGPDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:37 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbp-0005hJ-Mt; Thu, 07 Jun 2018 15:09:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb2-0002qp-67; Thu, 07 Jun 2018 15:09:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Miquel Raynal" <miquel.raynal@free-electrons.com>,
        "Boris Brezillon" <boris.brezillon@free-electrons.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.996482940@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 119/410] mtd: nand: Fix nand_do_read_oob() return value
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@free-electrons.com>

commit 87e89ce8d0d14f573c068c61bec2117751fb5103 upstream.

Starting from commit 041e4575f034 ("mtd: nand: handle ECC errors in
OOB"), nand_do_read_oob() (from the NAND core) did return 0 or a
negative error, and the MTD layer expected it.

However, the trend for the NAND layer is now to return an error or a
positive number of bitflips. Deciding which status to return to the user
belongs to the MTD layer.

Commit e47f68587b82 ("mtd: check for max_bitflips in mtd_read_oob()")
brought this logic to the mtd_read_oob() function while the return value
coming from nand_do_read_oob() (called by the ->_read_oob() hook) was
left unchanged.

Fixes: e47f68587b82 ("mtd: check for max_bitflips in mtd_read_oob()")
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/nand/nand_base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1837,6 +1837,7 @@ static int nand_write_oob_syndrome(struc
 static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
+	unsigned int max_bitflips = 0;
 	int page, realpage, chipnr;
 	struct nand_chip *chip = mtd->priv;
 	struct mtd_ecc_stats stats;
@@ -1897,6 +1898,8 @@ static int nand_do_read_oob(struct mtd_i
 				nand_wait_ready(mtd);
 		}
 
+		max_bitflips = max_t(unsigned int, max_bitflips, ret);
+
 		readlen -= len;
 		if (!readlen)
 			break;
@@ -1922,7 +1925,7 @@ static int nand_do_read_oob(struct mtd_i
 	if (mtd->ecc_stats.failed - stats.failed)
 		return -EBADMSG;
 
-	return  mtd->ecc_stats.corrected - stats.corrected ? -EUCLEAN : 0;
+	return max_bitflips;
 }
 
 /**
