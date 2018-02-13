Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x2243EXrMM5e5j/UUhYiW0g+JXPzSaKl9jDRCzyShwphh6alluinFEmcVWBgTS7/Hw+w1Xa83
ARC-Seal: i=1; a=rsa-sha256; t=1518550344; cv=none;
        d=google.com; s=arc-20160816;
        b=nzQnLg9aOGJETJYEejHGhnKKsduYtGMa781qgyCvusEFiG9l7iFDtP+QiIWG9W4aB+
         Tya7+L3Msusw1SBn+8Npg9pplvzVkqYbXTRnxRr1R+O9Uu8SGKs7whhjtPKPuuj39q9I
         ohdF7V9QpmwXhAAEQxYYs/Px/DUGWMIQ3aH1Ghbiex9RgXae6QoE3hpaPZz7A5awWePP
         HF6tNkyYv61FIRA7sEH8oFji52ZyKPhrYxp3NlrZ/fokASM9SN0fL5xblK25HSrNW0F+
         0RnJgjefMTL8C/dBV3LVNlzgz4VtL3iRpTV9mxYf8Opjji6k2Wm3Hqq5LqkQcIcTOeqP
         +Drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=nvUhYGMJLoBT+cewwV4lzYQ36ANH/VrgQ2+leEXSxhw=;
        b=foMCcnHESjqK5Vj6Zg8veM/k1YtkcNQ7tL0a6QW677F4NGojhtEKyzGe4bJRf84lsa
         8S7akDWAMnn5bGpAliOt8USjdwKmKTKLM/udrpAOxYPqNlet/S5gKYQL8+lFxwj0ODL/
         VaigiL0AZevQaHt1Iakl5vr1sXiBy0vpEecl5ysQqhDfw+c6BgPHvKVdoqqMwPx/es4W
         Dk9JOJ+/xisTvnIgk+eSAE6zdtqb4rmGi8pJjtsWZq1bEn6qYS28X/DHzKBGxrpK9fKU
         N1jNEwragsjtxTCxVJLI7qsEKNzUfhDfo8L8icE342qJu+fUbXhKW7QV5zdTdkK2MegA
         ebVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ivfyHniB;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ivfyHniB;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [PATCH v3 0/4] optimize memory hotplug
Date: Tue, 13 Feb 2018 14:31:55 -0500
Message-Id: <20180213193159.14606-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=594
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802130233
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446760578462?=
X-GMAIL-MSGID: =?utf-8?q?1592315446760578462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changelog:
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

The following experiments were performed on Xeon(R) CPU E7-8895 v3 @ 2.60GHz
with 1T RAM:

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

Pavel Tatashin (4):
  mm/memory_hotplug: enforce block size aligned range check
  x86/mm/memory_hotplug: determine block size based on the end of boot
    memory
  mm: uninitialized struct page poisoning sanity checking
  mm/memory_hotplug: optimize memory hotplug

 arch/x86/mm/init_64.c          | 33 +++++++++++++++++++++++++++++----
 drivers/base/memory.c          | 38 +++++++++++++++++++++-----------------
 drivers/base/node.c            | 17 ++++++++++-------
 include/linux/memory_hotplug.h |  2 ++
 include/linux/mm.h             |  4 +++-
 include/linux/node.h           |  4 ++--
 include/linux/page-flags.h     | 22 +++++++++++++++++-----
 mm/memblock.c                  |  2 +-
 mm/memory_hotplug.c            | 36 ++++++++++--------------------------
 mm/page_alloc.c                | 28 ++++++++++------------------
 mm/sparse.c                    | 29 ++++++++++++++++++++++++++---
 11 files changed, 131 insertions(+), 84 deletions(-)

-- 
2.16.1
