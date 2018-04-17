Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeDQNrM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:47:12 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:63776 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753902AbeDQNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:47:08 -0400
Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
To: Lars-Peter Clausen <lars@metafoo.de>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        Vinod Koul <vinod.koul@intel.com>
CC: "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-3-git-send-email-radheys@xilinx.com>
 <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
Date: Tue, 17 Apr 2018 16:46:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-17 15:54, Lars-Peter Clausen wrote:
> On 04/17/2018 01:43 PM, Radhey Shyam Pandey wrote:
>> Hi Vinod,
>>
>>> -----Original Message-----
>>> From: Vinod Koul [mailto:vinod.koul@intel.com]
>>> Sent: Wednesday, April 11, 2018 2:39 PM
>>> To: Radhey Shyam Pandey <radheys@xilinx.com>
>>> Cc: dan.j.williams@intel.com; michal.simek@xilinx.com; Appana Durga
>>> Kedareswara Rao <appanad@xilinx.com>; Radhey Shyam Pandey
>>> <radheys@xilinx.com>; lars@metafoo.de; dmaengine@vger.kernel.org;
>>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>>> Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control
>>> words to netdev dma client
>>>
>>> On Mon, Apr 02, 2018 at 04:09:02PM +0530, Radhey Shyam Pandey wrote:
>>>
>>>> +
>>>> +		if (chan->xdev->has_axieth_connected) {
>>>> +			seg = list_first_entry(&desc->segments,
>>>> +					struct xilinx_axidma_tx_segment,
>>> node);
>>>> +			if (cb.callback_param) {
>>>> +				app_w = (u32 *) cb.callback_param;
>>>
>>> why are you interpreting callback_param? This is plainly wrong.
>>> we do not know what is the interpretation of callback_param and it is
>>> internal to submitter.
>> In design, if AXI DMA is connected to AXI Ethernet IP there are certain
>> AXI4-Stream Status fields (RX) that we need to pass to ethernet driver
>> along with data buffer. An example includes: checksum fields, packet
>> length etc. To pass these control words there is a structure defined
>> between dmaengine and client. Before calling the client callback
>> stream control words are copied to dma client callback_param struct
>> (only if axieth is connected).
>>
>> I understand it's not an ideal way and we shouldn't be interpreting
>> callback_param but couldn't find any better alternative of passing
>> custom information from dmaengine to client driver and still be 
>> aligned to the framework.
>>
>>>
>>> What exactly is the problem you are trying to solve?
>> As mentioned above we need to pass AXI4-stream words(custom
>> data) from dmaengine driver to dma client driver(ethernet) for
>> each DMA descriptor. Current solution populates callback_param
>> struct (only if axieth is connected). Please let me know if there is
>> an alternate solution. 
> 
> The standard interfaces need to work in a way that a client using them does
> not have to know to which DMA controller it is connected. In a similar way
> the DMA controller shouldn't have any client specific logic for the generic
> interfaces. Otherwise there is no point of having a generic interface.
> 
> There are two options.
> 
> Either you extend the generic interfaces so it can cover your usecase in a
> generic way. E.g. the ability to attach meta data to transfer.

Fwiw I have this patch as part of a bigger work to achieve similar results:

commit f7cf442a37618bbd996f2640ececc4a990ea655e
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Wed Nov 22 10:21:59 2017 +0200

    dmaengine: Add callback to set per descriptor metadata
    
    Some DMA engines can send and receive side band information, commands or
    parameters which is not transferred within the data stream itself. In such
    case clients can set the metadata to the given descriptor and it is going
    to be sent to the peripheral, or in case of DEV_TO_MEM the provided buffer
    will receive the metadata.
    
    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index cc887a6f74ba..fb8e9c92fb01 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -709,6 +709,11 @@ struct dma_filter {
  *	be called after period_len bytes have been transferred.
  * @device_prep_interleaved_dma: Transfer expression in a generic way.
  * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst address
+ * @device_attach_metadata: Some DMA engines can send and receive side band
+ *	information, commands or parameters which is not transferred within the
+ *	data stream itself. In such case clients can set the metadata to the
+ *	given descriptor and it is going to be sent to the peripheral, or in
+ *	case of DEV_TO_MEM the provided buffer will receive the metadata.
  * @device_config: Pushes a new configuration to a channel, return 0 or an error
  *	code
  * @device_pause: Pauses any transfer happening on a channel. Returns
@@ -796,6 +801,9 @@ struct dma_device {
 		struct dma_chan *chan, dma_addr_t dst, u64 data,
 		unsigned long flags);
 
+	int (*device_attach_metadata)(struct dma_async_tx_descriptor *desc,
+				      void *data, size_t len);
+
 	int (*device_config)(struct dma_chan *chan,
 			     struct dma_slave_config *config);
 	int (*device_pause)(struct dma_chan *chan);
@@ -909,6 +917,21 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
 						    len, flags);
 }
 
+static inline int dmaengine_attach_metadata(
+		struct dma_async_tx_descriptor *desc, void *data, size_t len)
+{
+	struct dma_chan *chan;
+
+	if (!desc)
+		return 0;
+
+	chan = desc->chan;
+	if (!chan || !chan->device || !chan->device->device_attach_metadata)
+		return 0;
+
+	return chan->device->device_attach_metadata(desc, data, len);
+}
+
 /**
  * dmaengine_terminate_all() - Terminate all active DMA transfers
  * @chan: The channel for which to terminate the transfers

The drawback is that the DMA drivers need to do memcpy.
I'm considering to change this to get metadata_ptr() so clients can
directly write to the buffer w/o memcpy.

> Or you can implement a interface that is specific to your DMA controller and
> any client using this interface knows it is talking to your DMA controller.

Hrm, so we can have DMA driver specific calls? The reason why TI's keystone 2
navigator DMA support was rejected that it was introducing NAV specific calls
for clients to configure features not yet supported by the framework.

> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
