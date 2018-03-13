Return-Path: <kernel-hardening-return-12552-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvFZkqtBwUX0WeyeprfL8ztl+om7QbicR7eZUYgvGFMVPcmmykwLpxdxHc6IFuYu4nPDGRz
ARC-Seal: i=1; a=rsa-sha256; t=1520977639; cv=none;
        d=google.com; s=arc-20160816;
        b=V3PKUGHQfpmfUosSmq1sgxLRIYJwE2mhT/5axMtoG7iH7ZW69FPTJ/PBSKKbl2hpHh
         PbSa74FHngv/TYukqvvhlBGMYC5Nuh/3mDK1RdCzMnlB2accGqB0PFWNoZ1HtzPAQ+YK
         CtaC+9GlFg9s7aghO4iOB37GuaxWb5540aHZpAheeDCx1N7JRB2XxWdz1Xa/FUqKprgK
         tqDqSxU17HW+GKeqnyRW0TDjyhKEhjk18WjJSlqNF6fcfGi4cCnZzS4254aHLsk/SK3G
         vVGGBXL7dwMLahrx0qdlAlN4bX2MbpDPuWrpr8J7K2ask8SmVh+FemEk7XW2Z4iXOxVJ
         7N4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=YUnOBgn7cEFzX6W8/Al+7BDebc644rxBHnUzqagykeU=;
        b=n3OJqb+pNsPbxrKzGmPvKDPk5SVFhNdEkXs/hRaFpSKozqmNwpFzFcbnNFE8qmAy39
         p0NsrhTahHIcX2oXvqU1+6mGELXwrXIGbMLsFzJYyZ8bWLBte8ylqCbBa8B4HzYz7NIZ
         CR73lCpVzszqFUJ8jUWE/Nf7U7vv7i2GJmDgZ73ZazK8CQpYteQtkrDlhTP+Qxl+H1IK
         XiZ8hLaRTzaVyIPfvTcGYKiPjweIsaB/tiD9x8fLWGBd96P+ONb/rpX0uEpncer+CRR5
         1wl53s0ZTX+cr6TvkumpZiwtxdA670D0wvCRwR997RCocW+Cx87ZqNHl3yLw6euyctYa
         ptdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12552-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12552-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12552-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12552-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <david@fromorbit.com>, <willy@infradead.org>, <rppt@linux.vnet.ibm.com>,
	<keescook@chromium.org>, <mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [RFC PATCH v19 0/8] mm: security: ro protection for dynamic data
Date: Tue, 13 Mar 2018 23:45:46 +0200
Message-ID: <20180313214554.28521-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860649725336168?=
X-GMAIL-MSGID: =?utf-8?q?1594860649725336168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch-set introduces the possibility of protecting memory that has
been allocated dynamically.

The memory is managed in pools: when a memory pool is turned into R/O,
all the memory that is part of it, will become R/O.

A R/O pool can be destroyed, to recover its memory, but it cannot be
turned back into R/W mode.

This is intentional. This feature is meant for data that doesn't need
further modifications after initialization.

However the data might need to be released, for example as part of module
unloading.
To do this, the memory must first be freed, then the pool can be destroyed.

An example is provided, in the form of self-testing.

Changes since v18:

[http://www.openwall.com/lists/kernel-hardening/2018/02/28/21]

* Code refactoring in pmalloc & genalloc:
  - simplify the logic for handling pools before and after sysf init
  - reduced section holding mutex on pmalloc list, when adding a pool
  - reduced the steps in finding length of an existing allocation
  - split various functions into smaller ones
* clarified in the comments the need for pfree()
* Various fixes to the documentation:
  - remove kerneldoc duplicates
  - added cross-reference lables
  - miscellaneous typos
* improved error notifications: use WARNs with specific messages
* added missing tests for possible error conditions


Discussion topics that are unclear if they are closed and would need
comment from those who initiated them, if my answers are accepted or not:

* @Kees Cook proposed to have first self testing for genalloc, to
  validate the following patch, adding tracing of allocations
  My answer was that such tests would also need patching, therefore they 
  could not certify that the functionality is corect both before and
  after the genalloc bitmap modification.

* @Kees Cook proposed to turn the self testing into modules.
  My answer was that the functionality is intentionally tested very early
  in the boot phase, to prevent unexplainable errors, should the feature
  really fail.

* @Matthew Wilcox proposed to use a different mechanism for th genalloc
  bitmap: 2 bitmaps, one for occupation and one for start.
  And possibly use an rbtree for the starts.
  My answer was that this solution is less optimized, because it scatters
  the data of one allocation across multiple words/pages, plus is not
  a transaction anymore. And the particular distribution of sizes of
  allocation is likely to eat up much more memory than the bitmap.

Igor Stoppa (8):
  genalloc: track beginning of allocations
  Add label to genalloc.rst for cross reference
  genalloc: selftest
  struct page: add field for vm_struct
  Protectable Memory
  Pmalloc selftest
  lkdtm: crash on overwriting protected pmalloc var
  Documentation for Pmalloc

 Documentation/core-api/genalloc.rst |   2 +
 Documentation/core-api/index.rst    |   1 +
 Documentation/core-api/pmalloc.rst  | 111 ++++++
 drivers/misc/lkdtm.h                |   1 +
 drivers/misc/lkdtm_core.c           |   3 +
 drivers/misc/lkdtm_perms.c          |  28 ++
 include/linux/genalloc.h            | 116 +++---
 include/linux/mm_types.h            |   1 +
 include/linux/pmalloc.h             | 163 ++++++++
 include/linux/test_genalloc.h       |  26 ++
 include/linux/test_pmalloc.h        |  24 ++
 include/linux/vmalloc.h             |   1 +
 init/main.c                         |   4 +
 lib/Kconfig                         |  15 +
 lib/Makefile                        |   1 +
 lib/genalloc.c                      | 765 ++++++++++++++++++++++++++----------
 lib/test_genalloc.c                 | 410 +++++++++++++++++++
 mm/Kconfig                          |  17 +
 mm/Makefile                         |   2 +
 mm/pmalloc.c                        | 643 ++++++++++++++++++++++++++++++
 mm/test_pmalloc.c                   | 238 +++++++++++
 mm/usercopy.c                       |  33 ++
 mm/vmalloc.c                        |   2 +
 23 files changed, 2352 insertions(+), 255 deletions(-)
 create mode 100644 Documentation/core-api/pmalloc.rst
 create mode 100644 include/linux/pmalloc.h
 create mode 100644 include/linux/test_genalloc.h
 create mode 100644 include/linux/test_pmalloc.h
 create mode 100644 lib/test_genalloc.c
 create mode 100644 mm/pmalloc.c
 create mode 100644 mm/test_pmalloc.c

-- 
2.14.1
