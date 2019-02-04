Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B52C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CA3214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fMj/QMoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfBDOYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:24:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43186 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbfBDOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:24:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14ENSEF031947;
        Mon, 4 Feb 2019 08:23:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549290208;
        bh=0+KyfIOVDeytTSCzB8JNujMdAyrnWVoo29rT5qH9ivQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fMj/QMoA2crKpPHMx69PccjBGiLr+7UnxRlLm+JPaBsTOzDoRtQC6BJMmCOJPEed+
         S3j7ff6mayK93hhMgrq3EhmlzwQ7hFdAHpYO4xZBKe2wbTme2Of/Qv/G4iagly1oGt
         iEPHkn97OvgIwpqAqJ3Lk9GC+91CVRvOoPGchnG4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14ENStT010352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 08:23:28 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 08:23:27 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 08:23:27 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14EMoKg012232;
        Mon, 4 Feb 2019 08:23:24 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>, <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH v2 08/14] remoteproc: Add support to handle device specific resource types
Date:   Mon, 4 Feb 2019 16:22:41 +0200
Message-ID: <1549290167-876-9-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549290167-876-1-git-send-email-rogerq@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
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
make sense for the framework to handle it.

For instance, a remoteproc implementation might want timers information
embedded in the resource table so that the driver could parse the binary
and enable accordingly. Another example would be hwspinlocks that it
is using, to properly share system wide resources. The PRU interrupt
controller's interrupt-map could be provided via a vendor specific
resource.

This patch adds a function pointer to the list of rproc_ops for the
driver implementation to handle such custom vendor resources.

[rogerq@ti.com] Get rid of pre/post loaders. Show in debugfs.
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/remoteproc/remoteproc_core.c    | 36 +++++++++++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_debugfs.c |  3 +++
 include/linux/remoteproc.h              | 17 ++++++++++++++--
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 2d9646f..b43aa40 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -896,6 +896,41 @@ void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
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
@@ -983,6 +1018,7 @@ static rproc_handle_resource_t rproc_loading_handlers[RSC_LAST] = {
 	[RSC_CARVEOUT] = (rproc_handle_resource_t)rproc_handle_carveout,
 	[RSC_DEVMEM] = (rproc_handle_resource_t)rproc_handle_devmem,
 	[RSC_TRACE] = (rproc_handle_resource_t)rproc_handle_trace,
+	[RSC_VENDOR] = (rproc_handle_resource_t)rproc_handle_vendor_rsc,
 	[RSC_VDEV] = (rproc_handle_resource_t)rproc_handle_vdev,
 };
 
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index e90135c..ef66165 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -230,6 +230,9 @@ static int rproc_rsc_table_show(struct seq_file *seq, void *p)
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
index b5aa5fb..9f4c457 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -100,6 +100,7 @@ struct fw_rsc_hdr {
  *		    the remote processor will be writing logs.
  * @RSC_VDEV:       declare support for a virtio device, and serve as its
  *		    virtio header.
+ * @RSC_VENDOR:	    vendor specific resource type.
  * @RSC_LAST:       just keep this one at the end
  *
  * For more details regarding a specific resource type, please see its
@@ -115,7 +116,8 @@ enum fw_resource_type {
 	RSC_DEVMEM	= 1,
 	RSC_TRACE	= 2,
 	RSC_VDEV	= 3,
-	RSC_LAST	= 4,
+	RSC_VENDOR	= 4,
+	RSC_LAST,
 };
 
 #define FW_RSC_ADDR_ANY (-1)
@@ -308,6 +310,14 @@ struct fw_rsc_vdev {
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
@@ -347,7 +357,8 @@ struct firmware;
  * @da_to_va:	optional platform hook to perform address translations
  * @load_rsc_table:	load resource table from firmware image
  * @find_loaded_rsc_table: find the loaded resouce table
- * @load:		load firmeware to memory, where the remote processor
+ * @handle_vendor_rsc:	hook to handle device specific resource table entries
+ * @load:		load firmware to memory, where the remote processor
  *			expects to find it
  * @sanity_check:	sanity check the fw image
  * @get_boot_addr:	get boot address to entry point specified in firmware
@@ -360,6 +371,8 @@ struct rproc_ops {
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

