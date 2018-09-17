Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9196ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF352146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF352146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbeIRElY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:41:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbeIRElY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:41:24 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87391707;
        Mon, 17 Sep 2018 23:11:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 097/158] mtd: rawnand: make subop helpers return unsigned values
Date:   Tue, 18 Sep 2018 00:42:07 +0200
Message-Id: <20180917211715.776695932@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 760c435e0f85ed19e48a90d746ce1de2cd02def7 ]

A report from Colin Ian King pointed a CoverityScan issue where error
values on these helpers where not checked in the drivers. These
helpers can error out only in case of a software bug in driver code,
not because of a runtime/hardware error. Hence, let's WARN_ON() in this
case and return 0 which is harmless anyway.

Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/nand_base.c |   44 +++++++++++++++++++--------------------
 include/linux/mtd/rawnand.h      |   16 +++++++-------
 2 files changed, 30 insertions(+), 30 deletions(-)

--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -2668,8 +2668,8 @@ static bool nand_subop_instr_is_valid(co
 	return subop && instr_idx < subop->ninstrs;
 }
 
-static int nand_subop_get_start_off(const struct nand_subop *subop,
-				    unsigned int instr_idx)
+static unsigned int nand_subop_get_start_off(const struct nand_subop *subop,
+					     unsigned int instr_idx)
 {
 	if (instr_idx)
 		return 0;
@@ -2688,12 +2688,12 @@ static int nand_subop_get_start_off(cons
  *
  * Given an address instruction, returns the offset of the first cycle to issue.
  */
-int nand_subop_get_addr_start_off(const struct nand_subop *subop,
-				  unsigned int instr_idx)
+unsigned int nand_subop_get_addr_start_off(const struct nand_subop *subop,
+					   unsigned int instr_idx)
 {
-	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
-	    subop->instrs[instr_idx].type != NAND_OP_ADDR_INSTR)
-		return -EINVAL;
+	if (WARN_ON(!nand_subop_instr_is_valid(subop, instr_idx) ||
+		    subop->instrs[instr_idx].type != NAND_OP_ADDR_INSTR))
+		return 0;
 
 	return nand_subop_get_start_off(subop, instr_idx);
 }
@@ -2710,14 +2710,14 @@ EXPORT_SYMBOL_GPL(nand_subop_get_addr_st
  *
  * Given an address instruction, returns the number of address cycle to issue.
  */
-int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
-				unsigned int instr_idx)
+unsigned int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
+					 unsigned int instr_idx)
 {
 	int start_off, end_off;
 
-	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
-	    subop->instrs[instr_idx].type != NAND_OP_ADDR_INSTR)
-		return -EINVAL;
+	if (WARN_ON(!nand_subop_instr_is_valid(subop, instr_idx) ||
+		    subop->instrs[instr_idx].type != NAND_OP_ADDR_INSTR))
+		return 0;
 
 	start_off = nand_subop_get_addr_start_off(subop, instr_idx);
 
@@ -2742,12 +2742,12 @@ EXPORT_SYMBOL_GPL(nand_subop_get_num_add
  *
  * Given a data instruction, returns the offset to start from.
  */
-int nand_subop_get_data_start_off(const struct nand_subop *subop,
-				  unsigned int instr_idx)
+unsigned int nand_subop_get_data_start_off(const struct nand_subop *subop,
+					   unsigned int instr_idx)
 {
-	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
-	    !nand_instr_is_data(&subop->instrs[instr_idx]))
-		return -EINVAL;
+	if (WARN_ON(!nand_subop_instr_is_valid(subop, instr_idx) ||
+		    !nand_instr_is_data(&subop->instrs[instr_idx])))
+		return 0;
 
 	return nand_subop_get_start_off(subop, instr_idx);
 }
@@ -2764,14 +2764,14 @@ EXPORT_SYMBOL_GPL(nand_subop_get_data_st
  *
  * Returns the length of the chunk of data to send/receive.
  */
-int nand_subop_get_data_len(const struct nand_subop *subop,
-			    unsigned int instr_idx)
+unsigned int nand_subop_get_data_len(const struct nand_subop *subop,
+				     unsigned int instr_idx)
 {
 	int start_off = 0, end_off;
 
-	if (!nand_subop_instr_is_valid(subop, instr_idx) ||
-	    !nand_instr_is_data(&subop->instrs[instr_idx]))
-		return -EINVAL;
+	if (WARN_ON(!nand_subop_instr_is_valid(subop, instr_idx) ||
+		    !nand_instr_is_data(&subop->instrs[instr_idx])))
+		return 0;
 
 	start_off = nand_subop_get_data_start_off(subop, instr_idx);
 
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -986,14 +986,14 @@ struct nand_subop {
 	unsigned int last_instr_end_off;
 };
 
-int nand_subop_get_addr_start_off(const struct nand_subop *subop,
-				  unsigned int op_id);
-int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
-				unsigned int op_id);
-int nand_subop_get_data_start_off(const struct nand_subop *subop,
-				  unsigned int op_id);
-int nand_subop_get_data_len(const struct nand_subop *subop,
-			    unsigned int op_id);
+unsigned int nand_subop_get_addr_start_off(const struct nand_subop *subop,
+					   unsigned int op_id);
+unsigned int nand_subop_get_num_addr_cyc(const struct nand_subop *subop,
+					 unsigned int op_id);
+unsigned int nand_subop_get_data_start_off(const struct nand_subop *subop,
+					   unsigned int op_id);
+unsigned int nand_subop_get_data_len(const struct nand_subop *subop,
+				     unsigned int op_id);
 
 /**
  * struct nand_op_parser_addr_constraints - Constraints for address instructions


