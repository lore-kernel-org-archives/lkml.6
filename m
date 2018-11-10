Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12899C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB1D2133D
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dnR+FA8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB1D2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeKJKjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:39:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33374 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeKJKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:39:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAA0sfTG084313;
        Sat, 10 Nov 2018 00:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1AXo21GEKmRC8UMYL/vaSQ0T0qPZJ12SUFIGGFWCuIg=;
 b=dnR+FA8XW5gaYXlYVeaMsA2nwVvJ+JNLi56L+uCEpfYfY5L3R+uuBsJu2ldq0v7Xpmyf
 eBCFjhTEsYT6jAOqYqkX6LDhIk+/HgBECZaWGFforY6xIRSHvlMb97Ik1jkGeu+e1rQW
 q9Idngr6QH039DiiuMtNhvaXS++iPu7bn6ms2JTdBzfpGIYcLkVgBHbiFxWiWlvmIv4C
 Q29Oe9ZC3KZAfNnYCArkCNYnpOpKDyKyy24dPXS10hn4BZVVjxpmaT3F4Muw/QqYyYSR
 gPBxHRjdBGfHOhEutGFaKIGchR9J78P5cVgwjlfm/DV4awDrX0dRZensuJYuJ0naXXvx /Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nh33uhu5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Nov 2018 00:55:47 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAA0tjDG001602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Nov 2018 00:55:45 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAA0tijp008565;
        Sat, 10 Nov 2018 00:55:44 GMT
Received: from [10.39.244.128] (/10.39.244.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 16:55:43 -0800
Subject: Re: [RFC PATCH] mm: thp: implement THP reservations for anonymous
 memory
To:     Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        jglisse@redhat.com, khandual@linux.vnet.ibm.com,
        kirill.shutemov@linux.intel.com, mgorman@techsingularity.net,
        mhocko@kernel.org, minchan@kernel.org, peterz@infradead.org,
        rientjes@google.com, vbabka@suse.cz, willy@infradead.org,
        ying.huang@intel.com, nitingupta910@gmail.com
References: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
 <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
 <20181109195150.GA24747@redhat.com>
From:   anthony.yznaga@oracle.com
Organization: Oracle Corporation
Message-ID: <4425914b-3082-e3fa-4562-de532fd8a3b2@oracle.com>
Date:   Fri, 9 Nov 2018 16:55:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181109195150.GA24747@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9072 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=902
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811100005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/2018 11:51 AM, Andrea Arcangeli wrote:
> Hello,
>
> On Fri, Nov 09, 2018 at 03:13:18PM +0300, Kirill A. Shutemov wrote:
>> On Thu, Nov 08, 2018 at 10:48:58PM -0800, Anthony Yznaga wrote:
>>> The basic idea as outlined by Mel Gorman in [2] is:
>>>
>>> 1) On first fault in a sufficiently sized range, allocate a huge page
>>>    sized and aligned block of base pages.  Map the base page
>>>    corresponding to the fault address and hold the rest of the pages in
>>>    reserve.
>>> 2) On subsequent faults in the range, map the pages from the reservation.
>>> 3) When enough pages have been mapped, promote the mapped pages and
>>>    remaining pages in the reservation to a huge page.
>>> 4) When there is memory pressure, release the unused pages from their
>>>    reservations.
>> I haven't yet read the patch in details, but I'm skeptical about the
>> approach in general for few reasons:
>>
>> - PTE page table retracting to replace it with huge PMD entry requires
>>   down_write(mmap_sem). It makes the approach not practical for many
>>   multi-threaded workloads.
>>
>>   I don't see a way to avoid exclusive lock here. I will be glad to
>>   be proved otherwise.
>>
>> - The promotion will also require TLB flush which might be prohibitively
>>   slow on big machines.
>>
>> - Short living processes will fail to benefit from THP with the policy,
>>   even with plenty of free memory in the system: no time to promote to THP
>>   or, with synchronous promotion, cost will overweight the benefit.
>>
>> The goal to reduce memory overhead of THP is admirable, but we need to be
>> careful not to kill THP benefit itself. The approach will reduce number of
>> THP mapped in the system and/or shift their allocation to later stage of
>> process lifetime.
>>
>> The only way I see it can be useful is if it will be possible to apply the
>> policy on per-VMA basis. It will be very useful for malloc()
>> implementations, for instance. But as a global policy it's no-go to me.
> I'm also skeptical about this: the current design is quite
> intentional. It's not a bug but a feature that we're not doing the
> promotion.
>
> Part of the tradeoff with THP is to use more RAM to save CPU, when you
> use less RAM you're inherently already wasting some CPU just for the
> reservation management and you don't get the immediate TLB benefit
> anymore either.
>
> And if you're in the camp that is concerned about the use of more RAM
> or/and about the higher latency of COW faults, I'm afraid the
> intermediate solution will be still slower than the already available
> MADV_NOHUGEPAGE or enabled=madvise.
>
> Apps like redis that will use more RAM during snapshot and that are
> slowed down with THP needs to simply use MADV_NOHUGEPAGE which already
> exists as an madvise from the very first kernel that supported
> THP-anon. Same thing for other apps that use more RAM with THP and
> that are on the losing end of the tradeoff.
>
> Now about the implementation: the whole point of the reservation
> complexity is to skip the khugepaged copy, so it can collapse in
> place. Is skipping the copy worth it? Isn't the big cost the IPI
> anyway to avoid leaving two simultaneous TLB mappings of different
> granularity?
Good questions.  I'll take them into account when measuring performance.
I do wonder about other architectures (e.g. ARM) where the PMD
size may be significantly larger than 2MB.

>
> khugepaged is already tunable to specify a ratio of memory in use to
> avoid wasting memory
> /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none.
>
> If you set max_ptes_none to half the default value, it'll only promote
> pages that are half mapped, reducing the memory waste to 50% of what
> it is by default.
>
> So if you are ok to copy the memory that you promote to THP, you'd
> just need a global THP mode to avoid allocating THP even when they're
> available during the page fault (while still allowing khugepaged to
> collapse hugepages in the background), and then reduce max_ptes_none
> to get the desired promotion ratio.
>
> Doing the copy will avoid the reservation there will be also more THP
> available to use for those khugepaged users without losing them in
> reservations. You won't have to worry about what to do when there's
> memory pressure because you won't have to undo the reservation because
> there was no reservation in the first place. That problem also goes
> away with the copy.
>
> So it sounds like you could achieve a similar runtime behavior with
> much less complexity by reducing max_ptes_none and by doing the copy
> and dropping all reservation code.

These are compelling arguments.  I will be sure to evaluate any
performance data against this alternate implementation/tuning.

Thank you for the comments.

Anthony

>
>> Prove me wrong with performance data. :)
> Same here.
>
> Thanks,
> Andrea

