Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D9CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA7C253A1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA7C253A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032017AbeGAQlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:41:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37298 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031508AbeGAQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:41:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9539ACC;
        Sun,  1 Jul 2018 16:41:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.17 099/220] mtd: rawnand: Do not check FAIL bit when executing a SET_FEATURES op
Date:   Sun,  1 Jul 2018 18:22:03 +0200
Message-Id: <20180701160912.545449483@linuxfoundation.org>
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

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 782d1967d0479ffd59412b2f3179c8bb35f50ff6 upstream.

The ONFI spec clearly says that FAIL bit is only valid for PROGRAM,
ERASE and READ-with-on-die-ECC operations, and should be ignored
otherwise.

It seems that checking it after sending a SET_FEATURES is a bad idea
because a previous READ, PROGRAM or ERASE op may have failed, and
depending on the implementation, the FAIL bit is not cleared until a
new READ, PROGRAM or ERASE is started.

This leads to ->set_features() returning -EIO while it actually worked,
which can sometimes stop a batch of READ/PROGRAM ops.

Note that we only fix the ->exec_op() path here, because some drivers
are abusing the NAND_STATUS_FAIL flag in their ->waitfunc()
implementation to propagate other kind of errors, like
wait-ready-timeout or controller-related errors. Let's not try to fix
those drivers since they worked fine so far.

Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/nand_base.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -2174,7 +2174,6 @@ static int nand_set_features_op(struct n
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	const u8 *params = data;
 	int i, ret;
-	u8 status;
 
 	if (chip->exec_op) {
 		const struct nand_sdr_timings *sdr =
@@ -2188,26 +2187,18 @@ static int nand_set_features_op(struct n
 		};
 		struct nand_operation op = NAND_OPERATION(instrs);
 
-		ret = nand_exec_op(chip, &op);
-		if (ret)
-			return ret;
-
-		ret = nand_status_op(chip, &status);
-		if (ret)
-			return ret;
-	} else {
-		chip->cmdfunc(mtd, NAND_CMD_SET_FEATURES, feature, -1);
-		for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-			chip->write_byte(mtd, params[i]);
-
-		ret = chip->waitfunc(mtd, chip);
-		if (ret < 0)
-			return ret;
-
-		status = ret;
+		return nand_exec_op(chip, &op);
 	}
 
-	if (status & NAND_STATUS_FAIL)
+	chip->cmdfunc(mtd, NAND_CMD_SET_FEATURES, feature, -1);
+	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
+		chip->write_byte(mtd, params[i]);
+
+	ret = chip->waitfunc(mtd, chip);
+	if (ret < 0)
+		return ret;
+
+	if (ret & NAND_STATUS_FAIL)
 		return -EIO;
 
 	return 0;


