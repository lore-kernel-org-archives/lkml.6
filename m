Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD0DC43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2232070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546528440;
	bh=0EOsFbbfMriuPVfCu+ooNQDoeQxDIth1CN5P5ZIHr6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oZNY8vy2NeVa50Hkef2WZDuUqPqFxaUand90vnFv9o4wDSAeU03MerlcX1F1V1GoV
	 cuXnsuyJrHM8Vp/qmhvYIsBmwIegt1Q9ROOa54uwTBluYoNCk42LD07kDoMYPpDB9o
	 e7zBZZxZt9ccJOxHhpbFXwZB1hhPd/zE9FEIFJ/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfACPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:13:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:35000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728208AbfACPN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:13:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4F8AAD47;
        Thu,  3 Jan 2019 15:13:57 +0000 (UTC)
Date:   Thu, 3 Jan 2019 16:13:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/vmalloc: fix size check for
 remap_vmalloc_range_partial()
Message-ID: <20190103151357.GR31793@dhcp22.suse.cz>
References: <20190103145954.16942-1-rpenyaev@suse.de>
 <20190103145954.16942-2-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103145954.16942-2-rpenyaev@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 15:59:52, Roman Penyaev wrote:
> area->size can include adjacent guard page but get_vm_area_size()
> returns actual size of the area.
> 
> This fixes possible kernel crash when userspace tries to map area
> on 1 page bigger: size check passes but the following vmalloc_to_page()
> returns NULL on last guard (non-existing) page.

Can this actually happen? I am not really familiar with all the callers
of this API but VM_NO_GUARD is not really used wildly in the kernel.
All I can see is kasan na arm64 which doesn't really seem to use it
for vmalloc.

So is the problem real or this is a mere cleanup?
 
> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 871e41c55e23..2cd24186ba84 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2248,7 +2248,7 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
>  	if (!(area->flags & VM_USERMAP))
>  		return -EINVAL;
>  
> -	if (kaddr + size > area->addr + area->size)
> +	if (kaddr + size > area->addr + get_vm_area_size(area))
>  		return -EINVAL;
>  
>  	do {
> -- 
> 2.19.1

-- 
Michal Hocko
SUSE Labs
