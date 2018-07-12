Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6472AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1682420BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1682420BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbeGLJSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:18:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeGLJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:18:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 09F7986A;
        Thu, 12 Jul 2018 09:09:26 +0000 (UTC)
Date:   Thu, 12 Jul 2018 11:09:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: Re: [PATCH 05/31] usb: usbssp: Added first part of initialization
 sequence.
Message-ID: <20180712090924.GA8255@kroah.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-6-git-send-email-pawell@cadence.com>
 <20180712062714.GI20905@kroah.com>
 <BYAPR07MB47096E3B832D07F8F3017974DD590@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR07MB47096E3B832D07F8F3017974DD590@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 09:03:30AM +0000, Pawel Laszczak wrote:
> > > +/* USB 2.0 hardware LMP capability*/
> > > +#define USBSSP_HLC			(1 << 19)
> > > +#define USBSSP_BLC			(1 << 20)
> > 
> > Again, BIT() please.
> > 
> > > +int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
> > > +{
> > > +	u32	result;
> > 
> > Some places you use tabs for the variable declarations, and some you do
> > not.  Pick a single style and stick to it please.
> > 
> > > +
> > > +	do {
> > > +		result = readl(ptr);
> > > +		if (result == ~(u32)0)	/* card removed */
> > > +			return -ENODEV;
> > > +		result &= mask;
> > > +		if (result == done)
> > > +			return 0;
> > > +		udelay(1);
> > > +		usec--;
> > > +	} while (usec > 0);
> > > +	return -ETIMEDOUT;
> > 
> > We don't have a built-in kernel function to do this type of thing already?
> > That's sad.  Oh well...
> > 
> > > +int usbssp_init(struct usbssp_udc *usbssp_data) {
> > > +	int retval = 0;
> > > +
> > > +	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
> > "usbssp_init");
> > > +
> > > +	spin_lock_init(&usbssp_data->lock);
> > > +	spin_lock_init(&usbssp_data->irq_thread_lock);
> > > +
> > > +	//TODO: memory initialization
> > > +	//retval = usbssp_mem_init(usbssp_data, GFP_KERNEL);
> > > +
> > > +	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
> > > +			"Finished usbssp_init");
> > 
> > When your trace functions do nothing but say "entered a function", and
> > "exited a function", why even have them?  ftrace can provide that for you
> > already, no need to overload that on the tracing framework, right?
> 
> Do you suggest to use only: 
> 	trace_usbssp_dbg_init("Finished usbssp_init"); 
> instead: 
> 	usbssp_dbg(usbssp_data, "%pV\n", "Finished usbssp_init");
> 	trace_usbssp_dbg_init("Finished usbssp_init");
> ?
> 
> I'm simple re-used the code from XHCI driver. It's really redundant, 
> but I don't know the intention of author 😊.  

Why are any of those lines needed?  Doesn't ftrace work properly for
you?

And yeah, if xhci has this it should be removed from there as well.

thanks,

greg k-h
