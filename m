Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbeEHAfz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:35:55 -0400
Received: from ext-host0001.ascade.co.jp ([218.224.228.194]:62222 "EHLO
        ns.ascade.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeEHAfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:35:53 -0400
Subject: Re: [PATCH] memcg, hugetlb: pages allocated for hugetlb's overcommit
 will be charged to memcg
To: Mike Kravetz <mike.kravetz@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
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
 <a696eccd-24f3-9368-5baa-afbd3628468a@ascade.co.jp>
 <fae2dde5-00b0-f12c-66ff-8b69351805a9@oracle.com>
From: TSUKADA Koutaro <tsukada@ascade.co.jp>
Message-ID: <7c4dced0-fb54-4336-8bcb-e863187a0d49@ascade.co.jp>
Date: Tue, 8 May 2018 09:35:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fae2dde5-00b0-f12c-66ff-8b69351805a9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/05/04 13:26, Mike Kravetz wrote:
> Thank you for the explanation of your use case.  I now understand what
> you were trying to accomplish with your patch.
> 
> Your use case reminds me of the session at LSFMM titled "swap accounting".
> https://lwn.net/Articles/753162/
> 
> I hope someone with more cgroup expertise (Johannes? Aneesh?) can provide
> comments.  My experience in that area is limited.

I am waiting for comments from expertise. The point is whether the surplus
hugetlb page that allocated from buddy pool directly should be charged to
memory cgroup or not.

> One question that comes to mind is "Why would the user/application writer
> use hugetlbfs overcommit instead of THP?".  For hugetlbfs overcommit, they
> need to be prepared for huge page allocations to fail.  So, in some cases
> they may not be able to use any hugetlbfs pages.  This is not much different
> than THP.  However, in the THP case huge page allocation failures and fall
> back to base pages is transparent to the user.  With THP, the normal memory
> cgroup controller should work well.

Certainly THP is much easier to use than hugetlb in 4KB page size kernel.
On the other hand, some distributions(SUSE, RHEL) have a page size of 64KB,
and the THP size in that case is 512MB(not 2MB). I am afraid that 512MB of
huge page is somewhat difficult to use.

In hugetlbfs, page size variation increases by using contiguous bits
supported by aarch64 architecture, and 2MB, 512MB, 16GB, 4TB can be used
in 64KB environment(Actually, only 2MB is usable...). I also believe THP
is the best in the 4KB environment, but I am considering how to use the
huge page in the 64KB environment.
-- 
Tsukada Koutaro
