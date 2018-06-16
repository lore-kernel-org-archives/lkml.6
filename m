Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08239C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BA920896
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiKINQjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BA920896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeFPHOz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 03:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932319AbeFPHOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 03:14:54 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F404F20896;
        Sat, 16 Jun 2018 07:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529133293;
        bh=Z6bqxMeDE4vfkr9KhbXhKbWhDL3S1EjTJ/6tW5sXAZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IiKINQjF/wrZT67LKQATck/MvT7XcOvt90+y20R56VYESyDnMvy19hlmiY1KThpAc
         rSXKlixwtUsf85I1t5mFB5rwXU944ZruqRMg+rEHno77YHfJ0PaR3jmCBQbRXXWrgn
         NgZlnfltBcar56A1LyVMUWAK4pmUTfDj23Mp+rHQ=
Date:   Sat, 16 Jun 2018 09:14:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: ensure class is registered before devices
Message-ID: <20180616071430.GC30558@kroah.com>
References: <20180615155249.17607-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615155249.17607-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 05:52:49PM +0200, Alexandre Belloni wrote:
> When both uio and the uio drivers are built in the kernel, it is possible
> for a driver to register devices before the uio class is registered.
> 
> This may result in a NULL pointer dereference later on in
> get_device_parent() when accessing the class glue_dirs spinlock.
> 
> The trace looks like that:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000140
> [...]
> Process swapper/0 (pid: 1, stack limit = 0xffff000008070000)
> Call trace:
> Exception stack(0xffff000008073810 to 0xffff000008073950)
> 3800:                                   0000000000000140 0000000000000001
> 3820: ffff800078f60000 ffffffffffffffff 0000000000000000 0000000000000000
> 3840: 0000000000000d39 07650764075f0774 0765076307690776 077207610770075f
> 3860: 07200774076e0765 0720072007200720 0720072007200720 0720072007200720
> 3880: 0720072007200720 ffffffffffffffff 0000000000000000 ffff0000089e88c0
> 38a0: 0000000000000010 ffff000008e0c000 ffff8000780990b0 ffff8000780f4ec0
> 38c0: ffff000008c41a48 ffff000008c41a30 ffff000008a59660 ffff000008c41a30
> 38e0: ffff000008a59660 ffff8000780f4c80 ffff000008c41000 ffff000008073950
> 3900: ffff0000084f3bb0 ffff000008073950 ffff0000089cc234 0000000040000045
> 3920: 00000000000005e7 ffff000008a59660 ffffffffffffffff 0000000000000000
> 3940: ffff000008073950 ffff0000089cc234
> [<ffff0000089cc234>] _raw_spin_lock+0x14/0x48
> [<ffff0000084f56bc>] device_add+0x154/0x6a0
> [<ffff0000084f5e48>] device_create_groups_vargs+0x120/0x128
> [<ffff0000084f5edc>] device_create+0x54/0x60
> [<ffff0000086e72c0>] __uio_register_device+0x120/0x4a8
> [<ffff000008528b7c>] jaguar2_pci_probe+0x2d4/0x558
> [<ffff0000083fc18c>] local_pci_probe+0x3c/0xb8
> [<ffff0000083fd81c>] pci_device_probe+0x11c/0x180
> [<ffff0000084f88bc>] driver_probe_device+0x22c/0x2d8
> [<ffff0000084f8a24>] __driver_attach+0xbc/0xc0
> [<ffff0000084f69fc>] bus_for_each_dev+0x4c/0x98
> [<ffff0000084f81b8>] driver_attach+0x20/0x28
> [<ffff0000084f7d08>] bus_add_driver+0x1b8/0x228
> [<ffff0000084f93c0>] driver_register+0x60/0xf8
> [<ffff0000083fb918>] __pci_register_driver+0x40/0x48
> 
> Return EPROBE_DEFER in that case so the driver can register the device
> later.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> 
> Hi Greg,
> 
> I'm not sure using struct class::p to test for class registration is really
> something we should do but this allows to have a small patch.
> 
> The other solutions to fix this are:
>  - use a similar change but with a boolean to store whether the class has been
>    registered.
>  - or instead of EPROBE_DEFER, just register the class when the first uio
>    device is registered.
>  _ or stop allowing to compile uio as a module and use subsys_initcall instead
>  of module_init
> 
> What do you think?
> 
>  drivers/uio/uio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index e8f4ac9400ea..3fb84ab3dd99 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -853,6 +853,9 @@ int __uio_register_device(struct module *owner,
>  	struct uio_device *idev;
>  	int ret = 0;
>  
> +	if (!uio_class.p)
> +		return -EPROBE_DEFER;

Ick, you are right, don't touch the .p field please.  We just need a "is
uio all initialized" flag for the class here that we should check
instead.

thanks,

greg k-h
