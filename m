Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6F6C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B11208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B11208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeHTOhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:37:47 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46749 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeHTOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:37:47 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so15682261qtn.13;
        Mon, 20 Aug 2018 04:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpbGvea2LMx0Tt9m6fPKIRZHV47OGpDAuBls2hEtCYk=;
        b=RBXcdXPhMNFveuP2RqJalL120YaKWxHqD/cGS+DloPKY12gnp3U1Pms/Phl+338EHt
         mvAMZafYZ0DXtujEWSRP1wztcmQKQRaI7VjGtyB0L1uiXozXWgHEwMqXsq/oK0slgqDV
         B5bIRt+U9MJy9kmPNnjlLHSi03ODPTeTgbAtMYLiYtUONlH9LzKi8V1yoYNwb4GSdEX3
         JPzqgw2smWeEIwx+w4AU06Fx7oHukrlY5CbD74oZRBa3yClr8U6xRNGp81kQhvGv/cmO
         2CwAN0N3MrCBzEXFgY1PuvIr5/Q5H3iKty3bMT8qUc6IrW+IhSKYD6KNb0VbfaOYNxc0
         EOtw==
X-Gm-Message-State: AOUpUlHbnf7Y9p+nYNDoJ+oekfVLgflCGCfJqqVTfNI4AGLqsuFnlawC
        Df5tiW1UnWZjz98u0V7YhWSjd/Z1lJV9D5sOMDw=
X-Google-Smtp-Source: AA+uWPx8xVUWI3eCsQPyIew2aWIiwVyLrQgmpD35Y5fwXb6f3p2fD9Ao04707sl4+/HGMBGNSuEFNR8FQqEeR7PG9rw=
X-Received: by 2002:a0c:a8cc:: with SMTP id h12-v6mr41161338qvc.161.1534764153267;
 Mon, 20 Aug 2018 04:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180813214924.3567840-1-arnd@arndb.de> <Pine.LNX.4.44L0.1808140957350.1466-100000@iolanthe.rowland.org>
 <CAK8P3a33DRBj6ZeJBeWGnw3RnpK3rTaYtrbs6jjZ8VVPOk8=qw@mail.gmail.com> <OSBPR01MB22931014287A7641FFBFBE56D8320@OSBPR01MB2293.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB22931014287A7641FFBFBE56D8320@OSBPR01MB2293.jpnprd01.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Aug 2018 13:22:16 +0200
Message-ID: <CAK8P3a1eWyqp=fevH2KvbhTgRGXFXgtXpfObkEqLO2c5x6WNvA@mail.gmail.com>
Subject: Re: [PATCH] usb: hide usb_of_get_companion_dev for CONFIG_USB=n
To:     yoshihiro.shimoda.uh@renesas.com
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        gregkh <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johan Hovold <johan@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 5:22 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Arnd Bergmann, Sent: Tuesday, August 14, 2018 11:27 PM
> >
> > On Tue, Aug 14, 2018 at 3:58 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Mon, 13 Aug 2018, Arnd Bergmann wrote:
> > > > diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> > > > index 0a16cbd4e528..663a8bd67a7b 100644
> > > > --- a/drivers/usb/gadget/udc/Kconfig
> > > > +++ b/drivers/usb/gadget/udc/Kconfig
> > > > @@ -193,6 +193,7 @@ config USB_RENESAS_USB3
> > > >       tristate 'Renesas USB3.0 Peripheral controller'
> > > >       depends on ARCH_RENESAS || COMPILE_TEST
> > > >       depends on EXTCON
> > > > +     depends on USB || !USB
> > >
> > > Is this some weird standard idiom?  It looks really strange.
> >
> > Yes, and yes.
> >
> > A less common way to write it is
> >
> >         depends on (USB != m) || m
> >
> > which some people prefer, but I find even weirder.
>
> Thank you for the patch!
>
> On other thread, John mentions gadget-side drivers should not depend on host-side [1].
> So, I submitted a patch today [2]. What do you think about my submitted patch?
>
> [1]
> https://marc.info/?l=linux-usb&m=153433776202861&w=2

I don't really think this is a big issue, as you can still build the driver
with CONFIG_USB=n, so it's not a strict dependency.

> [2]
> https://patchwork.kernel.org/patch/10569847/

On the other hand, your patch looks nice and is somewhat
less confusing, so you have my Ack on that.

      Arnd
