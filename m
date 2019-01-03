Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81BCC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F372184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546529032;
	bh=jj1GY5V85Itu5KUK2MW45aijwNjExRKBc+CHCk7oI6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=USmqPy8VTv/mFyHldAn8FpuD63JXTSRGezPM+AAriSx00bEYG85FmWRDoZqpDGRSg
	 jO+aTp7zAVbMmUSd8XrPUBJkKoCeJcef+9LMur7UMomY3huHA4NSuvKq5JSYgVr9yA
	 Fhp6cua8PhhYJLgKvP/pdSMqhCF9JHh/ZXi537nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfACPXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:23:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:36158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728208AbfACPXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:23:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54178AD05;
        Thu,  3 Jan 2019 15:23:49 +0000 (UTC)
Date:   Thu, 3 Jan 2019 16:23:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/vmalloc: pass VM_USERMAP flags directly to
 __vmalloc_node_range()
Message-ID: <20190103152348.GS31793@dhcp22.suse.cz>
References: <20190103145954.16942-1-rpenyaev@suse.de>
 <20190103145954.16942-4-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103145954.16942-4-rpenyaev@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 15:59:54, Roman Penyaev wrote:
> vmalloc_user*() calls differ from normal vmalloc() only in that they
> set VM_USERMAP flags for the area.  During the whole history of
> vmalloc.c changes now it is possible simply to pass VM_USERMAP flags
> directly to __vmalloc_node_range() call instead of finding the area
> (which obviously takes time) after the allocation.

Yes, this looks correct and a nice cleanup

> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmalloc.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index dc6a62bca503..83fa4c642f5e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1865,18 +1865,10 @@ EXPORT_SYMBOL(vzalloc);
>   */
>  void *vmalloc_user(unsigned long size)
>  {
> -	struct vm_struct *area;
> -	void *ret;
> -
> -	ret = __vmalloc_node(size, SHMLBA,
> -			     GFP_KERNEL | __GFP_ZERO,
> -			     PAGE_KERNEL, NUMA_NO_NODE,
> -			     __builtin_return_address(0));
> -	if (ret) {
> -		area = find_vm_area(ret);
> -		area->flags |= VM_USERMAP;
> -	}
> -	return ret;
> +	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
> +				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
> +				    VM_USERMAP, NUMA_NO_NODE,
> +				    __builtin_return_address(0));
>  }
>  EXPORT_SYMBOL(vmalloc_user);
>  
> @@ -1970,16 +1962,10 @@ EXPORT_SYMBOL(vmalloc_32);
>   */
>  void *vmalloc_32_user(unsigned long size)
>  {
> -	struct vm_struct *area;
> -	void *ret;
> -
> -	ret = __vmalloc_node(size, 1, GFP_VMALLOC32 | __GFP_ZERO, PAGE_KERNEL,
> -			     NUMA_NO_NODE, __builtin_return_address(0));
> -	if (ret) {
> -		area = find_vm_area(ret);
> -		area->flags |= VM_USERMAP;
> -	}
> -	return ret;
> +	return __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
> +				    GFP_VMALLOC32 | __GFP_ZERO, PAGE_KERNEL,
> +				    VM_USERMAP, NUMA_NO_NODE,
> +				    __builtin_return_address(0));
>  }
>  EXPORT_SYMBOL(vmalloc_32_user);
>  
> -- 
> 2.19.1

-- 
Michal Hocko
SUSE Labs
