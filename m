Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA2CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EE321738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeLaMQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 07:16:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40959 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeLaMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 07:16:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so15609064qki.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 04:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVT+VfMStcHdKtf7fNwd4LBoX1A0p8UlQm2STswVEBw=;
        b=EkPoKuhzzu+23MW4wGx+Ybr3+wKMFJBKHUStNULD6TuyfRwxNge4TfRcMPb04cMl8c
         zZs2sf22VHTMhEEoYPuneFTiyCljydFzdv0v03fR/nF+2qCMRKEjI6u6ziF/Vw+I0vK0
         +W2OjfE4HpnUH8h3YWIkUk+c/VT1Q71227dAodlc0+GxUvTPVLo2D9wojSEOOCmdaIqi
         icoCpIsUxIUqvRgwhZS1CligCIeWTObTco0VPorjaSFf9dRn2KA1q0VevAEYZBGnBkGN
         pkBPJ9SO0Ems+LVvZug7eM0/6c3jrOxf2iL5RVllCAIP4PmvQxFjYUN8RIlSA25NPt2M
         23iA==
X-Gm-Message-State: AJcUukfackoz+ow6E1DtwlVg7K4jYtfaDJU78imq4ijluc7Z4L/RptCP
        nYgXvpgNVh///Qsbkwd1j420ltTA/yr7uBzTEjQ=
X-Google-Smtp-Source: ALg8bN6hmSV6LuVJERub18YLmv7Nc/ghydOwZZJjR9aMvu3Yi8wRSQB8ndXoq9D/PhINUnGoS+Dr2TETcA57AASd4KM=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr33366179qkf.330.1546258596087;
 Mon, 31 Dec 2018 04:16:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com> <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Dec 2018 13:16:19 +0100
Message-ID: <CAK8P3a1rkdMXGOt90SDhBkVvFeNsqdoMKQAu4nLfk_Eg+_CB6g@mail.gmail.com>
Subject: Re: [PATCH v8 18/25] powerpc: Implement nvram sync ioctl
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 8:25 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Sat, 29 Dec 2018, Arnd Bergmann wrote:
>
> > > --- a/drivers/char/nvram.c
> > > +++ b/drivers/char/nvram.c
> > > @@ -48,6 +48,10 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/pagemap.h>
> > >
> > > +#ifdef CONFIG_PPC
> > > +#include <asm/nvram.h>
> > > +#include <asm/machdep.h>
> > > +#endif
> > >
> > >  static DEFINE_MUTEX(nvram_mutex);
> > >  static DEFINE_SPINLOCK(nvram_state_lock);
> > > @@ -331,6 +335,37 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
> > >         long ret = -ENOTTY;
> > >
> > >         switch (cmd) {
> > > +#ifdef CONFIG_PPC
> > > +       case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
> > > +               pr_warn("nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
> > > +               /* fall through */
> > > +       case IOC_NVRAM_GET_OFFSET:
> > > +               ret = -EINVAL;
> > > +#ifdef CONFIG_PPC_PMAC
> >
> > I think it would make be nicer here to keep the ppc bits in arch/ppc,
> > and instead add a .ioctl() callback to nvram_ops.
> >
>
> The problem with having an nvram_ops.ioctl() method is the code in the
> !PPC branch. That code would get duplicated because it's needed by both
> X86 and M68K, to implement the checksum ioctls.

I was thinking you'd just have a common ioctl function that falls
back to the .ioctl callback for any unhandled commands like

    switch (cmd) {
    case NVRAM_INIT:
         ...
         break;
    case ...:
         break;
    default:
         if (ops->ioctl)
                 return ops->ioctl(...);
         return -EINVAL;
    }

Would that work?

       Arnd
