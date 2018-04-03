Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AIpwx491whG4IjeCTdCmx8nkm8mXXdKaHCIG2PFZZ1km3sJ2nImP0Jfi6Ry4zjeo2FF/NS40qzbh
ARC-Seal: i=1; a=rsa-sha256; t=1522779427; cv=none;
        d=google.com; s=arc-20160816;
        b=rTrG/+GGn0U212Owi/xf0exhZJXisx0F9bJow6/p6zl29ZiiSP9CH2Dw2ohXbLZJqP
         08/BbIGDifwm9PQMmCD7OLBePqH2IRmZQKnA04Q1KBcgzz+doNC74f9jJ2IzCdQjiyTk
         9R9ctOPklJm0+FWnCpYOMDlOCg4NwHCWiG5rvDa+2cA8uuEK7Ux1qO4B/UDNWQcQYSKU
         gUiyS/KJ0l7kAqvBGIt52NePXOM9Oi7gPVPuIDbLbXpKRYZHQ3hccp1XiVc540699jqq
         48IpZTlTFuEfCXGBqZFb57df7j1jOtEWL1EvAEM7ednuh9JWlQQI5K2LSU3hZl8+JcPa
         cXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=Noc6Uoe2FT5hJdDfDuefKeSCNneo678QW5oj4BEkqpA=;
        b=FnCKuJcYxdAnge1y0lJ8FRM2IkrAtZQcWhhxey2Nq/HnQSM31ga3hHpvb6+Xv4T/+i
         jb76qZKGnT+++ydhPoJn0fFB1iF+tk0wI1PrzcmScaUSJ3hTIf8lDOd9f1hS5c+WaJvY
         q47K07RfRpMgYvLqUVYsHWLMRRoijKCv4Z/Tl5N4Crn1CDcFDWNOyJao7Tg5gLZCU3qU
         CQneLoYvP6J/HI3PC7T04N0Kos0bYm07IaQ54igOeI71bLGZHhYgrxnR77s8O78YX7sZ
         Y4ri3A+NlbK4HAqUgWso6KWjSoUOVm6Qd04z8JkDlVD0JQ1iv0VQ2FrlwwnZVe+nAAy3
         /Zuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Rf5pxT9h;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Rf5pxT9h;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com, alexander.levin@microsoft.com
Subject: [v6 0/6] optimize memory hotplug
Date: Tue,  3 Apr 2018 14:16:37 -0400
Message-Id: <20180403181643.28127-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030185
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596749960988119864?=
X-GMAIL-MSGID: =?utf-8?q?1596749960988119864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changelog:
	v6 - v5
	- Improved "mm: add uninitialized struct page poisoning sanity
	  checking". Fixed __dump_page() to detect that page is poisoned.
	  This should fix a panic printing issue reported by Sasha Levin.

	v5 - v4
	- Addressed more comments from Ingo Molnar and Michal Hocko.
	- In the patch "optimize memory hotplug" we are now using
	  struct memory_block to hold node id as suggested by Michal.
	- In the patch "don't read nid from struct page during hotplug"
	  renamed register_new_memory() to hotplug_memory_register() as
	  suggested by Ingo. Also, in this patch replaced the
	  description with the one provided by Michal.
	- Fixed other spelling issues found by Ingo.

	v3 - v4
	Addressed comments from Ingo Molnar and from Michal Hocko
	Split 4th patch into three patches
	Instead of using section table to save node ids, saving node id in
	the first page of every section.

	v2 - v3
	Fixed two issues found during testing
	Addressed Kbuild warning reports

	v1 - v2
	Added struct page poisoning checking in order to verify that
	struct pages are never accessed until initialized during memory
	hotplug

This patchset:
- Improves hotplug performance by eliminating a number of
struct page traverses during memory hotplug.

- Fixes some issues with hotplugging, where boundaries
were not properly checked. And on x86 block size was not properly aligned
with end of memory

- Also, potentially improves boot performance by eliminating condition from
  __init_single_page().

- Adds robustness by verifying that that struct pages are correctly
  poisoned when flags are accessed.

The following experiments were performed on Xeon(R)
CPU E7-8895 v3 @ 2.60GHz with 1T RAM:

booting in qemu with 960G of memory, time to initialize struct pages:

no-kvm:
	TRY1		TRY2
BEFORE:	39.433668	39.39705
AFTER:	36.903781	36.989329

with-kvm:
BEFORE:	10.977447	11.103164
AFTER:	10.929072	10.751885

Hotplug 896G memory:
no-kvm:
	TRY1		TRY2
BEFORE: 848.740000	846.910000
AFTER:  783.070000	786.560000

with-kvm:
	TRY1		TRY2
BEFORE: 34.410000	33.57
AFTER:	29.810000	29.580000

Pavel Tatashin (6):
  mm/memory_hotplug: enforce block size aligned range check
  x86/mm/memory_hotplug: determine block size based on the end of boot
    memory
  mm: add uninitialized struct page poisoning sanity checking
  mm/memory_hotplug: optimize probe routine
  mm/memory_hotplug: don't read nid from struct page during hotplug
  mm/memory_hotplug: optimize memory hotplug

 arch/x86/mm/init_64.c      | 33 +++++++++++++++++++++++++++++----
 drivers/base/memory.c      | 40 ++++++++++++++++++++++------------------
 drivers/base/node.c        | 24 +++++++++++++++++-------
 include/linux/memory.h     |  3 ++-
 include/linux/mm.h         |  4 +++-
 include/linux/node.h       |  4 ++--
 include/linux/page-flags.h | 22 +++++++++++++++++-----
 mm/debug.c                 | 14 +++++++++++---
 mm/memblock.c              |  2 +-
 mm/memory_hotplug.c        | 44 +++++++++++++++++---------------------------
 mm/page_alloc.c            | 28 ++++++++++------------------
 mm/sparse.c                |  8 +++++++-
 12 files changed, 138 insertions(+), 88 deletions(-)

-- 
2.16.3
