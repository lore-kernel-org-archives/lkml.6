Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE28C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A0220893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kPxec/ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A0220893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeG3JMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:12:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeG3JMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rU27RagDkvHjsHn3c57V0keubLSNYTdb6SZeYlUHUOg=; b=kPxec/ecPIpTjfSPZIiXKuWcu
        KKa30EFYAKu1OPqaODWLyUoBVqbHjhWhb8KVN9HtHSinSy7iTm5M90rEVGDh9Y7vpaxTMXbKHpkoy
        008ThAEi3YYEUD3oTUQgZL+k6IUAjAlZPa4bNkXyYTsgswwhxbQ6TVEJTEc8x1bpju7eRlGvLcqCF
        A7LavOTL4jojv2VNpNwPsG025sY7K6wE1igbx/w2jRAIH0n3A0KqCAMlpw1ULyD8NQkuJhl2MHM9Q
        xEkNPEjEBlzliD/xvOCNQCPkD6YHYn4GRTXDXPPoxJQYcFyzt9wqgEG4JR9/iiUssf7NUUgVUtwjv
        zVJ5SXrMw==;
Received: from 089144213232.atnat0022.highway.a1.net ([89.144.213.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk2lR-0000rU-2a; Mon, 30 Jul 2018 07:38:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-pci@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common code
Date:   Mon, 30 Jul 2018 09:38:42 +0200
Message-Id: <20180730073842.16092-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing arch specific about PCI or dma-debug, so move this
call to common code just after registering the bus type.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma.c | 3 ---
 arch/sh/drivers/pci/pci.c | 2 --
 arch/x86/kernel/pci-dma.c | 3 ---
 drivers/pci/pci-driver.c  | 2 +-
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 155170d70324..dbfc7056d7df 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -357,9 +357,6 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
 
 static int __init dma_init(void)
 {
-#ifdef CONFIG_PCI
-	dma_debug_add_bus(&pci_bus_type);
-#endif
 #ifdef CONFIG_IBMVIO
 	dma_debug_add_bus(&vio_bus_type);
 #endif
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index e5b7437ab4af..8256626bc53c 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -160,8 +160,6 @@ static int __init pcibios_init(void)
 	for (hose = hose_head; hose; hose = hose->next)
 		pcibios_scanbus(hose);
 
-	dma_debug_add_bus(&pci_bus_type);
-
 	pci_initialized = 1;
 
 	return 0;
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index ab5d9dd668d2..43f58632f123 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -155,9 +155,6 @@ static int __init pci_iommu_init(void)
 {
 	struct iommu_table_entry *p;
 
-#ifdef CONFIG_PCI
-	dma_debug_add_bus(&pci_bus_type);
-#endif
 	x86_init.iommu.iommu_init();
 
 	for (p = __iommu_table; p < __iommu_table_end; p++) {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6792292b5fc7..bef17c3fca67 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1668,7 +1668,7 @@ static int __init pci_driver_init(void)
 	if (ret)
 		return ret;
 #endif
-
+	dma_debug_add_bus(&pci_bus_type);
 	return 0;
 }
 postcore_initcall(pci_driver_init);
-- 
2.18.0

