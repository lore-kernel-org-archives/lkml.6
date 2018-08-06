Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21732C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B158F21A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jZYYQEKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B158F21A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbeHFMlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:41:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51668 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeHFMlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:41:47 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w76AXH3B023952;
        Mon, 6 Aug 2018 05:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533551597;
        bh=MZOtS1qn/pRkjlqsYB+TZeBqBiqcpCgTY+s2RFpEXuw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jZYYQEKZ6qaenXwMjPEI7cbDBPYJBCnVl/LVado9WI/nDLlhWc7x1GUbi5KpbcAes
         dzNEmIl17xqCp+uw2EsVlnIb2UzgjBPnRJLQ44T5n8MzxAF905Qi8LSB4lrmYT41ny
         pH2dstGNAeP/qRGNwXGGBeG0PqWkii05AshnfIt8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w76AXHDI004772;
        Mon, 6 Aug 2018 05:33:17 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 6 Aug
 2018 05:33:17 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 6 Aug 2018 05:33:17 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w76AXFbW032493;
        Mon, 6 Aug 2018 05:33:15 -0500
Subject: Re: [PATCH 05/31] usb: usbssp: Added first part of initialization
 sequence.
To:     Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
 <1532023084-28083-6-git-send-email-pawell@cadence.com>
 <45dff595-5363-bbef-1240-6b693b4829b2@ti.com>
 <BYAPR07MB4709E2EB84E8004952772829DD200@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <1d69cef1-400d-3841-982f-cd37964bfd06@ti.com>
Date:   Mon, 6 Aug 2018 13:33:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB4709E2EB84E8004952772829DD200@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/18 11:57, Pawel Laszczak wrote:
> Hi,
>>
>> Hi,
>>
>> On 19/07/18 20:57, Pawel Laszczak wrote:
>>> Patch adds some initialization function. The initialization sequence
>>> is quite complicated and this patch implements it only partially.
>>> Initialization will be completed in next few patches.
>>>
>>> Patch introduce three new files:
>>> 1. gadget-dbg.c - file contains functions used for debugging purpose.
>>> 2. gadget-ext-caps.h - holds macro definition related to
>>> 		       Extended Capabilities
>>> 3. gadget-if - file implements stuff related to upper layer
>>> 	(e.g usb_ep_ops, usb_gadget_ops interface).
>>>
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>> ---
>>>  drivers/usb/usbssp/Makefile          |   1 +
>>>  drivers/usb/usbssp/gadget-dbg.c      |  30 ++++
>>>  drivers/usb/usbssp/gadget-ext-caps.h |  53 ++++++
>>>  drivers/usb/usbssp/gadget-if.c       |  24 +++
>>>  drivers/usb/usbssp/gadget.c          | 242 +++++++++++++++++++++++++++
>>>  drivers/usb/usbssp/gadget.h          |  15 ++
>>>  6 files changed, 365 insertions(+)
>>>  create mode 100644 drivers/usb/usbssp/gadget-dbg.c
>>>  create mode 100644 drivers/usb/usbssp/gadget-ext-caps.h
>>>  create mode 100644 drivers/usb/usbssp/gadget-if.c
>>>
>>> diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
>>> index d85f15afb51c..0606f3c63cd0 100644
>>> --- a/drivers/usb/usbssp/Makefile
>>> +++ b/drivers/usb/usbssp/Makefile
>>> @@ -5,6 +5,7 @@ CFLAGS_gadget-trace.o := -I$(src)
>>>  obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
>>>  usbssp-y 			:= usbssp-plat.o gadget-ring.o \
>>>  				   gadget.o
>>> +				    gadget-dbg.o
>>>
>>>  ifneq ($(CONFIG_TRACING),)
>>>  	usbssp-y		+= gadget-trace.o
>>> diff --git a/drivers/usb/usbssp/gadget-dbg.c b/drivers/usb/usbssp/gadget-dbg.c
>>> new file mode 100644
>>> index 000000000000..277617d1a996
>>> --- /dev/null
>>> +++ b/drivers/usb/usbssp/gadget-dbg.c
>>> @@ -0,0 +1,30 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * USBSSP device controller driver
>>> + *
>>> + * Copyright (C) 2018 Cadence.
>>> + *
>>> + * Author: Pawel Laszczak
>>> + *
>>> + * A lot of code based on Linux XHCI driver.
>>> + * Origin: Copyright (C) 2008 Intel Corp
>>> + */
>>> +
>>> +#include "gadget.h"
>>> +
>>> +void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
>>> +		      void (*trace)(struct va_format *),
>>> +		      const char *fmt, ...)
>>> +{
>>> +	struct va_format vaf;
>>> +	va_list args;
>>> +
>>> +	va_start(args, fmt);
>>> +	vaf.fmt = fmt;
>>> +	vaf.va = &args;
>>> +	dev_dbg(usbssp_data->dev, "%pV\n", &vaf);
>>
>> dev_dbg will mess up with timings to be useful.
>> Why not just use one of the trace events you defined in gadget-trace.h?
> 
> Function is equivalent of xhci_dbg_trace from XHCI driver.
> It is a function of general use. 
> The problem with trace is that trace log is deleted after rebooting system. 
> Using trace log is problematic during developing and debugging driver. 

OK. But I think trace log is more useful for I/O related debugging as it
keeps the timing impact minimal. For things that don't come in the I/O path
you could use dev_dbg().

> Do you know whether  trace log is saved anywhere on disk ?  
> 
I think trace_cmd allows you to record on the disk or even send it over the network.
https://lwn.net/Articles/410200/

>>> +	trace(&vaf);
>>> +	va_end(args);
>>> +}
>>> +EXPORT_SYMBOL_GPL(usbssp_dbg_trace);
>>> +

<snip>

>>>  int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
>>>  {
>>>  	int ret;
>>> +
>>> +	/*
>>> +	 * Check the compiler generated sizes of structures that must be laid
>>> +	 * out in specific ways for hardware access.
>>> +	 */
>>> +	BUILD_BUG_ON(sizeof(struct usbssp_doorbell_array) != 2*32/8);
>>> +	BUILD_BUG_ON(sizeof(struct usbssp_slot_ctx) != 8*32/8);
>>> +	BUILD_BUG_ON(sizeof(struct usbssp_ep_ctx) != 8*32/8);
>>> +	/* usbssp_device has eight fields, and also
>>> +	 * embeds one usbssp_slot_ctx and 31 usbssp_ep_ctx
>>> +	 */
>>> +	BUILD_BUG_ON(sizeof(struct usbssp_stream_ctx) != 4*32/8);
>>> +	BUILD_BUG_ON(sizeof(union usbssp_trb) != 4*32/8);
>>> +	BUILD_BUG_ON(sizeof(struct usbssp_erst_entry) != 4*32/8);
>>> +	BUILD_BUG_ON(sizeof(struct usbssp_cap_regs) != 8*32/8);
>>> +	BUILD_BUG_ON(sizeof(struct usbssp_intr_reg) != 8*32/8);
>>> +	/* usbssp_run_regs has eight fields and embeds 128 usbssp_intr_regs */
>>> +	BUILD_BUG_ON(sizeof(struct usbssp_run_regs) != (8+8*128)*32/8);
>>> +
>>> +	/* fill gadget fields */
>>> +	/*TODO: implements usbssp_gadget_ops object*/
>>> +	//usbssp_data->gadget.ops = &usbssp_gadget_ops;
>>> +	usbssp_data->gadget.name = "usbssp-gadget";
>>> +	usbssp_data->gadget.max_speed = USB_SPEED_SUPER_PLUS;
>>> +	usbssp_data->gadget.speed = USB_SPEED_UNKNOWN;
>>> +	usbssp_data->gadget.sg_supported = true;
>>> +	usbssp_data->gadget.lpm_capable = 1;
>>> +
>>> +	usbssp_data->setup_buf = kzalloc(USBSSP_EP0_SETUP_SIZE, GFP_KERNEL);
>>> +	if (!usbssp_data->setup_buf)
>>> +		return -ENOMEM;
>>> +
>>> +	/*USBSSP support not aligned buffer but this option
>>> +	 * improve performance of this controller.
>>> +	 */
>>
>> Multi-line comment formatting. Checkpach should complain.
> It doesn't complain about this case. I don't know why.
> 

Can you try with --strict option to checkpatch?

>>> +	usbssp_data->gadget.quirk_ep_out_aligned_size = true;
>>> +	ret = usbssp_gen_setup(usbssp_data);
>>> +	if (ret < 0) {
>>> +		dev_err(usbssp_data->dev,
>>> +				"Generic initialization failed with error code%d\n",
>>> +				ret);
>>> +		goto err3;
>>> +	}
>>> +
>>> +	ret = usbssp_gadget_init_endpoint(usbssp_data);
>>> +	if (ret < 0) {
>>> +		dev_err(usbssp_data->dev, "failed to initialize endpoints\n");
>>> +		goto err1;
>>> +	}
>>> +
>>> +	ret = usb_add_gadget_udc(usbssp_data->dev, &usbssp_data->gadget);
>>> +
>>> +	if (ret) {
>>> +		dev_err(usbssp_data->dev, "failed to register udc\n");
>>> +		goto err2;
>>> +	}
>>> +
>>> +	return ret;
>>> +err2:
>>> +	usbssp_gadget_free_endpoint(usbssp_data);
>>> +err1:
>>> +	usbssp_halt(usbssp_data);
>>> +	/*TODO add implementation of usbssp_reset function*/
>>> +	//usbssp_reset(usbssp_data);
>>> +	/*TODO add implementation of freeing memory*/
>>> +	//usbssp_mem_cleanup(usbssp_data);
>>> +err3:
>>>  	return ret;
>>>  }
>>>
>>> @@ -60,5 +298,9 @@ int usbssp_gadget_exit(struct usbssp_udc *usbssp_data)
>>>  {
>>>  	int ret = 0;
>>>
>>> +	usb_del_gadget_udc(&usbssp_data->gadget);
>>> +	usbssp_gadget_free_endpoint(usbssp_data);
>>> +	/*TODO: add usbssp_stop implementation*/
>>> +	//usbssp_stop(usbssp_data);
>>>  	return ret;
>>>  }
>>> diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
>>> index 55e20795d900..5d8918f8da84 100644
>>> --- a/drivers/usb/usbssp/gadget.h
>>> +++ b/drivers/usb/usbssp/gadget.h
>>> @@ -12,8 +12,10 @@
>>>  #ifndef __LINUX_USBSSP_GADGET_H
>>>  #define __LINUX_USBSSP_GADGET_H
>>>
>>> +#include <linux/irq.h>
>>>  #include <linux/io-64-nonatomic-lo-hi.h>
>>>  #include <linux/usb/gadget.h>
>>> +#include "gadget-ext-caps.h"
>>>
>>>  /* Max number slots - only 1 is allowed */
>>>  #define DEV_MAX_SLOTS		1
>>> @@ -1676,7 +1678,18 @@ static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
>>>  	lo_hi_writeq(val, regs);
>>>  }
>>>
>>> +/* USBSSP memory management */
>>> +void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
>>> +		void (*trace)(struct va_format *),
>>> +		const char *fmt, ...);
>>
>> what has this function to do with memory management?
>>
> Nothing, 
> 
>>>  /* USBSSP Device controller glue */
>>> +void usbssp_bottom_irq(struct work_struct *work);
>>
>> usbssp_bottom_irq() wasn't defined in this patch.
> Removed from this patch
> 
>>> +int usbssp_init(struct usbssp_udc *usbssp_data);
>>> +void usbssp_stop(struct usbssp_udc *usbssp_data);
>>> +int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
>>> +void usbssp_quiesce(struct usbssp_udc *usbssp_data);
>>> +extern int usbssp_reset(struct usbssp_udc *usbssp_data);
>>> +
>>>  int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
>>>  int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated);
>>>
>>> @@ -1689,6 +1702,8 @@ dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
>>>  /* USBSSP gadget interface*/
>>>  int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
>>>  int usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
>>> +void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data);
>>> +int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data);
>>>
>>>  static inline char *usbssp_slot_state_string(u32 state)
>>>  {
>>>
>>

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
