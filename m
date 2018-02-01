Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756018AbeBABOA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:14:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57700 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755903AbeBABN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:13:58 -0500
Subject: Re: [PATCH v2] mm: Reduce memory bloat with THP
To: Mel Gorman <mgorman@suse.de>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>, Michal Hocko <mhocko@kernel.org>,
        Nitin Gupta <nitingupta910@gmail.com>, steven.sistare@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        "Levin, Alexander" <alexander.levin@verizon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hillf Danton <hillf.zj@alibaba-inc.com>, Shaohua Li <shli@fb.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@redhat.com>,
        Jan Kara <jack@suse.cz>, Dave Jiang <dave.jiang@intel.com>,
        J?r?me Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@linux.intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, Tobin C Harding <me@tobin.cc>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1516318444-30868-1-git-send-email-nitingupta910@gmail.com>
 <20180119124957.GA6584@dhcp22.suse.cz>
 <ce7c1498-9f28-2eb0-67b7-ade9b04b8e2b@oracle.com>
 <59F98618-C49F-48A8-BCA1-A8F717888BAA@cs.rutgers.edu>
 <4d7ce874-9771-ad5f-c064-52a46fc37689@oracle.com>
 <20180125211303.rbfeg7ultwr6hpd3@suse.de>
From: Nitin Gupta <nitin.m.gupta@oracle.com>
Message-ID: <c8e16ca6-b78d-6066-4d5a-bb6be337c93e@oracle.com>
Date: Wed, 31 Jan 2018 17:09:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180125211303.rbfeg7ultwr6hpd3@suse.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010012
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/25/2018 01:13 PM, Mel Gorman wrote:
> On Thu, Jan 25, 2018 at 11:41:03AM -0800, Nitin Gupta wrote:
>>>> It's not really about memory scarcity but a more efficient use of it.
>>>> Applications may want hugepage benefits without requiring any changes to
>>>> app code which is what THP is supposed to provide, while still avoiding
>>>> memory bloat.
>>>>
>>> I read these links and find that there are mainly two complains:
>>> 1. THP causes latency spikes, because direction compaction slows down THP allocation,
>>> 2. THP bloats memory footprint when jemalloc uses MADV_DONTNEED to return memory ranges smaller than
>>>    THP size and fails because of THP.
>>>
>>> The first complain is not related to this patch.
>>
>> I'm trying to address many different THP issues and memory bloat is
>> first among them.
> 
> Expecting userspace to get this right is probably going to go sideways.
> It'll be screwed up and be sub-optimal or have odd semantics for existing
> madvise flags. The fact is that an application may not even know if it's
> going to be sparsely using memory in advance if it's a computation load
> modelling from unknown input data.
> 
> I suggest you read the old Talluri paper "Superpassing the TLB Performance
> of Superpages with Less Operating System Support" and pay attention to
> Section 4. There it discusses a page reservation scheme whereby on fault
> a naturally aligned set of base pages are reserved and only one correctly
> placed base page is inserted into the faulting address. It was tied into
> a hypothetical piece of hardware that doesn't exist to give best-effort
> support for superpages so it does not directly help you but the initial
> idea is sound. There are holes in the paper from todays perspective but
> it was written in the 90's.
> 
> From there, read "Transparent operating system support for superpages"
> by Navarro, particularly chapter 4 paying attention to the parts where
> it talks about opportunism and promotion threshold.
> 
> Superficially, it goes like this
> 
> 1. On fault, reserve a THP in the allocator and use one base page that
>    is correctly-aligned for the faulting addresses. By correctly-aligned,
>    I mean that you use base page whose offset would be naturally contiguous
>    if it ever was part of a huge page.
> 2. On subsequent faults, attempt to use a base page that is naturally
>    aligned to be a THP
> 3. When a "threshold" of base pages are inserted, allocate the remaining
>    pages and promote it to a THP
> 4. If there is memory pressure, spill "reserved" pages into the main
>    allocation pool and lose the opportunity to promote (which will need
>    khugepaged to recover)
> 
> By definition, a promotion threshold of 1 would be the existing scheme
> of allocation a THP on the first fault and some users will want that. It
> also should be the default to avoid unexpected overhead.  For workloads
> where memory is being sparsely addressed and the increased overhead of
> THP is unwelcome then the threshold should be tuned higher with a maximum
> possible value of HPAGE_PMD_NR.
> 
> It's non-trivial to do this because at minimum a page fault has to check
> if there is a potential promotion candidate by checking the PTEs around
> the faulting address searching for a correctly-aligned base page that is
> already inserted. If there is, then check if the correctly aligned base
> page for the current faulting address is free and if so use it. It'll
> also then need to check the remaining PTEs to see if both the promotion
> threshold has been reached and if so, promote it to a THP (or else teach
> khugepaged to do an in-place promotion if possible). In other words,
> implementing the promotion threshold is both hard and it's not free.
> 
> However, if it did exist then the only tunable would be the "promotion
> threshold" and applications would not need any special awareness of their
> address space.
> 

I went through both references you mentioned and I really like the
idea of reservation-based hugepage allocation.  Navarro also extends
the idea to allow multiple hugepage sizes to be used (as support by
underlying hardware) which was next in order of what I wanted to do in
THP.

So, please ignore this patch and I would work towards implementing
ideas in these papers.

Thanks for the feedback.

Nitin
