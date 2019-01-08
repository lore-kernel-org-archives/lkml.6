Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D731C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D032183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfAHDZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:25:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:13278 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727030AbfAHDZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:25:00 -0500
X-UUID: 963b6ed344c64603bf61c6f016fea25b-20190108
X-UUID: 963b6ed344c64603bf61c6f016fea25b-20190108
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 186511454; Tue, 08 Jan 2019 11:24:51 +0800
Received: from MTKMBS06N2.mediatek.inc (172.21.101.130) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 11:24:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 11:24:43 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 8 Jan 2019 11:24:43 +0800
Message-ID: <1546917883.6754.8.camel@mtkswgap22>
Subject: Re: [PATCH] arm64: trap illegal translations in __virt_to_phys()
From:   Miles Chen <miles.chen@mediatek.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Tue, 8 Jan 2019 11:24:43 +0800
In-Reply-To: <20190107150019.GC46743@lakrids.cambridge.arm.com>
References: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
         <20190107150019.GC46743@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: CF316DC2706CB07A686B9BCABA81EC80B486DB3C62FD6C297DC7DBA4C053A0FD2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 15:00 +0000, Mark Rutland wrote:
> On Mon, Jan 07, 2019 at 07:21:20PM +0800, Miles Chen wrote:
> > Current __virt_to_phys() only print warning messages for non-linear
> > addresses. It's hard to catch all warnings by those messages.
> 
> Why? Are you seeing a large number of warnings somewhere?

Official kernel works fine. I saw some cases in our internal branch and
we're fixing them.

> 
> > So add a VIRTUAL_BUG_ON() to trap all non-linear and non-symbol
> > addresses (e.g., stack addresses)
> > 
> > Tested by pass stack addresses and symbol addresses to __pa(). Result:
> > stack addresses: kernel BUG()
> 
> Either:
> 
> * Stacks are vmap'd, and __is_lm_address(stack_addr) is false. We'll
>   produce a WARNING() today (and return a junk physical address).
> 
> * Stacks are linear mapped, and cannot be distinguished from other
>   linear mapped addresses. The physical address will be valid.
> 
> ... so I don't understand why you need to change this.

For the first case: for vmap'd stack, __pa() returns a junk
physical address and it might be easier to debug this incorrect address
translation by a BUG() call instead of monitoring the warning log.

Like __phys_addr_symbol() does. __phys_addr_symbol() uses
VIRTUAL_BUG_ON() for non symbol addresses.

> 
> > symbol addresses: kernel warning message
> 
> That should already be the case today, since the kernel image is mapped
> separately from the linear map, so __is_lm_address(symbol_addr) should
> be false.
> 
> > 
> > Maybe we should trap all non-linear address translations in the future.
> > 
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > ---
> >  arch/arm64/mm/physaddr.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
> > index 67a9ba9eaa96..f6b935dad19c 100644
> > --- a/arch/arm64/mm/physaddr.c
> > +++ b/arch/arm64/mm/physaddr.c
> > @@ -14,6 +14,11 @@ phys_addr_t __virt_to_phys(unsigned long x)
> >  	      (void *)x,
> >  	      (void *)x);
> >  
> > +	/* trap all non-linear and non-symbol addresses */
> > +	VIRTUAL_BUG_ON(!__is_lm_address(x) &&
> > +			(x < (unsigned long)KERNEL_START ||
> > +			 x > (unsigned long)KERNEL_END));
> 
> The KERNEL_START and KERNEL_END definitions refer to the kernel image,
> not the linear map, so it doesn't make any sense to permit those here.
> 
> It is *not* valid to call __virt_to_phys() with a symbol address. We
> only support those in __virt_to_phys_nodebug() so that broken code has a
> chance of stumbling on.
> 
> If you want the kernel to die immediately when it hits a warning here,
> please set panic_on_warn.
> 
> Thanks,
> Mark.


