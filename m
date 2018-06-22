Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6812C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A394723D15
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A394723D15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeFVEcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 00:32:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:60869 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbeFVEcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 00:32:00 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5M4VZ5Z007407;
        Thu, 21 Jun 2018 23:31:40 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 01/14] devres: Add devm_of_iomap()
Date:   Fri, 22 Jun 2018 14:31:21 +1000
Message-Id: <20180622043134.18238-2-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622043134.18238-1-benh@kernel.crashing.org>
References: <20180622043134.18238-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are still quite a few cases where a device might want
to get to a different node of the device-tree, obtain the
resources and map them.

We have of_iomap() and of_io_request_and_map() but they both
have shortcomings, such as not returning the size of the
resource found (which can be useful) and not being "managed".

This adds a devm_of_iomap() that provides all of these and
should probably replace uses of the above in most drivers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 include/linux/device.h |  4 ++++
 lib/devres.c           | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 477956990f5e..96249d790374 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -688,6 +688,10 @@ extern void devm_free_pages(struct device *dev, unsigned long addr);
 
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
 
+void __iomem *devm_of_iomap(struct device *dev,
+			    struct device_node *node, int index,
+			    resource_size_t *size);
+
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
diff --git a/lib/devres.c b/lib/devres.c
index 5bec1120b392..faccf1a037d0 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -4,6 +4,7 @@
 #include <linux/io.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
+#include <linux/of_address.h>
 
 enum devm_ioremap_type {
 	DEVM_IOREMAP = 0,
@@ -162,6 +163,41 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 }
 EXPORT_SYMBOL(devm_ioremap_resource);
 
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
 #ifdef CONFIG_HAS_IOPORT_MAP
 /*
  * Generic iomap devres
-- 
2.17.1

