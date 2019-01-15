Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3BDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2C120645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570528;
	bh=eXnRlkWGb+n8QQgGh5yjxvK4Xp4AV/bB/iO7QalRckA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=euBD2IpNkyRFpN6UKfAcVjvxBbAeqUDOp5iiJPcJ5dTRX6htr9UEP66hVtZkAoP6B
	 K+Hr4u6dYKUxR8LmHUDP2kJL6rZeYIM5s68cEYCRacSZ7X7X3JZO1JhM2h9b0eCRii
	 5Wxb4g3Aw2Ux+boyNVXL9HBKQeWXWLPkp3TkI5Os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfAOQmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbfAOQmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E4820859;
        Tue, 15 Jan 2019 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570522;
        bh=eXnRlkWGb+n8QQgGh5yjxvK4Xp4AV/bB/iO7QalRckA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChfBWwbItBP049zHYf0IIqoR7/ONJUtBoLUhY8s83SeiFWWy2Fr+RUl9udNZMJk1s
         z44WKw61L0ZM/0jMS3QkRXEBu2WfQB9FB4PwQ8R3/oSAn6aF0CsdGMUJ0iEEv8x97v
         9M5hc4R4OgHqc/qPS6qIYE4DRotRhBgcHT0AFtBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH 4.19 25/50] mtd: rawnand: qcom: fix memory corruption that causes panic
Date:   Tue, 15 Jan 2019 17:36:01 +0100
Message-Id: <20190115154911.407813130@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

From: Christian Lamparter <chunkeey@gmail.com>

commit 81d9bdf59092e4755fc4307c93c4589ef0fe2e0f upstream.

This patch fixes a memory corruption that occurred in the
qcom-nandc driver since it was converted to nand_scan().

On boot, an affected device will panic from a NPE at a weird place:
| Unable to handle kernel NULL pointer dereference at virtual address 0
| pgd = (ptrval)
| [00000000] *pgd=00000000
| Internal error: Oops: 80000005 [#1] SMP ARM
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.9 #0
| Hardware name: Generic DT based system
| PC is at   (null)
| LR is at nand_block_isbad+0x90/0xa4
| pc : [<00000000>]    lr : [<c0592240>]    psr: 80000013
| sp : cf839d40  ip : 00000000  fp : cfae9e20
| r10: cf815810  r9 : 00000000  r8 : 00000000
| r7 : 00000000  r6 : 00000000  r5 : 00000001  r4 : cf815810
| r3 : 00000000  r2 : cfae9810  r1 : ffffffff  r0 : cf815810
| Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
| Control: 10c5387d  Table: 8020406a  DAC: 00000051
| Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
| [<c0592240>] (nand_block_isbad) from [<c0580a94>]
| [<c0580a94>] (allocate_partition) from [<c05811e4>]
| [<c05811e4>] (add_mtd_partitions) from [<c0581164>]
| [<c0581164>] (parse_mtd_partitions) from [<c057def4>]
| [<c057def4>] (mtd_device_parse_register) from [<c059d274>]
| [<c059d274>] (qcom_nandc_probe) from [<c0567f00>]

The problem is that the nand_scan()'s qcom_nand_attach_chip callback
is updating the nandc->max_cwperpage from 1 to 4. This causes the
sg_init_table of clear_bam_transaction() in the driver's
qcom_nandc_block_bad() to memset much more than what was initially
allocated by alloc_bam_transaction().

This patch restores the old behavior by reallocating the shared bam
transaction alloc_bam_transaction() after the chip was identified,
but before mtd_device_parse_register() (which is an alias for
mtd_device_register() - see panic) gets called. This fixes the
corruption and the driver is working again.

Cc: stable@vger.kernel.org
Fixes: 6a3cec64f18c ("mtd: rawnand: qcom: convert driver to nand_scan()")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/qcom_nandc.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2839,6 +2839,16 @@ static int qcom_nand_host_init_and_regis
 	if (ret)
 		return ret;
 
+	if (nandc->props->is_bam) {
+		free_bam_transaction(nandc);
+		nandc->bam_txn = alloc_bam_transaction(nandc);
+		if (!nandc->bam_txn) {
+			dev_err(nandc->dev,
+				"failed to allocate bam transaction\n");
+			return -ENOMEM;
+		}
+	}
+
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
 		nand_cleanup(chip);
@@ -2853,16 +2863,6 @@ static int qcom_probe_nand_devices(struc
 	struct qcom_nand_host *host;
 	int ret;
 
-	if (nandc->props->is_bam) {
-		free_bam_transaction(nandc);
-		nandc->bam_txn = alloc_bam_transaction(nandc);
-		if (!nandc->bam_txn) {
-			dev_err(nandc->dev,
-				"failed to allocate bam transaction\n");
-			return -ENOMEM;
-		}
-	}
-
 	for_each_available_child_of_node(dn, child) {
 		host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
 		if (!host) {


