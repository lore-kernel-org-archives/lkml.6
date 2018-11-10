Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89463C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FFF2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4MxwnSk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FFF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeKJKYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:24:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46810 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeKJKYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:24:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAA0ctuL075051;
        Sat, 10 Nov 2018 00:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Fl69ZlGrVbokIYKsIJy1mIZMU3k8tgreCZmSJC3vH4A=;
 b=4MxwnSk/LqSFSu+ien2/UXfeZJKOX/QPcjhQ1JM8cbjp2bD5LwqEJ1ILDQovBP16k9e2
 iIe7a8388TMOcPm83Au/b93ODcgX7jafS4GSOlFeeTSx9TF1L/bxrMcogkIAsBjdLAUy
 mZuJktYH8Shfb0I1eQrk7rG9cOH1pcOuhCwrxmbdIH/QnxE2GmTGZJDtlT5nUs5EpmTb
 v+lxizu1PUKb+n7RO1kuB1kQ14aqrxRUFf7sLF25haDGuIfkI7FBFVz+nhFd1FxUf0uP
 20HW+P2DDMOfN2zDrjSXxggVvzi+qei3SSE6w70IkG+ubD8Q1ljCY2KHVbFdTpsxhoou 7g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nh33uhte8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Nov 2018 00:39:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAA0dnJU025562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Nov 2018 00:39:49 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAA0dltA020383;
        Sat, 10 Nov 2018 00:39:47 GMT
Received: from [10.39.244.128] (/10.39.244.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 16:39:47 -0800
Subject: Re: [RFC PATCH] mm: thp: implement THP reservations for anonymous
 memory
To:     Zi Yan <zi.yan@cs.rutgers.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, jglisse@redhat.com,
        khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com,
        mhocko@kernel.org, minchan@kernel.org, peterz@infradead.org,
        rientjes@google.com, vbabka@suse.cz, willy@infradead.org,
        ying.huang@intel.com, nitingupta910@gmail.com
References: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
 <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
 <20181109131128.GE23260@techsingularity.net>
 <EEBCAF4D-138C-4CF7-B4B7-C55F1192A026@cs.rutgers.edu>
From:   anthony.yznaga@oracle.com
Organization: Oracle Corporation
Message-ID: <dc53e320-d35c-3cb8-df9e-8dc6ffbe2163@oracle.com>
Date:   Fri, 9 Nov 2018 16:39:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <EEBCAF4D-138C-4CF7-B4B7-C55F1192A026@cs.rutgers.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9072 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=667
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811100003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/2018 07:34 AM, Zi Yan wrote:
> On 9 Nov 2018, at 8:11, Mel Gorman wrote:
>
>> On Fri, Nov 09, 2018 at 03:13:18PM +0300, Kirill A. Shutemov wrote:
>>> On Thu, Nov 08, 2018 at 10:48:58PM -0800, Anthony Yznaga wrote:
>>>> The basic idea as outlined by Mel Gorman in [2] is:
>>>>
>>>> 1) On first fault in a sufficiently sized range, allocate a huge page
>>>>    sized and aligned block of base pages.  Map the base page
>>>>    corresponding to the fault address and hold the rest of the pages in
>>>>    reserve.
>>>> 2) On subsequent faults in the range, map the pages from the reservation.
>>>> 3) When enough pages have been mapped, promote the mapped pages and
>>>>    remaining pages in the reservation to a huge page.
>>>> 4) When there is memory pressure, release the unused pages from their
>>>>    reservations.
>>> I haven't yet read the patch in details, but I'm skeptical about the
>>> approach in general for few reasons:
>>>
>>> - PTE page table retracting to replace it with huge PMD entry requires
>>>   down_write(mmap_sem). It makes the approach not practical for many
>>>   multi-threaded workloads.
>>>
>>>   I don't see a way to avoid exclusive lock here. I will be glad to
>>>   be proved otherwise.
>>>
>> That problem is somewhat fundamental to the mmap_sem itself and
>> conceivably it could be alleviated by range-locking (if that gets
>> completed). The other thing to bear in mind is the timing. If the
>> promotion is in-place due to reservations, there isn't the allocation
>> overhead and the hold times *should* be short.
>>
> Is it possible to convert all these PTEs to migration entries during
> the promotion and replace them with a huge PMD entry afterwards?
> AFAIK, migrating pages does not require holding a mmap_sem.
> Basically, it will act like migrating 512 base pages to a THP without
> actually doing the page copy.
That's an interesting idea.  I'll look into it.

Thanks,
Anthony

>
> --
> Best Regards
> Yan Zi

