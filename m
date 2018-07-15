Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A57ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5878F208DE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5878F208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeGOKfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:35:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeGOKfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:35:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B802899;
        Sun, 15 Jul 2018 10:12:46 +0000 (UTC)
Date:   Sun, 15 Jul 2018 12:12:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
Subject: Re: [PATCH] Input: pxrc - fix leak of usb_device
Message-ID: <20180715101244.GA32410@kroah.com>
References: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
 <20180714080920.GA15123@gmail.com>
 <20180714085109.mbhk6aybpjsbuq6l@penguin>
 <20180715074225.GB15123@gmail.com>
 <CAKdAkRS0NBOo7thkevZAQXBWt_ReppjdPz6a6PQ6LtJHbPYgVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRS0NBOo7thkevZAQXBWt_ReppjdPz6a6PQ6LtJHbPYgVg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 01:06:32PM +0300, Dmitry Torokhov wrote:
> On Sun, Jul 15, 2018 at 10:42 AM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > On Sat, Jul 14, 2018 at 08:51:09AM +0000, Dmitry Torokhov wrote:
> > > On Sat, Jul 14, 2018 at 10:09:20AM +0200, Marcus Folkesson wrote:
> > > > Hi Alexey,
> > > >
> > > > Good catch!
> > > >
> > > > On Fri, Jul 13, 2018 at 11:07:57PM +0300, Alexey Khoroshilov wrote:
> > > > > pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
> > > > > anywhere in the driver.
> > > > >
> > > > > The patch adds one to error handling code and to pxrc_disconnect().
> > > > >
> > > > > Found by Linux Driver Verification project (linuxtesting.org).
> > > > >
> > > > > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > > >
> > > > Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > >
> > > Hmm, the biggest question however if we need to "take" the device, as I
> > > do not think interface can outlive the device, and whether we actually
> > > need to store it in pxrc, as we only need it during set up, as far as I
> > > can see.
> >
> > Yep, the device is only used during setup.
> > I interpret the comments for usb_get_dev() as you should take a
> > reference count on the device even if you only use the interface, but I
> > could be wrong.
> >
> > From usb_get_dev()::
> >
> >          * usb_get_dev - increments the reference count of the usb device structure
> >          * @dev: the device being referenced
> >          *
> >          * Each live reference to a device should be refcounted.
> >          *
> >          * Drivers for USB interfaces should normally record such references in
> >          * their probe() methods, when they bind to an interface, and release
> >          * them by calling usb_put_dev(), in their disconnect() methods.
> 
> Hmm, usb device is a parent of usb interface so our driver model rules
> ensure that usb device should not disappear while interface device is
> still there. Greg, is this comment still valid?

Yes, that is true.  But remember that interface devices can go away
while the parent is still present, so if you need the interface pointer,
you have to grab a reference on it.

thanks,

greg k-h
