Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9373C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7530920866
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7530920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeKBIfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:35:20 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:58186 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727749AbeKBIfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:35:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D04A5180A8145;
        Thu,  1 Nov 2018 23:30:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: clam17_20c6b73b5135
X-Filterd-Recvd-Size: 2470
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Nov 2018 23:30:13 +0000 (UTC)
Message-ID: <3c81f60ac1ff270df972ded4128a7dbf41a91113.camel@perches.com>
Subject: Re: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>, miles.chen@mediatek.com
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Michal Hocko <mhocko@kernel.org>
Date:   Thu, 01 Nov 2018 16:30:12 -0700
In-Reply-To: <20181101144723.3ddc1fa1ab7f81184bc2fdb8@linux-foundation.org>
References: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
         <20181101144723.3ddc1fa1ab7f81184bc2fdb8@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-01 at 14:47 -0700, Andrew Morton wrote:
> On Fri, 2 Nov 2018 01:00:07 +0800 <miles.chen@mediatek.com> wrote:
> 
> > From: Miles Chen <miles.chen@mediatek.com>
> > 
> > The page owner read might allocate a large size of memory with
> > a large read count. Allocation fails can easily occur when doing
> > high order allocations.
> > 
> > Clamp buffer size to PAGE_SIZE to avoid arbitrary size allocation
> > and avoid allocation fails due to high order allocation.
> > 
> > ...
> > 
> > --- a/mm/page_owner.c
> > +++ b/mm/page_owner.c
> > @@ -351,6 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
> >  		.skip = 0
> >  	};
> >  
> > +	count = count > PAGE_SIZE ? PAGE_SIZE : count;
> >  	kbuf = kmalloc(count, GFP_KERNEL);
> >  	if (!kbuf)
> >  		return -ENOMEM;
> 
> A bit tidier:
> 
> --- a/mm/page_owner.c~mm-page_owner-clamp-read-count-to-page_size-fix
> +++ a/mm/page_owner.c
> @@ -351,7 +351,7 @@ print_page_owner(char __user *buf, size_
>  		.skip = 0
>  	};
>  
> -	count = count > PAGE_SIZE ? PAGE_SIZE : count;
> +	count = min_t(size_t, count, PAGE_SIZE);
>  	kbuf = kmalloc(count, GFP_KERNEL);
>  	if (!kbuf)
>  		return -ENOMEM;

A bit tidier still might be

	if (count > PAGE_SIZE)
		count = PAGE_SIZE;

as that would not always cause a write back to count.


