Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936589AbeBUNVl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:21:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54426 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752736AbeBUNMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:12:05 -0500
Date: Wed, 21 Feb 2018 13:12:04 +0000
From: Will Deacon <will.deacon@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Speier <tspeier@codeaurora.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Philip Elcan <pelcan@codeaurora.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
Message-ID: <20180221131203.GB7614@arm.com>
References: <1519095546-24420-1-git-send-email-shankerd@codeaurora.org>
 <20180221111233.gylb6v4yxqnn6gyj@localhost>
 <23d70753-a628-f2e4-84df-39e4021337f5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d70753-a628-f2e4-84df-39e4021337f5@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 07:10:34AM -0600, Shanker Donthineni wrote:
> On 02/21/2018 05:12 AM, Catalin Marinas wrote:
> > However, my worry is that in an implementation with DIC set, we also
> > skip the DSB/ISB sequence in the invalidate_icache_by_line macro. For
> > example, in an implementation with transparent PoU, we could have:
> > 
> > 	str	<some instr>, [addr]
> > 	// no cache maintenance or barrier
> > 	br	<addr>
> > 
> 
> Thanks for pointing out the missing barriers. I think it make sense to follow
> the existing barrier semantics in order to avoid the unknown things.
>  
> > Is an ISB required between the instruction store and execution? I would
> > say yes but maybe Will has a better opinion here.
> > 
> Agree, an ISB is required especially for self-modifying code. I'll include in v3 patch. 

I'd have thought you'd need a DSB too, before the ISB.

Will
