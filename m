Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCZKC0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:02:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39028 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbeCZKCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:02:25 -0400
Date: Mon, 26 Mar 2018 11:02:21 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Philip Elcan <pelcan@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Thomas Speier <tspeier@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>
Subject: Re: [PATCH] arm64: tlbflush: avoid writing RES0 bits
Message-ID: <20180326100220.zbu4dfojofmbesp4@lakrids.cambridge.arm.com>
References: <1521666172-2494-1-git-send-email-pelcan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521666172-2494-1-git-send-email-pelcan@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 05:02:52PM -0400, Philip Elcan wrote:
> Bits [47:44] of the TLBI register operand are RES0 for instructions that
> require a VA, per the ARM ARM spec, so TLBI operations should avoid writing
> non-zero values to these bits.
> 
> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
> ---
>  arch/arm64/include/asm/tlbflush.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 9e82dd7..dbd22a9 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -60,6 +60,9 @@
>  		__tlbi(op, (arg) | USER_ASID_FLAG);				\
>  } while (0)
>  
> +/* This macro masks out RES0 bits in the TLBI operand */
> +#define __TLBI_VADDR(addr) (addr & ~GENMASK_ULL(47, 44))

If we're going to mask the address bits, it would be simpler to keep the
valid bits than to clear the invalid bits. i.e.

#define __TLBI_VADDR(addr) (addr & GENMASK_ULL(43, 0))

Maybe we want a helper that does all of the addr / asid shifting and
masking, so we do that in one place rather than spreading it across all
helpers, e.g.

#define __tlbi_addr(addr, asid)				\
({							\
	unsigned long __ta = (addr) >> 12;		\
	__ta &= GENMASK_ULL(43, 0);			\
	__ta |= (asid) << 48;				\
	__ta;						\
})

Thanks,
Mark.
