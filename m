Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbeFAKRV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:17:21 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:40803 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeFAKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:17:18 -0400
Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
To: Radhey Shyam Pandey <radheys@xilinx.com>,
        Vinod Koul <vinod.koul@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
 <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
 <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
 <78828d31-e4cd-5211-f1b6-8918ac38f599@ti.com>
 <e5a6c1ad-e263-7b9d-a5e2-744884c9d6de@metafoo.de>
 <a6ac9ca8-91b4-c7b1-0f0c-c04dd10048e2@ti.com>
 <d7432292-cedd-7d61-f219-8b63eb6c1d50@metafoo.de>
 <8c7a5ac8-0747-9dad-f6e5-74890b64f618@ti.com>
 <20180424035548.GA6014@localhost>
 <ee1dc551-7c11-6d10-651d-01bf6520f049@ti.com>
 <MWHPR02MB3293486390485A6FCCEA7DECC7910@MWHPR02MB3293.namprd02.prod.outlook.com>
 <99581088-7ef8-6fac-c934-91eadddfb04e@ti.com>
 <DM6PR02MB43612FF66323449C7D2B4FDCC76C0@DM6PR02MB4361.namprd02.prod.outlook.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
Date: Fri, 1 Jun 2018 13:17:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <DM6PR02MB43612FF66323449C7D2B4FDCC76C0@DM6PR02MB4361.namprd02.prod.outlook.com>
Content-Type: multipart/mixed;
        boundary="------------CFD7AA2DD37D5BB890FA9895"
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------CFD7AA2DD37D5BB890FA9895
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Radhey,

On 2018-05-30 20:29, Radhey Shyam Pandey wrote:
>> In couple of days I can update the metadata patches I have atm and send
>> as RFC.
>>
>> Is there anything from your side I should take into account when doing that?
> I think a generic interface to attach/share metadata buffer b/w client and the
> dmaengine driver is good enough. Is metadata patchset (early version) 
> available in TI external repos? 

I don't have it in public repository, but now that the TRM is public I
can start preparing things for upstream.

I have attached the patch I ended up with, but I need to add the
documentation part.

Since the 'metadata' is part of the DMA descriptor itself I thought that
it might be better to reflect that -> the metadata_ops is part of the
dma_async_tx_descriptor struct.

DMA drivers can initialize it when it is supported by the channel or
setup. In my case it is optional, many peripherals did not use it at all.

I have two modes to deal with the metadata:
1. attach mode
Client drivers are giving a buffer and a size to the DMA driver and in
case of TX the data is copied to the descriptor's metadata part. In case
of RX when the transfer is completed the DMA driver will copy the data
from the DMA descriptor to the client provided buffer.
Here we need one memcpy for each descriptor.

2. pointer mode
If we have high throughput peripheral, the per descriptor memcpy can be
an obstacle for performance.

TX: The client dmaengine_desc_get_metadata_ptr() to get the pointer to
the metadata section of the descriptor, it will receive back the max
size and the currently used size (important for RX). This is done before
issue_pending().
The client can update the metadata directly and when it is done calls
the dmaengine_desc_set_metadata_len() to tell the DMA driver the size of
the metadata it has configured.

RX: in the DMA callback the client calls
dmaengine_desc_get_metadata_ptr() to get the pointer and the size of the
metadata we have received and can process the information w/o memcpy.

I think it might be better to rename these from metadata to client_data
or something. It is part of the DMA descriptor, passed along with the
DMA descriptor, but it is owned by the client driver.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--------------CFD7AA2DD37D5BB890FA9895
Content-Type: text/x-patch;
	name="0001-dmaengine-Add-metadat_ops-for-dma_async_tx_descripto.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-dmaengine-Add-metadat_ops-for-dma_async_tx_descripto.pa";
	filename*1="tch"

>From cdd04a5876d5e2b1e10b4e5456585958715fd3a7 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 20 Apr 2018 15:10:08 +0300
Subject: [PATCH] dmaengine: Add metadat_ops for dma_async_tx_descriptor

If the DMA supports per descriptor metadata it can implement the attach,
get_ptr/set_len callbacks.

Client drivers must only use either attach or get_ptr/set_len to avoid
miss configuration.

Wrappers are also added for the metadata_ops:
dmaengine_desc_attach_metadata()
dmaengine_desc_get_metadata_ptr()
dmaengine_desc_set_metadata_len()

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/dmaengine.h | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 51fbb861e84b..ac42ace36aa3 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -491,6 +491,18 @@ struct dmaengine_unmap_data {
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
@@ -520,6 +532,7 @@ struct dma_async_tx_descriptor {
 	dma_async_tx_callback_result callback_result;
 	void *callback_param;
 	struct dmaengine_unmap_data *unmap;
+	struct dma_descriptor_metadata_ops *metadata_ops;
 #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	struct dma_async_tx_descriptor *next;
 	struct dma_async_tx_descriptor *parent;
@@ -932,6 +945,43 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
 						    len, flags);
 }
 
+static inline int dmaengine_desc_attach_metadata(
+		struct dma_async_tx_descriptor *desc, void *data, size_t len)
+{
+	if (!desc)
+		return 0;
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
+	if (!desc)
+		return NULL;
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
+	if (!desc)
+		return 0;
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


--------------CFD7AA2DD37D5BB890FA9895--
