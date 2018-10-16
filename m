Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FAAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473EC208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d22wxBkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473EC208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJPOQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbeJPOQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:16:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A9F4208B3;
        Tue, 16 Oct 2018 06:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539671244;
        bh=NaN9aAokQaczPfGn05CUFy8guXpRqzf7zL8yQzcBaRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d22wxBknidUycQgLi8A2S02+noUTQjTDyKmqKPxKWRI5iEGkNyVWXJX/39DXgLP7k
         lPlIGyACxbOKiS+JyevsPq+S5HqhBqcSWQUGuf8Yn4rl6A0mQ/wmkiC/CcgPkvUStZ
         Eke+0blaaqidLm5C7DtYvw2y/r+sL1AyLhRuNvAE=
Date:   Tue, 16 Oct 2018 08:27:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 06/15] platform: goldfish: pipe: Move memory
 allocation from probe to init
Message-ID: <20181016062721.GA882@kroah.com>
References: <20181003171720.169953-1-rkir@google.com>
 <20181003171720.169953-6-rkir@google.com>
 <20181015183458.GA28454@kroah.com>
 <CAOGAQerzTxLEcFjqCqjGvFDaK79LWw7kuGqprw4mEj6gmcm6tA@mail.gmail.com>
 <20181015185611.GA5201@kroah.com>
 <CAOGAQerxP0hsVF2ArpXJ4HrPj=-XKfdqvAdUGoC4xo+sc4UYvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQerxP0hsVF2ArpXJ4HrPj=-XKfdqvAdUGoC4xo+sc4UYvw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:06:12PM -0700, Roman Kiryanov wrote:
> > > probe does not know what memory to allocate. We have several versions
> > > of the driver (with different init) and different versions allocate
> > > different state.
> >
> > I only see one driver here.
> 
> It will be added in "PATCH v3 15/15". There will be two init functions
> allocating different states.

I think we are getting our terms confused here.

"init" usually means module_init(), is that what you are referring to
here?

probe means when your bus-specific driver's probe function is called
because the kernel recognizes your hardware as being present.

At module_init time, you should do nothing except register your bus
specific driver.

At probe time, allocate memory all you want, that is the correct point
in time to do it.

So yes, if you have two separate drivers, you will have two separate
init functions, but both of them should just register the bus specific
driver.

> > Why does probe not know what to allocate?  That is exactly when the
> > device is bound to the driver, you have _way_ more information than you
> > do at init time.
> 
> We have two versions of the driver. Probe asks for the version and
> calls the init function for this version.
> I don't want probe to know everything about all versions.

Why would your probe function know, or care, about versions?  That's up
to the driver core.  How is your probe function learning about the
"version" to use here?

> > > >, not init time as what
> > > > happens if the hardware is not present yet your driver is loaded?
> > >
> > > init will have to rollback what it allocated.
> >
> > But those resources it will sit there wasted until unload happens.  And
> > unload _never_ happens on a system unless you are a developer working on
> > the module.
> 
> If probe fails I expect the kernel to release all resources. Is this
> not the case?

You have to clean up after your probe function failing before you return
from it.

thanks,

greg k-h
