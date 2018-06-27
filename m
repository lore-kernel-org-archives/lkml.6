Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3B7C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C6725918
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BhwsKo9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C6725918
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeF0X1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:27:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53882 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752413AbeF0X1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:27:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5RNNv8j152927;
        Wed, 27 Jun 2018 23:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=bgtDP08hsJkdLwOozClPNHd8djWHgbf+0j2ax2MiZlM=;
 b=BhwsKo9BvpWWT70SjmLVRSlOn9tgVCRPJo8TvD0L1d6UhqdynuAWaz8hDWDo0fxJHgXI
 6sHTP1bQLj1VC/OlPAR5xXO+8LzmKL61l70OUU1XsOyhXgEs4zmQLaf3n+xwe+m+3maP
 hOxwl9Qr6N8DUVNdQLj3T33Y8tuViFyGReDA9NgIjWfz1tfgWdssDHxIN9GERSqzhKSV
 eG5oAvIV5xPUySZG6H+l5ufie/KYhxGM2M81gu5Cjlp747YAadcrVTSc5Siufa37RXoS
 W7nhPwszhRO0on0Pnkv5Kk/JXD/qXNIPyBiq1/YCKUhBJR+LPFpYHqZdgcK9nhj3POe8 Yw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jukhsewpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 23:27:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5RNRQeh017544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 23:27:26 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5RNRPjW006057;
        Wed, 27 Jun 2018 23:27:25 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 16:27:25 -0700
Subject: Re: [PATCH] mm: hugetlb: yield when prepping struct pages
To:     Cannon Matthews <cannonmatthews@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, gthelen@google.com
References: <20180627214447.260804-1-cannonmatthews@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <89c34814-ee1a-6339-1daf-fff02ce947e5@oracle.com>
Date:   Wed, 27 Jun 2018 16:27:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627214447.260804-1-cannonmatthews@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806270245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/2018 02:44 PM, Cannon Matthews wrote:
> When booting with very large numbers of gigantic (i.e. 1G) pages, the
> operations in the loop of gather_bootmem_prealloc, and specifically
> prep_compound_gigantic_page, takes a very long time, and can cause a
> softlockup if enough pages are requested at boot.
> 
> For example booting with 3844 1G pages requires prepping

Wow!  I wish I had a system with that much memory to test. :)

> (set_compound_head, init the count) over 1 billion 4K tail pages, which
> takes considerable time. This should also apply to reserving the same
> amount of memory as 2M pages, as the same number of struct pages
> are affected in either case.

Actually, this change would not apply to 2M (on x86) pages.  The hugetlbfs
initialization code is a bit confusing, but alloc_bootmem_huge_page and
gather_bootmem_prealloc are only exercised in the case where huge page
order >= MAX_ORDER.

Allocation and initialization of 2M pages happens after the normal memory
allocators are setup via the routine hugetlb_hstate_alloc_pages.  And,
there is already a cond_resched in that loop today.

Note that 'else if' in the for loop of hugetlb_hstate_alloc_pages.  This
allows the same routine to be called for early gigantic page allocations
using the bootmem allocator, and later normal (2M) allocations using the
normal memory allocators.  To me, this is a source of confusion and is
something I plan to clean up in the future.

> Add a cond_resched() to the outer loop in gather_bootmem_prealloc() to
> prevent this lockup.
> 
> Tested: Booted with softlockup_panic=1 hugepagesz=1G hugepages=3844 and
> no softlockup is reported, and the hugepages are reported as
> successfully setup.
> 
> Signed-off-by: Cannon Matthews <cannonmatthews@google.com>

My only suggestion would be to remove the mention of 2M pages in the
commit message.  Thanks for adding this.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  mm/hugetlb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a963f2034dfc..d38273c32d3b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2169,6 +2169,7 @@ static void __init gather_bootmem_prealloc(void)
>  		 */
>  		if (hstate_is_gigantic(h))
>  			adjust_managed_page_count(page, 1 << h->order);
> +		cond_resched();
>  	}
>  }
>  
> 
