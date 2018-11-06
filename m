Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FC2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A300720869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A300720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbeKFUpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:45:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:17895 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeKFUpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:45:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 03:20:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="83694421"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by fmsmga007.fm.intel.com with ESMTP; 06 Nov 2018 03:20:33 -0800
Date:   Tue, 6 Nov 2018 19:20:33 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?UGF3ZcWC?= Staszewski <pstaszewski@itcare.pl>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yoel Caspersen <yoel@kviknet.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v2 2/2] mm/page_alloc: use a single function to free page
Message-ID: <20181106112033.GB24198@intel.com>
References: <20181105085820.6341-1-aaron.lu@intel.com>
 <20181105085820.6341-2-aaron.lu@intel.com>
 <20181106053037.GD6203@intel.com>
 <d6b4890c-0def-6114-2dcf-3ed120dea82c@suse.cz>
 <20181106084746.GA24198@intel.com>
 <30aa9d1f-d619-c143-3de6-6876029538bc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30aa9d1f-d619-c143-3de6-6876029538bc@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 10:32:00AM +0100, Vlastimil Babka wrote:
> On 11/6/18 9:47 AM, Aaron Lu wrote:
> > On Tue, Nov 06, 2018 at 09:16:20AM +0100, Vlastimil Babka wrote:
> >> On 11/6/18 6:30 AM, Aaron Lu wrote:
> >>> We have multiple places of freeing a page, most of them doing similar
> >>> things and a common function can be used to reduce code duplicate.
> >>>
> >>> It also avoids bug fixed in one function but left in another.
> >>>
> >>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> >>
> >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > Thanks.
> > 
> >> I assume there's no arch that would run page_ref_sub_and_test(1) slower
> >> than put_page_testzero(), for the critical __free_pages() case?
> > 
> > Good question.
> > 
> > I followed the non-arch specific calls and found that:
> > page_ref_sub_and_test() ends up calling atomic_sub_return(i, v) while
> > put_page_testzero() ends up calling atomic_sub_return(1, v). So they
> > should be same for archs that do not have their own implementations.
> 
> x86 seems to distinguish between DECL and SUBL, see

Ah right.

> arch/x86/include/asm/atomic.h although I could not figure out where does
> e.g. arch_atomic_dec_and_test become atomic_dec_and_test to override the
> generic implementation.

I didn't check that either but I think it will :-)

> I don't know if the CPU e.g. executes DECL faster, but objectively it
> has one parameter less. Maybe it doesn't matter?

No immediate idea.

> > Back to your question: I don't know either.
> > If this is deemed unsafe, we can probably keep the ref modify part in
> > their original functions and only take the free part into a common
> > function.
> 
> I guess you could also employ  if (__builtin_constant_p(nr)) in
> free_the_page(), but the result will be ugly I guess, and maybe not
> worth it :)

Right I can't make it clean.
I think I'll just move the free part a common function and leave the ref
decreasing part as is to be safe.

Regards,
Aaron
 
> >>> ---
> >>> v2: move comments close to code as suggested by Dave.
> >>>
> >>>  mm/page_alloc.c | 36 ++++++++++++++++--------------------
> >>>  1 file changed, 16 insertions(+), 20 deletions(-)
> >>>
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index 91a9a6af41a2..4faf6b7bf225 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -4425,9 +4425,17 @@ unsigned long get_zeroed_page(gfp_t gfp_mask)
> >>>  }
> >>>  EXPORT_SYMBOL(get_zeroed_page);
> >>>  
> >>> -void __free_pages(struct page *page, unsigned int order)
> >>> +static inline void free_the_page(struct page *page, unsigned int order, int nr)
> >>>  {
> >>> -	if (put_page_testzero(page)) {
> >>> +	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
> >>> +
> >>> +	/*
> >>> +	 * Free a page by reducing its ref count by @nr.
> >>> +	 * If its refcount reaches 0, then according to its order:
> >>> +	 * order0: send to PCP;
> >>> +	 * high order: directly send to Buddy.
> >>> +	 */
> >>> +	if (page_ref_sub_and_test(page, nr)) {
> >>>  		if (order == 0)
> >>>  			free_unref_page(page);
> >>>  		else
> >>> @@ -4435,6 +4443,10 @@ void __free_pages(struct page *page, unsigned int order)
> >>>  	}
> >>>  }
> >>>  
> >>> +void __free_pages(struct page *page, unsigned int order)
> >>> +{
> >>> +	free_the_page(page, order, 1);
> >>> +}
> >>>  EXPORT_SYMBOL(__free_pages);
> >>>  
> >>>  void free_pages(unsigned long addr, unsigned int order)
> >>> @@ -4481,16 +4493,7 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
> >>>  
> >>>  void __page_frag_cache_drain(struct page *page, unsigned int count)
> >>>  {
> >>> -	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
> >>> -
> >>> -	if (page_ref_sub_and_test(page, count)) {
> >>> -		unsigned int order = compound_order(page);
> >>> -
> >>> -		if (order == 0)
> >>> -			free_unref_page(page);
> >>> -		else
> >>> -			__free_pages_ok(page, order);
> >>> -	}
> >>> +	free_the_page(page, compound_order(page), count);
> >>>  }
> >>>  EXPORT_SYMBOL(__page_frag_cache_drain);
> >>>  
> >>> @@ -4555,14 +4558,7 @@ void page_frag_free(void *addr)
> >>>  {
> >>>  	struct page *page = virt_to_head_page(addr);
> >>>  
> >>> -	if (unlikely(put_page_testzero(page))) {
> >>> -		unsigned int order = compound_order(page);
> >>> -
> >>> -		if (order == 0)
> >>> -			free_unref_page(page);
> >>> -		else
> >>> -			__free_pages_ok(page, order);
> >>> -	}
> >>> +	free_the_page(page, compound_order(page), 1);
> >>>  }
> >>>  EXPORT_SYMBOL(page_frag_free);
> >>>  
> >>>
> >>
> 
