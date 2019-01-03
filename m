Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B727C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192A32070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eP8Ighkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfACOnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:43:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfACOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YwpJbb3OcnPjGYvo3jjt8nSUTMJBu8TN1h47nuDYqwE=; b=eP8Ighkgi/CSBdP7uYdeWJrxA
        3kNThYO+QN02kUrh0HLyJS3gW7by6AUX6+WsMSSJ949FOSYzxJXZUG8/6VjmlstjOWgWmmnz1Cu65
        ci5pSsGZ0Pr5tEsL1oH/2h5n7Ljd07YJrnzkqTLoQZkg5d34JfJEDkB74V3Isq47u24XrxAAhggah
        +i3jEQPC0Nb2eI0k/QOY9xKZnuNa4F85/tUiltOhePktxG3N7EnEk4eypiXlJczSVBHd3dUn9tuIJ
        o+ZdDWGJPmPu/jstEdJBdyLC+xK/sappsJ8iBTYu0rEJUMatO91Tpl+Hw4rn3RooTMufRGa/EjrLg
        HNnQdwEHQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gf4DJ-00036V-EI; Thu, 03 Jan 2019 14:43:13 +0000
Date:   Thu, 3 Jan 2019 06:43:13 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Initialise mmu_notifier_range correctly
Message-ID: <20190103144313.GR6310@bombadil.infradead.org>
References: <20190103002126.GM6310@bombadil.infradead.org>
 <20190103143116.GB3395@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103143116.GB3395@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 09:31:16AM -0500, Jerome Glisse wrote:
> On Wed, Jan 02, 2019 at 04:21:26PM -0800, Matthew Wilcox wrote:
> > 
> > One of the paths in follow_pte_pmd() initialised the mmu_notifier_range
> > incorrectly.
> > 
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > Fixes: ac46d4f3c432 ("mm/mmu_notifier: use structure for invalidate_range_start/end calls v2")
> > Tested-by: Dave Chinner <dchinner@redhat.com>
> 
> Actually now that i have read the code again this is not ok to
> do so. The caller of follow_pte_pmd() will call range_init and
> follow pmd will only update the range address. So existing code
> is ok.

I think you need to re-read your own patch.

`git show ac46d4f3c43241ffa23d5bf36153a0830c0e02cc`

@@ -4058,10 +4059,10 @@ static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
                if (!pmdpp)
                        goto out;
 
-               if (start && end) {
-                       *start = address & PMD_MASK;
-                       *end = *start + PMD_SIZE;
-                       mmu_notifier_invalidate_range_start(mm, *start, *end);
+               if (range) {
+                       mmu_notifier_range_init(range, mm, address & PMD_MASK,
+                                            (address & PMD_MASK) + PMD_SIZE);
+                       mmu_notifier_invalidate_range_start(range);

... so it's fine to call range_init() *here*.

@@ -4069,17 +4070,17 @@ static int __follow_pte_pmd(struct mm_struct *mm, unsign
ed long address,
[...]
        if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
                goto out;
 
-       if (start && end) {
-               *start = address & PAGE_MASK;
-               *end = *start + PAGE_SIZE;
-               mmu_notifier_invalidate_range_start(mm, *start, *end);
+       if (range) {
+               range->start = address & PAGE_MASK;
+               range->end = range->start + PAGE_SIZE;
+               mmu_notifier_invalidate_range_start(range);

... but then *not* here later in the same function?  You're not making
any sense.
