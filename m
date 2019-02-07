Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E2C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9638C2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPP6alBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBGSvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:51:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37404 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:51:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x17InAek026056;
        Thu, 7 Feb 2019 18:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=CY1qIemIcU7S4oq51xk5yyrbeVt0hXCjaaqLCg3A9io=;
 b=mPP6alBTXMCwd2BrszA7sBmzRFHYaRPYGw5M42IKT4hhPIdJe7SCqJ27GLLDjJjmZPGS
 x+BqiKSLpSgDIF3fkHykBThDcwlEe7aBM8C2eOlxAvHZzqS0pjEkoJJKmXn2q5SCnmee
 UIDI21L5mLJ+ioUmfULPaYUfS8TD5PphKzujjhOvaYFu+mmCWJOE2fyv00yUGRiu0+Bk
 C1TprmXik7XvQP+ZkCUUCj97xn6kpxASs0yjukibItTZW6GXOmoX9XypaWfvCSJKbZOe
 C/L/D3jWJyvi7KxuYGEL1dZcX9IJYLAtwSGo3yXx/laFhD7TVa7xaksUFld1mHLTpGmh yQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qd9arrrqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Feb 2019 18:50:59 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x17IowKf014618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 18:50:59 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x17Iovuj023593;
        Thu, 7 Feb 2019 18:50:57 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Feb 2019 18:50:56 +0000
Subject: Re: [PATCH] huegtlbfs: fix page leak during migration of file pages
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20190130211443.16678-1-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <917e7673-051b-e475-8711-ed012cff4c44@oracle.com>
Date:   Thu, 7 Feb 2019 10:50:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130211443.16678-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9160 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=807 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902070141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 1:14 PM, Mike Kravetz wrote:
> Files can be created and mapped in an explicitly mounted hugetlbfs
> filesystem.  If pages in such files are migrated, the filesystem
> usage will not be decremented for the associated pages.  This can
> result in mmap or page allocation failures as it appears there are
> fewer pages in the filesystem than there should be.

Does anyone have a little time to take a look at this?

While migration of hugetlb pages 'should' not be a common issue, we
have seen it happen via soft memory errors/page poisoning in production
environments.  Didn't see a leak in that case as it was with pages in a
Sys V shared mem segment.  However, our DB code is starting to make use
of files in explicitly mounted hugetlbfs filesystems.  Therefore, we are
more likely to hit this bug in the field.
-- 
Mike Kravetz

> 
> For example, a test program which hole punches, faults and migrates
> pages in such a file (1G in size) will eventually fail because it
> can not allocate a page.  Reported counts and usage at time of failure:
> 
> node0
> 537	free_hugepages
> 1024	nr_hugepages
> 0	surplus_hugepages
> node1
> 1000	free_hugepages
> 1024	nr_hugepages
> 0	surplus_hugepages
> 
> Filesystem                         Size  Used Avail Use% Mounted on
> nodev                              4.0G  4.0G     0 100% /var/opt/hugepool
> 
> Note that the filesystem shows 4G of pages used, while actual usage is
> 511 pages (just under 1G).  Failed trying to allocate page 512.
> 
> If a hugetlb page is associated with an explicitly mounted filesystem,
> this information in contained in the page_private field.  At migration
> time, this information is not preserved.  To fix, simply transfer
> page_private from old to new page at migration time if necessary. Also,
> migrate_page_states() unconditionally clears page_private and PagePrivate
> of the old page.  It is unlikely, but possible that these fields could
> be non-NULL and are needed at hugetlb free page time.  So, do not touch
> these fields for hugetlb pages.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 10 ++++++++++
>  mm/migrate.c         | 10 ++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 32920a10100e..fb6de1db8806 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -859,6 +859,16 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
>  	rc = migrate_huge_page_move_mapping(mapping, newpage, page);
>  	if (rc != MIGRATEPAGE_SUCCESS)
>  		return rc;
> +
> +	/*
> +	 * page_private is subpool pointer in hugetlb pages, transfer
> +	 * if needed.
> +	 */
> +	if (page_private(page) && !page_private(newpage)) {
> +		set_page_private(newpage, page_private(page));
> +		set_page_private(page, 0);
> +	}
> +
>  	if (mode != MIGRATE_SYNC_NO_COPY)
>  		migrate_page_copy(newpage, page);
>  	else
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f7e4bfdc13b7..0d9708803553 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -703,8 +703,14 @@ void migrate_page_states(struct page *newpage, struct page *page)
>  	 */
>  	if (PageSwapCache(page))
>  		ClearPageSwapCache(page);
> -	ClearPagePrivate(page);
> -	set_page_private(page, 0);
> +	/*
> +	 * Unlikely, but PagePrivate and page_private could potentially
> +	 * contain information needed at hugetlb free page time.
> +	 */
> +	if (!PageHuge(page)) {
> +		ClearPagePrivate(page);
> +		set_page_private(page, 0);
> +	}
>  
>  	/*
>  	 * If any waiters have accumulated on the new page then
> 
