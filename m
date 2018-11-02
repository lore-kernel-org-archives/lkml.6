Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1FCC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D45C20666
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FvtLBmv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D45C20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeKBJIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:08:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKBJIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VUoxclPY/cYAQeJKl3xtp7ETpqx0IXVnEk7Sf+Q/k3E=; b=FvtLBmv2WknZ11L5+CZMemsQD
        Yv/7S+IomXVTWSIgvW+2jadmvDDFZNhWpw+iFd/B4mxBb3S8HReg8hRd04xbA2/WRUcvBIoaVeSpb
        kQVi1ULXc2ts1lq99tmblCuT9yNVKjFuH0mYkGkKW/++Th0fqaNU4OZMV8WqymBMz4yO+2uW085wM
        QviBD17kf/dyDBw4n2eIhRIPzz+bW8ti/VuXYsMTO/AuEWugx4oUZqnzaRty1JrZdpVm9IDpILuCz
        ox/OPyt3dOEhsSqH8xjeozCHy60mBdRZcw2KKf/9lK1Ar3CAMJHnepGuaAhWeGOYfY4JDRcXm3cwB
        aXZg4Ca2w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIMvc-0004z4-7T; Fri, 02 Nov 2018 00:03:08 +0000
Date:   Thu, 1 Nov 2018 17:03:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, miles.chen@mediatek.com,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
Message-ID: <20181102000307.GO10491@bombadil.infradead.org>
References: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
 <20181101144723.3ddc1fa1ab7f81184bc2fdb8@linux-foundation.org>
 <3c81f60ac1ff270df972ded4128a7dbf41a91113.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c81f60ac1ff270df972ded4128a7dbf41a91113.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 04:30:12PM -0700, Joe Perches wrote:
> On Thu, 2018-11-01 at 14:47 -0700, Andrew Morton wrote:
> > +++ a/mm/page_owner.c
> > @@ -351,7 +351,7 @@ print_page_owner(char __user *buf, size_
> >  		.skip = 0
> >  	};
> >  
> > -	count = count > PAGE_SIZE ? PAGE_SIZE : count;
> > +	count = min_t(size_t, count, PAGE_SIZE);
> >  	kbuf = kmalloc(count, GFP_KERNEL);
> >  	if (!kbuf)
> >  		return -ENOMEM;
> 
> A bit tidier still might be
> 
> 	if (count > PAGE_SIZE)
> 		count = PAGE_SIZE;
> 
> as that would not always cause a write back to count.

90% chance 'count' is already in a register and will stay there.  99.9%
chance that if it's not in a register, it's on the top of the stack,
which is by definition a hot, local, dirty cacheline.

What you're saying makes sense for a struct which might well be in a
shared cacheline state.  But for a function-local variable?  No.
