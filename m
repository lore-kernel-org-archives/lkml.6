Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x225UzB4h85q5I67C9IlZU29iQ1YhA0cwjeWUtfSA2SFW58NUe4x1icA8Dbkj+caFqdsl+/CG
ARC-Seal: i=1; a=rsa-sha256; t=1518713982; cv=none;
        d=google.com; s=arc-20160816;
        b=thJL5tS4NKG31iZ3Ss6WX6tEslKmIwskWNHpSkxgON/OnLf5NcYcRj/vD4/2OlyYZf
         PQCwPw9zKXInMzxev0d3fMmsCN2IHjCGyMhLzTRXezS8lu2zlPB9KElzkkuIvGBsJhe5
         1r2vMYXAL+EwTQcQ/O4lGbPQD5lCR5cgLXWosZ6fOR0SVpVKVXmJm+vw1/y5Bcq3ahxS
         7/EJH9MTQgNM27jT4BYVHOkM10Rbr+9L81xAM2MRiykAALk+txc07VWrl9RIl2c7K0mR
         nnOJIFNp4xH5bjL9mRX8UqbiOOpPiNauTQQuwGjs3XHgApntRDuupbIQDHuUVGbHFam1
         /Wqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=SOQz10HVteTzZxyN4bNZPRm+egG9LAy9hLapnf09dOM=;
        b=iF6evZYX+y5wC/6Azy6hWdyF56A3I8/qgDaM3ai7HujQMW6JYMTvRaqPQOt0Org0hy
         dlOtGF0sQM1KCMXbMwkTCr/LtiBXDQ+8sYuiMXxHYe9RR0FfLGruL6Lpvc+hmiLIZGhV
         pX+GYOSQQlt1YjssL3MUpfrvAmjGj+eZ6G/iQlGAW7o8SH9TA4O1wDFPPRnIHwfuJO14
         g9lVODMJk4SJUmStw6xaNtgwooI1RFqzOx8yPmkndWuMRYiUdr3xYgxiJG85XMukM9W5
         UjPURmg0ALWA6Qbh+QJsFw/HzICi5kZiLWuSxQSNRYY8P/SON7GKnoISctA80lLD0FTT
         24Og==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LtNfz8Yd;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LtNfz8Yd;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [v4 0/6] optimize memory hotplug
Date: Thu, 15 Feb 2018 11:59:14 -0500
Message-Id: <20180215165920.8570-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=572
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150205
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592487033227290538?=
X-GMAIL-MSGID: =?utf-8?q?1592487033227290538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changelog:
	v3 - v4
	Addressed comments from Ingo Molnar and from Michal Hocko
	Splitted 4th patch into three patches
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

Pavel Tatashin (6):
  mm/memory_hotplug: enforce block size aligned range check
  x86/mm/memory_hotplug: determine block size based on the end of boot
    memory
  mm: uninitialized struct page poisoning sanity checking
  mm/memory_hotplug: optimize probe routine
  mm/memory_hotplug: don't read nid from struct page during hotplug
  mm/memory_hotplug: optimize memory hotplug

 arch/x86/mm/init_64.c      | 33 +++++++++++++++++++++++++++++----
 drivers/base/memory.c      | 38 +++++++++++++++++++++-----------------
 drivers/base/node.c        | 22 +++++++++++++++-------
 include/linux/mm.h         |  4 +++-
 include/linux/node.h       |  4 ++--
 include/linux/page-flags.h | 22 +++++++++++++++++-----
 mm/memblock.c              |  2 +-
 mm/memory_hotplug.c        | 36 ++++++++++++++----------------------
 mm/page_alloc.c            | 28 ++++++++++------------------
 mm/sparse.c                |  9 ++++++++-
 10 files changed, 120 insertions(+), 78 deletions(-)

-- 
2.16.1
