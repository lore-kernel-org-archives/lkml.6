Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4DFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23CD20864
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23CD20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbeGLG3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:29:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeGLG3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:29:46 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 66CC5C9E;
        Thu, 12 Jul 2018 06:21:41 +0000 (UTC)
Date:   Thu, 12 Jul 2018 08:21:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, ltyrala@cadence.com,
        adouglas@cadence.com
Subject: Re: [PATCH 04/31] usb: usbssp: Added USBSSP platform driver
Message-ID: <20180712062139.GH20905@kroah.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-5-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531374448-26532-5-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:47:01AM +0100, Pawel Laszczak wrote:
> This patch adds platform driver that is entry point for loading and
> unloading usbssp.ko modules.
> It also adds information about this driver to drivers/usb/Kconfig
> and drivers/usb/Makefile files and create Kconfig and Makefile
> files in drivers/usb/usbssp directory.
> 
> Patch also adds template for some function ivokked from
> usbssp_plat.c file. These function will be implemented in next patches.
> 
> This patch also introduce usbssp_trb_virt_to_dma that converts
> virtual address of TRB's to DMA address. In this moment this
> function is used only in gadget-trace.h.
> 
> >From this moment the driver can be compiled.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

This is a much nicer breakup of the patches than the last series, thanks
for doing it this way.

> --- a/drivers/usb/usbssp/gadget.h
> +++ b/drivers/usb/usbssp/gadget.h
> @@ -9,7 +9,6 @@
>   * A lot of code based on Linux XHCI driver.
>   * Origin: Copyright (C) 2008 Intel Corp.
>   */
> -
>  #ifndef __LINUX_USBSSP_GADGET_H
>  #define __LINUX_USBSSP_GADGET_H
>  

You should have done that in an earlier patch :)

> @@ -1671,6 +1670,21 @@ static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
>  {
>  	lo_hi_writeq(val, regs);
>  }
> +
> +/* USBSSP Device controller glue */
> +int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
> +int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated);
> +
> +irqreturn_t usbssp_irq(int irq, void *priv);
> +
> +/* USBSSP ring, segment, TRB, and TD functions */
> +dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
> +		union usbssp_trb *trb);
> +
> +/* USBSSP gadget interface*/
> +int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
> +int  usbssp_gadget_exit(struct usbssp_udc *usbssp_data);

Very odd indentation, don't you think?

> +MODULE_ALIAS("platform:usbss-gadget");
> +MODULE_DESCRIPTION("USBSSP' Device Controller (USBSSP) Driver");
> +MODULE_LICENSE("GPL");

Wrong MODULE_LICENSE() string.  Please read module.h for what these all
should be.

thanks,

greg k-h
