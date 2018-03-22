Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCVPzA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:55:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751539AbeCVPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:54:58 -0400
Subject: Re: [RFC PATCH 1/8] mm: mmap: unmap large mapping by section
To: Matthew Wilcox <willy@infradead.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
 <1521581486-99134-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180321130833.GM23100@dhcp22.suse.cz>
 <f88deb20-bcce-939f-53a6-1061c39a9f6c@linux.alibaba.com>
 <20180321172932.GE4780@bombadil.infradead.org>
 <f057a634-7e0a-1b51-eede-dcb6f128b18e@linux.alibaba.com>
 <20180321224631.GB3969@bombadil.infradead.org>
 <18a727fd-f006-9fae-d9ca-74b9004f0a8b@linux.vnet.ibm.com>
 <20180322154055.GB28468@bombadil.infradead.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 16:54:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322154055.GB28468@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032215-0044-0000-0000-0000053ED1E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032215-0045-0000-0000-0000287DDBB4
Message-Id: <0442fb0e-3da3-3f23-ce4d-0f6cbc3eac9a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803220184
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/03/2018 16:40, Matthew Wilcox wrote:
> On Thu, Mar 22, 2018 at 04:32:00PM +0100, Laurent Dufour wrote:
>> On 21/03/2018 23:46, Matthew Wilcox wrote:
>>> On Wed, Mar 21, 2018 at 02:45:44PM -0700, Yang Shi wrote:
>>>> Marking vma as deleted sounds good. The problem for my current approach is
>>>> the concurrent page fault may succeed if it access the not yet unmapped
>>>> section. Marking deleted vma could tell page fault the vma is not valid
>>>> anymore, then return SIGSEGV.
>>>>
>>>>> does not care; munmap will need to wait for the existing munmap operation
>>>>
>>>> Why mmap doesn't care? How about MAP_FIXED? It may fail unexpectedly, right?
>>>
>>> The other thing about MAP_FIXED that we'll need to handle is unmapping
>>> conflicts atomically.  Say a program has a 200GB mapping and then
>>> mmap(MAP_FIXED) another 200GB region on top of it.  So I think page faults
>>> are also going to have to wait for deleted vmas (then retry the fault)
>>> rather than immediately raising SIGSEGV.
>>
>> Regarding the page fault, why not relying on the PTE locking ?
>>
>> When munmap() will unset the PTE it will have to held the PTE lock, so this
>> will serialize the access.
>> If the page fault occurs before the mmap(MAP_FIXED), the page mapped will be
>> removed when mmap(MAP_FIXED) would do the cleanup. Fair enough.
> 
> The page fault handler will walk the VMA tree to find the correct
> VMA and then find that the VMA is marked as deleted.  If it assumes
> that the VMA has been deleted because of munmap(), then it can raise
> SIGSEGV immediately.  But if the VMA is marked as deleted because of
> mmap(MAP_FIXED), it must wait until the new VMA is in place.

I'm wondering if such a complexity is required.
If the user space process try to access the page being overwritten through
mmap(MAP_FIXED) by another thread, there is no guarantee that it will
manipulate the *old* page or *new* one.
I'd think this is up to the user process to handle that concurrency.
What needs to be guaranteed is that once mmap(MAP_FIXED) returns the old page
are no more there, which is done through the mmap_sem and PTE locking.

> I think I was wrong to describe VMAs as being *deleted*.  I think we
> instead need the concept of a *locked* VMA that page faults will block on.
> Conceptually, it's a per-VMA rwsem, but I'd use a completion instead of
> an rwsem since the only reason to write-lock the VMA is because it is
> being deleted.

Such a lock would only makes sense in the case of mmap(MAP_FIXED) since when
the VMA is removed there is no need to wait. Isn't it ?
