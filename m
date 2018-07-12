Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AFDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6130E20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6130E20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeGLGfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:35:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37298 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeGLGfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:35:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A7FBC75;
        Thu, 12 Jul 2018 06:27:16 +0000 (UTC)
Date:   Thu, 12 Jul 2018 08:27:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, ltyrala@cadence.com,
        adouglas@cadence.com
Subject: Re: [PATCH 05/31] usb: usbssp: Added first part of initialization
 sequence.
Message-ID: <20180712062714.GI20905@kroah.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-6-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531374448-26532-6-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:47:02AM +0100, Pawel Laszczak wrote:
> +/* USB 2.0 hardware LMP capability*/
> +#define USBSSP_HLC			(1 << 19)
> +#define USBSSP_BLC			(1 << 20)

Again, BIT() please.

> +int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
> +{
> +	u32	result;

Some places you use tabs for the variable declarations, and some you do
not.  Pick a single style and stick to it please.

> +
> +	do {
> +		result = readl(ptr);
> +		if (result == ~(u32)0)	/* card removed */
> +			return -ENODEV;
> +		result &= mask;
> +		if (result == done)
> +			return 0;
> +		udelay(1);
> +		usec--;
> +	} while (usec > 0);
> +	return -ETIMEDOUT;

We don't have a built-in kernel function to do this type of thing
already?  That's sad.  Oh well...

> +int usbssp_init(struct usbssp_udc *usbssp_data)
> +{
> +	int retval = 0;
> +
> +	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init, "usbssp_init");
> +
> +	spin_lock_init(&usbssp_data->lock);
> +	spin_lock_init(&usbssp_data->irq_thread_lock);
> +
> +	//TODO: memory initialization
> +	//retval = usbssp_mem_init(usbssp_data, GFP_KERNEL);
> +
> +	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
> +			"Finished usbssp_init");

When your trace functions do nothing but say "entered a function", and
"exited a function", why even have them?  ftrace can provide that for
you already, no need to overload that on the tracing framework, right?

> +/*
> + * gadget-if.c file is part of gadget.c file and implements interface
> + * for gadget driver
> + */
> +#include "gadget-if.c"

Ugh, I know USB hcd drivers love to include .c files in the middle of
them, but do we have to continue that crazy practice in newer drivers?
Is it really necessary?

> +	/*
> +	 * Check the compiler generated sizes of structures that must be laid
> +	 * out in specific ways for hardware access.
> +	 */
> +	BUILD_BUG_ON(sizeof(struct usbssp_doorbell_array) != 2*32/8);
> +	BUILD_BUG_ON(sizeof(struct usbssp_slot_ctx) != 8*32/8);
> +	BUILD_BUG_ON(sizeof(struct usbssp_ep_ctx) != 8*32/8);
> +	/* usbssp_device has eight fields, and also
> +	 * embeds one usbssp_slot_ctx and 31 usbssp_ep_ctx
> +	 */
> +	BUILD_BUG_ON(sizeof(struct usbssp_stream_ctx) != 4*32/8);
> +	BUILD_BUG_ON(sizeof(union usbssp_trb) != 4*32/8);
> +	BUILD_BUG_ON(sizeof(struct usbssp_erst_entry) != 4*32/8);
> +	BUILD_BUG_ON(sizeof(struct usbssp_cap_regs) != 8*32/8);
> +	BUILD_BUG_ON(sizeof(struct usbssp_intr_reg) != 8*32/8);
> +	/* usbssp_run_regs has eight fields and embeds 128 usbssp_intr_regs */
> +	BUILD_BUG_ON(sizeof(struct usbssp_run_regs) != (8+8*128)*32/8);

I love hard-coded numbers as much as the next person, but really?  Is
this necessary now that you have the code up and working properly?


I've stopped reviewing this series here.

thanks,

greg k-h
