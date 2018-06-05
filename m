Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeFETyC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:54:02 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41079 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbeFETyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:54:01 -0400
X-Google-Smtp-Source: ADUXVKJCajRlNfeX6iRHnLZzUCEF4Z2X99pHrzR0YzPAfzJmdkfChAvBhRaphR9dtg+NpFGYCEyrUQ==
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] mremap: Avoid TLB flushing anonymous pages that are not
 in swap cache
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180605171319.uc5jxdkxopio6kg3@techsingularity.net>
Date: Tue, 5 Jun 2018 12:53:57 -0700
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Aaron Lu <aaron.lu@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Message-Id: <EAD124C4-FFA4-4894-AE8B-33949CD6731B@gmail.com>
References: <20180605171319.uc5jxdkxopio6kg3@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55Js9sZ008324

Mel Gorman <mgorman@techsingularity.net> wrote:

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
> The anonymous page race fix is overkill for two reasons. Pages that are not
> in the swap cache are not going to be issued for IO and if a stale TLB entry
> is used, the write still occurs on the same physical page. Any race with
> mmap replacing the address space is handled by mmap_sem. As anonymous pages
> are often dirty, it can mean that mremap always has to flush even when it is
> not necessary.
> 
> This patch special cases anonymous pages to only flush if the page is in
> swap cache and can be potentially queued for IO. It uses the page lock to
> serialise against any potential reclaim. If the page is added to the swap
> cache on the reclaim side after the page lock is dropped on the mremap
> side then reclaim will call try_to_unmap_flush_dirty() before issuing
> any IO so there is no data integrity issue. This means that in the common
> case where a workload avoids swap entirely that mremap is a much cheaper
> operation due to the lack of TLB flushes.
> 
> Using another testcase that simply calls mremap heavily with varying number
> of threads, it was found that very broadly speaking that TLB shootdowns
> were reduced by 31% on average throughout the entire test case but your
> milage will vary.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
> mm/mremap.c | 42 +++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 049470aa1e3e..d26c5a00fd9d 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -24,6 +24,7 @@
> #include <linux/uaccess.h>
> #include <linux/mm-arch-hooks.h>
> #include <linux/userfaultfd_k.h>
> +#include <linux/mm_inline.h>
> 
> #include <asm/cacheflush.h>
> #include <asm/tlbflush.h>
> @@ -112,6 +113,41 @@ static pte_t move_soft_dirty_pte(pte_t pte)
> 	return pte;
> }
> 
> +/* Returns true if a TLB must be flushed before PTL is dropped */
> +static bool should_force_flush(pte_t *pte)
> +{
> +	bool is_swapcache;
> +	struct page *page;
> +
> +	if (!pte_present(*pte) || !pte_dirty(*pte))
> +		return false;
> +
> +	/*
> +	 * If we are remapping a dirty file PTE, make sure to flush TLB
> +	 * before we drop the PTL for the old PTE or we may race with
> +	 * page_mkclean().
> +	 */
> +	page = pte_page(*pte);
> +	if (page_is_file_cache(page))
> +		return true;
> +
> +	/*
> +	 * For anonymous pages, only flush swap cache pages that could
> +	 * be unmapped and queued for swap since flush_tlb_batched_pending was
> +	 * last called. Reclaim itself takes care that the TLB is flushed
> +	 * before IO is queued. If a page is not in swap cache and a stale TLB
> +	 * is used before mremap is complete then the write hits the same
> +	 * physical page and there is no lost data loss. Check under the
> +	 * page lock to avoid any potential race with reclaim.
> +	 */
> +	if (!trylock_page(page))
> +		return true;
> +	is_swapcache = PageSwapCache(page);
> +	unlock_page(page);
> +
> +	return is_swapcache;
> +}

While I do not have a specific reservation regarding the logic, I find the
current TLB invalidation scheme hard to follow and inconsistent. I guess
should_force_flush() can be extended and used more commonly to make things
clearer.

To be more specific and to give an example: Can should_force_flush() be used
in zap_pte_range() to set the force_flush instead of the current code?

  if (!PageAnon(page)) {
	if (pte_dirty(ptent)) {
		force_flush = 1;
		...
  	}
