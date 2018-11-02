Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E1C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E6E20661
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz7yJrks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E6E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbeKCJIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:08:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36247 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeKCJId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:08:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id z17-v6so1635428pgv.3;
        Fri, 02 Nov 2018 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yVCC8OaI5Rtyedrj3zm5wUwPJwDjIqqbnaav5FL1DtU=;
        b=Yz7yJrksHc20baqyJX9/9ouy5TTNtnkVANCsy+U2dIq5u2i8HZvvvClLbwgn+DNGkA
         Xhd9inqL+6tkHO+jr0sbp/hckr0i2/oJynipvBPYCaR0zx02sFi8tzkVupHzBRePaOFq
         uMG6PAOGiWTLnidcQKHo9If8KjQEG0HwlRE2kCVxURYniHEkTuLt4rwTwUz8Nejk458W
         UTDq6f1gZLMb3TIrva9lDwR4gOTOiljavbo1r4ZalutugONbmrDHySYMVnliDLjyq8Lu
         YiwPs05a9N7VdxSrFvjxlYTOfUlYjt2bVi/D/4GclscurI5AoczqsqMYlJhWmTPM4p0F
         PJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yVCC8OaI5Rtyedrj3zm5wUwPJwDjIqqbnaav5FL1DtU=;
        b=NC7njmMYAjiDZFb/a/AOM8s87i2fDwRwMy7q4qr/HZSt6YfSL649eZ7vm/47KZLs6S
         KLmk2sPXG6WPOYKgLrlbr0FXV7OHbpBCYyOCNWZweRPIbPOPaY5QRykxqUYGCSwtTLKN
         uj94HzhmatfC6B6O7wzCV4gtCEp4SWdwQ+ylKUlZaHlxYvUSk6aOpeyzCr81H1ii0Etv
         4Ry9uXeLV5REqrI7a2W2QXuS68RfziddZQRB5ShYZd5TxKA1qHXJdzNhugL7PskupSzH
         xdeewYIfLc+dt/6kJsMN8cHr7pVjZpncfyoFKO2bcQDdTQitk4EdZZHAiRUAy8CT8LbX
         EnoQ==
X-Gm-Message-State: AGRZ1gJE2bG4zTn24tQ3xTyOtsfeMRohhjt6TKEPqs8s1CUo74dKF3Ez
        2N+7f5iz6sh3CyC5xVYf/xU=
X-Google-Smtp-Source: AJdET5esTk+dnmIK5LRUyJnnT7K4nCRngDUDsXsBBP+ED34sPVZ7YbkdxHtQ6zVwXt7JH88Jhd4xPQ==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr12184128pgk.406.1541203156774;
        Fri, 02 Nov 2018 16:59:16 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id r1-v6sm49374077pfb.41.2018.11.02.16.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 16:59:16 -0700 (PDT)
Date:   Fri, 2 Nov 2018 23:59:14 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
Message-ID: <20181102235214.uow7crqa5qxnuzxr@mail.google.com>
References: <20181031145907.1ee2e866@canb.auug.org.au>
 <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
 <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com>
 <20181101142946.u5luuctqav6fec6k@mail.google.com>
 <CAK7LNAQbBG=KV5Q8o5-JiNCswuse94jECoqT+T+UEY7bLCRPNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQbBG=KV5Q8o5-JiNCswuse94jECoqT+T+UEY7bLCRPNw@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada,
>On Fri, Nov 02, 2018 at 05:25:00PM +0900, Masahiro Yamada wrote:
>[...]
> > > >
> > > > diff --git a/drivers/virt/vboxguest/vboxguest_core.c
> > > > b/drivers/virt/vboxguest/vboxguest_core.c
> > > > index 3093655c7b92..1475ed5ffcde 100644
> > > > --- a/drivers/virt/vboxguest/vboxguest_core.c
> > > > +++ b/drivers/virt/vboxguest/vboxguest_core.c
> > > > @@ -1312,7 +1312,7 @@ static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
> > > >                 return -EINVAL;
> > > >         }
> > > >
> > > > -       if (f32bit)
> > > > +       if (IS_ENABLED(CONFIG_COMPAT) && f32bit)
> > > >                 ret = vbg_hgcm_call32(gdev, client_id,
> > > >                                       call->function, call->timeout_ms,
> > > >                                       VBG_IOCTL_HGCM_CALL_PARMS32(call),
> > >
> > > Right, but adding the CONFIG_COMPAT guard to both the caller and the callee
> > > looks a bit redundant...
> > >
> > >
> > > I think most cases causing this kind of problem
> > > rely on the assumption that 'static' functions are inlined.
> > >
> > > We can force the compiler to do so
> > > by replacing 'static' with 'static __always_inline'
> > >
> > Declaring it as normal 'inline' is enough. The inline functions are
> > still inlined by gcc. Thanks.
> 
> 
> How about clang?
> 
> For clang, -Og might be equivalent to -O1 at this moment, but I am not sure.
> 
> In my understanding, Clang does not inline functions marked with 'static inline'
> for -Og (or -O1) optimization level.
> 
> Theoretically, 'inline' keyword is a just hint for the compiler, after all.
> 
I only verified it with GCC. But on my machine, clang does not work since it
lacks 'asm-goto' feature. Is clang linux completed?

changbin@acer:~/Desktop/work/linux$ make HOSTCC=clang CC=clang
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --syncconfig Kconfig
Compiler lacks asm-goto support.
arch/x86/Makefile:308: recipe for target 'checkbin' failed
make: *** [checkbin] Error 1
changbin@acer:~/Desktop/work/linux$ clang -v
clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/i686-linux-gnu/8
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/7
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/7.3.0
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/8
Found candidate GCC installation: /usr/lib/gcc/i686-linux-gnu/8
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/7
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/7.3.0
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/8
Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/7.3.0
Candidate multilib: .;@m64
Selected multilib: .;@m64

> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
