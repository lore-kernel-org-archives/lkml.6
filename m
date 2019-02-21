Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAC8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA7D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bg01VyIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBUWMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:12:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56206 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfBUWMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:12:35 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LM9IlJ011007;
        Thu, 21 Feb 2019 22:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HCmVZI+GR5G5wAqDTWNvr8+k7CGJy/LU6FuN0FrxADg=;
 b=bg01VyIzPI9uMfUxADlWLQE+6Wtng8Zr/CAYK93/dU1v1kNnFsQgHD01/dp8tZv9DcQJ
 2Fyak9kZor0m5gVCvEHUOEQL3CfPVEw8kDucJgmiVexDaHCPmygtn5JWyhHFu4Vfipt3
 O7Cl9AxcvOTaPBZZ6vpYX7t/fqguP+xCAtsSrF+/Jpf6fP2lH8aBMoPfZNCbu2CMFDVZ
 3PW6KGKNAQMb9fn0hHQMFctpqraREVUzOAcoHeX1SfXFLiZfONkA6s4Uu/4Y0qTe33QB
 XGO32zuBnoxcKQB52ixuNsO1ShRxqEWfNukalAKwvSVFmIuVg+h9s+XjDFD2eakCsVQf Ig== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qp81ekap5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 22:12:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1LMCOSE021975
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 22:12:24 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LMCNAU029038;
        Thu, 21 Feb 2019 22:12:23 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 14:12:23 -0800
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
To:     Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, david@redhat.com
References: <20190221094212.16906-1-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c4fc87f2-9ff8-3bc1-e990-da97c56ba18f@oracle.com>
Date:   Thu, 21 Feb 2019 14:12:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221094212.16906-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 1:42 AM, Oscar Salvador wrote:
> On x86_64, 1GB-hugetlb pages could never be offlined due to the fact
> that hugepage_migration_supported() returned false for PUD_SHIFT.
> So whenever we wanted to offline a memblock containing a gigantic
> hugetlb page, we never got beyond has_unmovable_pages() check.
> This changed with [1], where now we also return true for PUD_SHIFT.
> 
> After that patch, the check in has_unmovable_pages() and scan_movable_pages()
> returned true, but we still had a final barrier in do_migrate_range():
> 
> if (compound_order(head) > PFN_SECTION_SHIFT) {
> 	ret = -EBUSY;
> 	break;
> }
> 
> This is not really nice, and we do not really need it.
> It is perfectly possible to migrate a gigantic page as long as another node has
> a spare gigantic page for us.
> In alloc_huge_page_nodemask(), we calculate the __real__ number of free pages,
> and if any, we try to dequeue one from another node.
> 
> This all works fine when we do have another node with a spare gigantic page,
> but if that is not the case, alloc_huge_page_nodemask() ends up calling
> alloc_migrate_huge_page() which bails out if the wanted page is gigantic.
> That is mainly because finding a 1GB (or even 16GB on powerpc) contiguous
> memory is quite unlikely when the system has been running for a while.

I suspect the reason for the check is that it was there before the ability
to migrate gigantic pages was added, and nobody thought to remove it.  As
you say, the likelihood of finding a gigantic page after running for some
time is not too good.  I wonder if we should remove that check?  Just trying
to create a gigantic page could result in a bunch of migrations which could
impact the system.  But, this is the result of a memory offline operation
which one would expect to have some negative impact.

> In that situation, we will keep looping forever because scan_movable_pages()
> will give us the same page and we will fail again because there is no node
> where we can dequeue a gigantic page from.
> This is not nice, and I wish we could differentiate a fatal error from a
> transient error in do_migrate_range()->migrate_pages(), but I do not really
> see a way now.

Michal may have some thoughts here.  Note that the repeat loop does not
even consider the return value from do_migrate_range().  Since this the the
result of an offline, I am thinking it was designed to retry forever.  But,
perhaps there are some errors/ret codes where we should give up?

> Anyway, I would tend say that this is the administrator's job, to make sure
> that the system can keep up with the memory to be offlined, so that would mean
> that if we want to use gigantic pages, make sure that the other nodes have at
> least enough gigantic pages to keep up in case we need to offline memory.
> 
> Just for the sake of completeness, this is one of the tests done:
> 
>  # echo 1 > /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/nr_hugepages
>  # echo 1 > /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/nr_hugepages
> 
>  # cat /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/nr_hugepages
>    1
>  # cat /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/free_hugepages
>    1
> 
>  # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/nr_hugepages
>    1
>  # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/free_hugepages
>    1
> 
>  (hugetlb1gb is a program that maps 1GB region using MAP_HUGE_1GB)
> 
>  # numactl -m 1 ./hugetlb1gb
>  # cat /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/free_hugepages
>    0
>  # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/free_hugepages
>    1
> 
>  # offline node1 memory
>  # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/free_hugepages
>    0
> 
> [1] https://lore.kernel.org/patchwork/patch/998796/
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/memory_hotplug.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d5f7afda67db..04f6695b648c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1337,8 +1337,7 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>  		if (!PageHuge(page))
>  			continue;
>  		head = compound_head(page);
> -		if (hugepage_migration_supported(page_hstate(head)) &&
> -		    page_huge_active(head))
> +		if (page_huge_active(head))

I'm confused as to why the removal of the hugepage_migration_supported()
check is required.  Seems that commit aa9d95fa40a2 ("mm/hugetlb: enable
arch specific huge page size support for migration") should make the check
work as desired for all architectures.
-- 
Mike Kravetz
