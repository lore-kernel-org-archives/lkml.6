Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeC0RgF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:36:05 -0400
Received: from foss.arm.com ([217.140.101.70]:60818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752060AbeC0RgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:36:03 -0400
Date: Tue, 27 Mar 2018 18:36:13 +0100
From: Will Deacon <will.deacon@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Philip Elcan <pelcan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Thomas Speier <tspeier@codeaurora.org>
Subject: Re: [PATCH V2] arm64: tlbflush: avoid writing RES0 bits
Message-ID: <20180327173613.GI18435@arm.com>
References: <1522120877-9136-1-git-send-email-pelcan@codeaurora.org>
 <985a0edd-e388-dade-8824-30cc58a236f3@arm.com>
 <56b560a5-6e57-8e01-32ca-9d3c95ccd2e5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56b560a5-6e57-8e01-32ca-9d3c95ccd2e5@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shanker,

On Tue, Mar 27, 2018 at 09:53:16AM -0500, Shanker Donthineni wrote:
> On 03/27/2018 06:34 AM, Robin Murphy wrote:
> > On 27/03/18 04:21, Philip Elcan wrote:
> >> Several of the bits of the TLBI register operand are RES0 per the ARM
> >> ARM, so TLBI operations should avoid writing non-zero values to these
> >> bits.
> >>
> >> This patch adds a macro __TLBI_VADDR(addr, asid) that creates the
> >> operand register in the correct format and honors the RES0 bits.
> >>
> >> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
> >> ---
> >>   arch/arm64/include/asm/tlbflush.h | 23 ++++++++++++++++-------
> >>   1 file changed, 16 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> >> index 9e82dd7..b1205e9 100644
> >> --- a/arch/arm64/include/asm/tlbflush.h
> >> +++ b/arch/arm64/include/asm/tlbflush.h
> >> @@ -60,6 +60,15 @@
> >>           __tlbi(op, (arg) | USER_ASID_FLAG);                \
> >>   } while (0)
> >>   +/* This macro creates a properly formatted VA operand for the TLBI */
> >> +#define __TLBI_VADDR(addr, asid)                \
> >> +    ({                            \
> >> +        unsigned long __ta = (addr) >> 12;        \
> >> +        __ta &= GENMASK_ULL(43, 0);            \
> >> +        __ta |= (unsigned long)(asid) << 48;        \
> >> +        __ta;                        \
> >> +    })
> > 
> > I'd be inclined to make this a static inline function rather than a
> > macro, since it doesn't need to do any wacky type-dodging, but either
> > way the overall change now looks appropriate;
> > 
> > Acked-by: Robin Murphy <robin.murphy@arm.com>
> > 
> 
> Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

[...]

> >> @@ -154,8 +163,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
> >>           return;
> >>       }
> >>   -    start = asid | (start >> 12);
> >> -    end = asid | (end >> 12);
> >> +    start = __TLBI_VADDR(start, asid);
> >> +    end = __TLBI_VADDR(end, asid);

Can you test this bit too, please? ;)

Will
