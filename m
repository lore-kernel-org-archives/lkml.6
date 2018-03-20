Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeCTCI1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:08:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbeCTCI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:08:26 -0400
Date: Mon, 19 Mar 2018 22:08:23 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 09/14] mm/hmm: do not differentiate between empty entry
 or missing directory
Message-ID: <20180320020823.GA3436@redhat.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-10-jglisse@redhat.com>
 <680af8e7-0f6d-85cb-f259-8a6a1d1dc9c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <680af8e7-0f6d-85cb-f259-8a6a1d1dc9c3@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 04:06:11PM -0700, John Hubbard wrote:

[...]

> > @@ -419,7 +404,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> >  		pfns[i] = 0;
> >  
> >  		if (pte_none(pte)) {
> > -			pfns[i] = HMM_PFN_EMPTY;
> > +			pfns[i] = 0;
> 
> Why is this being set to zero? (0 == HMM_PFN_VALID, btw.)
> I would have expected HMM_PFN_NONE. Actually, looking through the 
> larger patchset, I think there are a couple of big questions about
> these HMM_PFN_* flags. Maybe it's just that the comment documentation
> has fallen completely behind, but it looks like there is an actual
> problem in the code:
> 
> 1. HMM_PFN_* used to be bit shifts, so setting them directly sometimes
> worked. But now they are enum values, so that doesn't work anymore.
> Yet they are still being set directly in places: the enum is being
> treated as a flag, probably incorrectly.
> 
> Previously: 
> 
> #define HMM_PFN_VALID (1 << 0)
> #define HMM_PFN_WRITE (1 << 1)
> #define HMM_PFN_ERROR (1 << 2)
> #define HMM_PFN_EMPTY (1 << 3)
> ...
> 
> New:
> 
> enum hmm_pfn_flag_e {
> 	HMM_PFN_VALID = 0,
> 	HMM_PFN_WRITE,
> 	HMM_PFN_ERROR,
> 	HMM_PFN_NONE,
> ...
> 
> Yet we still have, for example:
> 
>     pfns = HMM_PFN_ERROR;
> 
> This might be accidentally working, because HMM_PFN_ERROR
> has a value of 2, so only one bit is set, but...yikes.
> 
> 2. The hmm_range.flags variable is a uint64_t* (pointer). And then
> the patchset uses the HMM_PFN_* enum to *index* into that as an 
> array. Something is highly suspect here, because...an array that is
> indexed by HMM_PFN_* enums? It's certainly not documented that way.
> 
> Examples:
>     range->flags[HMM_PFN_ERROR]
>  
>     range->flags[HMM_PFN_VALID] 
> 
> I'll go through and try to point these out right next to the relevant
> parts of the patchset, but because I'm taking a little longer than 
> I'd hoped to review this, I figured it's best to alert you earlier, as
> soon as I spot something.
> 

I added more comments in v3 to explain this in last patch (15), and i
also splited values and flags hoping this make it more clear. Maybe
look at how nouveau use that NV_HMM_PAGE_FLAG* and NV_HMM_PAGE_VALUE*
[1] [2]

It is the same idea as pgprot_t vm_page_prot in vma struct except that
it is per device driver and hence not something i can optimize away at
build time for all possible user of HMM and thus why i use an array
provided by each device driver.

Hope this helps explaining it. Note that this would be best to discuss
as last patch review as this patch has nothing to do with that.

Cheers,
Jérôme

[1] https://cgit.freedesktop.org/~glisse/linux/commit/?h=nouveau-hmm&id=b5da479c212d1fe7b6734dd8e69045e23871fdc8
[2] https://cgit.freedesktop.org/~glisse/linux/commit/?h=nouveau-hmm&id=1993d1b09f5941e0fab80c0b485eef296119d393
