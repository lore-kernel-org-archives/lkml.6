Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE93C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4216E206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fju7Z5EU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbeLNTpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:45:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eJitfIF5tV0Tv6OzLWeekme+t2QDJsCN3sHudGCP87s=; b=Fju7Z5EULkU5SinXD4SfxS8KX
        KltMFuG6RV9PZt6DX46Jf/qmXpIiLUOKtdyllYwnB7NEvUF+0qoyRekxGVWCs7UYkdYFquVTGBiW5
        nCkP8RfroO1XudjeD145AA64pC3XfFj16t8c8HRUDrbdlLOAvJZIeZcYrRrWyt1nMSDrTeJm5392y
        3jItF9jDWP+b9uimtlA68jmWeq/cTzYG4vraTeddRh0W2HE70bVT5eLqqVssU/rqU04mCavgtpU/P
        JUNWErCwK6WM9W5OwdWjHLCE8oKI49ObC3Qv14JVlL/zNTwinooapD0p7Db5+sPuHnTP4XjvYNbb7
        bIWryUB+A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXtOO-0007ZJ-Ca; Fri, 14 Dec 2018 19:45:00 +0000
Date:   Fri, 14 Dec 2018 11:45:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Roman Gushchin <guroan@gmail.com>, linux-mm@kvack.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: Re: [RFC 2/4] mm: separate memory allocation and actual work in
 alloc_vmap_area()
Message-ID: <20181214194500.GF10600@bombadil.infradead.org>
References: <20181214180720.32040-1-guro@fb.com>
 <20181214180720.32040-3-guro@fb.com>
 <20181214181322.GC10600@bombadil.infradead.org>
 <0192c1984f42ad0a33e4c9aca04df90c97ebf412.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0192c1984f42ad0a33e4c9aca04df90c97ebf412.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:40:45AM -0800, Joe Perches wrote:
> On Fri, 2018-12-14 at 10:13 -0800, Matthew Wilcox wrote:
> > On Fri, Dec 14, 2018 at 10:07:18AM -0800, Roman Gushchin wrote:
> > > +/*
> > > + * Allocate a region of KVA of the specified size and alignment, within the
> > > + * vstart and vend.
> > > + */
> > > +static struct vmap_area *alloc_vmap_area(unsigned long size,
> > > +					 unsigned long align,
> > > +					 unsigned long vstart,
> > > +					 unsigned long vend,
> > > +					 int node, gfp_t gfp_mask)
> > > +{
> > > +	struct vmap_area *va;
> > > +	int ret;
> > > +
> > > +	va = kmalloc_node(sizeof(struct vmap_area),
> > > +			gfp_mask & GFP_RECLAIM_MASK, node);
> > > +	if (unlikely(!va))
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	ret = init_vmap_area(va, size, align, vstart, vend, node, gfp_mask);
> > > +	if (ret) {
> > > +		kfree(va);
> > > +		return ERR_PTR(ret);
> > > +	}
> > > +
> > > +	return va;
> > >  }
> > >  
> > > +
> > 
> > Another spurious blank line?
> 
> I don't think so.
> 
> I think it is the better style to separate
> the error return from the normal return.

Umm ... this blank line changed the file from having one blank line
after the function to having two blank lines after the function.
