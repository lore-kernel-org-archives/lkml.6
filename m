Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3CBC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06DE20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uGLGXlXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06DE20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLAKnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:43:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43642 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLAKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:43:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAUNTW3X043827;
        Fri, 30 Nov 2018 23:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=nENTVkKC+R2Y3iWjY7dbMdbLTCd3YqvvNLP1SQw1stI=;
 b=uGLGXlXNi4dysSLSjKExD+ZiMa5dEp0MFj71B53PSnCxNDVM/CAKSPZkb0uJtzvlZ/ju
 29Ps2jpq/+7SOhzD3ED4NLkox+rDgrwKp6JBBc+BNa23jQgAVckvte05kZqxIO59W+K7
 rRLXDc3TiOQ04uHQ81UEnwsrHW1I5oNmvHPCAuvTt8+stR5Pv2rINOSMuo1bft1Co8MY
 6PiV0pT9N9dOPH40GvzZFIgF1G3yfdjbK/y5JN4G4mFSRcbBGER/ULT+x4FF3ThZE3yo
 Q43aBhUDrMLXzvrLnpDOCRpKpfsQa+2RygSgeli9+9sNCmWNXkCNP02f8MPicDMsoYep hA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p2jf0r3t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 23:31:57 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAUNVsgb002532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 23:31:54 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAUNVoR9002380;
        Fri, 30 Nov 2018 23:31:51 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Nov 2018 15:31:50 -0800
Date:   Fri, 30 Nov 2018 15:32:01 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -V7 RESEND 08/21] swap: Support to read a huge swap
 cluster for swapin a THP
Message-ID: <20181130233201.6yuzbhymtjddvf3u@ca-dmjordan1.us.oracle.com>
References: <20181120085449.5542-1-ying.huang@intel.com>
 <20181120085449.5542-9-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120085449.5542-9-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9093 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811300200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ying,

On Tue, Nov 20, 2018 at 04:54:36PM +0800, Huang Ying wrote:
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 97831166994a..1eedbc0aede2 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -387,14 +389,42 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 * as SWAP_HAS_CACHE.  That's done in later part of code or
>  		 * else swap_off will be aborted if we return NULL.
>  		 */
> -		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
> +		if (!__swp_swapcount(entry, &entry_size) &&
> +		    swap_slot_cache_enabled)
>  			break;
>  
>  		/*
>  		 * Get a new page to read into from swap.
>  		 */
> -		if (!new_page) {
> -			new_page = alloc_page_vma(gfp_mask, vma, addr);
> +		if (!new_page ||
> +		    (IS_ENABLED(CONFIG_THP_SWAP) &&
> +		     hpage_nr_pages(new_page) != entry_size)) {
> +			if (new_page)
> +				put_page(new_page);
> +			if (IS_ENABLED(CONFIG_THP_SWAP) &&
> +			    entry_size == HPAGE_PMD_NR) {
> +				gfp_t gfp;
> +
> +				gfp = alloc_hugepage_direct_gfpmask(vma, addr);

vma is NULL when we get here from try_to_unuse, so the kernel will die on
vma->flags inside alloc_hugepage_direct_gfpmask.

try_to_unuse swaps in before it finds vma's, but even if those were reversed,
it seems try_to_unuse wouldn't always have a single vma to pass into this path
since it's walking the swap_map and multiple processes mapping the same huge
page can have different huge page advice (and maybe mempolicies?), affecting
the result of alloc_hugepage_direct_gfpmask.  And yet
alloc_hugepage_direct_gfpmask needs a vma to do its job.  So, I'm not sure how
to fix this.

If the entry's usage count were 1, we could find the vma in that common case to
give read_swap_cache_async, and otherwise allocate small pages.  We'd have THPs
some of the time and be exactly following alloc_hugepage_direct_gfpmask, but
would also be conservative when it's uncertain.

Or, if the system-wide THP settings allow it then go for it, but otherwise
ignore vma hints and always fall back to small pages.  This requires another
way of controlling THP allocations besides alloc_hugepage_direct_gfpmask.

Or maybe try_to_unuse shouldn't allocate hugepages at all, but then no perf
improvement for try_to_unuse.

What do you think?
