Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD072C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEA020827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEA020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeJ2REm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:04:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725969AbeJ2REm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:04:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62187AD73;
        Mon, 29 Oct 2018 08:17:07 +0000 (UTC)
Date:   Mon, 29 Oct 2018 09:17:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     miles.chen@mediatek.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
Message-ID: <20181029081706.GC32673@dhcp22.suse.cz>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
 <20181029080708.GA32673@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029080708.GA32673@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-10-18 09:07:08, Michal Hocko wrote:
[...]
> Besides that, the following doesn't make much sense to me. It simply
> makes no sense to use vmalloc for sub page allocation regardless of
> HIGHMEM.

OK, it is still early morning here. Now I get the point of the patch.
You just want to (ab)use highmeme for smaller requests. I do not like
this, to be honest. It causes an internal fragmentation and more
importantly the VMALLOC space on 32b where HIGHMEM is enabled (do we
have any 64b with HIGHMEM btw?) is quite small to be wasted like that.

In any case such a changes should come with some numbers and as a
separate patch for sure.

> > diff --git a/mm/util.c b/mm/util.c
> > index 8bf08b5b5760..7b1c59b9bfbf 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -416,10 +416,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
> >  	ret = kmalloc_node(size, kmalloc_flags, node);
> >  
> >  	/*
> > -	 * It doesn't really make sense to fallback to vmalloc for sub page
> > -	 * requests
> > +	 * It only makes sense to fallback to vmalloc for sub page
> > +	 * requests if we might be able to allocate highmem pages.
> >  	 */
> > -	if (ret || size <= PAGE_SIZE)
> > +	if (ret || (!IS_ENABLED(CONFIG_HIGHMEM) && size <= PAGE_SIZE))
> >  		return ret;
> >  
> >  	return __vmalloc_node_flags_caller(size, node, flags,
> > -- 
> > 2.18.0
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
