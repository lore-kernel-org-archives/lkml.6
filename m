Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CD120989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CD120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbeK3Dmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:42:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38822 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbeK3Dmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:42:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A47F1A78;
        Thu, 29 Nov 2018 08:36:58 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 734CD3F59C;
        Thu, 29 Nov 2018 08:36:58 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D6B831AE0FD4; Thu, 29 Nov 2018 16:37:16 +0000 (GMT)
Date:   Thu, 29 Nov 2018 16:37:16 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Julien Thierry <Julien.Thierry@arm.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Message-ID: <20181129163716.GA21475@arm.com>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
 <20181129104902.GA2377@arm.com>
 <20181129161039.GA17063@flashbox>
 <20181129161337.GA21349@arm.com>
 <20181129161738.GA9805@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129161738.GA9805@flashbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:17:38AM -0700, Nathan Chancellor wrote:
> On Thu, Nov 29, 2018 at 04:13:37PM +0000, Will Deacon wrote:
> > On Thu, Nov 29, 2018 at 09:10:39AM -0700, Nathan Chancellor wrote:
> > > This doesn't appear to work, I get this error:
> > > 
> > > In file included from arch/arm64/kernel/asm-offsets.c:24:
> > > In file included from ./include/linux/dma-mapping.h:11:
> > > In file included from ./include/linux/scatterlist.h:9:
> > > In file included from ./arch/arm64/include/asm/io.h:209:
> > > ./include/asm-generic/io.h:695:9: error: expected expression
> > >         return readb(addr);
> > >                ^
> > > ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> > > #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
> > >                                                                ^
> > > ./arch/arm64/include/asm/io.h:120:28: note: expanded from macro '__iormb'
> > >                      : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
> > >                                          ^
> > 
> > Can you try throwing another set of brackets around it, please?
> > 
> > 	((unsigned long)(v))
> > 
> Thanks, that fixes the warning as well.

Great, I'll push this out tomorrow with your reported-by on it.

Will
