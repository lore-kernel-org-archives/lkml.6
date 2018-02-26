Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeBZQCb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:02:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46066 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbeBZQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:02:29 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@oracle.com, jgross@suse.com, akataria@vmware.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        boris.ostrovsky@oracle.com, akpm@linux-foundation.org, mhocko@suse.com,
        vbabka@suse.cz, luto@kernel.org, labbott@redhat.com,
        kirill.shutemov@linux.intel.com, bp@suse.de, minipli@googlemail.com,
        jinb.park7@gmail.com, dan.j.williams@intel.com, bhe@redhat.com,
        zhang.jia@linux.alibaba.com, mgorman@techsingularity.net,
        hannes@cmpxchg.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org
Subject: [v2 0/1] Allow deferred page initialization for xen pv domains
Date: Mon, 26 Feb 2018 11:01:11 -0500
Message-Id: <20180226160112.24724-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=926
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802260213
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v1 - v2
- Addressed coomment from Juergen Gross: fixed a comment, and moved
  after_bootmem from PV framework to x86_init.hyper.

>From this discussion:
https://www.spinics.net/lists/linux-mm/msg145604.html

I investigated whether it is feasible to re-enable deferred page
initialization on xen's para-vitalized domains. After studying the
code, I found non-intrusive way to do just that.

All we need to do is to assume that page-table's pages are pinned early in
boot, which is always true, and add a new x86_init.hyper OP call to notify
guests that boot allocator is finished, so we can set all the necessary
fields in already initialized struct pages.

I have tested this on my laptop with 64-bit kernel, but I would appreciate
if someone could provide more xen testing.

Apply against: linux-next. Enable the following configs:

CONFIG_XEN_PV=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
The above two are needed to test deferred page initialization on PV Xen
domains. If fix is applied correctly, dmesg should output line(s) like this
during boot:
[    0.266180] node 0 initialised, 717570 pages in 36ms

CONFIG_DEBUG_VM=y
This is needed to poison struct page's memory, otherwise it would be all
zero.

CONFIG_DEBUG_VM_PGFLAGS=y
Verifies that we do not access struct pages flags while memory is still
poisoned (struct pages are not initialized yet).

Pavel Tatashin (1):
  xen, mm: Allow deferred page initialization for xen pv domains

 arch/x86/include/asm/x86_init.h |  2 ++
 arch/x86/kernel/x86_init.c      |  1 +
 arch/x86/mm/init_32.c           |  1 +
 arch/x86/mm/init_64.c           |  1 +
 arch/x86/xen/mmu_pv.c           | 38 ++++++++++++++++++++++++++------------
 mm/page_alloc.c                 |  4 ----
 6 files changed, 31 insertions(+), 16 deletions(-)

-- 
2.16.2
