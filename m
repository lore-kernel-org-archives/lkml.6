Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED3FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B2721905
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfBSJER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:04:17 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39622 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:04:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id o6so22282889qtk.6;
        Tue, 19 Feb 2019 01:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duVmfkmCaKyI9suah2ZRlGhjzmTZPtPlQOQquFJ631U=;
        b=EnRFgFdmn9XenRJpMZ/CB5jutodFxn02DGa921mfPSBMjHc41Zzwrt5Whm3eEqr8l7
         eBX3G+Ny2bE8QstzTzTTP1b0IOE/96F8H7YTyNqQz5v5cQ85QX9MUOFFxXA+9q2PvHeE
         z4+CHBd3pmx/vs61vTb64bDy+VSfiKN0uqo7e2ySyHAXezdtPalhcUNZFBkWrkEQgV80
         vyFAqary2ydpmQ5iTy3lGn/O8MYJIguivfk5/CnZ2in7/lmNvHzpLdy94PuWCbRm/CKm
         4/CuGd8atcu8K5gIOmkN7XD+7gkbrCg1xNP11CfPzbhn2pHIPjpEaXpmcGBTBrzts+cU
         h+6w==
X-Gm-Message-State: AHQUAuYwqePeWN7stm+BV9TPVbssiHt7dY8wtqF2oZ3qnxq5Q4+Udjd5
        XGIGIJ2eOi2eQtsHKQgiT1NZckcu1snKqPw8TVM=
X-Google-Smtp-Source: AHgI3IYg19qI+e8SxIgEcwghsNphBBbOMbd8JoAMf2bRV3g+BmWK61s3iETvwplmqz4xYFhpqC5f1IE2GTFoPjzowzg=
X-Received: by 2002:a0c:e98f:: with SMTP id z15mr20909616qvn.115.1550567054789;
 Tue, 19 Feb 2019 01:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20190218210712.3503891-1-arnd@arndb.de> <20190218210712.3503891-8-arnd@arndb.de>
 <20190219021834.GA4495@guoren-Inspiron-7460>
In-Reply-To: <20190219021834.GA4495@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Feb 2019 10:03:57 +0100
Message-ID: <CAK8P3a0c6sNAPb_t2H9DbOi_antu4p5ncY76Vc6cFRZc=ZtiBg@mail.gmail.com>
Subject: Re: [PATCH 7/8] csky: Use latest system call ABI
To:     Guo Ren <guoren@kernel.org>
Cc:     Mao Han <han_mao@c-sky.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Greentime Hu <green.hu@gmail.com>,
        linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>,
        Joseph Myers <joseph@codesourcery.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:40 PM Joseph Myers <joseph@codesourcery.com> wrote:
>
> On Mon, 18 Feb 2019, Arnd Bergmann wrote:
>
> > We don't yet have an upstream glibc port for csky, so there is no user
>
> We do.  It's in 2.29.
...
On Tue, Feb 19, 2019 at 3:18 AM Guo Ren <guoren@kernel.org> wrote:
>
> Mao Han has merged csky port into glibc 2.29, so we should keep the
> __ARCH_WANT_TIME32_SYSCALLS.

My mistake. I've dropped patch 7/8 from this series now.

> > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > index 6959e0b1e956..398113c845f5 100644
> > --- a/arch/csky/Kconfig
> > +++ b/arch/csky/Kconfig
> > @@ -1,6 +1,5 @@
> >  config CSKY
> >       def_bool y
> > -     select ARCH_32BIT_OFF_T
> >       select ARCH_HAS_SYNC_DMA_FOR_CPU
> >       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> >       select ARCH_USE_BUILTIN_BSWAP
> > diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
> > index ec60e49cea66..224c9a9ab45b 100644
> > --- a/arch/csky/include/uapi/asm/unistd.h
> > +++ b/arch/csky/include/uapi/asm/unistd.h
> > @@ -2,8 +2,6 @@
> >  // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> >
> >  #define __ARCH_WANT_SYS_CLONE
> > -#define __ARCH_WANT_SET_GET_RLIMIT
> Seems it's not related to y2038 issue. Is __ARCH_WANT_SET_GET_RLIMIT no
> use ?

In new architectures, we do not need to set CONFIG_ARCH_32BIT_OFF_T
or __ARCH_WANT_SET_GET_RLIMIT, since we can assume that user
space always uses a 64-bit off_t and a 'struct rlimit' matching the
kernel's rlimit64, with the prlimit64() system call replacing both getrlimit
and setrlimit on the kernel/user ABI side.

I don't know if glibc still uses the 32-bit off_t behavior or the old
getrlimit/setrlimit, but if we're not also changing the time32 interfaces,
the safest option seems to be to leave all three in place.

     Arnd
