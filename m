Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeBUQTT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:19:19 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:40612 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeBUQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:19:17 -0500
X-Google-Smtp-Source: AG47ELvSNVsbeMaWI3WNRWkyHMZqnes3DeFWZRVUAFwPvlcKnpZ3jBztQo+kpgrdN9Q0F+Zcy8ap6A==
Date: Wed, 21 Feb 2018 10:19:14 -0600
From: Dan Rue <dan.rue@linaro.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] mm, hugetlb: further simplify hugetlb allocation API
Message-ID: <20180221161914.ltssyoumwpyiwca6@xps>
References: <20180103093213.26329-1-mhocko@kernel.org>
 <20180103093213.26329-6-mhocko@kernel.org>
 <20180221042457.uolmhlmv5je5dqx7@xps>
 <20180221095526.GB2231@dhcp22.suse.cz>
 <20180221100107.GC2231@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221100107.GC2231@dhcp22.suse.cz>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:01:07AM +0100, Michal Hocko wrote:
> On Wed 21-02-18 10:55:26, Michal Hocko wrote:
> > On Tue 20-02-18 22:24:57, Dan Rue wrote:
> [...]
> > > I bisected the failure to this commit. The problem is seen on multiple
> > > architectures (tested x86-64 and arm64).
> > 
> > The patch shouldn't have introduced any functional changes IIRC. But let
> > me have a look
> 
> Hmm, I guess I can see it. Does the following help?
> ---
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7c204e3d132b..a963f2034dfc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1583,7 +1583,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  		page = NULL;
>  	} else {
>  		h->surplus_huge_pages++;
> -		h->nr_huge_pages_node[page_to_nid(page)]++;
> +		h->surplus_huge_pages_node[page_to_nid(page)]++;
>  	}
>  
>  out_unlock:

That did the trick. Confirmed fixed on v4.15-3389-g0c397daea1d4 and
v4.16-rc2 with the above patch.

Dan

> -- 
> Michal Hocko
> SUSE Labs
