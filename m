Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1943C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB8120651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865667;
	bh=EeTHaqoX3mhX+JM7DMOCDAe3n5CHx4n00TI33JDY7m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i86smRIJtWmA8VCEoxs8mBuwmzL9BsU9rxKwIQ708IfdHVOUErTeerZtpjo1XeG9p
	 rmyul05ZIfsc2d7g8NDygk5vrEgNI5IuPZtqSwL0bvvIrHYU7krxIVNgaIpVDBmsCB
	 VaJVX/sK2X97uTdxV1790mkmkBzRW2w/EovgyJWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfAGMy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfAGMxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:53:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E0E920651;
        Mon,  7 Jan 2019 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865623;
        bh=EeTHaqoX3mhX+JM7DMOCDAe3n5CHx4n00TI33JDY7m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w61h5a0Mt6NaXREJtdbE6YQ6RAWOUApVeRz6FnmRTBiUev93TLdOrGuMPFW25LIym
         STK/UzdegyJSAij7cV+p3B43ZR0cSDEhjDbRg+o1xji6RW9R+2rSyIYN0Kb9nC7u4+
         8nZkNgeE6UB63Y7eh/poqJZ+3G5n9ZASNykXaSwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.19 066/170] mtd: rawnand: marvell: prevent timeouts on a loaded machine
Date:   Mon,  7 Jan 2019 13:31:33 +0100
Message-Id: <20190107104500.836151117@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit cafb56dd741e61c99709bcd2b193a9a1d36def3b upstream.

marvell_nfc_wait_op() waits for completion during 'timeout_ms'
milliseconds before throwing an error. While the logic is fine, the
value of 'timeout_ms' is given by the core and actually correspond to
the maximum time the NAND chip will take to complete the
operation. Assuming there is no overhead in the propagation of the
interrupt signal to the the NAND controller (through the Ready/Busy
line), this delay does not take into account the latency of the
operating system. For instance, for a page write, the delay given by
the core is rounded up to 1ms. Hence, when the machine is over loaded,
there is chances that this timeout will be reached.

There are two ways to solve this issue that are not incompatible:
1/ Enlarge the timeout value (if so, how much?).
2/ Check after the waiting method if we did not miss any interrupt
because of the OS latency (an interrupt is still pending). In this
case, we assume the operation exited successfully.

We choose the second approach that is a must in all cases, with the
possibility to also modify the timeout value to be, e.g. at least 1
second in all cases.

Fixes: 02f26ecf8c77 ("mtd: nand: add reworked Marvell NAND controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/marvell_nand.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -444,9 +444,14 @@ static void marvell_nfc_enable_int(struc
 	writel_relaxed(reg & ~int_mask, nfc->regs + NDCR);
 }
 
-static void marvell_nfc_clear_int(struct marvell_nfc *nfc, u32 int_mask)
+static u32 marvell_nfc_clear_int(struct marvell_nfc *nfc, u32 int_mask)
 {
+	u32 reg;
+
+	reg = readl_relaxed(nfc->regs + NDSR);
 	writel_relaxed(int_mask, nfc->regs + NDSR);
+
+	return reg & int_mask;
 }
 
 static void marvell_nfc_force_byte_access(struct nand_chip *chip,
@@ -613,6 +618,7 @@ static int marvell_nfc_wait_cmdd(struct
 static int marvell_nfc_wait_op(struct nand_chip *chip, unsigned int timeout_ms)
 {
 	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
+	u32 pending;
 	int ret;
 
 	/* Timeout is expressed in ms */
@@ -625,8 +631,13 @@ static int marvell_nfc_wait_op(struct na
 	ret = wait_for_completion_timeout(&nfc->complete,
 					  msecs_to_jiffies(timeout_ms));
 	marvell_nfc_disable_int(nfc, NDCR_RDYM);
-	marvell_nfc_clear_int(nfc, NDSR_RDY(0) | NDSR_RDY(1));
-	if (!ret) {
+	pending = marvell_nfc_clear_int(nfc, NDSR_RDY(0) | NDSR_RDY(1));
+
+	/*
+	 * In case the interrupt was not served in the required time frame,
+	 * check if the ISR was not served or if something went actually wrong.
+	 */
+	if (ret && !pending) {
 		dev_err(nfc->dev, "Timeout waiting for RB signal\n");
 		return -ETIMEDOUT;
 	}


