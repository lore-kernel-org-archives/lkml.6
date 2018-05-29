Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965798AbeE2SNV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:13:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56790 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936850AbeE2SNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:13:20 -0400
Subject: Re: [patch] mm, hugetlb_cgroup: suppress SIGBUS when hugetlb_cgroup
 charge fails
To: David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <alpine.DEB.2.21.1805251316090.167008@chino.kir.corp.google.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7cf79250-a58a-b8a3-50ca-5e472762b510@oracle.com>
Date: Tue, 29 May 2018 11:13:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805251316090.167008@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8908 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805290197
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/2018 01:16 PM, David Rientjes wrote:
> When charging to a hugetlb_cgroup fails, alloc_huge_page() returns
> ERR_PTR(-ENOSPC) which will cause VM_FAULT_SIGBUS to be returned to the
> page fault handler.
> 
> Instead, return the proper error code, ERR_PTR(-ENOMEM), so VM_FAULT_OOM
> is handled correctly.  This is consistent with failing mem cgroup charges
> in the non-hugetlb fault path.

Apologies for the late reply.

I am not %100 sure we want to make this change.  When hugetlb cgroup support
was added by Aneesh, the intention was for the application to get SIGBUS.

commit 2bc64a204697
https://lwn.net/Articles/499255/

Since the code has always caused SIGBUS when exceeding cgroup limit, there
may be applications depending on this behavior.  I would be especially
concerned with HPC applications which were the original purpose for adding
the feature.

Perhaps, the original code should have returned ENOMEM to be consistent as
in your patch.  That does seem to be the more correct behavior.  But, do we
want to change behavior now (admittedly undocumented) and potentially break
some application?

I echo Michal's question about the reason for the change.  If there is a
real problem or issue to solve, that makes more of a case for making the
change.  If it is simply code/behavior cleanup for consistency then I would
suggest not making the change, but rather documenting this as another
hugetlbfs "special behavior".

As a quick test, I added a shell to a hugetlb cgroup with 2 huge page
limit and started a task using huge pages.

Current behavior
----------------
ssh_to_dbg # sudo ./test_mmap 4
mapping 4 huge pages
address 7f62bba00000 read (-)
address 7f62bbc00000 read (-)
Bus error
ssh_to_dbg #

Behavior with patch
-------------------
ssh_to_dbg # sudo ./test_mmap 4
mapping 4 huge pages
address 7f62bba00000 read (-)
address 7f62bbc00000 read (-)
Connection to dbg closed by remote host.
Connection to dbf closed.

OOM did kick in (lots of console/log output) and killed the shell
as well.
-- 
Mike Kravetz
