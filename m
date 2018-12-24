Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6741F218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545643028;
	bh=LAXHI7tOqqWKs6hDmttMvJAkS9G4dCVLuvptUWXYFFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pJk1Egl2zRFAHxKN+cn6+oT42iBUlOG12yfWMYz6bqNiwm0tf/V4FeVzc3/WthG+n
	 LLQlMzOcnmB8OtH7/478DllvTxfAGxtpqJZ/9TgFl5PoI/kh83VZh0NzRl576F+E07
	 uk1vF9iZls5h1HmBQrpSMElmkxEa8QgPVyjHWSqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbeLXJRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbeLXJRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:17:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F10D218AF;
        Mon, 24 Dec 2018 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545643025;
        bh=LAXHI7tOqqWKs6hDmttMvJAkS9G4dCVLuvptUWXYFFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgZUNjL8BDsauqZGZjl+jBOLMX6MaNkOg33OUeCVovYWQcxMB6sWqs7BfOL1amNOK
         dkSfxVMBgd05lfmoUjJptm4J2exNVSYPWZ6o55JHoBQYpWSCCl8HvrF9tqycJdDe8t
         Xc44+blVhdHc1WZ7yXZx++1D5DK1Bl/W0SokFocc=
Date:   Mon, 24 Dec 2018 10:17:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Marcus Meissner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181224091703.GB26796@kroah.com>
References: <20181223164954.hib4lbchftspidsd@suse.de>
 <20181223171703.s7jm6fkyosnsf33z@brauner.io>
 <20181223180609.GA102606@dtor-ws>
 <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 08:31:27AM +0100, Gabriel C wrote:
> Am So., 23. Dez. 2018 um 19:09 Uhr schrieb Dmitry Torokhov
> <dmitry.torokhov@gmail.com>:
> 
> [ also added Linus to CC on that one too ]
> >
> > On Sun, Dec 23, 2018 at 06:17:04PM +0100, Christian Brauner wrote:
> > > On Sun, Dec 23, 2018 at 05:49:54PM +0100, Marcus Meissner wrote:
> > > > Hi,
> > > >
> > > > I am the maintainer of libmtp and libgphoto2
> > > >
> > > > Some months ago I was made aware of this bug:
> > > >     https://bugs.kde.org/show_bug.cgi?id=387454
> > > >
> > > > This was fallout identified to come from this kernel commit:
> > > >
> > > >     commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
> > > >     Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > >     Date:   Wed Jul 19 17:24:30 2017 -0700
> > >
> > > Fwiw, the addition of {un}bind events has caused issues for
> > > systemd-udevd as well and is tracked here:
> > > https://github.com/systemd/systemd/issues/7587
> > > I haven't been aware of this until yesterday and it seems that so far
> > > this hasn't been brought up on lkml until you did now.
> >
> > The fallout was caused by premature enabling of the new events in
> > systemd/udev by yours truly (even though the commit has Lennart's name
> > on it due to how it was merged):
> >
> > https://github.com/systemd/systemd/commit/9a39e1ce314d1a6f8a754f6dab040019239666a9
> >
> > "Add handling for bind/unbind actions (#6720)
> >
> > Newer kernels will emit uevents with "bind" and "unbind" actions. These
> > uevents will be issued when driver is bound to or unbound from a device.
> > "Bind" events are helpful when device requires a firmware to operate
> > properly, and driver is unable to create a child device before firmware
> > is properly loaded.
> >
> > For some reason systemd validates actions and drops the ones it does not
> > know, instead of passing them on through as old udev did, so we need to
> > explicitly teach it about them."
> >
> > Similarly it is now papered over in systemd/udev until we make it
> > properly handle new events:
> >
> > https://github.com/systemd/systemd/commit/56c886dc7ed5b2bb0882ba85136f4070545bfc1b
> >
> > "sd-device: ignore bind/unbind events for now
> >
> > Until systemd/udev are ready for the new events and do not flush entire
> > device state on each new event received, we should ignore them."
> >
> 
> And how about peoples still uses systemd < 235 and newer kernels ?

Is that an issue?  Who uses that, and does it cause problems on their
systems given that the events just do not do anything for those systems?

We tested this out a lot back in the summer of 2017 and I thought all
was well.  What recently changed that caused breakages to suddenly show
up?  How have we not seen this until now?

We can drop the "new" uevents now by reverting the patch, but what about
the userspace tools that now depend on them as we have had them in our
kernels for so long?  We can't now break them, right?  Should we add a
new kernel config option to not emit those for older userspaces that can
not handle this (of which I really still do not understand given that we
tested the heck out of this last year...)

still confused,

greg k-h
