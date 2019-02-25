Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD8F21848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130322;
	bh=oCqbrym/J4tzAGoGWD8Z+dE3iv5GpjdjdAe+u603h2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AKWY7/csaTW3MQRR2CaPzEJRHwGSMB6aNb2lXuqpQkchxYJ+4r8dZeLW1gNHxQ03s
	 YMHrEwkYEnx1GoRAM7ogvnYZWWtegKQJMJr3GN4hgl56uMtNO2H40yAziuBrN11FXG
	 Ntag1dXB4ykFkVKLRA6dUsNq5O8q6mBG6Izwxxek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbfBYVcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbfBYVbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8F0217F5;
        Mon, 25 Feb 2019 21:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130312;
        bh=oCqbrym/J4tzAGoGWD8Z+dE3iv5GpjdjdAe+u603h2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZtglFwS7c8jr6theSOQUjq18lVDbHWREnzfsPMIErqMm/7zZ8vVod/Kxdd9B/uHD
         v035SZhscBlYZd9Qhtu+PbHgqxqz8kDfpZ1idaZ1fENPCb9nwScllohRCo7ku/5NpT
         sizJIIxHRuodD3Xoq9PNxdF/Zi7VHRlSy+cGd2Fo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 081/183] scsi: qla1280: set 64bit coherent mask
Date:   Mon, 25 Feb 2019 22:10:54 +0100
Message-Id: <20190225195108.111443345@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 15a50cc7e4b36..c8589926014d4 100644
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



