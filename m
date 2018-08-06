Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D72C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BBB21A2D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BBB21A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeHFPgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:36:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:32822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727510AbeHFPgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:36:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02966AFE0;
        Mon,  6 Aug 2018 13:26:58 +0000 (UTC)
Date:   Mon, 6 Aug 2018 15:26:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v6 PATCH 1/2] mm: refactor do_munmap() to extract the
 common part
Message-ID: <20180806132657.GB22858@dhcp22.suse.cz>
References: <1532628614-111702-1-git-send-email-yang.shi@linux.alibaba.com>
 <1532628614-111702-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180803085335.GH27245@dhcp22.suse.cz>
 <7b84088a-4e49-ed7c-e750-7aba5cc17f11@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b84088a-4e49-ed7c-e750-7aba5cc17f11@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-08-18 13:47:19, Yang Shi wrote:
> 
> 
> On 8/3/18 1:53 AM, Michal Hocko wrote:
> > On Fri 27-07-18 02:10:13, Yang Shi wrote:
> > > Introduces three new helper functions:
> > >    * munmap_addr_sanity()
> > >    * munmap_lookup_vma()
> > >    * munmap_mlock_vma()
> > > 
> > > They will be used by do_munmap() and the new do_munmap with zapping
> > > large mapping early in the later patch.
> > > 
> > > There is no functional change, just code refactor.
> > > 
> > > Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> > > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > > ---
> > >   mm/mmap.c | 120 ++++++++++++++++++++++++++++++++++++++++++--------------------
> > >   1 file changed, 82 insertions(+), 38 deletions(-)
> > > 
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index d1eb87e..2504094 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2686,34 +2686,44 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
> > >   	return __split_vma(mm, vma, addr, new_below);
> > >   }
> > > -/* Munmap is split into 2 main parts -- this part which finds
> > > - * what needs doing, and the areas themselves, which do the
> > > - * work.  This now handles partial unmappings.
> > > - * Jeremy Fitzhardinge <jeremy@goop.org>
> > > - */
> > > -int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> > > -	      struct list_head *uf)
> > > +static inline bool munmap_addr_sanity(unsigned long start, size_t len)
> > munmap_check_addr? Btw. why does this need to have munmap prefix at all?
> > This is a general address space check.
> 
> Just because I extracted this from do_munmap, no special consideration. It
> is definitely ok to use another name.
> 
> > 
> > >   {
> > > -	unsigned long end;
> > > -	struct vm_area_struct *vma, *prev, *last;
> > > -
> > >   	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
> > > -		return -EINVAL;
> > > +		return false;
> > > -	len = PAGE_ALIGN(len);
> > > -	if (len == 0)
> > > -		return -EINVAL;
> > > +	if (PAGE_ALIGN(len) == 0)
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +/*
> > > + * munmap_lookup_vma: find the first overlap vma and split overlap vmas.
> > > + * @mm: mm_struct
> > > + * @vma: the first overlapping vma
> > > + * @prev: vma's prev
> > > + * @start: start address
> > > + * @end: end address
> > This really doesn't help me to understand how to use the function.
> > Why do we need both prev and vma etc...
> 
> prev will be used by unmap_region later.

But what does it stand for? Why cannot you take prev from the returned
vma? In other words, if somebody reads this documentation how does he
know what the prev is supposed to be used for?

> > > + *
> > > + * returns 1 if successful, 0 or errno otherwise
> > This is a really weird calling convention. So what does 0 tell? /me
> > checks the code. Ohh, it is nothing to do. Why cannot you simply return
> > the vma. NULL implies nothing to do, ERR_PTR on error.
> 
> A couple of reasons why it is implemented as so:
> 
>     * do_munmap returns 0 for both success and no suitable vma
> 
>     * Since prev is needed by finding the start vma, and prev will be used
> by unmap_region later too, so I just thought it would look clean to have one
> function to return both start vma and prev. In this way, we can share as
> much as possible common code.
> 
>     * In this way, we just need return 0, 1 or error no just as same as what
> do_munmap does currently. Then we know what is failure case exactly to just
> bail out right away.
> 
> Actually, I tried the same approach as you suggested, but it had two
> problems:
> 
>     * If it returns the start vma, we have to re-find its prev later, but
> the prev has been found during finding start vma. And, duplicate the code in
> do_munmap_zap_rlock. It sounds not that ideal.
> 
>     * If it returns prev, it might be null (start vma is the first vma). We
> can't tell if null is a failure or success case

Even if you need to return both vma and prev then it would be better to
simply return vma directly than having this -errno, 0 or 1 return
semantic.
-- 
Michal Hocko
SUSE Labs
