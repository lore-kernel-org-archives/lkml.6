Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68EA206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbeLNTkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:40:51 -0500
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:51879 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730467AbeLNTku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:40:50 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2D07F100E86C5;
        Fri, 14 Dec 2018 19:40:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail13_411a7fb9b8703
X-Filterd-Recvd-Size: 2213
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Dec 2018 19:40:47 +0000 (UTC)
Message-ID: <0192c1984f42ad0a33e4c9aca04df90c97ebf412.camel@perches.com>
Subject: Re: [RFC 2/4] mm: separate memory allocation and actual work in
 alloc_vmap_area()
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Date:   Fri, 14 Dec 2018 11:40:45 -0800
In-Reply-To: <20181214181322.GC10600@bombadil.infradead.org>
References: <20181214180720.32040-1-guro@fb.com>
         <20181214180720.32040-3-guro@fb.com>
         <20181214181322.GC10600@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-14 at 10:13 -0800, Matthew Wilcox wrote:
> On Fri, Dec 14, 2018 at 10:07:18AM -0800, Roman Gushchin wrote:
> > +/*
> > + * Allocate a region of KVA of the specified size and alignment, within the
> > + * vstart and vend.
> > + */
> > +static struct vmap_area *alloc_vmap_area(unsigned long size,
> > +					 unsigned long align,
> > +					 unsigned long vstart,
> > +					 unsigned long vend,
> > +					 int node, gfp_t gfp_mask)
> > +{
> > +	struct vmap_area *va;
> > +	int ret;
> > +
> > +	va = kmalloc_node(sizeof(struct vmap_area),
> > +			gfp_mask & GFP_RECLAIM_MASK, node);
> > +	if (unlikely(!va))
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ret = init_vmap_area(va, size, align, vstart, vend, node, gfp_mask);
> > +	if (ret) {
> > +		kfree(va);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	return va;
> >  }
> >  
> > +
> 
> Another spurious blank line?

I don't think so.

I think it is the better style to separate
the error return from the normal return.

> With these two fixed,
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> 

