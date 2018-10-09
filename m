Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5DBC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738D021479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1AYtAEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738D021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeJIU0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeJIU0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:26:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4520213A2;
        Tue,  9 Oct 2018 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539090555;
        bh=ZVN56JnstScbyXg+ukIzxKFvx8fLob6+ycHDNU+6X1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1AYtAELkOYl07+Veb0UrDLK6iD+ompCafET2mPWLxAIw61u4GgcBDZ3Gsx70DbGo
         n38SKwe6lPnezD6LQWPk/Y6/uhznxXvV962EJod0dGGhpc2kt+McO4Ce36DOifu5J5
         FRhbAYS4qW/nTrYmRgFWvdHhlyYJiDWoVBMnJWgw=
Date:   Tue, 9 Oct 2018 15:09:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, damm+renesas@opensource.se,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] staging: emxx_udc: Remove unused device_desc declaration
Message-ID: <20181009130912.GA25423@kroah.com>
References: <20181004055559.3197-1-natechancellor@gmail.com>
 <CAKwvOdk7v2KhA2DW6eh8RgGt-WyQQhCSp=hKgcWra8Jw9vLOJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk7v2KhA2DW6eh8RgGt-WyQQhCSp=hKgcWra8Jw9vLOJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 02:05:45PM -0700, Nick Desaulniers wrote:
> On Wed, Oct 3, 2018 at 10:56 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/staging/emxx_udc/emxx_udc.c:1373:37: warning: variable
> > 'device_desc' is not needed and will not be emitted
> > [-Wunneeded-internal-declaration]
> > static struct usb_device_descriptor device_desc = {
> >                                     ^
> > 1 warning generated.
> >
> > This definition hasn't been attached to anything since the driver was
> > introduced in commit 33aa8d45a4fe ("staging: emxx_udc: Add Emma Mobile
> > USB Gadget driver") and neither GCC nor Clang emit any reference to the
> > variable in the final assembly. The only reason GCC doesn't warn about
> > this variable being unused is the sizeof function.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > This seems kind of wrong given this is a USB driver but there isn't an
> > instance of a platform_driver in the kernel tree having a usb device
> > descriptor declaration so I'm unsure of how to handle this warning aside
> > from just removing the definition but I'm certainly open to suggestions.
> 
> In drivers under drivers/usb/gadget/legacy/{ether|mass_storage|hid}.c,
> it seems that addresses of instances of `struct usb_device_descriptor`
> are stored in instances of `struct usb_composite_driver eth_driver`
> that are passed to module_usb_composite_driver().
> 
> drivers/staging/emxx_udc/emxx_udc.c doesn't mention anything about
> being a composite driver, and I don't know if there are multiple
> devices to warrant a composite driver?  Composite seems to imply "more
> than one gadget" while the path to drivers using this interface under
> drivers/usb/gadget/legacy/ seem to imply there's a modern (non-legacy)
> usb gadget interface that could potentially be used instead.
> 
> If this was never intended to be a composite usb driver, or there's
> some reason why it doesn't make sense for it to be one, then this code
> is likely dead and your fix is correct.  If it's not, maybe folks who
> know more about the USB interfaces have another solution to make this
> a composite usb driver?

I'll take the patch, the code looks wrong, it should not be needed here.

thanks,

greg k-h
