Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE94C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 05:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C995207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 05:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qwqY0mtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C995207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJXN1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 09:27:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35508 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeJXN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 09:27:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9O4xntR172502;
        Wed, 24 Oct 2018 05:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=UxkED6G8ykMeWeaogMW5FaK3aJ+Oy+ny8Kh8fyr8aa4=;
 b=qwqY0mtTnEoseFmd2Jj1QPyJxLUkdBmUDdbLiDpfFISECYLaQj9pw2u+4yoDKSZj82Br
 DllrwJk62b5YU3OHW4QBjuIgbafvsJ9F4xQ2FdXpL0eLBDP+RSfdthIgUGGCWfwkhKRs
 caf+rED/XAV7g9HUD+bVSrSDROD8LkjuYjVzm6z93roQH4GfDPtTYvzztKHpCLgbDWV5
 +0BehpTlyAvYmY8/NlOD2ute/rBEvcoEbkWz4PSL7AYdNo7Wcn63tkRPsWHY3jFLtBEc
 4htkS09KETuv+ltbwYvpXj03ZHr7vGqop47IBsg5wjyfvnN/t3V9Pu4PDHp5nIwNqOSr Kg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2n7w0qs293-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 05:00:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9O50OBG012043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 05:00:24 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9O50Oku000344;
        Wed, 24 Oct 2018 05:00:24 GMT
Received: from concerto (/47.8.173.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 22:00:23 -0700
Message-ID: <460643f8371a423e97af375f9835243e1e8831bb.camel@oracle.com>
Subject: Re: [PATCH] hugetlbfs: dirty pages as they are added to pagecache
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Date:   Wed, 24 Oct 2018 10:30:42 +0530
In-Reply-To: <b5be45b8-5afe-56cd-9482-28384699a049@oracle.com>
References: <20181018041022.4529-1-mike.kravetz@oracle.com>
         <20181023074340.GO18839@dhcp22.suse.cz>
         <b5be45b8-5afe-56cd-9482-28384699a049@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-23 at 10:30 -0700, Mike Kravetz wrote:
> ..... snip....
> Here is updated patch without the drop_caches change and updated
> fixes tag.
> 
> From: Mike Kravetz <mike.kravetz@oracle.com>
> 
> hugetlbfs: dirty pages as they are added to pagecache
> 
> Some test systems were experiencing negative huge page reserve
> counts and incorrect file block counts.  This was traced to
> /proc/sys/vm/drop_caches removing clean pages from hugetlbfs
> file pagecaches.  When non-hugetlbfs explicit code removes the
> pages, the appropriate accounting is not performed.
> 
> This can be recreated as follows:
>  fallocate -l 2M /dev/hugepages/foo
>  echo 1 > /proc/sys/vm/drop_caches
>  fallocate -l 2M /dev/hugepages/foo
>  grep -i huge /proc/meminfo
>    AnonHugePages:         0 kB
>    ShmemHugePages:        0 kB
>    HugePages_Total:    2048
>    HugePages_Free:     2047
>    HugePages_Rsvd:    18446744073709551615
>    HugePages_Surp:        0
>    Hugepagesize:       2048 kB
>    Hugetlb:         4194304 kB
>  ls -lsh /dev/hugepages/foo
>    4.0M -rw-r--r--. 1 root root 2.0M Oct 17 20:05 /dev/hugepages/foo
> 
> To address this issue, dirty pages as they are added to pagecache.
> This can easily be reproduced with fallocate as shown above. Read
> faulted pages will eventually end up being marked dirty.  But there
> is a window where they are clean and could be impacted by code such
> as drop_caches.  So, just dirty them all as they are added to the
> pagecache.
> 
> Fixes: 6bda666a03f0 ("hugepages: fold find_or_alloc_pages into
> huge_no_page()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5c390f5a5207..7b5c0ad9a6bd 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3690,6 +3690,12 @@ int huge_add_to_page_cache(struct page *page,
> struct address_space *mapping,
>  		return err;
>  	ClearPagePrivate(page);
>  
> +	/*
> +	 * set page dirty so that it will not be removed from
> cache/file
> +	 * by non-hugetlbfs specific code paths.
> +	 */
> +	set_page_dirty(page);
> +
>  	spin_lock(&inode->i_lock);
>  	inode->i_blocks += blocks_per_huge_page(h);
>  	spin_unlock(&inode->i_lock);

This looks good.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>

--
Khalid
