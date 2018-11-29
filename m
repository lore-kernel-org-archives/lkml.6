Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D60C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5AF213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAdmnQPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5AF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeK3DQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:16:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42319 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbeK3DQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:16:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so2464791wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8gapXwiXjGxXSVtyA4Gab236Oo4t1DTJ0o6K8zWtc74=;
        b=EAdmnQPAcEzq4wSna6JlGM22swIFYHnlnKMc79TYv3jVWpqq7fz4AcZMRxMTHn7Nlx
         rAIsWhTegSI4RbCG4xqMEu1z/CMS/e7A0GiUnKDrS/PvMKUcx/M/WvFNavZQTWFIx7Fg
         ioChnq4RJhK/BhAbew0vC7sgk1mvaiG1U5ZBA/UPruscd810QOpAYMDbuYeMQPJlmuvk
         LO2E44/ZCa/HzOSO4aL/bpWwKQN7kDHolezZziogfxGm17odJxZWzmzjQQNKO+p9LAAA
         wtOIzqHvpt9+vZvEJMxfnSm8fvM0rtnT78thsxPNuSXLRIozpuyUHmGLSr1sWfRZd8E7
         xSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8gapXwiXjGxXSVtyA4Gab236Oo4t1DTJ0o6K8zWtc74=;
        b=euLgsmzkmGRSOEbnDLvDTK+7EIKjtq5kDPdN1fy9ikLzAwrZLp7DIgroQ7gWoxGkVU
         Rz41tclkR/0/Njfb3nUmr2fIDCzPEJkR+LuXQgMI6h5aUF+utAiPnW6aL5QYMRK55djm
         v+54bcmHhWdcJ+Hm8ZBOcM/knqpM6K0kmzQ0H3KRpp9hJYEVbfDkCxfEUiBm6ZHEVT3O
         uZX+5PqrlvjIbBHoVekt1R+uHjJFuhztycMKMimTFNgpbyzX+4ReUiUqMUE2TTle6ihC
         KYUM0ZWvNqzV0VYsG4Z8tbq7hqhRuH2+k9/7Zv+x4nK2BWQ1Br4xGVtps1iiGJt7k2CG
         6m1A==
X-Gm-Message-State: AA+aEWYdlBKwDOqGsRVddTKVLqFsZ7WqP2Ro63FA3qx50GNdeUgqxVas
        UJm7wTbAYsuZoG+kUQte04k=
X-Google-Smtp-Source: AFSGD/X25r3VcSoWfqBbq/vOEGSexhxh04nk/Q8iGRJPdA6GRgyZS6B//fdPytrbc129p+szccG3lA==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr2125359wrw.50.1543507842052;
        Thu, 29 Nov 2018 08:10:42 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j8sm1689948wrt.40.2018.11.29.08.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:10:41 -0800 (PST)
Date:   Thu, 29 Nov 2018 09:10:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Julien Thierry <Julien.Thierry@arm.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Message-ID: <20181129161039.GA17063@flashbox>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
 <20181129104902.GA2377@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129104902.GA2377@arm.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:49:03AM +0000, Will Deacon wrote:
> On Thu, Nov 29, 2018 at 09:03:54AM +0000, Julien Thierry wrote:
> >
> >
> > On 29/11/18 04:19, Nick Desaulniers wrote:
> > > Fixes the warning produced from Clang:
> > > ./include/asm-generic/io.h:711:9: warning: value size does not match
> > > register size specified by the constraint and modifier
> > > [-Wasm-operand-widths]
> > >         return readl(addr);
> > >                ^
> > > ./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
> > >                                                           ^
> > > ./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
> > > ./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
> > >                                                   ^
> > > ./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
> > >         asm volatile("eor       %w0, %1, %1\n" \
> > >                                      ^
> >
> > Why does the "eor %0, %1, %1" become "eor %w0, %1, %1" ?
> > The variable passed to the inline assembly for %0 is unsigned long, so
> > always 64-bits wide on arm64. Why is clang trying to use a 32-bit
> > register for it?

Sorry, this was my fault, I accidentally added a w during testing to see
what constraints were valid (given that my assembly knowledge is nearly
non-existence so forgive the non-sensical experimentation) and I used
that message rather than the original one. This is the unadulterated one.

In file included from arch/arm64/kernel/asm-offsets.c:24:
In file included from ./include/linux/dma-mapping.h:11:
In file included from ./include/linux/scatterlist.h:9:
In file included from ./arch/arm64/include/asm/io.h:209:
./include/asm-generic/io.h:695:9: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
        return readb(addr);
               ^
./arch/arm64/include/asm/io.h:147:58: note: expanded from macro 'readb'
#define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
                                                                       ^
./include/asm-generic/io.h:695:9: note: use constraint modifier "w"
./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
#define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
                                                               ^
./arch/arm64/include/asm/io.h:118:24: note: expanded from macro '__iormb'
        asm volatile("eor       %0, %1, %1\n"                           \
                                    ^

>
> Yeah, the message above looks bogus to me. I can see %1 being 32-bit for
> read[bwl], so maybe clang is just getting the diagnostic wrong. If so,
> I wonder if the following fixes the problem:
>

This doesn't appear to work, I get this error:

In file included from arch/arm64/kernel/asm-offsets.c:24:
In file included from ./include/linux/dma-mapping.h:11:
In file included from ./include/linux/scatterlist.h:9:
In file included from ./arch/arm64/include/asm/io.h:209:
./include/asm-generic/io.h:695:9: error: expected expression
        return readb(addr);
               ^
./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
#define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
                                                               ^
./arch/arm64/include/asm/io.h:120:28: note: expanded from macro '__iormb'
                     : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
                                         ^

>
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index d42d00d8d5b6..13befec8b64e 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -117,7 +117,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>          */                                                             \
>         asm volatile("eor       %0, %1, %1\n"                           \
>                      "cbnz      %0, ."                                  \
> -                    : "=r" (tmp) : "r" (v) : "memory");                \
> +                    : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
>  })
>
>  #define __iowmb()              wmb()
>
>
> Will
