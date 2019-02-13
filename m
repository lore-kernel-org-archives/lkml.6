Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D24FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA9D20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WVhGUKtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbfBMHCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:02:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388157AbfBMHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lAOO1HC++5Mrs6514jGpFnMwjmjeCUdU2nzNgRqcG90=; b=WVhGUKtAhUxjvbnMuEdVCCDUJH
        ADClSN9k6qwTeTwX4/DFGDgSmPVw6rNphgKx5uucbUjU7tGFKx7uS/99itai6X78hJ4GZ1TrnDHqO
        ul9ANybdYx5hfPnmNTqjmicGrNVfDlKpsLSLh+dSbgB2t43ycgj3YClF1/xm6g7se5bBmbEk1sj9y
        xwOaXAy0S0GY4rYVRg7BPhD7pj3zpIdnL/D29FYvCbvnF+kwblSwqZT91bgORwc16MQaXKE5r07OZ
        84zRMQmWNs4OYtrDrip6hm1uIPjpZBxe8N83YnL8LTJCPAtQSGdD9spQSYNIe5P+NY/tMif7TK64T
        Khv0IaFg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoYV-0000Ip-5F; Wed, 13 Feb 2019 07:02:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/32] powerpc/powernv: remove pnv_npu_dma_set_mask
Date:   Wed, 13 Feb 2019 08:01:13 +0100
Message-Id: <20190213070133.11259-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These devices are not PCIe devices and do not have associated dma map
ops, so this is just dead code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d9060a0f4c8e..23ffbc71589a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3646,14 +3646,6 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
-static int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask)
-{
-	dev_err_once(&npdev->dev,
-			"%s operation unsupported for NVLink devices\n",
-			__func__);
-	return -EPERM;
-}
-
 static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.dma_dev_setup		= pnv_pci_dma_dev_setup,
 	.setup_msi_irqs		= pnv_setup_msi_irqs,
@@ -3661,7 +3653,6 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.enable_device_hook	= pnv_pci_enable_device_hook,
 	.window_alignment	= pnv_pci_window_alignment,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
-	.dma_set_mask		= pnv_npu_dma_set_mask,
 	.shutdown		= pnv_pci_ioda_shutdown,
 	.disable_device		= pnv_npu_disable_device,
 };
-- 
2.20.1

