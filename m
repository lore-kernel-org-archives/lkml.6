Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FEAC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C212082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C212082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeJ3KUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 06:20:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35479 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725902AbeJ3KUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 06:20:51 -0400
X-UUID: bf4319f52ccb49e6a55b67a58e6a52da-20181030
X-UUID: bf4319f52ccb49e6a55b67a58e6a52da-20181030
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1095696761; Tue, 30 Oct 2018 09:29:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 30 Oct 2018 09:29:10 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Oct 2018 09:29:10 +0800
Message-ID: <1540862950.12374.40.camel@mtkswgap22>
Subject: Re: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Tue, 30 Oct 2018 09:29:10 +0800
In-Reply-To: <20181029081706.GC32673@dhcp22.suse.cz>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
         <20181029080708.GA32673@dhcp22.suse.cz>
         <20181029081706.GC32673@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: E2CBA49B416C4E3BC132CB3C34AA7BF195474575720F322FAF6EEBF393DA96F42000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 09:17 +0100, Michal Hocko wrote:
> On Mon 29-10-18 09:07:08, Michal Hocko wrote:
> [...]
> > Besides that, the following doesn't make much sense to me. It simply
> > makes no sense to use vmalloc for sub page allocation regardless of
> > HIGHMEM.
> 
> OK, it is still early morning here. Now I get the point of the patch.
> You just want to (ab)use highmeme for smaller requests. I do not like
> this, to be honest. It causes an internal fragmentation and more
> importantly the VMALLOC space on 32b where HIGHMEM is enabled (do we
> have any 64b with HIGHMEM btw?) is quite small to be wasted like that.
> 
thanks for your comment. It looks like that using vmalloc fallback for
sub page allocation is not good here.

Your comment gave another idea:

1. force kbuf to PAGE_SIZE
2. allocate a page by alloc_page(GFP_KERNEL | __GFP_HIGHMEM); so we can
get a highmem page if possible
3. use kmap/kunmap pair to create mapping for this page. No vmalloc
space is used.
4. do not change kvmalloc logic.


> In any case such a changes should come with some numbers and as a
> separate patch for sure.
> 
> > > diff --git a/mm/util.c b/mm/util.c
> > > index 8bf08b5b5760..7b1c59b9bfbf 100644
> > > --- a/mm/util.c
> > > +++ b/mm/util.c
> > > @@ -416,10 +416,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
> > >  	ret = kmalloc_node(size, kmalloc_flags, node);
> > >  
> > >  	/*
> > > -	 * It doesn't really make sense to fallback to vmalloc for sub page
> > > -	 * requests
> > > +	 * It only makes sense to fallback to vmalloc for sub page
> > > +	 * requests if we might be able to allocate highmem pages.
> > >  	 */
> > > -	if (ret || size <= PAGE_SIZE)
> > > +	if (ret || (!IS_ENABLED(CONFIG_HIGHMEM) && size <= PAGE_SIZE))
> > >  		return ret;
> > >  
> > >  	return __vmalloc_node_flags_caller(size, node, flags,
> > > -- 
> > > 2.18.0
> > > 
> > 
> > -- 
> > Michal Hocko
> > SUSE Labs
> 


