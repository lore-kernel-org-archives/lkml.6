Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E60C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB1220843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="yyyDDU0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB1220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeIZTno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:43:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38734 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZTno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:43:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so13446886pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TcZy8jc7oYWniGd7VHUDZTQgmW0RGl2adqaDemrvmao=;
        b=yyyDDU0drYdc6c/KgvAEtaBa/O3wpDwXQ1n+1ksmIP1FCJJ8giC59DTLTtmIGvdqlR
         cOWIJss1rZA2LvUZEr319VV3XUhUE2m2ztAGqgcIhd6JxwfJ1jlD6nmtmdEUcZKRpCwQ
         0Ooyq/wwWug4BIkxaG4ai78sqxT/AL7omvYjKWiUqD1yJ9VReD843ekMJPlJdqGdxQ7v
         U8goAYKPJXyyGBrvpLYvgdRh66rd5lG3X3DXIkpDG7nBHZq/HuW2Es7AwAkOl3gb0JU3
         uNMq9qCz4v2ghBHy/ey/bXQo0dhHBLyxRX9Ezptlj6TiQ5ESfcqOx2IWZzsEOQQIuxei
         G1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TcZy8jc7oYWniGd7VHUDZTQgmW0RGl2adqaDemrvmao=;
        b=IKgIQ8UDfelpoCspackHEtgUBsck7LhQBmjw80dacETPLcpzXciYNj5dNe9Mu3NCQ+
         dIzv9jSeewJRyW6B/qSSv5/jU53VkiAxoBjByFwYyffLN3cg4MPtqlYli0UVkyQTPt20
         s6mZpQ1TDyI2kL7Wtc9deh8mWjOSeg2EZC4UjSZLjJCObCscGWWj8Yfq0ovw7ZRhhVtq
         IbXjjwEibRuo/6iPNgkqlH2ZSk/V9MqVtQWVrHujd6tP0VakMlNbj6qyHnE3sNan3yi8
         AdGWMs4LBdPBMI/Wl7Vsda/ATW8erZ29jy1hnNwIrU/BquaStJUZp+c1B68f6eejs0+Y
         aenw==
X-Gm-Message-State: ABuFfoj/fFotIPYS6M8jpG3cGD/DXoQsEd5VN4AoGwZMmfgcu9zT5zjB
        Qw0NIH/2E/nl6+NvrYFQFNev4g==
X-Google-Smtp-Source: ACcGV620nIR7Utbe0YEx1Z/AKlPFw2Ku+TIh5cqtmQMeW/S14KeJo3FHjyKtphYVcCiZMujJqZKKnw==
X-Received: by 2002:a62:5d4c:: with SMTP id r73-v6mr6449938pfb.88.1537968644964;
        Wed, 26 Sep 2018 06:30:44 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id j22-v6sm6969452pfh.45.2018.09.26.06.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 06:30:43 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 380F0300029; Wed, 26 Sep 2018 16:30:39 +0300 (+03)
Date:   Wed, 26 Sep 2018 16:30:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
Message-ID: <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925120326.24392-3-mhocko@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:03:26PM +0200, Michal Hocko wrote:
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c3bc7e9c9a2a..c0bcede31930 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -629,21 +629,40 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>   *	    available
>   * never: never stall for any thp allocation
>   */
> -static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
> +static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
> +	gfp_t this_node = 0;
> +
> +#ifdef CONFIG_NUMA
> +	struct mempolicy *pol;
> +	/*
> +	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
> +	 * specified, to express a general desire to stay on the current
> +	 * node for optimistic allocation attempts. If the defrag mode
> +	 * and/or madvise hint requires the direct reclaim then we prefer
> +	 * to fallback to other node rather than node reclaim because that
> +	 * can lead to excessive reclaim even though there is free memory
> +	 * on other nodes. We expect that NUMA preferences are specified
> +	 * by memory policies.
> +	 */
> +	pol = get_vma_policy(vma, addr);
> +	if (pol->mode != MPOL_BIND)
> +		this_node = __GFP_THISNODE;
> +	mpol_cond_put(pol);
> +#endif

I'm not very good with NUMA policies. Could you explain in more details how
the code above is equivalent to the code below?

...

> @@ -2026,60 +2025,6 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  		goto out;
>  	}
>  
> -	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
> -		int hpage_node = node;
> -
> -		/*
> -		 * For hugepage allocation and non-interleave policy which
> -		 * allows the current node (or other explicitly preferred
> -		 * node) we only try to allocate from the current/preferred
> -		 * node and don't fall back to other nodes, as the cost of
> -		 * remote accesses would likely offset THP benefits.
> -		 *
> -		 * If the policy is interleave, or does not allow the current
> -		 * node in its nodemask, we allocate the standard way.
> -		 */
> -		if (pol->mode == MPOL_PREFERRED &&
> -						!(pol->flags & MPOL_F_LOCAL))
> -			hpage_node = pol->v.preferred_node;
> -
> -		nmask = policy_nodemask(gfp, pol);
> -		if (!nmask || node_isset(hpage_node, *nmask)) {
> -			mpol_cond_put(pol);
> -			/*
> -			 * We cannot invoke reclaim if __GFP_THISNODE
> -			 * is set. Invoking reclaim with
> -			 * __GFP_THISNODE set, would cause THP
> -			 * allocations to trigger heavy swapping
> -			 * despite there may be tons of free memory
> -			 * (including potentially plenty of THP
> -			 * already available in the buddy) on all the
> -			 * other NUMA nodes.
> -			 *
> -			 * At most we could invoke compaction when
> -			 * __GFP_THISNODE is set (but we would need to
> -			 * refrain from invoking reclaim even if
> -			 * compaction returned COMPACT_SKIPPED because
> -			 * there wasn't not enough memory to succeed
> -			 * compaction). For now just avoid
> -			 * __GFP_THISNODE instead of limiting the
> -			 * allocation path to a strict and single
> -			 * compaction invocation.
> -			 *
> -			 * Supposedly if direct reclaim was enabled by
> -			 * the caller, the app prefers THP regardless
> -			 * of the node it comes from so this would be
> -			 * more desiderable behavior than only
> -			 * providing THP originated from the local
> -			 * node in such case.
> -			 */
> -			if (!(gfp & __GFP_DIRECT_RECLAIM))
> -				gfp |= __GFP_THISNODE;
> -			page = __alloc_pages_node(hpage_node, gfp, order);
> -			goto out;
> -		}
> -	}
> -
>  	nmask = policy_nodemask(gfp, pol);
>  	preferred_nid = policy_node(gfp, pol, node);
>  	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);

-- 
 Kirill A. Shutemov
