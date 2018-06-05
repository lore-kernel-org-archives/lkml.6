Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeFEUIE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:08:04 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:35781 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752050AbeFEUIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:08:02 -0400
Date: Tue, 5 Jun 2018 21:08:00 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Aaron Lu <aaron.lu@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mremap: Avoid TLB flushing anonymous pages that are not
 in swap cache
Message-ID: <20180605200800.emb3yfdtnpjgmxb7@techsingularity.net>
References: <20180605171319.uc5jxdkxopio6kg3@techsingularity.net>
 <EAD124C4-FFA4-4894-AE8B-33949CD6731B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <EAD124C4-FFA4-4894-AE8B-33949CD6731B@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:53:57PM -0700, Nadav Amit wrote:
> While I do not have a specific reservation regarding the logic, I find the
> current TLB invalidation scheme hard to follow and inconsistent. I guess
> should_force_flush() can be extended and used more commonly to make things
> clearer.
> 
> To be more specific and to give an example: Can should_force_flush() be used
> in zap_pte_range() to set the force_flush instead of the current code?
> 
>   if (!PageAnon(page)) {
> 	if (pte_dirty(ptent)) {
> 		force_flush = 1;
> 		...
>   	}
> 

That check is against !PageAnon pages where it's potentially critical
that the dirty PTE bit be propogated to the page. You could split the
separate the TLB flush from the dirty page setting but it's not the same
class of problem and without perf data, it's not clear it's worthwhile.

Note that I also didn't handle the huge page moving because it's already
naturally batching a larger range with a lower potential factor of TLB
flushing and has different potential race conditions.

I agree that the TLB handling would benefit from being simplier but it's
not a simple search/replace job to deal with the different cases that apply.

-- 
Mel Gorman
SUSE Labs
