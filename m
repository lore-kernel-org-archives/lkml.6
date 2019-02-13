Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD652C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940F7222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T5RyWRDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbfBMURS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:17:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfBMURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2HC/AVySH17dcJ1eOjuqITZP6s+yGuGkZUMcpGJBHoA=; b=T5RyWRDUQkXyAIUCElyhQ3Jhp
        bH/HvPWbtTW8d2AqknG8JEyVi9nmhcszo7/sALatw7nh9S3jgQpfbMIemIKv7j3kXoes3jQr4SqBF
        iJmHF/5SqtJAOFf0saSHLF2Y3M9gon++aqPvFAJKTxIyQWOV29L1yoIyLNJK9FgadABtwuA8shsXZ
        JVJIXPnAVX0eR3ORsMxcjEB66ktIn1UYYQRCCpWHnR7UT1BtMothiJhHmYTE4IEKZSgn1KCKZxMxF
        pCfHHxc0XBpmzsdj3Ee84P0oEuCHsUy1Gc2pPwAI4birJMpq2LJyspeyRWYvtDEDbZn1FkSUJy/Wg
        2/nd/jzGA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gu0y4-00038t-2d; Wed, 13 Feb 2019 20:17:16 +0000
Date:   Wed, 13 Feb 2019 12:17:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190213201715.GU12668@bombadil.infradead.org>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190213144102.GA18351@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213144102.GA18351@quack2.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 03:41:02PM +0100, Jan Kara wrote:
> On Tue 12-02-19 10:34:54, Matthew Wilcox wrote:
> > Transparent Huge Pages are currently stored in i_pages as pointers to
> > consecutive subpages.  This patch changes that to storing consecutive
> > pointers to the head page in preparation for storing huge pages more
> > efficiently in i_pages.
> > 
> > Large parts of this are "inspired" by Kirill's patch
> > https://lore.kernel.org/lkml/20170126115819.58875-2-kirill.shutemov@linux.intel.com/
> > 
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> 
> I like the idea!

Thanks!  It's a step towards reducing the overhead of huge pages in the
page cache from (on x86) 520 pointers to a mere 8.  Still not as good as
hugetlbfs, but I'm working on that too.

> > -		pages[ret] = page;
> > +		pages[ret] = find_subpage(page, xas.xa_index);
> >  		if (++ret == nr_pages) {
> >  			*start = page->index + 1;
> >  			goto out;
> >  		}
> 
> So this subtly changes the behavior because now we will be returning in
> '*start' a different index. So you should rather use 'pages[ret]->index'
> instead.

You're right, I made a mistake there.  However, seeing this:
https://lore.kernel.org/lkml/20190110030838.84446-1-yuzhao@google.com/

makes me think that I should be using xa_index + 1 there.

> Otherwise the patch looks good to me so feel free to add:
> 
> Acked-by: Jan Kara <jack@suse.cz>
> 
> after fixing these two.

Thanks!
