Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELu0Bjx3KGU9wjgNvCKa6/RuImE3va1zCHH0F7kAml6Jr9V45/EtcddizHINY1XPjdJiL6e6
ARC-Seal: i=1; a=rsa-sha256; t=1519787011; cv=none;
        d=google.com; s=arc-20160816;
        b=DEagk5cjPENnY6Pn9Uv86vM5eJarJXpjoOnENq3s34h/LtikX9Ss+Il4i3z+vNe4Ar
         nixrPEJW0YsjvBxLGyMS/JJRsj1U7rpnrDv8n1PqM/F6v/sNUaQIijdqZTNIBB9B2KL2
         JdWBcCfRb+gfh4nkRJ/L/VQd4R+Ua8dwlVQk/HEVXoIn+z2HHkVrjEkqoYKfUNHzxZ2k
         4QHpXB/XaILlNUBW0j/THrpYvyVBzk9iHyzVm0R0ENxl+0vojv3go2WQy4w6zh96f+YV
         ZFBbvyTLV6RARB2IOgBwwhX89QRVsiMrdJcAV9xVqipTiTVrejo1m6XC93piyZICBJTm
         i6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=ahhR1X13KhHU9hX320FszCz5w/ufXT2ZCOBwMjML0SU=;
        b=tq8b7neL6pkgcL9o9+d8bcPkHSTzbjnACQ23nzHK64Y5GjyK+XYa7619thI1Xfor4q
         2CG+mO/gUBb9+9ntaUKjzILMItZMpE2fu9yJCBa+F0VE3RdtlhFEtiYP+GCkT1rz1hE+
         +Ai4osOGVvS8pcIK/pdVH0765lra1HEFpNPP4l/C6tJjPezYOILWOGzVw7oy+nd0JjAB
         Cviu4CtdCDD029YFPwXT68BA7tHafWNGNx451yAdDXLWn2CN8QIRA69+QJjBq6iYo5Bc
         Y0z02tpOlswtRUcjcfI3HVsPW8QJw6XWH9kJZAc0LVVaRav8hPwjEOgQiwfpcKY22OI3
         BVXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=lE07fO5z;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=lE07fO5z;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [v5 0/6] optimize memory hotplug
Date: Tue, 27 Feb 2018 22:03:02 -0500
Message-Id: <20180228030308.1116-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=798
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593612185598129869?=
X-GMAIL-MSGID: =?utf-8?q?1593612185598129869?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changelog:
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
 mm/memblock.c              |  2 +-
 mm/memory_hotplug.c        | 44 +++++++++++++++++---------------------------
 mm/page_alloc.c            | 28 ++++++++++------------------
 mm/sparse.c                |  8 +++++++-
 11 files changed, 127 insertions(+), 85 deletions(-)

-- 
2.16.2
