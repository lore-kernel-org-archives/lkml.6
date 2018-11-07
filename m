Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC64C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709C02086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW7fhfQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709C02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbeKGSuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbeKGSuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:50:19 -0500
Received: from localhost (unknown [104.153.224.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D94CD2086B;
        Wed,  7 Nov 2018 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541582449;
        bh=u27OcqB2iuCAJnRjNwM+AlVLdBdaKcaD4/VcM80qh0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LW7fhfQsmcF8fuP565OFj5YAyddwONvDuuXeUwGZkRdGxa7hQnyKWisdG+FJY1bEl
         HnIH51MGMcj383RMcxbPzwA7AjKornIefXNsV5BCk2fXQNa6dP8vv5sf/cJl7QFpVV
         3PQ0XNjKTOFuBGBkEufAXNxdxf94NecgSlLkRmUI=
Date:   Wed, 7 Nov 2018 10:20:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@google.com>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Rob Springer <rspringer@google.com>,
        LKML <linux-kernel@vger.kernel.org>, devel@linuxdriverproject.org
Subject: Re: RFC: staging: gasket: re-implement using UIO
Message-ID: <20181107092040.GE31015@kroah.com>
References: <20180818155724.GA22569@kroah.com>
 <20180828103817.GB1397@do-kernel>
 <20180828123607.GB13441@kroah.com>
 <20180828143049.GA7388@darwi-kernel>
 <20180910081626.GA31344@kroah.com>
 <20180910152837.GA31819@darwi-kernel>
 <CAAW3YpZj=U=RtKLtB3Wq-agi9Vxxd_Mn8x1qo5hXXcV7hSLV9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAW3YpZj=U=RtKLtB3Wq-agi9Vxxd_Mn8x1qo5hXXcV7hSLV9Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 04:20:49PM -0800, Todd Poynor wrote:
> On Mon, Sep 10, 2018 at 8:28 AM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> >
> > The gasket in-kernel framework, recently introduced under staging,
> > re-implements what is already long-time provided by the UIO
> > subsystem, with extra PCI BAR remapping and MSI conveniences.
> >
> > Before moving it out of staging, make sure we add the new bits to
> > the UIO framework instead, then transform its signle client, the
> > Apex driver, to a proper UIO driver (uio_driver.h).
> >
> > Link: https://lkml.kernel.org/r/20180828103817.GB1397@do-kernel
> 
> So I'm looking at this for reals now.  The BAR mapping stuff is
> straightforward with the existing framework.  Everything else could be
> done outside of UIO via the existing device interface, but figured I'd
> collect any opinions about adding the new bits to UIO.
> 
> The Apex device has 13 MSIX interrupts.  UIO does one IRQ per device.
> The PRUSS driver registers 8 instances of the UIO device with
> identical memory mappings but individual IRQs for its 8 interrupts.
> Currently gasket has userspace pass down an eventfd (via ioctl) for
> each interrupt it wants to watch.  Is there interest in modifying UIO
> to handle multiple IRQs in some perhaps similar fashion?
> 
> Speaking of ioctls, are those allowed here, or is sysfs or something
> else always required?  The aforementioned multiple IRQ stuff probably
> maps nicely to sysfs (there's a small number of them easily
> represented as attributes), while DMA buffer mappings seem more
> problematic, but maybe somebody's thought of a good way to represent
> these already.

Adding ioctls opens up a huge can of worms where each driver would
probably want to do their own mess and then we have to constantly audit
the mess all of the time.  What do you really need to do in an ioctl?

> And then we need to map buffers to our device.  We could probably
> implement this via an IOMMU driver API for our custom MMU and hook
> that up to generic IOMMU support for UIO, which sounds like something
> a lot of drivers could use.

You need to map buffers from what to what?  UIO is for pass-through
memory that your device exposes to userspace through mmap, what more do
you need that the existing api does not give you?

> There's a few other tidbits the driver does, including allocating
> coherent memory for userspace to share with the device, but that's
> probably enough for now.
> 
> If anybody wants to squash any of the above as a non-starter for UIO
> or point things in a different direction, it's appreciated.

Patches are always the best way to do review, we generally do not have
time or bandwidth to do "what do you think of my design" ideas without
real code behind it, sorry.  That way we know you really did try to do
something and you have something that starts to work for you.

thanks,

greg k-h
