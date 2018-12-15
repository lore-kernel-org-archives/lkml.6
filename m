Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B185C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870D6206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 02:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeLOCWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 21:22:38 -0500
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:51321 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726609AbeLOCWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 21:22:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4C761100E86C0;
        Sat, 15 Dec 2018 02:22:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crate80_50b36013e941f
X-Filterd-Recvd-Size: 2576
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 15 Dec 2018 02:22:34 +0000 (UTC)
Message-ID: <f990f087a667031887804028abfe525283dad09a.camel@perches.com>
Subject: Re: [RFC 2/4] mm: separate memory allocation and actual work in
 alloc_vmap_area()
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Roman Gushchin <guroan@gmail.com>, linux-mm@kvack.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Date:   Fri, 14 Dec 2018 18:22:33 -0800
In-Reply-To: <20181214194500.GF10600@bombadil.infradead.org>
References: <20181214180720.32040-1-guro@fb.com>
         <20181214180720.32040-3-guro@fb.com>
         <20181214181322.GC10600@bombadil.infradead.org>
         <0192c1984f42ad0a33e4c9aca04df90c97ebf412.camel@perches.com>
         <20181214194500.GF10600@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-14 at 11:45 -0800, Matthew Wilcox wrote:
> On Fri, Dec 14, 2018 at 11:40:45AM -0800, Joe Perches wrote:
> > On Fri, 2018-12-14 at 10:13 -0800, Matthew Wilcox wrote:
> > > On Fri, Dec 14, 2018 at 10:07:18AM -0800, Roman Gushchin wrote:
> > > > +/*
> > > > + * Allocate a region of KVA of the specified size and alignment, within the
> > > > + * vstart and vend.
> > > > + */
> > > > +static struct vmap_area *alloc_vmap_area(unsigned long size,
> > > > +					 unsigned long align,
> > > > +					 unsigned long vstart,
> > > > +					 unsigned long vend,
> > > > +					 int node, gfp_t gfp_mask)
> > > > +{
> > > > +	struct vmap_area *va;
> > > > +	int ret;
> > > > +
> > > > +	va = kmalloc_node(sizeof(struct vmap_area),
> > > > +			gfp_mask & GFP_RECLAIM_MASK, node);
> > > > +	if (unlikely(!va))
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	ret = init_vmap_area(va, size, align, vstart, vend, node, gfp_mask);
> > > > +	if (ret) {
> > > > +		kfree(va);
> > > > +		return ERR_PTR(ret);
> > > > +	}
> > > > +
> > > > +	return va;
> > > >  }
> > > >  
> > > > +
> > > 
> > > Another spurious blank line?

[wrong spacing noticed]

> Umm ... this blank line changed the file from having one blank line
> after the function to having two blank lines after the function.

right. thanks.


