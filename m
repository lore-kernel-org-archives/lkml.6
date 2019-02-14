Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76721C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CAA21B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sRmxpgYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408120AbfBNW0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:26:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbfBNWZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pdhKxVVqmXpVOXlq9Z0kCS3TO3miCpdx6bwvuDnZVMM=; b=sRmxpgYFBjZqBxHYfNG/Vjxc/
        6WK3Iz5PSY3xD7ZBEWFmpYXymwkHbp7hKHd6Cz4ZVeaI9vURVsakD8MO9G+TKUzIaq9NWJW2PDf7K
        TvzmsMklmQnZs5g1oeLApfP4dn3/v9Fzh+wvJ/jI4cOwjeW8OyhsJRvYfshferKEdB/f+y/OkwrKS
        uZDWMvsqB9sA0MXmuGH+UULMnmJHF2FsNniCs2LikU4zNxEbKSSufcn90RDDjofCTIf+X5YC1QuaK
        b89bVrmLmhQUZMf9eN4N30BsxnRmW9D3P+dnmYjCOc9SlxXd8bqBv8+7vtjCowb+mHhi84+VSC2Ck
        AEf1npnGg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guPRx-0002av-0E; Thu, 14 Feb 2019 22:25:45 +0000
Date:   Thu, 14 Feb 2019 14:25:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190214222544.GG12668@bombadil.infradead.org>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
 <20190214205331.GD12668@bombadil.infradead.org>
 <20190214220344.2ovvzwcfuxxehzzt@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214220344.2ovvzwcfuxxehzzt@kshutemo-mobl1>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:03:44AM +0300, Kirill A. Shutemov wrote:
> > +		/*
> > +		 * A page got inserted in our range? Skip it. We have our
> > +		 * pages locked so they are protected from being removed.
> > +		 */
> > +		if (page != pvec->pages[i]) {
> 
> Maybe a comment for the VM_BUG while you're there?

Great idea.  I didn't understand it the first time I looked at it either,
but I forgot to write a comment when I figured it out.

                /*
                 * A page got inserted in our range? Skip it. We have our
                 * pages locked so they are protected from being removed.
+                * If we see a page whose index is higher than ours, it
+                * means our page has been removed, which shouldn't be
+                * possible because we're holding the PageLock.
                 */
                if (page != pvec->pages[i]) {

> > +		/* Leave page->index set: truncation lookup relies on it */
> > +
> > +		if (page->index + (1UL << compound_order(page)) - 1 ==
> > +				xas.xa_index)
> 
> It's 1am here and I'm slow, but it took me few minutes to understand how
> it works. Please add a comment.

I should get you to review at 1am more often!  You're quite right.
Sleep-deprived Kirill spots problems that normal people would encounter.


                /* Leave page->index set: truncation lookup relies on it */
 
+               /*
+                * Move to the next page in the vector if this is a small page
+                * or the index is of the last page in this compound page).
+                */
                if (page->index + (1UL << compound_order(page)) - 1 ==
                                xas.xa_index)
                        i++;


Thanks for the review.
