Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeDLU7X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:59:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51900 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeDLU7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:59:21 -0400
Subject: Re: [RFC PATCH 0/3] Interface for higher order contiguous allocations
To: Reinette Chatre <reinette.chatre@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>, Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>, David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>
References: <20180212222056.9735-1-mike.kravetz@oracle.com>
 <770445b3-6caa-a87a-5de7-3157fc5280c2@intel.com>
 <74b7c6e5-bce6-a70a-287a-af44765836c7@intel.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8f67cb20-3d70-274b-871b-11bedc687bd9@oracle.com>
Date: Thu, 12 Apr 2018 13:58:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <74b7c6e5-bce6-a70a-287a-af44765836c7@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8861 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804120199
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 01:40 PM, Reinette Chatre wrote:
> Hi Mike,
> 
> On 2/15/2018 12:22 PM, Reinette Chatre wrote:
>> On 2/12/2018 2:20 PM, Mike Kravetz wrote:
>>> These patches came out of the "[RFC] mmap(MAP_CONTIG)" discussions at:
>>> http://lkml.kernel.org/r/21f1ec96-2822-1189-1c95-79a2bb491571@oracle.com
>>>
>>> One suggestion in that thread was to create a friendlier interface that
>>> could be used by drivers and others outside core mm code to allocate a
>>> contiguous set of pages.  The alloc_contig_range() interface is used for
>>> this purpose today by CMA and gigantic page allocation.  However, this is
>>> not a general purpose interface.  So, wrap alloc_contig_range() in the
>>> more general interface:
>>>
>>> struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp, int nid,
>>> 					nodemask_t *nodemask)
>>>
>>> No underlying changes are made to increase the likelihood that a contiguous
>>> set of pages can be found and allocated.  Therefore, any user of this
>>> interface must deal with failure.  The hope is that this interface will be
>>> able to satisfy some use cases today.
>>
>> As discussed in another thread a new feature, Cache Pseudo-Locking,
>> requires large contiguous regions. Until now I just exposed
>> alloc_gigantic_page() to handle these allocations in my testing. I now
>> moved to using find_alloc_contig_pages() as introduced here and all my
>> tests passed. I do hope that an API supporting large contiguous regions
>> become available.
>>
>> Thank you very much for creating this.
>>
>> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Do you still intend on submitting these changes for inclusion?
> 
> I would really like to use this work but unfortunately the original
> patches submitted here do not apply anymore. I am encountering conflicts
> with, for example:
> 
> commit d9cc948f6fa1c3384037f500e0acd35f03850d15
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Wed Jan 31 16:20:44 2018 -0800
> 
>     mm, hugetlb: integrate giga hugetlb more naturally to the allocation
> path
> 
> Thank you very much

Thanks for the reminder Reinette.

You were the only one to comment on the original proposal.  In addition,
my original use case may have gone away.  So, this effort went to the
bottom of my priority list.

I am happy rebase the patches, but would really like to get additional
comments.  Allocation of hugetlbfs gigantic pages is the only existing
user.  Perhaps this is a natural progression of Michal's patch above
as it moves all that special pfn range scanning out of hugetlb code.
-- 
Mike Kravetz
