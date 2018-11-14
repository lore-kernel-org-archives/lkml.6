Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77E0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D44D223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VhtqkC1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D44D223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbeKNS0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:26:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeKNS0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ojn3hRaifuiWPVnO+cN83IVjVfWmL3wmTfXzmmsF6EI=; b=VhtqkC1OiXLcx+lQyQiJ/IVIry
        TWPJ6ZrQmqmN7ksFo8aGFKWuiUosXXhsbRbrbLnfbpJa3hKLvLoyc8CjCkrkdWHOwww6RatpYrwT3
        wz/SqNb/QArO1gcLQzU9Oxd70PegNiwuyZvqav1hQ89XBxLD23r1EvIzb9mC9f5cuvftF2Iv/3bh1
        DVQkjsVD5N6LrHantJGheNQQP7ueiQmFgvSZuk+6rVD5cX162hmehiGgfpNrgLiN8zAJDsmajz/52
        /yk0r/u6JCE6U2qiGzi2g5DvuZlCQIrsdIW0RmdUF2zpcTS//lzHOVpzl1r8TwPDhoH/reBvaTkPN
        LNxatDaA==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqTG-000524-79; Wed, 14 Nov 2018 08:24:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/34] powerpc/dma: move pci_dma_dev_setup_swiotlb to fsl_pci.c
Date:   Wed, 14 Nov 2018 09:23:04 +0100
Message-Id: <20181114082314.8965-25-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_dma_dev_setup_swiotlb is only used by the fsl_pci code, and closely
related to it, so fsl_pci.c seems like a better place for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/swiotlb.h |  2 --
 arch/powerpc/kernel/dma-swiotlb.c  | 11 -----------
 arch/powerpc/sysdev/fsl_pci.c      |  9 +++++++++
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/swiotlb.h b/arch/powerpc/include/asm/swiotlb.h
index f65ecf57b66c..26a0f12b835b 100644
--- a/arch/powerpc/include/asm/swiotlb.h
+++ b/arch/powerpc/include/asm/swiotlb.h
@@ -18,8 +18,6 @@ extern const struct dma_map_ops powerpc_swiotlb_dma_ops;
 extern unsigned int ppc_swiotlb_enable;
 int __init swiotlb_setup_bus_notifier(void);
 
-extern void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev);
-
 #ifdef CONFIG_SWIOTLB
 void swiotlb_detect_4g(void);
 #else
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 678811abccfc..38a2c9f5ab54 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -63,17 +63,6 @@ const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.get_required_mask = swiotlb_powerpc_get_required,
 };
 
-void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev)
-{
-	struct pci_controller *hose;
-	struct dev_archdata *sd;
-
-	hose = pci_bus_to_host(pdev->bus);
-	sd = &pdev->dev.archdata;
-	sd->max_direct_dma_addr =
-		hose->dma_window_base_cur + hose->dma_window_size;
-}
-
 static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
 				  unsigned long action, void *data)
 {
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 918be816b097..561f97d698cc 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -114,6 +114,15 @@ static struct pci_ops fsl_indirect_pcie_ops =
 static u64 pci64_dma_offset;
 
 #ifdef CONFIG_SWIOTLB
+static void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct dev_archdata *sd = &pdev->dev.archdata;
+
+	sd->max_direct_dma_addr =
+		hose->dma_window_base_cur + hose->dma_window_size;
+}
+
 static void setup_swiotlb_ops(struct pci_controller *hose)
 {
 	if (ppc_swiotlb_enable) {
-- 
2.19.1

