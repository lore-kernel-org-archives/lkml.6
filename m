Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeEPUGM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:06:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57970 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeEPUGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:06:11 -0400
Subject: Re: [PATCH -mm] mm, hugetlb: Pass fault address to no page handler
To: Michal Hocko <mhocko@kernel.org>, "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <20180515005756.28942-1-ying.huang@intel.com>
 <20180516091226.GM12670@dhcp22.suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c94f7180-d49b-3a9d-8d9e-002642ee9f3b@oracle.com>
Date: Wed, 16 May 2018 13:04:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180516091226.GM12670@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8895 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160196
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 02:12 AM, Michal Hocko wrote:
> On Tue 15-05-18 08:57:56, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>>
>> This is to take better advantage of huge page clearing
>> optimization (c79b57e462b5d, "mm: hugetlb: clear target sub-page last
>> when clearing huge page").  Which will clear to access sub-page last
>> to avoid the cache lines of to access sub-page to be evicted when
>> clearing other sub-pages.  This needs to get the address of the
>> sub-page to access, that is, the fault address inside of the huge
>> page.  So the hugetlb no page fault handler is changed to pass that
>> information.  This will benefit workloads which don't access the begin
>> of the huge page after page fault.
>>
>> With this patch, the throughput increases ~28.1% in vm-scalability
>> anon-w-seq test case with 88 processes on a 2 socket Xeon E5 2699 v4
>> system (44 cores, 88 threads).  The test case creates 88 processes,
>> each process mmap a big anonymous memory area and writes to it from
>> the end to the begin.  For each process, other processes could be seen
>> as other workload which generates heavy cache pressure.  At the same
>> time, the cache miss rate reduced from ~36.3% to ~25.6%, the
>> IPC (instruction per cycle) increased from 0.3 to 0.37, and the time
>> spent in user space is reduced ~19.3%
> 
> This paragraph is confusing as Mike mentioned already. It would be
> probably more helpful to see how was the test configured to use hugetlb
> pages and what is the end benefit.
> 
> I do not have any real objection to the implementation so feel free to
> add
> Acked-by: Michal Hocko <mhocko@suse.com>
> I am just wondering what is the usecase driving this. Or is it just a
> generic optimization that always makes sense to do? Indicating that in
> the changelog would be helpful as well.

I just noticed that the optimization was not added for 'gigantic' pages.
Should we consider adding support for gigantic pages as well?  It may be
that the cache miss cost is insignificant when added to the time required
to clear a 1GB (for x86) gigantic page.

One more thing, I'm guessing the copy_huge/gigantic_page() routines would
see a similar benefit.  Specifically, for copies as a result of a COW.
Is that another area to consider?

That gets back to Michal's question of a specific use case or generic
optimization.  Unless code is simple (as in this patch), seems like we should
hold off on considering additional optimizations unless there is a specific
use case.

I'm still OK with this change.
-- 
Mike Kravetz
