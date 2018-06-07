Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oY/kDVMLGVtuZQAAmS7hNA
	; Thu, 07 Jun 2018 10:42:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 18789608B8; Thu,  7 Jun 2018 10:42:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F38856089E;
	Thu,  7 Jun 2018 10:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F38856089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeFGKmS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:42:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:34027 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753004AbeFGKmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:42:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6FF77ABF9;
        Thu,  7 Jun 2018 10:42:15 +0000 (UTC)
Date: Thu, 7 Jun 2018 12:42:14 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>, vbabka@suse.cz,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mremap: Remove LATENCY_LIMIT from mremap to reduce the
 number of TLB shootdowns
Message-ID: <20180607104214.GI32433@dhcp22.suse.cz>
References: <20180606183803.k7qaw2xnbvzshv34@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606183803.k7qaw2xnbvzshv34@techsingularity.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-06-18 19:38:03, Mel Gorman wrote:
> Commit 5d1904204c99 ("mremap: fix race between mremap() and page cleanning")
> fixed races between mremap and other operations for both file-backed and
> anonymous mappings. The file-backed was the most critical as it allowed the
> possibility that data could be changed on a physical page after page_mkclean
> returned which could trigger data loss or data integrity issues. A customer
> reported that the cost of the TLBs for anonymous regressions was excessive
> and resulting in a 30-50% drop in performance overall since this commit
> on a microbenchmark. Unfortunately I neither have access to the test-case
> nor can I describe what it does other than saying that mremap operations
> dominate heavily.
> 
> This patch removes the LATENCY_LIMIT to handle TLB flushes on a PMD boundary
> instead of every 64 pages to reduce the number of TLB shootdowns by a factor
> of 8 in the ideal case. LATENCY_LIMIT was almost certainly used originally
> to limit the PTL hold times but the latency savings are likely offset by
> the cost of IPIs in many cases. This patch is not reported to completely
> restore performance but gets it within an acceptable percentage. The given
> metric here is simply described as "higher is better".
> 
> Baseline that was known good
> 002:  Metric:       91.05
> 004:  Metric:      109.45
> 008:  Metric:       73.08
> 016:  Metric:       58.14
> 032:  Metric:       61.09
> 064:  Metric:       57.76
> 128:  Metric:       55.43
> 
> Current
> 001:  Metric:       54.98
> 002:  Metric:       56.56
> 004:  Metric:       41.22
> 008:  Metric:       35.96
> 016:  Metric:       36.45
> 032:  Metric:       35.71
> 064:  Metric:       35.73
> 128:  Metric:       34.96
> 
> With patch
> 001:  Metric:       61.43
> 002:  Metric:       81.64
> 004:  Metric:       67.92
> 008:  Metric:       51.67
> 016:  Metric:       50.47
> 032:  Metric:       52.29
> 064:  Metric:       50.01
> 128:  Metric:       49.04
> 
> So for low threads, it's not restored but for larger number of threads,
> it's closer to the "known good" baseline.
> 
> Using a different mremap-intensive workload that is not representative of
> the real workload there is little difference observed outside of noise in
> the headline metrics However, the TLB shootdowns are reduced by 11% on
> average and at the peak, TLB shootdowns were reduced by 21%. Interrupts
> were sampled every second while the workload ran to get those figures.
> It's known that the figures will vary as the non-representative load is
> non-deterministic.
> 
> An alternative patch was posted that should have significantly reduced the
> TLB flushes but unfortunately it does not perform as well as this version
> on the customer test case. If revisited, the two patches can stack on top
> of each other.

Yes, I think the other patch still makes some sense. I do not see why it
is not helping much but I hope we will learn that. This is a reasonable
step in the meantime.

I like the limit removal more than the previous version to tweak it.

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/mremap.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 049470aa1e3e..5c2e18505f75 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -191,8 +191,6 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>  		drop_rmap_locks(vma);
>  }
>  
> -#define LATENCY_LIMIT	(64 * PAGE_SIZE)
> -
>  unsigned long move_page_tables(struct vm_area_struct *vma,
>  		unsigned long old_addr, struct vm_area_struct *new_vma,
>  		unsigned long new_addr, unsigned long len,
> @@ -247,8 +245,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  		next = (new_addr + PMD_SIZE) & PMD_MASK;
>  		if (extent > next - new_addr)
>  			extent = next - new_addr;
> -		if (extent > LATENCY_LIMIT)
> -			extent = LATENCY_LIMIT;
>  		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
>  			  new_pmd, new_addr, need_rmap_locks, &need_flush);
>  	}

-- 
Michal Hocko
SUSE Labs
