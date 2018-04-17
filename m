Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeDQNfo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:35:44 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:46427 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeDQNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:35:43 -0400
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: ysato@users.sourceforge.jp, dalias@libc.org,
        thomas.petazzoni@free-electrons.com, robin.murphy@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: mm: Fix unprotected access to struct device
Date: Tue, 17 Apr 2018 15:35:23 +0200
Message-Id: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping
operations observe dev->dma_pfn_offset") the generic DMA allocation
function on which the SH 'dma_alloc_coherent()' function relies on,
access the 'dma_pfn_offset' field of struct device.

Unfortunately the 'dma_generic_alloc_coherent()' function is called from
several places with a NULL struct device argument, halting the CPU
during the boot process.

This patch fixes the issue protecting access to dev->dma_pfn_offset,
with a trivial check for validity. It also passes a valid 'struct device'
in the 'platform_resource_setup_memory' function which is the main user
of 'dma_alloc_coherent()', and inserting a WARN_ON() check to make future
(and existing) bogus users of this function they're should provide a valid
'struct device' whenever possible.

Fixes: ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset")
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/sh/mm/consistent.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 8ce9869..b257155 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -39,6 +39,8 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 	void *ret, *ret_nocache;
 	int order = get_order(size);

+	WARN_ON(!dev);
+
 	gfp |= __GFP_ZERO;

 	ret = (void *)__get_free_pages(gfp, order);
@@ -59,7 +61,9 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,

 	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);

-	*dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
+	*dma_handle = virt_to_phys(ret);
+	if (dev)
+		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);

 	return ret_nocache;
 }
@@ -69,9 +73,14 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
 			       unsigned long attrs)
 {
 	int order = get_order(size);
-	unsigned long pfn = (dma_handle >> PAGE_SHIFT) + dev->dma_pfn_offset;
+	unsigned long pfn = (dma_handle >> PAGE_SHIFT);
 	int k;

+	WARN_ON(!dev);
+
+	if (dev)
+		pfn += dev->dma_pfn_offset;
+
 	for (k = 0; k < (1 << order); k++)
 		__free_pages(pfn_to_page(pfn + k), 0);

@@ -143,7 +152,7 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 	if (!memsize)
 		return 0;

-	buf = dma_alloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
+	buf = dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
 	if (!buf) {
 		pr_warning("%s: unable to allocate memory\n", name);
 		return -ENOMEM;
--
2.7.4
