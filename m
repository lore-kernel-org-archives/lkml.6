Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FE3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3F12087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3F12087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbeITM6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:58:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44389 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeITM6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:58:49 -0400
Received: by mail-ua1-f66.google.com with SMTP id m11-v6so4030082uao.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 00:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbRx8KXrkmQV/Y95TxT1nzAeqT4HvkyRl2bK3e3z4jU=;
        b=otWYCSkrnKMKJHO8tQhaZ8YH9jCyfkXNcFwWBXZkLWtw4/vhPIFC5sou1Kzfsdjvan
         IGbEtnsKd6BvPp/KbXLqwRFLMJPIjC/BMlRcNrZH14tM/Nnsg8V5mkqoWpMm7ddixJ4h
         Tw/inemMXljSHY3W+UuCqVch/5xCyANgIhEaoOei52lxtBErHCL4ou4MzGTrIKz6Arly
         +ruwIRxgUYDxhVkhmEP08aqe54v9hwXikdwtC0GUJ/ooH7NEEXKUnPCuZBgOvtHE6Kmh
         UD1WwS+1A6r+Ivw/P2XHtDvU7r82AaDaiDovI2BGYi6xj9gaAXTZx7EyV++iBxiCmN7Z
         3ALg==
X-Gm-Message-State: APzg51CwBzZcnbhaswb76zWxgYJETDi/GmQP27NVUJL5pOiM1pQvhEJL
        Xh0Ep0OKC7NczPPfb1TTMxZkJJbwpalUoe8AGiI=
X-Google-Smtp-Source: ANB0VdapEOizdRj7AcVQz8Kv2sdYnfp3LOCv01xhiqQChJruQP8J15KctIYiGjdjntI3UZ6IT/IZe3GKYvhkQxYW62I=
X-Received: by 2002:ab0:60c6:: with SMTP id g6-v6mr12330860uam.41.1537427807893;
 Thu, 20 Sep 2018 00:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180919234721.16042-1-tpiepho@impinj.com> <CAMuHMdVMbjkvEXex_Z8ELPUo8hVZucFBCd2Wy4ENpiqEaLES_w@mail.gmail.com>
 <20180920070937.GA9609@kroah.com>
In-Reply-To: <20180920070937.GA9609@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Sep 2018 09:16:36 +0200
Message-ID: <CAMuHMdVoFQpLntp-aygO-T818BFb4-ybXa3FLkFKJxCpdw6m=w@mail.gmail.com>
Subject: Re: [PATCH] ARM: amba: Fix leak of driver_override attribute value
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Todd Kjos <tkjos@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Sep 20, 2018 at 9:09 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Sep 20, 2018 at 08:48:36AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Sep 20, 2018 at 1:48 AM Trent Piepho <tpiepho@impinj.com> wrote:
> > > If driver_override was set when a device was released the string would
> > > not be kfree'ed in amba_device_release and thus leaked when the amba
> > > device was freed.
> > >
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Todd Kjos <tkjos@google.com>
> > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> >
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device
> > binding path 'driver_override'")
>
> Then it should also have a cc: stable, right?

Perhaps. I usually leave that up to the maintainer, else git send-email sends
it to stable immediately.

The modern backporting AI will consider it anyway, due to the subject, and
the Fixes tag, right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
