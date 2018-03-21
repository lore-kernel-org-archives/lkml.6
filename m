Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeCUPIX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:08:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752568AbeCUPIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:08:22 -0400
Date: Wed, 21 Mar 2018 11:08:19 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 13/15] mm/hmm: factor out pte and pmd handling to
 simplify hmm_vma_walk_pmd()
Message-ID: <20180321150819.GC3214@redhat.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-14-jglisse@redhat.com>
 <e0fd4348-8b8c-90b2-a9d8-91a30768fddc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0fd4348-8b8c-90b2-a9d8-91a30768fddc@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 10:07:29PM -0700, John Hubbard wrote:
> On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > No functional change, just create one function to handle pmd and one
> > to handle pte (hmm_vma_handle_pmd() and hmm_vma_handle_pte()).
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  mm/hmm.c | 174 +++++++++++++++++++++++++++++++++++++--------------------------
> >  1 file changed, 102 insertions(+), 72 deletions(-)
> > 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 52cdceb35733..dc703e9c3a95 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -351,6 +351,99 @@ static int hmm_vma_walk_hole(unsigned long addr,
> >  	return hmm_vma_walk->fault ? -EAGAIN : 0;
> >  }
> >  
> > +static int hmm_vma_handle_pmd(struct mm_walk *walk,
> > +			      unsigned long addr,
> > +			      unsigned long end,
> > +			      uint64_t *pfns,
> 
> Hi Jerome,
> 
> Nice cleanup, it makes it much easier to follow the code now.
> 
> Let's please rename the pfns argument above to "pfn", because in this
> helper (and the _pte helper too), there is only one pfn involved, rather
> than an array of them.

This is only true to handle_pte, for handle_pmd it will go over several
pfn entries. But they will all get fill with same value modulo pfn which
will increase monotically (ie same flag as pmd permissions apply to all
entries).

Note sure s/pfns/pfn for hmm_vma_handle_pte() warrant a respin.

Cheers,
Jérôme
