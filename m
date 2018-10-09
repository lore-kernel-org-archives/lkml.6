Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F782C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A321479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ReTkexGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474A321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJIWOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:14:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIWOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T81c9MwxEAf/SLqkhYJXaBI8bHtTo5GTe9WBUSnscZY=; b=ReTkexGBSciYAvICZIfB9BooKe
        5cgJ5tg4MeyLiLpjn9XSy8xj+j669/nNHO66gyXdYVsP0WsyhXJPsTkCwunAET5WjuNaEbFyJ08p7
        Bf5bXKb/Qvi39haxfW+FQwNohnsToh5nROwHQjA12m30vhWVNwDvExMmki28W+mj46PK2tJUSjtDd
        flE9wzvJLwFxsJllRCim2kObVveFUNQtMIeEa3sIseAdfRW9tHwFhCzSl5emiiO++e5K8RlErEi8Q
        0LrBlBoAKgljvSNcf9YmnTd81zt8IB/qbuxC2Boib/LcSYQY9eXpfNYuv9kZDQxsJ1hhfDcYkQiDf
        byKtCa1A==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9tRt-0001Yp-Am; Tue, 09 Oct 2018 14:57:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org
Cc:     linux-atm-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] fore200e: simplify fore200e_bus usage
Date:   Tue,  9 Oct 2018 16:57:14 +0200
Message-Id: <20181009145720.32578-2-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009145720.32578-1-hch@lst.de>
References: <20181009145720.32578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have a global array of the ops, instead PCI and sbus
can have their own instances assigned in *_probe.  Also switch to C99
initializers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/atm/fore200e.c | 121 +++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 65 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 99a38115b0a8..008bd8541c61 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -106,7 +106,6 @@
 
 
 static const struct atmdev_ops   fore200e_ops;
-static const struct fore200e_bus fore200e_bus[];
 
 static LIST_HEAD(fore200e_boards);
 
@@ -664,9 +663,31 @@ fore200e_pca_proc_read(struct fore200e* fore200e, char *page)
 		   pci_dev->bus->number, PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
 }
 
+static const struct fore200e_bus fore200e_pci_ops = {
+	.model_name		= "PCA-200E",
+	.proc_name		= "pca200e",
+	.descr_alignment	= 32,
+	.buffer_alignment	= 4,
+	.status_alignment	= 32,
+	.read			= fore200e_pca_read,
+	.write			= fore200e_pca_write,
+	.dma_map		= fore200e_pca_dma_map,
+	.dma_unmap		= fore200e_pca_dma_unmap,
+	.dma_sync_for_cpu	= fore200e_pca_dma_sync_for_cpu,
+	.dma_sync_for_device	= fore200e_pca_dma_sync_for_device,
+	.dma_chunk_alloc	= fore200e_pca_dma_chunk_alloc,
+	.dma_chunk_free		= fore200e_pca_dma_chunk_free,
+	.configure		= fore200e_pca_configure,
+	.map			= fore200e_pca_map,
+	.reset			= fore200e_pca_reset,
+	.prom_read		= fore200e_pca_prom_read,
+	.unmap			= fore200e_pca_unmap,
+	.irq_check		= fore200e_pca_irq_check,
+	.irq_ack		= fore200e_pca_irq_ack,
+	.proc_read		= fore200e_pca_proc_read,
+};
 #endif /* CONFIG_PCI */
 
-
 #ifdef CONFIG_SBUS
 
 static u32 fore200e_sba_read(volatile u32 __iomem *addr)
@@ -855,8 +876,32 @@ static int fore200e_sba_proc_read(struct fore200e *fore200e, char *page)
 	return sprintf(page, "   SBUS slot/device:\t\t%d/'%s'\n",
 		       (regs ? regs->which_io : 0), op->dev.of_node->name);
 }
-#endif /* CONFIG_SBUS */
 
+static const struct fore200e_bus fore200e_sbus_ops = {
+	.model_name		= "SBA-200E",
+	.proc_name		= "sba200e",
+	.descr_alignment	= 32,
+	.buffer_alignent	= 64,
+	.status_alignment	= 32,
+	.read			= fore200e_sba_read,
+	.write			= fore200e_sba_write,
+	.dma_map		= fore200e_sba_dma_map,
+	.dma_unap		= fore200e_sba_dma_unmap,
+	.dma_sync_for_cpu	= fore200e_sba_dma_sync_for_cpu,
+	.dma_sync_for_device	= fore200e_sba_dma_sync_for_device,
+	.dma_chunk_alloc	= fore200e_sba_dma_chunk_alloc,
+	.dma_chunk_free		= fore200e_sba_dma_chunk_free,
+	.configure		= fore200e_sba_configure,
+	.map			= fore200e_sba_map,
+	.reset			= fore200e_sba_reset,
+	.prom_read		= fore200e_sba_prom_read,
+	.unmap			= fore200e_sba_unmap,
+	.irq_enable		= fore200e_sba_irq_enable,
+	.irq_check		= fore200e_sba_irq_check,
+	.irq_ack		= fore200e_sba_irq_ack,
+	.proc_read		= fore200e_sba_proc_read,
+};
+#endif /* CONFIG_SBUS */
 
 static void
 fore200e_tx_irq(struct fore200e* fore200e)
@@ -2631,7 +2676,6 @@ static const struct of_device_id fore200e_sba_match[];
 static int fore200e_sba_probe(struct platform_device *op)
 {
 	const struct of_device_id *match;
-	const struct fore200e_bus *bus;
 	struct fore200e *fore200e;
 	static int index = 0;
 	int err;
@@ -2639,18 +2683,17 @@ static int fore200e_sba_probe(struct platform_device *op)
 	match = of_match_device(fore200e_sba_match, &op->dev);
 	if (!match)
 		return -EINVAL;
-	bus = match->data;
 
 	fore200e = kzalloc(sizeof(struct fore200e), GFP_KERNEL);
 	if (!fore200e)
 		return -ENOMEM;
 
-	fore200e->bus = bus;
+	fore200e->bus = &fore200e_sbus_ops;
 	fore200e->bus_dev = op;
 	fore200e->irq = op->archdata.irqs[0];
 	fore200e->phys_base = op->resource[0].start;
 
-	sprintf(fore200e->name, "%s-%d", bus->model_name, index);
+	sprintf(fore200e->name, "SBA-200E-%d", index);
 
 	err = fore200e_init(fore200e, &op->dev);
 	if (err < 0) {
@@ -2678,7 +2721,6 @@ static int fore200e_sba_remove(struct platform_device *op)
 static const struct of_device_id fore200e_sba_match[] = {
 	{
 		.name = SBA200E_PROM_NAME,
-		.data = (void *) &fore200e_bus[1],
 	},
 	{},
 };
@@ -2698,7 +2740,6 @@ static struct platform_driver fore200e_sba_driver = {
 static int fore200e_pca_detect(struct pci_dev *pci_dev,
 			       const struct pci_device_id *pci_ent)
 {
-    const struct fore200e_bus* bus = (struct fore200e_bus*) pci_ent->driver_data;
     struct fore200e* fore200e;
     int err = 0;
     static int index = 0;
@@ -2719,20 +2760,19 @@ static int fore200e_pca_detect(struct pci_dev *pci_dev,
 	goto out_disable;
     }
 
-    fore200e->bus       = bus;
+    fore200e->bus       = &fore200e_pci_ops;
     fore200e->bus_dev   = pci_dev;    
     fore200e->irq       = pci_dev->irq;
     fore200e->phys_base = pci_resource_start(pci_dev, 0);
 
-    sprintf(fore200e->name, "%s-%d", bus->model_name, index - 1);
+    sprintf(fore200e->name, "PCA-200E-%d", index - 1);
 
     pci_set_master(pci_dev);
 
-    printk(FORE200E "device %s found at 0x%lx, IRQ %s\n",
-	   fore200e->bus->model_name, 
+    printk(FORE200E "device PCA-200E found at 0x%lx, IRQ %s\n",
 	   fore200e->phys_base, fore200e_irq_itoa(fore200e->irq));
 
-    sprintf(fore200e->name, "%s-%d", bus->model_name, index);
+    sprintf(fore200e->name, "PCA-200E-%d", index);
 
     err = fore200e_init(fore200e, &pci_dev->dev);
     if (err < 0) {
@@ -2767,8 +2807,7 @@ static void fore200e_pca_remove_one(struct pci_dev *pci_dev)
 
 
 static const struct pci_device_id fore200e_pca_tbl[] = {
-    { PCI_VENDOR_ID_FORE, PCI_DEVICE_ID_FORE_PCA200E, PCI_ANY_ID, PCI_ANY_ID,
-      0, 0, (unsigned long) &fore200e_bus[0] },
+    { PCI_VENDOR_ID_FORE, PCI_DEVICE_ID_FORE_PCA200E, PCI_ANY_ID, PCI_ANY_ID },
     { 0, }
 };
 
@@ -3108,8 +3147,7 @@ module_init(fore200e_module_init);
 module_exit(fore200e_module_cleanup);
 
 
-static const struct atmdev_ops fore200e_ops =
-{
+static const struct atmdev_ops fore200e_ops = {
 	.open       = fore200e_open,
 	.close      = fore200e_close,
 	.ioctl      = fore200e_ioctl,
@@ -3121,53 +3159,6 @@ static const struct atmdev_ops fore200e_ops =
 	.owner      = THIS_MODULE
 };
 
-
-static const struct fore200e_bus fore200e_bus[] = {
-#ifdef CONFIG_PCI
-    { "PCA-200E", "pca200e", 32, 4, 32, 
-      fore200e_pca_read,
-      fore200e_pca_write,
-      fore200e_pca_dma_map,
-      fore200e_pca_dma_unmap,
-      fore200e_pca_dma_sync_for_cpu,
-      fore200e_pca_dma_sync_for_device,
-      fore200e_pca_dma_chunk_alloc,
-      fore200e_pca_dma_chunk_free,
-      fore200e_pca_configure,
-      fore200e_pca_map,
-      fore200e_pca_reset,
-      fore200e_pca_prom_read,
-      fore200e_pca_unmap,
-      NULL,
-      fore200e_pca_irq_check,
-      fore200e_pca_irq_ack,
-      fore200e_pca_proc_read,
-    },
-#endif
-#ifdef CONFIG_SBUS
-    { "SBA-200E", "sba200e", 32, 64, 32,
-      fore200e_sba_read,
-      fore200e_sba_write,
-      fore200e_sba_dma_map,
-      fore200e_sba_dma_unmap,
-      fore200e_sba_dma_sync_for_cpu,
-      fore200e_sba_dma_sync_for_device,
-      fore200e_sba_dma_chunk_alloc,
-      fore200e_sba_dma_chunk_free,
-      fore200e_sba_configure,
-      fore200e_sba_map,
-      fore200e_sba_reset,
-      fore200e_sba_prom_read,
-      fore200e_sba_unmap,
-      fore200e_sba_irq_enable,
-      fore200e_sba_irq_check,
-      fore200e_sba_irq_ack,
-      fore200e_sba_proc_read,
-    },
-#endif
-    {}
-};
-
 MODULE_LICENSE("GPL");
 #ifdef CONFIG_PCI
 #ifdef __LITTLE_ENDIAN__
-- 
2.19.0

