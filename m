Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EA3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F7A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F7A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeK2Vxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:53:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60078 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbeK2Vxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:53:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 986AE80D;
        Thu, 29 Nov 2018 02:48:45 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66FF33F59C;
        Thu, 29 Nov 2018 02:48:45 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CE0D51AE0B68; Thu, 29 Nov 2018 10:49:03 +0000 (GMT)
Date:   Thu, 29 Nov 2018 10:49:03 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Julien Thierry <Julien.Thierry@arm.com>
Cc:     Nick Desaulniers <nick.desaulniers@gmail.com>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Message-ID: <20181129104902.GA2377@arm.com>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:03:54AM +0000, Julien Thierry wrote:
> 
> 
> On 29/11/18 04:19, Nick Desaulniers wrote:
> > Fixes the warning produced from Clang:
> > ./include/asm-generic/io.h:711:9: warning: value size does not match
> > register size specified by the constraint and modifier
> > [-Wasm-operand-widths]
> >         return readl(addr);
> >                ^
> > ./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
> >                                                           ^
> > ./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
> > ./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
> >                                                   ^
> > ./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
> >         asm volatile("eor       %w0, %1, %1\n" \
> >                                      ^
> 
> Why does the "eor %0, %1, %1" become "eor %w0, %1, %1" ?
> The variable passed to the inline assembly for %0 is unsigned long, so
> always 64-bits wide on arm64. Why is clang trying to use a 32-bit
> register for it?

Yeah, the message above looks bogus to me. I can see %1 being 32-bit for
read[bwl], so maybe clang is just getting the diagnostic wrong. If so,
I wonder if the following fixes the problem:


diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index d42d00d8d5b6..13befec8b64e 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -117,7 +117,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
         */                                                             \
        asm volatile("eor       %0, %1, %1\n"                           \
                     "cbnz      %0, ."                                  \
-                    : "=r" (tmp) : "r" (v) : "memory");                \
+                    : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
 })
 
 #define __iowmb()              wmb()


Will
