Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2C5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB84A20844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfAVKq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:46:27 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:21745 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfAVKq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:46:27 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 1704B3FF9; Tue, 22 Jan 2019 11:46:24 +0100 (CET)
Date:   Tue, 22 Jan 2019 11:46:24 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com, vbabka@suse.cz,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/hotplug: invalid PFNs from pfn_to_online_page()
Message-ID: <20190122104621.khvcpwz6vucmpthr@d104.suse.de>
References: <20190121212747.23029-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121212747.23029-1-cai@lca.pw>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:27:47PM -0500, Qian Cai wrote:
 
> Fixes: 9f1eb38e0e11 ("mm, kmemleak: little optimization while scanning")
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Qian Cai <cai@lca.pw>

Heh, I guess that it comes in handy to have a machine with CONFIG_HOLES_IN_ZONE
enabled.
I totally missed the fact that systems with such configuration can have
uninitialized pages even if the section is online.
To be honest, I blindly thought that if a section was online, that means
that all its pages were initialized properly.

Thanks for fixing it:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
> 
> v3: change the "Fixes" line.
> v2: update the changelog; keep the bound check; use pfn_valid_within().
> 
>  include/linux/memory_hotplug.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 07da5c6c5ba0..cdeecd9bd87e 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -21,14 +21,15 @@ struct vmem_altmap;
>   * walkers which rely on the fully initialized page->flags and others
>   * should use this rather than pfn_valid && pfn_to_page
>   */
> -#define pfn_to_online_page(pfn)				\
> -({							\
> -	struct page *___page = NULL;			\
> -	unsigned long ___nr = pfn_to_section_nr(pfn);	\
> -							\
> -	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr))\
> -		___page = pfn_to_page(pfn);		\
> -	___page;					\
> +#define pfn_to_online_page(pfn)					   \
> +({								   \
> +	struct page *___page = NULL;				   \
> +	unsigned long ___nr = pfn_to_section_nr(pfn);		   \
> +								   \
> +	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> +	    pfn_valid_within(pfn))				   \
> +		___page = pfn_to_page(pfn);			   \
> +	___page;						   \
>  })
>  
>  /*
> -- 
> 2.17.2 (Apple Git-113)
> 

-- 
Oscar Salvador
SUSE L3
