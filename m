Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEDAKA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:10:00 -0400
Received: from ext-host0001.ascade.co.jp ([218.224.228.194]:61324 "EHLO
        ns.ascade.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbeEDAJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:09:55 -0400
Subject: Re: [PATCH] memcg, hugetlb: pages allocated for hugetlb's overcommit
 will be charged to memcg
To: Mike Kravetz <mike.kravetz@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org, tsukada@ascade.co.jp
References: <ecb737e9-ccec-2d7e-45d9-91884a669b58@ascade.co.jp>
 <dc21a4ac-b57f-59a8-f97a-90a59d5a59cd@oracle.com>
 <c9019050-7c89-86c3-93fc-9beb64e43ed3@ascade.co.jp>
 <249d53f4-225d-8a11-d557-b915fa4fa9cb@oracle.com>
From: TSUKADA Koutaro <tsukada@ascade.co.jp>
Message-ID: <a696eccd-24f3-9368-5baa-afbd3628468a@ascade.co.jp>
Date: Fri, 4 May 2018 09:09:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <249d53f4-225d-8a11-d557-b915fa4fa9cb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/05/03 11:33, Mike Kravetz wrote:
> On 05/01/2018 11:54 PM, TSUKADA Koutaro wrote:
>> On 2018/05/02 13:41, Mike Kravetz wrote:
>>> What is the reason for not charging pages at allocation/reserve time?  I am
>>> not an expert in memcg accounting, but I would think the pages should be
>>> charged at allocation time.  Otherwise, a task could allocate a large number
>>> of (reserved) pages that are not charged to a memcg.  memcg charges in other
>>> code paths seem to happen at huge page allocation time.
>>
>> If we charge to memcg at page allocation time, the new page is not yet
>> registered in rmap, so it will be accounted as 'cache' inside the memcg. Then,
>> after being registered in rmap, memcg will account as 'RSS' if the task moves
>> cgroup, so I am worried about the possibility of inconsistency in statistics
>> (memory.stat).
>>
>> As you said, in this patch, there may be a problem that a memory leak occurs
>> due to unused pages after being reserved.
>>
>>>> This patch targets RHELSA(kernel-alt-4.11.0-45.6.1.el7a.src.rpm).
>>>
>>> It would be very helpful to rebase this patch on a recent mainline kernel.
>>> The code to allocate surplus huge pages has been significantly changed in
>>> recent kernels.
>>>
>>> I have no doubt that this is a real issue and we are not correctly charging
>>> surplus to a memcg.  But your patch will be hard to evaluate when based on
>>> an older distro kernel.
>> I apologize for the patch of the old kernel. The patch was rewritten
>> for 4.17-rc2(6d08b06).
> 
> Thank you very much for rebasing the patch.
> 
> I did not look closely at your patch until now.  My first thought was that
> you  were changing/expanding the existing accounting.  However, it appears
> that you want to account for hugetlb surplus pages in the memory cgroup.
> Is there any reason why the hugetlb cgroup resource controller does not meet
> your needs?  It a quick look at the code, it does appear to handle surplus
> pages correctly.

Yes, basically it is exactly what you are talking about, but my usage is
somewhat special. I would like users who submit jobs on the HPC cluster to use
the hugetlb page. When submitting a job, the user specifies a memory resource
(for example, sbatch --mem in slurm).

If the user specifies 10GB, we assume that the system administrator has set the
limit of 10GB for memory cgroup and hugetlb cgroup respectively, and does not
create a hugetlb pool and sets it so that can overcommit. Then, users can use
10GB normal pages and more 10GB hugetlb page by overcommitting, which means
user can use 20GB totaly. However, the administrator should restrict the normal
page and hugetlb page to 10GB in total.

Since it is difficult to estimate the ratio used by user of normal pages and
hugetlb pages, setting limits of 2 GB to memory cgroup and 8 GB to hugetlb
cgroup is not very good idea.

In such a case, with my patch, I thought that the administrator can manage the
resources just by setting 10GB for the limit of memory cgoup(No limit is set
for hugetlb cgroup).

-- 
