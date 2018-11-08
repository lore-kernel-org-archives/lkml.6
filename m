Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA591ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF0120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF0120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeKIC3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:29:34 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38559 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeKIC3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:29:33 -0500
Received: by mail-qk1-f195.google.com with SMTP id d19so27646257qkg.5;
        Thu, 08 Nov 2018 08:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OINucu49I50O4hdwT7f7zOMLwUBoreYOBrBIsiDoozs=;
        b=hS6+AcSW3zeLLi0A7+MpFjjXGae0Mbdt93/CHcpF6/6yhGjQcSN9Otj21TSjzwHUFK
         Mnwvjfg6Pxg0WOdKk/bjkCEqXTjkrUQtap01GW16aOhXqXYHztxWJJfTHrBCJm9aEG4T
         o+Bk7I2X+zNNCB9Q7ttMyQVUK3HGAMkedN/FLkT78Ogb5X7IOpG32wKqrDLqTbhibqpj
         lZfeHjIOb/LDeu4dOmvOLvcj9MXFODopruFyMobWs4C0cwFbJ3YwMWFVHZwqVLT8+rDQ
         hNR5JGteoy318qq3Vu9aJlFbWGOu1etqRYZVG0gc/wYVWaUL2bcPup5jrBgkLu0CBdXr
         e6BQ==
X-Gm-Message-State: AGRZ1gJqv3uA5U/tA5ZcA9aEQNvVdM6eaz/mvinxjROinmZSqRqWf2gj
        EldTzvJbhKZAKTmlC6Kcziqc4nGH1+FVA2pfX70=
X-Google-Smtp-Source: AJdET5dubdofAbeRaBdZx12QGhA9MX6Zo9gfzkb5yTS7RQ5Ycl04LdeD4EmeXo24rhD/eXP4AzST/qaBj5lyKt7mJnk=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr5015870qvl.180.1541695990632;
 Thu, 08 Nov 2018 08:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-7-TheSven73@googlemail.com> <CAK8P3a3apbxNa2FpADvdLCe-GzV+2xv2kO1_tosOZrUpY6xWtA@mail.gmail.com>
 <CAGngYiWvZze2wd-p4avhwGHap=RCO2XPcwShYWPRcs59c3q65A@mail.gmail.com>
In-Reply-To: <CAGngYiWvZze2wd-p4avhwGHap=RCO2XPcwShYWPRcs59c3q65A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Nov 2018 17:52:54 +0100
Message-ID: <CAK8P3a0qezBc_TQ+jtrkvnwkp7wROByzqBKYvDAgno2Wh-g9Wg@mail.gmail.com>
Subject: Re: [PATCH anybus v3 6/6] misc: support HMS Profinet IRT industrial controller
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>, noralf@tronnes.org,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 4:35 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> On Thu, Nov 8, 2018 at 9:20 AM Arnd Bergmann <arnd@arndb.de> wrote:
 > > +       struct {
> > > +               /* addresses IN NETWORK ORDER! */
> > > +               __u32 ip_addr;
> > > +               __u32 subnet_msk;
> > > +               __u32 gateway_addr;
> > > +               __u8  is_valid:1;
> > > +       } eth;
> >
> > Overall, this structure feels too complex for an ioctl interface,
> > with the nested structures. If we end up keeping that
> > ioctl, maybe at least make it a flat structure without padding,
> > or alternatively make it a set of separate ioctls.
> >
>
> I agree that it feels complex, but it's the best I could come up with.
> There are a few hidden constraints:
>
> 1. The profinet card configuration settings must be applied atomically.
> And they can only be applied right after device reset.
>
> So if we use smaller, separate ioctls, we will end up resetting the device
> each time we send an ioctl. And to assemble a real configuration, we need
> 5 or 6 ioctls, so the card gets reset 5 or 6 times, which takes ages.
> It cannot work this way.
>
> 2. Configuration settings are optional. That's why why each little struct
> has an is_valid member. If we use a flatter structure, we need a bool for
> every config setting in the struct, to indicate if it should be applied.
> Which feels clunky.

I think a more common way to do this would be to use a __u64
member containing a bitmask of which fields are valid.

> One way to overcome this is by letting the ioctls change data in the driver,
> but not on the card. Then a separate "apply" ioctl could apply the whole
> configuration atomically.
>
> Example:
> ioctl(clear all settings?);
> ioctl(set ip address);
> ioctl(set stop mode action);
> ioctl(enable internal webserver);
> ioctl(apply);
>
> But of course, what happens if two processes try to configure the
> driver at the same time?
> The ioctl calls would be interleaved, and the result would be very messy...
>
> There must be a better way?

In particular the bits about optional fields would fit much better
into netlink, which is a kind of TLV interface, and you can send
a number of configuration steps in one 'sendmsg' syscall,
but leave out the ones that you are not interested in.

This would also allow you to specify standard parameters that
could apply to multiple vendors or fieldbus protocols, and have
a common configuration tool for all of them.

       Arnd
