Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeERE1w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 00:27:52 -0400
Received: from ext-host0001.ascade.co.jp ([218.224.228.194]:61196 "EHLO
        ns.ascade.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbeERE1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 00:27:51 -0400
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Marc-Andre Lureau <marcandre.lureau@redhat.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org, tsukada@ascade.co.jp
From: TSUKADA Koutaro <tsukada@ascade.co.jp>
Subject: [PATCH v2 0/7] mm: pages for hugetlb's overcommit may be able to
 charge to memcg
Message-ID: <e863529b-7ce5-4fbe-8cff-581b5789a5f9@ascade.co.jp>
Date: Fri, 18 May 2018 13:27:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Mike Kravetz for comment on the previous version patch.

The purpose of this patch-set is to make it possible to control whether or
not to charge surplus hugetlb pages obtained by overcommitting to memory
cgroup. In the future, I am trying to accomplish limiting the memory usage
of applications that use both normal pages and hugetlb pages by the memory
cgroup(not use the hugetlb cgroup).

Applications that use shared libraries like libhugetlbfs.so use both normal
pages and hugetlb pages, but we do not know how much to use each. Please
suppose you want to manage the memory usage of such applications by cgroup
How do you set the memory cgroup and hugetlb cgroup limit when you want to
limit memory usage to 10GB?

If you set a limit of 10GB for each, the user can use a total of 20GB of
memory and can not limit it well. Since it is difficult to estimate the
ratio used by user of normal pages and hugetlb pages, setting limits of 2GB
to memory cgroup and 8GB to hugetlb cgroup is not very good idea. In such a
case, I thought that by using my patch-set, we could manage resources just
by setting 10GB as the limit of memory cgoup(there is no limit to hugetlb
cgroup).

In this patch-set, introduce the charge_surplus_huge_pages(boolean) to
struct hstate. If it is true, it charges to the memory cgroup to which the
task that obtained surplus hugepages belongs. If it is false, do nothing as
before, and the default value is false. The charge_surplus_huge_pages can
be controlled procfs or sysfs interfaces.

Since THP is very effective in environments with kernel page size of 4KB,
such as x86, there is no reason to positively use HugeTLBfs, so I think
that there is no situation to enable charge_surplus_huge_pages. However, in
some distributions such as arm64, the page size of the kernel is 64KB, and
the size of THP is too huge as 512MB, making it difficult to use. HugeTLBfs
may support multiple huge page sizes, and in such a special environment
there is a desire to use HugeTLBfs.

The patch set is for 4.17.0-rc3+. I don't know whether patch-set are
acceptable or not, so I just done a simple test.

Thanks,
Tsukada

TSUKADA Koutaro (7):
  hugetlb: introduce charge_surplus_huge_pages to struct hstate
  hugetlb: supports migrate charging for surplus hugepages
  memcg: use compound_order rather than hpage_nr_pages
  mm, sysctl: make charging surplus hugepages controllable
  hugetlb: add charge_surplus_hugepages attribute
  Documentation, hugetlb: describe about charge_surplus_hugepages
  memcg: supports movement of surplus hugepages statistics

 Documentation/vm/hugetlbpage.txt |    6 +
 include/linux/hugetlb.h          |    4 +
 kernel/sysctl.c                  |    7 +
 mm/hugetlb.c                     |  148 +++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c                  |  109 +++++++++++++++++++++++++++-
 5 files changed, 269 insertions(+), 5 deletions(-)

-- 
Tsukada
