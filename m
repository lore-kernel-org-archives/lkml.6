Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C7C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F754222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025320;
	bh=0OyBFdYCbZlKYGJzw7GAX0kFJZsdo0KflbSji7/c694=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nDhVUi1MehLs+Vhl1v1uWe2qBpPGYHJzevhQNQffhJp7h0Z2HuVTxYeKnzS3hyFhU
	 /3L6RPaZIjCNlvkWHx+XKzWpdhg8mnbfOLLLSc744R5ZJjw9LoDMVsni/Z+o2/S1d2
	 orS2pHfUlR6uGFx/am8EpNoy6nR6FWB+RBUsn8So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbfBMCfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbfBMCfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00BB2222CD;
        Wed, 13 Feb 2019 02:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025312;
        bh=0OyBFdYCbZlKYGJzw7GAX0kFJZsdo0KflbSji7/c694=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGb3BoffR9agLouKztcEV61/1RhxOKL460AMb7EqpBbGhwSMIw6rx8Ahpj/GyPnkm
         GBh5ZlUfIRgM24wFVpPxmb/ZE0Q4gT1ZUYzBsOj/uZfk3LLg9ZSj1C26gcgOCefj40
         dkAhTLUWeUttQgFHRH0h/XyYSJT4C6H444LZEeKs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 063/105] scsi: qla1280: set 64bit coherent mask
Date:   Tue, 12 Feb 2019 21:32:54 -0500
Message-Id: <20190213023336.19019-63-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit 4a01ab60f55041b1ccc760e43258a5b3aeeca1bc ]

After Commit 54aed4dd3526 ("MIPS: IP27: use dma_direct_ops") qla1280 driver
failed on SGI IP27 machines with

qla1280: QLA1040 found on PCI bus 0, dev 0
qla1280 0000:00:00.0: enabling device (0006 -> 0007)
qla1280: Failed to get request memory
qla1280: probe of 0000:00:00.0 failed with error -12

Reason is that SGI IP27 always generates 64bit DMA addresses and has no
fallback mode for 32bit DMA addresses implemented. QLA1280 supports 64bit
addressing for all DMA accesses so setting coherent mask to 64bit fixes the
issue.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla1280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 15a50cc7e4b3..c8589926014d 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -4259,7 +4259,7 @@ qla1280_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	ha->devnum = devnum;	/* specifies microcode load address */
 
 #ifdef QLA_64BIT_PTR
-	if (dma_set_mask(&ha->pdev->dev, DMA_BIT_MASK(64))) {
+	if (dma_set_mask_and_coherent(&ha->pdev->dev, DMA_BIT_MASK(64))) {
 		if (dma_set_mask(&ha->pdev->dev, DMA_BIT_MASK(32))) {
 			printk(KERN_WARNING "scsi(%li): Unable to set a "
 			       "suitable DMA mask - aborting\n", ha->host_no);
-- 
2.19.1

