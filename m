Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C414EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9336920823
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W1EkMPd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404033AbfBOU27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:28:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfBOU27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RfJTwQxNtAt3SGNUAeeBsgYvXmANCdHsJDtsXuMeyS8=; b=W1EkMPd+0mkWguf2uAGeMdTk3
        kZDkDxRdVsxC4bMDWDO/dB6wLusOvD4FSMkOajm/mzZCMr4eRc0QdIhOitulAZ0i+XxsGbICEUzsF
        8SYRg2eBxldECz8EjvYHs3DIHmiyAhMqr0ZayB0sutHedapn1CnACbAus6JToj2ZUdkN0IzzpLGVY
        +L5Z5Ey2VLTT0jd3j/yIAV/AZosDGDfaYDWucu78zkdEFazU32lalN2iDO60DNBh5wAIeL6nYJFsT
        jmPMJNvC5jyogYRq8H+ygQwIeambm5Myf3CiPc9VDy8QroKcuf+hLTzR2FwjC4hEs3PbAVsoIXG1G
        a1xMriBPg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guk6U-0001Xm-AK; Fri, 15 Feb 2019 20:28:58 +0000
Date:   Fri, 15 Feb 2019 12:28:58 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190215202858.GL12668@bombadil.infradead.org>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
 <20190214222944.74ipvbnvo2lvfgnr@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214222944.74ipvbnvo2lvfgnr@kshutemo-mobl1>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:29:44AM +0300, Kirill A. Shutemov wrote:
> On Thu, Feb 14, 2019 at 04:30:04PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Feb 12, 2019 at 10:34:54AM -0800, Matthew Wilcox wrote:
> > > Transparent Huge Pages are currently stored in i_pages as pointers to
> > > consecutive subpages.  This patch changes that to storing consecutive
> > > pointers to the head page in preparation for storing huge pages more
> > > efficiently in i_pages.
> > > 
> > > Large parts of this are "inspired" by Kirill's patch
> > > https://lore.kernel.org/lkml/20170126115819.58875-2-kirill.shutemov@linux.intel.com/
> > > 
> > > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > 
> > I believe I found few missing pieces:
> > 
> >  - page_cache_delete_batch() will blow up on
> > 
> > 			VM_BUG_ON_PAGE(page->index + HPAGE_PMD_NR - tail_pages
> > 					!= pvec->pages[i]->index, page);
> > 
> >  - migrate_page_move_mapping() has to be converted too.
> 
> Other missing pieces are memfd_wait_for_pins() and memfd_tag_pins()
> We need to call page_mapcount() for tail pages there.

@@ -39,6 +39,7 @@ static void memfd_tag_pins(struct xa_state *xas)
        xas_for_each(xas, page, ULONG_MAX) {
                if (xa_is_value(page))
                        continue;
+               page = find_subpage(page, xas.xa_index);
                if (page_count(page) - page_mapcount(page) > 1)
                        xas_set_mark(xas, MEMFD_TAG_PINNED);
 
@@ -88,6 +89,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
                        bool clear = true;
                        if (xa_is_value(page))
                                continue;
+                       page = find_subpage(page, xas.xa_index);
                        if (page_count(page) - page_mapcount(page) != 1) {
                                /*
                                 * On the last scan, we clean up all those tags

