Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B503C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D927820855
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3kn/rT/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D927820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeKJJse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:48:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48304 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbeKJJsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:48:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAA04SKx011051;
        Sat, 10 Nov 2018 00:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=aImLnv4yOOEs7mW0/3jZnLacTRzF4i3gh1yRp0xINSM=;
 b=3kn/rT/k5cuJIZpt9pYoYkXv/K2Y2Uct711L9ZLjlVCX47ZDBYmJVGoLxLGVHy+g9yAs
 eaJI0BVk1+y/f3xtKSnD5WXu6UyMh0c40joxDpT7yH3M+FScupwvuneKd8hxLS5DfxPf
 1O8gsYYMAUlcAIKiWIUfodZO634upegMsfqwZejZHdqaYtk1cl4xdp34TqBj0m4BzXgi
 GizfJFo2SLtYfKBAz4BtkP5HUAJhFlkgvcMFKWc8wD2e/9muRAdZFGW8NQbQ7/5xs9jw
 DD0RAZ4/WmuNtKg461b1KxoVaErDNrHj4ikZ48jdQeNo37yJt4yIQKUDgkDM0Oiqvp/h yw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nh4ar9ngk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Nov 2018 00:05:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAA051pf032643
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Nov 2018 00:05:02 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAA050Ms016943;
        Sat, 10 Nov 2018 00:05:00 GMT
Received: from [10.39.244.128] (/10.39.244.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 16:04:59 -0800
Subject: Re: [RFC PATCH] mm: thp: implement THP reservations for anonymous
 memory
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, jglisse@redhat.com,
        khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com,
        mgorman@techsingularity.net, mhocko@kernel.org, minchan@kernel.org,
        peterz@infradead.org, rientjes@google.com, vbabka@suse.cz,
        willy@infradead.org, ying.huang@intel.com, nitingupta910@gmail.com
References: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
 <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
From:   anthony.yznaga@oracle.com
Organization: Oracle Corporation
Message-ID: <e5873a6e-db77-d654-6df6-9b5017c31f70@oracle.com>
Date:   Fri, 9 Nov 2018 16:04:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9072 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=368
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/2018 04:13 AM, Kirill A. Shutemov wrote:
> On Thu, Nov 08, 2018 at 10:48:58PM -0800, Anthony Yznaga wrote:
>> The basic idea as outlined by Mel Gorman in [2] is:
>>
>> 1) On first fault in a sufficiently sized range, allocate a huge page
>>    sized and aligned block of base pages.  Map the base page
>>    corresponding to the fault address and hold the rest of the pages in
>>    reserve.
>> 2) On subsequent faults in the range, map the pages from the reservation.
>> 3) When enough pages have been mapped, promote the mapped pages and
>>    remaining pages in the reservation to a huge page.
>> 4) When there is memory pressure, release the unused pages from their
>>    reservations.
> I haven't yet read the patch in details, but I'm skeptical about the
> approach in general for few reasons:
>
> - PTE page table retracting to replace it with huge PMD entry requires
>   down_write(mmap_sem). It makes the approach not practical for many
>   multi-threaded workloads.
>
>   I don't see a way to avoid exclusive lock here. I will be glad to
>   be proved otherwise.
>
> - The promotion will also require TLB flush which might be prohibitively
>   slow on big machines.
>
> - Short living processes will fail to benefit from THP with the policy,
>   even with plenty of free memory in the system: no time to promote to THP
>   or, with synchronous promotion, cost will overweight the benefit.
>
> The goal to reduce memory overhead of THP is admirable, but we need to be
> careful not to kill THP benefit itself. The approach will reduce number of
> THP mapped in the system and/or shift their allocation to later stage of
> process lifetime.
>
> The only way I see it can be useful is if it will be possible to apply the
> policy on per-VMA basis. It will be very useful for malloc()
> implementations, for instance. But as a global policy it's no-go to me.
I agree that this should not be a global policy.  For example, it seems to me
that a VMA where MADV_HUGEPAGE has been applied should get huge
pages on first faults (I need to fix that in my implementation).
>
> Prove me wrong with performance data. :)
I'll try.  :-)

Thanks for the comments!

Anthony

