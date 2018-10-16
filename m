Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B598AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730692086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730692086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJPTdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:33:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:38588 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJPTdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:33:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 04:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="99858863"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Oct 2018 04:43:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9500617F; Tue, 16 Oct 2018 14:43:12 +0300 (EEST)
Date:   Tue, 16 Oct 2018 14:43:12 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        mhocko@suse.com, rppt@linux.vnet.ibm.com,
        imbrenda@linux.vnet.ibm.com, corbet@lwn.net,
        ndesaulniers@google.com, dave.jiang@intel.com, jglisse@redhat.com,
        jia.he@hxt-semitech.com, paulmck@linux.vnet.ibm.com,
        colin.king@canonical.com, jiang.biao2@zte.com.cn,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ksm: Assist buddy allocator to assemble 1-order pages
Message-ID: <20181016114312.bxkxxuttonfbjmsg@black.fi.intel.com>
References: <153925511661.21256.9692370932417728663.stgit@localhost.localdomain>
 <20181015154112.6bj5p4zuxjtz43pd@kshutemo-mobl1>
 <0b0a81c4-d0b3-99f4-6910-10b757732825@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b0a81c4-d0b3-99f4-6910-10b757732825@virtuozzo.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 09:34:11AM +0000, Kirill Tkhai wrote:
> On 15.10.2018 18:41, Kirill A. Shutemov wrote:
> > On Thu, Oct 11, 2018 at 01:52:22PM +0300, Kirill Tkhai wrote:
> >> try_to_merge_two_pages() merges two pages, one of them
> >> is a page of currently scanned mm, the second is a page
> >> with identical hash from unstable tree. Currently, we
> >> merge the page from unstable tree into the first one,
> >> and then free it.
> >>
> >> The idea of this patch is to prefer freeing that page
> >> of them, which has a free neighbour (i.e., neighbour
> >> with zero page_count()). This allows buddy allocator
> >> to assemble at least 1-order set from the freed page
> >> and its neighbour; this is a kind of cheep passive
> >> compaction.
> >>
> >> AFAIK, 1-order pages set consists of pages with PFNs
> >> [2n, 2n+1] (odd, even), so the neighbour's pfn is
> >> calculated via XOR with 1. We check the result pfn
> >> is valid and its page_count(), and prefer merging
> >> into @tree_page if neighbour's usage count is zero.
> >>
> >> There a is small difference with current behavior
> >> in case of error path. In case of the second
> >> try_to_merge_with_ksm_page() is failed, we return
> >> from try_to_merge_two_pages() with @tree_page
> >> removed from unstable tree. It does not seem to matter,
> >> but if we do not want a change at all, it's not
> >> a problem to move remove_rmap_item_from_tree() from
> >> try_to_merge_with_ksm_page() to its callers.
> >>
> >> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >> ---
> >>  mm/ksm.c |   15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/mm/ksm.c b/mm/ksm.c
> >> index 5b0894b45ee5..b83ca37e28f0 100644
> >> --- a/mm/ksm.c
> >> +++ b/mm/ksm.c
> >> @@ -1321,6 +1321,21 @@ static struct page *try_to_merge_two_pages(struct rmap_item *rmap_item,
> >>  {
> >>  	int err;
> >>  
> >> +	if (IS_ENABLED(CONFIG_COMPACTION)) {
> >> +		unsigned long pfn;
> >> +		/*
> >> +		 * Find neighbour of @page containing 1-order pair
> >> +		 * in buddy-allocator and check whether it is free.
> > 
> > You cannot really check if the page is free. There are some paths that
> > makes the refcount zero temporarely, but doesn't free the page.
> > See page_ref_freeze() for instance.
> 
> Thanks. Does this look better?
> 
>   Find neighbour of @page containing 1-order pair in buddy-allocator
>   and check whether its count is 0. If it is so, we consider it's as free
>   (this is more probable than it's freezed via page_ref_freeze()),
>   and we try to use @tree_page as ksm page and to free @page.

Looks fine to me.

-- 
 Kirill A. Shutemov
