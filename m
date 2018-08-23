Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D73AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45CF2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LGbrMYn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45CF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbeHWQhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:37:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44446 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeHWQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:37:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7ND78og039346;
        Thu, 23 Aug 2018 08:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535029628;
        bh=RVgELN6UWU8yeoE+0Dbn7KKQWqnLimMcmmLCXqqMwkw=;
        h=From:To:CC:Subject:Date;
        b=LGbrMYn+viOiGVaOjElJzbd6a/f715gdpok25ppvpv39QLjY9uiZM+wsdTZW784sg
         HtnomnD31wjpULwQSgAm9X7p7fiZN/iMM8fxatNYBpFYnC3uBfNQyI9UVVvqgo+O35
         g2LOHFREWEyv0LCmlTuHtSGDvn+o3yTGfKFvHu4Q=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7ND78eB013295;
        Thu, 23 Aug 2018 08:07:08 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 23
 Aug 2018 08:07:08 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 23 Aug 2018 08:07:08 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7ND75GJ029083;
        Thu, 23 Aug 2018 08:07:06 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <radheys@xilinx.com>
Subject: [PATCH] dmaengine: Add metadata_ops for dma_async_tx_descriptor
Date:   Thu, 23 Aug 2018 16:07:28 +0300
Message-ID: <20180823130728.20506-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metadata is best described as side band data or parameters traveling
alongside the data DMAd by the DMA engine. It is data
which is understood by the peripheral and the peripheral driver only, the
DMA engine see it only as data block and it is not interpreting it in any
way.

The metadata can be different per descriptor as it is a parameter for the
data being transferred.

If the DMA supports per descriptor metadata it can implement the attach,
get_ptr/set_len callbacks.

Client drivers must only use either attach or get_ptr/set_len to avoid
miss configuration.

Client driver can check if a given metadata mode is supported by the
channel during probe time with
dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_CLIENT);
dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_ENGINE);

and based on this information can use either mode.

Wrappers are also added for the metadata_ops.

To be used in DESC_METADATA_CLIENT mode:
dmaengine_desc_attach_metadata()

To be used in DESC_METADATA_ENGINE mode:
dmaengine_desc_get_metadata_ptr()
dmaengine_desc_set_metadata_len()

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since rfc:
- DESC_METADATA_EMBEDDED renamed to DESC_METADATA_ENGINE
- Use flow is added for both CLIENT and ENGINE metadata modes

Regards,
Peter

 include/linux/dmaengine.h | 144 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 3db833a8c542..f809635cfeaa 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -231,6 +231,57 @@ typedef struct { DECLARE_BITMAP(bits, DMA_TX_TYPE_END); } dma_cap_mask_t;
  * @bytes_transferred: byte counter
  */
 
+/**
+ * enum dma_desc_metadata_mode - per descriptor metadata mode types supported
+ * @DESC_METADATA_CLIENT - the metadata buffer is allocated/provided by the
+ *  client driver and it is attached (via the dmaengine_desc_attach_metadata()
+ *  helper) to the descriptor.
+ *
+ * Client drivers interested to use this mode can follow:
+ * - DMA_MEM_TO_DEV:
+ *   1. prepare the descriptor (dmaengine_prep_*)
+ *	construct the metadata in the clinet's buffer
+ *   2. use dmaengine_desc_attach_metadata() to attach the buffer to the
+ *	descriptor
+ *   3. submit the transfer
+ * - DMA_DEV_TO_MEM:
+ *   1. prepare the descriptor (dmaengine_prep_*)
+ *   2. use dmaengine_desc_attach_metadata() to attach the buffer to the
+ *	descriptor
+ *   3. submit the transfer
+ *   4. when the transfer is completed, the metadata should be available in the
+ *	attached buffer
+ *
+ * @DESC_METADATA_ENGINE - the metadata buffer is allocated/managed by the DMA
+ *  driver. The client driver can ask for the pointer, maximum size and the
+ *  currently used size of the metadata and can directly update or read it.
+ *  dmaengine_desc_get_metadata_ptr() and dmaengine_desc_set_metadata_len() is
+ *  provided as helper functions.
+ *
+ * Client drivers interested to use this mode can follow:
+ * - DMA_MEM_TO_DEV:
+ *   1. prepare the descriptor (dmaengine_prep_*)
+ *   2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the engine's
+ *	metadata area
+ *   3. update the metadata at the pointer
+ *   4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the amount
+ *	of data the client has placed into the metadata buffer
+ *   5. submit the transfer
+ * - DMA_DEV_TO_MEM:
+ *   1. prepare the descriptor (dmaengine_prep_*)
+ *   2. submit the transfer
+ *   3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get the
+ *	pointer to the engine's metadata are
+ *   4. Read out the metadate from the pointer
+ *
+ * Note: the two mode is not compatible and clients must use one mode for a
+ * descriptor.
+ */
+enum dma_desc_metadata_mode {
+	DESC_METADATA_CLIENT = (1 << 0),
+	DESC_METADATA_ENGINE = (1 << 1),
+};
+
 struct dma_chan_percpu {
 	/* stats */
 	unsigned long memcpy_count;
@@ -494,6 +545,18 @@ struct dmaengine_unmap_data {
 	dma_addr_t addr[0];
 };
 
+struct dma_async_tx_descriptor;
+
+struct dma_descriptor_metadata_ops {
+	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
+		      size_t len);
+
+	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
+			 size_t *payload_len, size_t *max_len);
+	int (*set_len)(struct dma_async_tx_descriptor *desc,
+		       size_t payload_len);
+};
+
 /**
  * struct dma_async_tx_descriptor - async transaction descriptor
  * ---dma generic offload fields---
@@ -523,6 +586,8 @@ struct dma_async_tx_descriptor {
 	dma_async_tx_callback_result callback_result;
 	void *callback_param;
 	struct dmaengine_unmap_data *unmap;
+	enum dma_desc_metadata_mode desc_metadata_mode;
+	struct dma_descriptor_metadata_ops *metadata_ops;
 #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	struct dma_async_tx_descriptor *next;
 	struct dma_async_tx_descriptor *parent;
@@ -685,6 +750,7 @@ struct dma_filter {
  * @global_node: list_head for global dma_device_list
  * @filter: information for device/slave to filter function/param mapping
  * @cap_mask: one or more dma_capability flags
+ * @desc_metadata_modes: supported metadata modes by the DMA device
  * @max_xor: maximum number of xor sources, 0 if no capability
  * @max_pq: maximum number of PQ sources and PQ-continue capability
  * @copy_align: alignment shift for memcpy operations
@@ -749,6 +815,7 @@ struct dma_device {
 	struct list_head global_node;
 	struct dma_filter filter;
 	dma_cap_mask_t  cap_mask;
+	enum dma_desc_metadata_mode desc_metadata_modes;
 	unsigned short max_xor;
 	unsigned short max_pq;
 	enum dmaengine_alignment copy_align;
@@ -935,6 +1002,83 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
 						    len, flags);
 }
 
+static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
+		enum dma_desc_metadata_mode mode)
+{
+	return !!(chan->device->desc_metadata_modes & mode);
+}
+
+static inline int _desc_check_and_set_metadata_mode(
+	struct dma_async_tx_descriptor *desc, enum dma_desc_metadata_mode mode)
+{
+	/* Make sure that the metadata mode is not mixed */
+	if (!desc->desc_metadata_mode) {
+		if (dmaengine_is_metadata_mode_supported(desc->chan, mode))
+			desc->desc_metadata_mode = mode;
+		else
+			return -ENOTSUPP;
+	} else if (desc->desc_metadata_mode != mode) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int dmaengine_desc_attach_metadata(
+		struct dma_async_tx_descriptor *desc, void *data, size_t len)
+{
+	int ret;
+
+	if (!desc)
+		return -EINVAL;
+
+	ret = _desc_check_and_set_metadata_mode(desc, DESC_METADATA_CLIENT);
+	if (ret)
+		return ret;
+
+	if (!desc->metadata_ops || !desc->metadata_ops->attach)
+		return -ENOTSUPP;
+
+	return desc->metadata_ops->attach(desc, data, len);
+}
+
+static inline void *dmaengine_desc_get_metadata_ptr(
+		struct dma_async_tx_descriptor *desc, size_t *payload_len,
+		size_t *max_len)
+{
+	int ret;
+
+	if (!desc)
+		return ERR_PTR(-EINVAL);
+
+	ret = _desc_check_and_set_metadata_mode(desc, DESC_METADATA_ENGINE);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!desc->metadata_ops || !desc->metadata_ops->get_ptr)
+		return ERR_PTR(-ENOTSUPP);
+
+	return desc->metadata_ops->get_ptr(desc, payload_len, max_len);
+}
+
+static inline int dmaengine_desc_set_metadata_len(
+		struct dma_async_tx_descriptor *desc, size_t payload_len)
+{
+	int ret;
+
+	if (!desc)
+		return -EINVAL;
+
+	ret = _desc_check_and_set_metadata_mode(desc, DESC_METADATA_ENGINE);
+	if (ret)
+		return ret;
+
+	if (!desc->metadata_ops || !desc->metadata_ops->set_len)
+		return -ENOTSUPP;
+
+	return desc->metadata_ops->set_len(desc, payload_len);
+}
+
 /**
  * dmaengine_terminate_all() - Terminate all active DMA transfers
  * @chan: The channel for which to terminate the transfers
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

