Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55832C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F82208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xgzo0ipo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F82208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeHVW1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:27:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35538 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeHVW1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:27:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7MIrUdd112181;
        Wed, 22 Aug 2018 18:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1miKbo76WUBcWCSr9eE93KHKdKk4y34U/L7/M6u1eGU=;
 b=Xgzo0ipo5WvXMVbdFdtT0Cm9gzSxoPxlC0PHUCERhQNzIBs2zoGMxPjhDgUzQZP2PpfR
 JX47Ufi9BHyg8t+WhwjWm1w9rKQSF2ES4nQtQYBxGCVGG8AKWia3oXaqB8/1w0hXV6cj
 PRPvYdBNne7soqlAAq7aU4pM88ugUrMmnSYm09eI0PAP1EWknIc7eIXY0vzbjcURSzAc
 hrQCnnegGZIQVD8kXTCFWZMnLBcTv8I1NndV3UpEYMk1hbAZyU5gYkOkc4AxZzi+XLVC
 ajOsEwXQZ+lVy5YFIhk9biF4C6W4qYFf4PHGl+/Z6I8YqnkABO0lMIZM7R9s4rGgqtv5 eA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kxavtv2f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 18:58:07 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7MIw6lO017858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 18:58:06 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7MIw4oQ026234;
        Wed, 22 Aug 2018 18:58:04 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Aug 2018 11:58:04 -0700
Subject: Re: Infinite looping observed in __offline_pages
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Haren Myneni <haren@linux.vnet.ibm.com>
Cc:     n-horiguchi@ah.jp.nec.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
        mgorman@suse.de
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz> <87bm9ug34l.fsf@linux.ibm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <54c72a22-a921-fc64-460d-f66985d0df4e@oracle.com>
Date:   Wed, 22 Aug 2018 11:58:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87bm9ug34l.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8993 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808220186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/2018 02:30 AM, Aneesh Kumar K.V wrote:
> commit 2e9d754ac211f2af3731f15df3cd8cd070b4cc54
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Date:   Tue Aug 21 14:17:55 2018 +0530
> 
>     mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is not supported.
>     
>     When scanning for movable pages, filter out Hugetlb pages if hugepage migration
>     is not supported. Without this we hit infinte loop in __offline pages where we
>     do
>             pfn = scan_movable_pages(start_pfn, end_pfn);
>             if (pfn) { /* We have movable pages */
>                     ret = do_migrate_range(pfn, end_pfn);
>                     goto repeat;
>             }
>     
>     We do support hugetlb migration ony if the hugetlb pages are at pmd level. Here

I thought migration at pgd level was added for POWER?  commit 94310cbcaa3c
(mm/madvise: enable (soft|hard) offline of HugeTLB pages at PGD level).
Only remember, because I did not fully understand the use case. :)

>     we just check for Kernel config. The gigantic page size check is done in
>     page_huge_active.
>     
>     Reported-by: Haren Myneni <haren@linux.vnet.ibm.com>
>     CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4eb6e824a80c..f9bdea685cf4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>  				return pfn;
>  			if (__PageMovable(page))
>  				return pfn;
> -			if (PageHuge(page)) {
> +			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
> +			    PageHuge(page)) {

How about using hugepage_migration_supported instead?  It would automatically
catch those non-migratable huge page sizes.  Something like:

			if (PageHuge(page) &&
			    hugepage_migration_supported(page_hstate(page))) {

-- 
Mike Kravetz

>  				if (page_huge_active(page))
>  					return pfn;
>  				else
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 15ea511fb41c..a3f81e18c882 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7649,6 +7649,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  		 * handle each tail page individually in migration.
>  		 */
>  		if (PageHuge(page)) {
> +
> +			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
> +				goto unmovable;
> +
>  			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
>  			continue;
>  		}
> 
