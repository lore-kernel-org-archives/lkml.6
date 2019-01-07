Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23204C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55672147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfAGPAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:00:24 -0500
Received: from foss.arm.com ([217.140.101.70]:32806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfAGPAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:00:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6372480D;
        Mon,  7 Jan 2019 07:00:23 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0979E3F5B7;
        Mon,  7 Jan 2019 07:00:21 -0800 (PST)
Date:   Mon, 7 Jan 2019 15:00:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] arm64: trap illegal translations in __virt_to_phys()
Message-ID: <20190107150019.GC46743@lakrids.cambridge.arm.com>
References: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:21:20PM +0800, Miles Chen wrote:
> Current __virt_to_phys() only print warning messages for non-linear
> addresses. It's hard to catch all warnings by those messages.

Why? Are you seeing a large number of warnings somewhere?

> So add a VIRTUAL_BUG_ON() to trap all non-linear and non-symbol
> addresses (e.g., stack addresses)
> 
> Tested by pass stack addresses and symbol addresses to __pa(). Result:
> stack addresses: kernel BUG()

Either:

* Stacks are vmap'd, and __is_lm_address(stack_addr) is false. We'll
  produce a WARNING() today (and return a junk physical address).

* Stacks are linear mapped, and cannot be distinguished from other
  linear mapped addresses. The physical address will be valid.

... so I don't understand why you need to change this.

> symbol addresses: kernel warning message

That should already be the case today, since the kernel image is mapped
separately from the linear map, so __is_lm_address(symbol_addr) should
be false.

> 
> Maybe we should trap all non-linear address translations in the future.
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  arch/arm64/mm/physaddr.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
> index 67a9ba9eaa96..f6b935dad19c 100644
> --- a/arch/arm64/mm/physaddr.c
> +++ b/arch/arm64/mm/physaddr.c
> @@ -14,6 +14,11 @@ phys_addr_t __virt_to_phys(unsigned long x)
>  	      (void *)x,
>  	      (void *)x);
>  
> +	/* trap all non-linear and non-symbol addresses */
> +	VIRTUAL_BUG_ON(!__is_lm_address(x) &&
> +			(x < (unsigned long)KERNEL_START ||
> +			 x > (unsigned long)KERNEL_END));

The KERNEL_START and KERNEL_END definitions refer to the kernel image,
not the linear map, so it doesn't make any sense to permit those here.

It is *not* valid to call __virt_to_phys() with a symbol address. We
only support those in __virt_to_phys_nodebug() so that broken code has a
chance of stumbling on.

If you want the kernel to die immediately when it hits a warning here,
please set panic_on_warn.

Thanks,
Mark.
