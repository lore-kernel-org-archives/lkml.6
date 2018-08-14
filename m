Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F22C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D645521700
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D645521700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbeHNROM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:14:12 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39451 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:14:12 -0400
Received: by mail-qk0-f193.google.com with SMTP id b5-v6so13493626qkg.6;
        Tue, 14 Aug 2018 07:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfhOC++sparQM3CevMnjMaXNb8ueZEMRB6SvfpR/zOQ=;
        b=svmCsPp6MCIzHNSiFt/O0CdsRxfh9nVJHXT7slPSryLF2th9DpNNMSZ0jKrm3H6vrk
         xbd0QUHbOvHCPbqKmmGZ1Ow/hjQgl0xoFZVeH+DWxJg6Hwv4AY7xuQpLm06cD1sXwr/l
         x4lDzqdTuQ6J++wjxhXBXPbnZWV3yaL0m777BzGQ5Ua3NbEdJGrZOo8GIcEPHkoeDknn
         zEbug4aD1hjXBO5UQgkCHUiTmFE1GDhj7t7L+ZKJpcnTuPBMZtITWSWXV/AYfUVRUdwN
         aedgKHfWuHuutKDLW6fC0WXOoeCEFXpyWzEuDxxmOG4zjBwS8Kk4B6MD/dhLwk+6U9Vv
         JsSw==
X-Gm-Message-State: AOUpUlEdjAVUACQxZ8VCKfq28E+C/e9XxblAOGrCH7gKMA88eKwaseu0
        G85VL0iCoFZl1YkT4EvxiupZew/sjJGztAsmQRM=
X-Google-Smtp-Source: AA+uWPyaiBcN88sKoRKtBY+OuWChHlLxhMSONhsuF7+881nsKU+14g/YpIvVb8Cgxd2qRrCF3e1XVNa/X0jSdNt2qWo=
X-Received: by 2002:a37:5b47:: with SMTP id p68-v6mr19568710qkb.202.1534256806787;
 Tue, 14 Aug 2018 07:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180813214924.3567840-1-arnd@arndb.de> <Pine.LNX.4.44L0.1808140957350.1466-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1808140957350.1466-100000@iolanthe.rowland.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Aug 2018 16:26:30 +0200
Message-ID: <CAK8P3a33DRBj6ZeJBeWGnw3RnpK3rTaYtrbs6jjZ8VVPOk8=qw@mail.gmail.com>
Subject: Re: [PATCH] usb: hide usb_of_get_companion_dev for CONFIG_USB=n
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        yoshihiro.shimoda.uh@renesas.com, Johan Hovold <johan@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 3:58 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 13 Aug 2018, Arnd Bergmann wrote:
> > diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> > index 0a16cbd4e528..663a8bd67a7b 100644
> > --- a/drivers/usb/gadget/udc/Kconfig
> > +++ b/drivers/usb/gadget/udc/Kconfig
> > @@ -193,6 +193,7 @@ config USB_RENESAS_USB3
> >       tristate 'Renesas USB3.0 Peripheral controller'
> >       depends on ARCH_RENESAS || COMPILE_TEST
> >       depends on EXTCON
> > +     depends on USB || !USB
>
> Is this some weird standard idiom?  It looks really strange.

Yes, and yes.

A less common way to write it is

        depends on (USB != m) || m

which some people prefer, but I find even weirder.

       Arnd
