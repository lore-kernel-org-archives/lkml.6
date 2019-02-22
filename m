Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38975C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0852720823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfBVGLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:11:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfBVGLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 01:11:37 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 88AC1DF5FCAF9ACBD1FC;
        Fri, 22 Feb 2019 14:11:34 +0800 (CST)
Received: from [127.0.0.1] (10.184.39.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Feb 2019
 14:11:30 +0800
Subject: Re: [PATCH] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1550323872-119049-1-git-send-email-jingxiangfeng@huawei.com>
 <20190218092750.GF4525@dhcp22.suse.cz>
 <7ec68c26-3caf-0446-9c93-461025c51c01@oracle.com>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <n-horiguchi@ah.jp.nec.com>, <aarcange@redhat.com>,
        <kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5C6F9258.3000904@huawei.com>
Date:   Fri, 22 Feb 2019 14:10:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <7ec68c26-3caf-0446-9c93-461025c51c01@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/20 7:45, Mike Kravetz wrote:
> On 2/18/19 1:27 AM, Michal Hocko wrote:
>> On Sat 16-02-19 21:31:12, Jingxiangfeng wrote:
>>> From: Jing Xiangfeng <jingxiangfeng@huawei.com>
>>>
>>> We can use the following command to dynamically allocate huge pages:
>>> 	echo NR_HUGEPAGES > /proc/sys/vm/nr_hugepages
>>> The count in  __nr_hugepages_store_common() is parsed from /proc/sys/vm/nr_hugepages,
>>> The maximum number of count is ULONG_MAX,
>>> the operation 'count += h->nr_huge_pages - h->nr_huge_pages_node[nid]' overflow and count will be a wrong number.
>>
>> Could you be more specific of what is the runtime effect on the
>> overflow? I haven't checked closer but I would assume that we will
>> simply shrink the pool size because count will become a small number.
>>
> 
> Well, the first thing to note is that this code only applies to case where
> someone is changing a node specific hugetlb count.  i.e.
> /sys/devices/system/node/node1/hugepages/hugepages-2048kB
> In this case, the calculated value of count is a maximum or minimum total
> number of huge pages.  However, only the number of huge pages on the specified
> node is adjusted to try and achieve this maximum or minimum.
> 
> So, in the case of overflow the number of huge pages on the specified node
> could be reduced.  I say 'could' because it really is dependent on previous
> values.  In some situations the node specific value will be increased.
> 
> Minor point is that the description in the commit message does not match
> the code changed.
> 
Thanks for your reply.as you said, the case is where someone is changing a node
specific hugetlb count when CONFIG_NUMA is enable. I will modify the commit message.

>> Is there any reason to report an error in that case? We do not report
>> errors when we cannot allocate the requested number of huge pages so why
>> is this case any different?
> 
> Another issue to consider is that h->nr_huge_pages is an unsigned long,
> and h->nr_huge_pages_node[] is an unsigned int.  The sysfs store routines
> treat them both as unsigned longs.  Ideally, the store routines should
> distinguish between the two.
> 
> In reality, an actual overflow is unlikely.  If my math is correct (not
> likely) it would take something like 8 Petabytes to overflow the node specific
> counts.
> 
> In the case of a user entering a crazy high value and causing an overflow,
> an error return might not be out of line.  Another option would be to simply
> set count to ULONG_MAX if we detect overflow (or UINT_MAX if we are paranoid)
> and continue on.  This may be more in line with user's intention of allocating
> as many huge pages as possible.
> 
> Thoughts?
> 
It is better to set count to ULONG_MAX if we detect overflow, and continue to
allocate as many huge pages as possible.
I will send v2 soon.

