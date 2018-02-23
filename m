Return-Path: <kernel-hardening-return-11918-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvswl80sOV5S4Lc3zxd10BL5rd9OEEKAM04Wu9pTAOWwLiqZXLaZvc9nM4OFLQJH4vC54XB
ARC-Seal: i=1; a=rsa-sha256; t=1519397345; cv=none;
        d=google.com; s=arc-20160816;
        b=q+/XaZV74Och8kuTK5cj3F5DdheQBnh7AXbir89NkPGTNoZX6OwunirEbziZxRdOzM
         G+goClHWczG3Mq8ABlNbooj0rpWadzWpaRoe0VOeHtQybhOUOuC8dc43UdQtBFpOA6Kb
         kdk1/OlLwtapCAMzKc7J7w7AxjhhHPA9/mLRQVcyKjc4Yy2pOMJxWOb5uiR+Hb8yUK0R
         KNYu0ex34CifDslPOlvzNGqcJgII4gFQu4lVH8st4VvJxG/pLXeJQLLthdgp6Hopr8Pb
         cecMgY3cNgGt26yqih4ifVuZBOuQx42iRUDe+n7x/ValJh7kXv75JhkrE8G/UID9Sn3g
         opLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=0GcjjEXORGEr9n2SsRd8/YKGEwN2nAkpGapyJkBP5Qs=;
        b=CxTwspFiEnQOxNVrmMQtYTpVF5TAX0w/7kFgtthZVR55fKGO0z9YzCzqChjHn2k9Qf
         6p1uWwQRHePJgPdGw+W9DHSy2LWSE2w86gnJ3x7aWmCel8ILYzsIMqFVD7ZfUXx/7Nm2
         ouDF8w8pbwE7lYC+RCFUXgRIup4/c1S/dZS8qJKWv/Huo/3cQ3vMKhkjGNAnwaZmySr/
         6by+m2m48QxaVmc6qkxPQ6u/0Dv/220mFcrDco3vbd4uqyrishAhp8H47GWeSuqArclf
         lLfZ7FSfWl45oc5L80UhTtdNwC/BriNT7slWBryhH5mCC/BRICrXz6gMJRwF92yeY8Sb
         sTBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11918-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11918-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11918-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11918-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <david@fromorbit.com>, <willy@infradead.org>, <keescook@chromium.org>,
	<mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [RFC PATCH v17 0/7] mm: security: ro protection for dynamic data
Date: Fri, 23 Feb 2018 16:48:00 +0200
Message-ID: <20180223144807.1180-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203591446493611?=
X-GMAIL-MSGID: =?utf-8?q?1593203591446493611?=
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

Changes since v16:
[http://www.openwall.com/lists/kernel-hardening/2018/02/12/13]

* introduced lkdtm test for write protection of a variable
* added comments with rationale for use of BUG_ON() when running selftest
* converted self-tests to kernel naming patter "test_xxx.c"
* moved triggering of pmalloc self-testing to early phase of main.c
* improved summaries of genalloc and vmalloc patches
* removed example of optimization of find_vm_area because of possible bug
  in vmalloc_to_page:
[https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1617030.html]

Igor Stoppa (7):
  genalloc: track beginning of allocations
  genalloc: selftest
  struct page: add field for vm_struct
  Protectable Memory
  Pmalloc selftest
  lkdtm: crash on overwriting protected pmalloc var
  Documentation for Pmalloc

 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 114 +++++++
 drivers/misc/lkdtm.h               |   1 +
 drivers/misc/lkdtm_core.c          |   3 +
 drivers/misc/lkdtm_perms.c         |  28 ++
 include/linux/genalloc.h           |   7 +-
 include/linux/mm_types.h           |   1 +
 include/linux/pmalloc.h            | 242 ++++++++++++++
 include/linux/test_genalloc.h      |  26 ++
 include/linux/test_pmalloc.h       |  24 ++
 include/linux/vmalloc.h            |   1 +
 init/main.c                        |   4 +
 lib/Kconfig                        |  15 +
 lib/Makefile                       |   1 +
 lib/genalloc.c                     | 658 +++++++++++++++++++++++++++----------
 lib/test_genalloc.c                | 410 +++++++++++++++++++++++
 mm/Kconfig                         |  15 +
 mm/Makefile                        |   2 +
 mm/pmalloc.c                       | 499 ++++++++++++++++++++++++++++
 mm/test_pmalloc.c                  |  79 +++++
 mm/usercopy.c                      |  33 ++
 mm/vmalloc.c                       |   5 +
 22 files changed, 1999 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/core-api/pmalloc.rst
 create mode 100644 include/linux/pmalloc.h
 create mode 100644 include/linux/test_genalloc.h
 create mode 100644 include/linux/test_pmalloc.h
 create mode 100644 lib/test_genalloc.c
 create mode 100644 mm/pmalloc.c
 create mode 100644 mm/test_pmalloc.c

-- 
2.14.1
