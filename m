Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4CC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0DF20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f1StIL2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0DF20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeK3DUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:20:24 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39908 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbeK3DUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G54T+5sk6bFuEzUiWI+1yMrD5NhH22z54h6GsTDnDwI=; b=f1StIL2vd+aZG0lWDUjey7mIu
        D4B6Q4p8e00zFjBP4riywI2PlJN7AwIcdTxtJBGZ30PKYmkQF961aG0a7b3e9SZn4idaVxCEvgpYN
        yZz0tGD6f4CWDk6sexveDfJPqvA9213cjE0vkcb0j6HWJxo8zSjIZ5k1uLrfamF0m9tD8=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:38357)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gSOxL-0003Hc-A6; Thu, 29 Nov 2018 16:14:23 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gSOx7-0002HX-1U; Thu, 29 Nov 2018 16:14:09 +0000
Date:   Thu, 29 Nov 2018 16:14:01 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>, Jens Axboe <axboe@kernel.dk>,
        Julien Thierry <Julien.Thierry@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Message-ID: <20181129161401.GY30658@n2100.armlinux.org.uk>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
 <20181129104902.GA2377@arm.com>
 <20181129161039.GA17063@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129161039.GA17063@flashbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:10:39AM -0700, Nathan Chancellor wrote:
> On Thu, Nov 29, 2018 at 10:49:03AM +0000, Will Deacon wrote:
> > On Thu, Nov 29, 2018 at 09:03:54AM +0000, Julien Thierry wrote:
> > >
> > >
> > > On 29/11/18 04:19, Nick Desaulniers wrote:
> > > > Fixes the warning produced from Clang:
> > > > ./include/asm-generic/io.h:711:9: warning: value size does not match
> > > > register size specified by the constraint and modifier
> > > > [-Wasm-operand-widths]
> > > >         return readl(addr);
> > > >                ^
> > > > ./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
> > > >                                                           ^
> > > > ./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
> > > > ./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
> > > >                                                   ^
> > > > ./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
> > > >         asm volatile("eor       %w0, %1, %1\n" \
> > > >                                      ^
> > >
> > > Why does the "eor %0, %1, %1" become "eor %w0, %1, %1" ?
> > > The variable passed to the inline assembly for %0 is unsigned long, so
> > > always 64-bits wide on arm64. Why is clang trying to use a 32-bit
> > > register for it?
> 
> Sorry, this was my fault, I accidentally added a w during testing to see
> what constraints were valid (given that my assembly knowledge is nearly
> non-existence so forgive the non-sensical experimentation) and I used
> that message rather than the original one. This is the unadulterated one.
> 
> In file included from arch/arm64/kernel/asm-offsets.c:24:
> In file included from ./include/linux/dma-mapping.h:11:
> In file included from ./include/linux/scatterlist.h:9:
> In file included from ./arch/arm64/include/asm/io.h:209:
> ./include/asm-generic/io.h:695:9: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
>         return readb(addr);
>                ^
> ./arch/arm64/include/asm/io.h:147:58: note: expanded from macro 'readb'
> #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
>                                                                        ^
> ./include/asm-generic/io.h:695:9: note: use constraint modifier "w"
> ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
>                                                                ^
> ./arch/arm64/include/asm/io.h:118:24: note: expanded from macro '__iormb'
>         asm volatile("eor       %0, %1, %1\n"                           \
>                                     ^
> 
> >
> > Yeah, the message above looks bogus to me. I can see %1 being 32-bit for
> > read[bwl], so maybe clang is just getting the diagnostic wrong. If so,
> > I wonder if the following fixes the problem:
> >
> 
> This doesn't appear to work, I get this error:
> 
> In file included from arch/arm64/kernel/asm-offsets.c:24:
> In file included from ./include/linux/dma-mapping.h:11:
> In file included from ./include/linux/scatterlist.h:9:
> In file included from ./arch/arm64/include/asm/io.h:209:
> ./include/asm-generic/io.h:695:9: error: expected expression
>         return readb(addr);
>                ^
> ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
>                                                                ^
> ./arch/arm64/include/asm/io.h:120:28: note: expanded from macro '__iormb'
>                      : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
>                                          ^
> 
> >
> > diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> > index d42d00d8d5b6..13befec8b64e 100644
> > --- a/arch/arm64/include/asm/io.h
> > +++ b/arch/arm64/include/asm/io.h
> > @@ -117,7 +117,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
> >          */                                                             \
> >         asm volatile("eor       %0, %1, %1\n"                           \
> >                      "cbnz      %0, ."                                  \
> > -                    : "=r" (tmp) : "r" (v) : "memory");                \
> > +                    : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \

The parens around the passed value are part of the asm() syntax, which
is:

	"contraint" (expression)

so should be:

+                    : "=r" (tmp) : "r" ((unsigned long)(v)) : "memory"); \

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
