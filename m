Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD56C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ED320672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uD43LAaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32ED320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeKZSqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:46:30 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39990 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeKZSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:46:29 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7r7jg060667;
        Mon, 26 Nov 2018 01:53:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218787;
        bh=/8OOFvUtRXDDErHhknGp1JRwOhjztgiZLV4bXOTe2ec=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uD43LAaWZa2wjbgaAAy9bhLLOIBZMUPUDhppQpoXmXKlhbP+Ve14ge/lihKULhGEW
         9I4DcpNBMJk8bT3Azv5O7gEVfN0qgha62x7YkPrnDDUQn1Q50Fyc+BmRIqTs7uYA0b
         kPGj+UYGNdod6LmJvRkL688PUOhB2tkRJ4mrId70=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7r7M9038014
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:07 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:06 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:06 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7r6Jo002217;
        Mon, 26 Nov 2018 01:53:06 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1H024490;
        Mon, 26 Nov 2018 01:53:02 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 03/16] remoteproc: Add support to handle device specific resource types
Date:   Mon, 26 Nov 2018 09:52:36 +0200
Message-ID: <1543218769-5507-4-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543218769-5507-1-git-send-email-rogerq@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The remoteproc framework handles a fixed set of resource table entries
today. To make it scalable across multiple platforms, it makes sense
for the framework to provide a way for the device specific implementation
to define and handle vendor specific resource types. These resource types
would be very specific to an implementation instance that it does not
make sense for the framework to handle it. There can be two types of
such resources depending on whether they need to be handled prior to
the loading of the firmware segments or after. A post-loading resource
type is typically needed because it references a loaded segment pointer
for conveying the resource information.

For instance, a remoteproc implementation might want timers information
embedded in the resource table so that the driver could parse the binary
and enable accordingly. Another example would be hwspinlocks that it
is using, to properly share system wide resources. A PRU post-loading
vendor resource handler for interrupts requires the PRU event - interrupt
channel information to be loaded into device memory.

This patch adds a function pointer to the list of rproc_ops for the
driver implementation to handle such custom vendor resources, and
reuses the same handler between pre-loading and post-loading resource
types, with the sub-types in the implementation handling the processing
of those resource types.

Signed-off-by: Suman Anna <s-anna@ti.com>

merge: remoteproc: simplify VENDOR specific resource

We don't need PRE and POST loading as we'll fix the PRU resource
table to be self sufficient.

Earlier it was half baked with channel mapping located elsewhere
in data section thus requiring data section to be loaded before
we can figure out the full INTC map.

Fix vendor resource to be TLV and definition agnostic.

Show in debugfs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/remoteproc/remoteproc_core.c    | 36 +++++++++++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_debugfs.c |  3 +++
 include/linux/remoteproc.h              | 15 +++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 581e6e8..9e387ab 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -898,6 +898,41 @@ void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
 EXPORT_SYMBOL(rproc_add_carveout);
 
 /**
+ * rproc_handle_vendor_rsc() - provide implementation specific hook
+ *			       to handle vendor/custom resources
+ * @rproc: the remote processor
+ * @rsc: vendor resource to be handled by remoteproc drivers
+ * @offset: offset of the resource data in resource table
+ * @avail: size of available data
+ *
+ * Remoteproc implementations might want to add resource table entries
+ * that are not generic enough to be handled by the framework. This
+ * provides a hook to handle such custom resources.
+ *
+ * Returns 0 on success, or an appropriate error code otherwise
+ */
+static int rproc_handle_vendor_rsc(struct rproc *rproc,
+				   struct fw_rsc_vendor *rsc,
+				   int offset, int avail)
+{
+	struct device *dev = &rproc->dev;
+
+	if (sizeof(*rsc) > avail) {
+		dev_err(dev, "vendor rsc is truncated\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "vendor rsc:");
+
+	if (!rproc->ops->handle_vendor_rsc) {
+		dev_err(dev, "no vendor rsc handler! ignoring resource\n");
+		return 0;
+	}
+
+	return rproc->ops->handle_vendor_rsc(rproc, (void *)rsc);
+}
+
+/**
  * rproc_mem_entry_init() - allocate and initialize rproc_mem_entry struct
  * @dev: pointer on device struct
  * @va: virtual address
@@ -985,6 +1020,7 @@ static rproc_handle_resource_t rproc_loading_handlers[RSC_LAST] = {
 	[RSC_CARVEOUT] = (rproc_handle_resource_t)rproc_handle_carveout,
 	[RSC_DEVMEM] = (rproc_handle_resource_t)rproc_handle_devmem,
 	[RSC_TRACE] = (rproc_handle_resource_t)rproc_handle_trace,
+	[RSC_VENDOR] = (rproc_handle_resource_t)rproc_handle_vendor_rsc,
 	[RSC_VDEV] = (rproc_handle_resource_t)rproc_handle_vdev,
 };
 
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index f330a9a..971c8ba 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -254,6 +254,9 @@ static int rproc_rsc_table_show(struct seq_file *seq, void *p)
 					   v->vring[j].pa);
 			}
 			break;
+		case RSC_VENDOR:
+			seq_printf(seq, "Entry %d is of type %s [Vendor specific]\n",
+				   i, types[hdr->type]);
 		default:
 			seq_printf(seq, "Unknown resource type found: %d [hdr: %pK]\n",
 				   hdr->type, hdr);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 063468b..4881415 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -101,6 +101,7 @@ struct fw_rsc_hdr {
  *		    the remote processor will be writing logs.
  * @RSC_VDEV:       declare support for a virtio device, and serve as its
  *		    virtio header.
+ * @RSC_VENDOR:	    vendor specific resource type.
  * @RSC_LAST:       just keep this one at the end
  *
  * For more details regarding a specific resource type, please see its
@@ -116,7 +117,8 @@ enum fw_resource_type {
 	RSC_DEVMEM	= 1,
 	RSC_TRACE	= 2,
 	RSC_VDEV	= 3,
-	RSC_LAST	= 4,
+	RSC_VENDOR	= 4,
+	RSC_LAST,
 };
 
 #define FW_RSC_ADDR_ANY (-1)
@@ -309,6 +311,14 @@ struct fw_rsc_vdev {
 struct rproc;
 
 /**
+ * struct fw_rsc_vendor - vendor specific resource definition
+ * @data: resource data. vendor defined.
+ */
+struct fw_rsc_vendor {
+	u8 data[0];
+} __packed;
+
+/**
  * struct rproc_mem_entry - memory entry descriptor
  * @va:	virtual address
  * @dma: dma address
@@ -361,6 +371,7 @@ struct firmware;
  * @da_to_va:	optional platform hook to perform address translations
  * @parse_fw:	parse firmware to extract information (e.g. resource table)
  * @find_loaded_rsc_table: find the loaded resouce table
+ * @handle_vendor_rsc:	hook to handle device specific resource table entries
  * @load:		load firmware to memory, where the remote processor
  *			expects to find it
  * @sanity_check:	sanity check the fw image
@@ -374,6 +385,8 @@ struct rproc_ops {
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
 	struct resource_table *(*find_loaded_rsc_table)(
 				struct rproc *rproc, const struct firmware *fw);
+	int (*handle_vendor_rsc)(struct rproc *rproc,
+				 struct fw_rsc_vendor *rsc);
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
 	u32 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

