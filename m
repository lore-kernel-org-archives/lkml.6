Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id um7oNY4/GlvMTwAAmS7hNA
	; Fri, 08 Jun 2018 08:34:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BDFD3607E4; Fri,  8 Jun 2018 08:34:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EAAFF60290;
	Fri,  8 Jun 2018 08:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAAFF60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeFHIeT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:34:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59526 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbeFHIeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:34:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 598671529;
        Fri,  8 Jun 2018 01:34:17 -0700 (PDT)
Received: from localhost (unknown [10.37.8.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7B7E3F557;
        Fri,  8 Jun 2018 01:34:16 -0700 (PDT)
Date: Fri, 8 Jun 2018 10:34:14 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Jia He <hejianet@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Suzuki.Poulose@arm.com, linux-kernel@vger.kernel.org,
        jia.he@hxt-semitech.com
Subject: Re: [PATCH v2 2/2] KVM: arm/arm64: harden unmap_stage2_ptes in case
 end is not PAGE_SIZE aligned
Message-ID: <20180608083414.GA5097@C02W217FHV2R.local>
References: <1526635630-18917-1-git-send-email-hejianet@gmail.com>
 <1526635630-18917-2-git-send-email-hejianet@gmail.com>
 <2185a61e-c157-e177-9bad-83b6f27fd784@arm.com>
 <50c98169-1606-48bf-0489-124adefd2a54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c98169-1606-48bf-0489-124adefd2a54@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 09:04:40PM +0800, Jia He wrote:
> 
> 
> On 5/18/2018 5:48 PM, Marc Zyngier Wrote:
> > On 18/05/18 10:27, Jia He wrote:
> >> If it passes addr=0x202920000,size=0xfe00 to unmap_stage2_range->
> >> ...->unmap_stage2_ptes, unmap_stage2_ptes will get addr=0x202920000,
> >> end=0x20292fe00. After first while loop addr=0x202930000, end=0x20292fe00,
> >> then addr!=end. Thus it will touch another pages by put_pages() in the
> >> 2nd loop.
> >>
> >> This patch fixes it by hardening the break condition of while loop.
> >>
> >> Signed-off-by: jia.he@hxt-semitech.com
> >> ---
> >> v2: newly added
> >>
> >>  virt/kvm/arm/mmu.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> >> index 8dac311..45cd040 100644
> >> --- a/virt/kvm/arm/mmu.c
> >> +++ b/virt/kvm/arm/mmu.c
> >> @@ -217,7 +217,7 @@ static void unmap_stage2_ptes(struct kvm *kvm, pmd_t *pmd,
> >>  
> >>  			put_page(virt_to_page(pte));
> >>  		}
> >> -	} while (pte++, addr += PAGE_SIZE, addr != end);
> >> +	} while (pte++, addr += PAGE_SIZE, addr < end);
> >>  
> >>  	if (stage2_pte_table_empty(start_pte))
> >>  		clear_stage2_pmd_entry(kvm, pmd, start_addr);
> >>
> > 
> > I don't think this change is the right thing to do. You get that failure
> > because you're being passed a size that is not a multiple of PAGE_SIZE.
> > That's the mistake.
> > 
> > You should ensure that this never happens, rather than changing the page
> > table walkers (which are consistent with the way this kind of code is
> > written in other places of the kernel). As you mentioned in your first
> > patch, the real issue is that KSM is broken, and this is what should be
> > fixed.
> > 
> Got it, thanks
> Should I resend the patch 1/2 without any changes after droping patch 2/2?
> 

That's fine if you trim the commit message to make it look nicer.

Also, in the future, please include a cover letter if you send more than
one patch to the list.

Thanks,
-Christoffer
