Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 76057C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335E2208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335E2208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933908AbeFLABU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:01:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:39124 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932688AbeFLABR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:01:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5C01DH6021908;
        Mon, 11 Jun 2018 19:01:14 -0500
Message-ID: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
Subject: [PATCH] drivers/of: Add devm_of_iomap()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 12 Jun 2018 10:01:13 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are still quite a few cases where a device might want to get to a
different node of the device-tree, obtain the resources and map them.

Drivers doing that currently open code the whole thing, which is error
proe.

We have of_iomap() and of_io_request_and_map() but they both have shortcomings,
such as not returning the size of the resource found (which can be necessary)
and not being "managed".

This adds a devm_of_iomap() that provides all of these and should probably
replace uses of the above in most drivers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I'm cooking a driver that uses this, if there's no objection I'd like
to carry it in my pull request for that driver (it can also exist in
the DT tree of course). Just let me know.

 drivers/of/address.c       | 35 +++++++++++++++++++++++++++++++++++
 include/linux/of_address.h |  5 +++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index cf83c05f5650..b7d49ee7b690 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -807,6 +807,41 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
 }
 EXPORT_SYMBOL(of_io_request_and_map);
 
+/*
+ * devm_of_iomap - Requests a resource and maps the memory mapped IO
+ *		   for a given device_node managed by a given device
+ *
+ * Checks that a resource is a valid memory region, requests the memory
+ * region and ioremaps it. All operations are managed and will be undone
+ * on driver detach of the device.
+ *
+ * This is to be used when a device requests/maps resources described
+ * by other device tree nodes (children or otherwise).
+ *
+ * @dev:	The device "managing" the resource
+ * @node:       The device-tree node where the resource resides
+ * @index:	index of the MMIO range in the "reg" property
+ * @size:	Returns the size of the resource (pass NULL if not needed)
+ * Returns a pointer to the requested and mapped memory or an ERR_PTR() encoded
+ * error code on failure. Usage example:
+ *
+ *	base = devm_of_iomap(&pdev->dev, node, 0, NULL);
+ *	if (IS_ERR(base))
+ *		return PTR_ERR(base);
+ */
+void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
+			    resource_size_t *size)
+{
+	struct resource res;
+
+	if (of_address_to_resource(node, index, &res))
+		return IOMEM_ERR_PTR(-EINVAL);
+	if (size)
+		*size = resource_size(&res);
+	return devm_ioremap_resource(dev, &res);
+}
+EXPORT_SYMBOL(devm_of_iomap);
+
 /**
  * of_dma_get_range - Get DMA range info
  * @np:		device node to get DMA range info
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 37864734ca50..2649232a2b26 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -40,6 +40,11 @@ extern void __iomem *of_iomap(struct device_node *device, int index);
 void __iomem *of_io_request_and_map(struct device_node *device,
 				    int index, const char *name);
 
+/* Request and map, wrapper on devm_ioremap_resource */
+extern void __iomem *devm_of_iomap(struct device *dev,
+				   struct device_node *node, int index,
+				   resource_size_t *size);
+
 /* Extract an address from a device, returns the region size and
  * the address space flags too. The PCI version uses a BAR number
  * instead of an absolute index


