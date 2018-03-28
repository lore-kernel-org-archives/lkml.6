Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeC1L55 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:57:57 -0400
Received: from foss.arm.com ([217.140.101.70]:39858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeC1L5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:57:54 -0400
Date: Wed, 28 Mar 2018 12:58:04 +0100
From: Will Deacon <will.deacon@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Philip Elcan <pelcan@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Speier <tspeier@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] arm64: tlbflush: avoid writing RES0 bits
Message-ID: <20180328115804.GD30850@arm.com>
References: <1522120877-9136-1-git-send-email-pelcan@codeaurora.org>
 <985a0edd-e388-dade-8824-30cc58a236f3@arm.com>
 <56b560a5-6e57-8e01-32ca-9d3c95ccd2e5@codeaurora.org>
 <20180327173613.GI18435@arm.com>
 <96f894bb-4855-a77f-3fd1-c8a2878faabb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96f894bb-4855-a77f-3fd1-c8a2878faabb@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 08:03:07PM -0500, Shanker Donthineni wrote:
> On 03/27/2018 12:36 PM, Will Deacon wrote:
> > On Tue, Mar 27, 2018 at 09:53:16AM -0500, Shanker Donthineni wrote:
> >>>> @@ -154,8 +163,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
> >>>>           return;
> >>>>       }
> >>>>   -    start = asid | (start >> 12);
> >>>> -    end = asid | (end >> 12);
> >>>> +    start = __TLBI_VADDR(start, asid);
> >>>> +    end = __TLBI_VADDR(end, asid);
> > 
> > Can you test this bit too, please? ;)
> > 
> 
> I've verified the basic boot functionality on QDF2400 platform. But I can see now
> after your comments, it leads to TLB conflicts because of ASID is truncated to zero
> due to two times 48bit shift.     
> 
> Thanks for catching this one.

I just noticed it during review. In general, if you're making changes
relating to virtual memory stuff I'd *strongly* advise you to do more
than a basic boot test. It's amazing how much appears to run fine when
stuff like TLB invalidation is completely broken.

Anyway, thanks for turning around a new version so quickly.

Will
