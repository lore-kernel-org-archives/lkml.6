Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D849AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F77620658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F77620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbeICWBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:01:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeICWBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:01:45 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ADFC8BC4;
        Mon,  3 Sep 2018 17:40:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.18 111/123] mtd: rawnand: hynix: Use ->exec_op() in hynix_nand_reg_write_op()
Date:   Mon,  3 Sep 2018 18:57:35 +0200
Message-Id: <20180903165724.201914077@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 20366e19e28f9954b25580c020d7a4e0db6055c4 upstream.

Modern NAND controller drivers implement ->exec_op() instead of
->cmdfunc(), make sure we don't end up with a NULL pointer dereference
when hynix_nand_reg_write_op() is called.

Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/nand_hynix.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -100,6 +100,16 @@ static int hynix_nand_reg_write_op(struc
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	u16 column = ((u16)addr << 8) | addr;
 
+	if (chip->exec_op) {
+		struct nand_op_instr instrs[] = {
+			NAND_OP_ADDR(1, &addr, 0),
+			NAND_OP_8BIT_DATA_OUT(1, &val, 0),
+		};
+		struct nand_operation op = NAND_OPERATION(instrs);
+
+		return nand_exec_op(chip, &op);
+	}
+
 	chip->cmdfunc(mtd, NAND_CMD_NONE, column, -1);
 	chip->write_byte(mtd, val);
 


