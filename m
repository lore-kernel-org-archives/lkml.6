Return-Path: <kernel-hardening-return-12745-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu5aBLpqRvdncGBoHQVUG4ECZ0dUKELd4UhDC8SlORBhB9+4BEuLCjeqnU2QYCchNY4K5sp
ARC-Seal: i=1; a=rsa-sha256; t=1522115786; cv=none;
        d=google.com; s=arc-20160816;
        b=AvhYtH6yHb18kg2XQVdSEhksAc6s7u5T1o9OqoyzEJSyUXz70wy7HoAdvvXiZ7yFqU
         6e6VxP05/g2CsMOJMqPKXtGtb+R8puB+S0w6/GrqfAcLesByw1nBI0Kg0jOhc/TvKPWO
         IE4LEZMH6ZtKnfPepnGs1BjAU1D2zeZFNEYmCtExHjMPDMC7y8b71d8xMxNIHV++vcOD
         QFMOlt4mATQmA6HdhQW7d+1zn5K96WdO0EikO9MPijKOeCDav0xew3TAv8GTMTGalXyW
         VDhd3/lKUmaBJpT2Wd5t/XzmkP3DjuJ/ritx2t479UZ8+Bc+xKbbxMPlbkndXD7pE7pZ
         hRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=8fA3U4MusqQItlxYQ8S3f+8kWLQAiQdGHvLh57zuolk=;
        b=cowPum9UJDCnvbo3HQIW0eK/PWaojP4lfGEByCAmQJ4sXmbFL4uL/NdI2c6aYdMk/r
         gBA09ma6R58Sod3HXllbC0iZ9KdR7tpE1PZRhoQcyr9f2fpp0ND9AOG1D64+7l5A4H7v
         7UxwmtbxYl3CA26wfdX+/xkyztMOk8Hh3B5fzuzbrjfRqvoKcgITM7cGSz9RbPqfDKF6
         ZuuATnQIV2gsVFUm/ZsCXgUjfOTJCB5xpRNyiqcCOxz0OP0AEBCfGj9SqJJYe0EJj5/N
         SOaZTrmdwLASwcUapQbYQYyMRBl+ehaKSfFAWs2WUAY8pKwGFn4TR2n61p0xxkk6cOmV
         WmXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12745-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12745-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12745-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12745-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>
CC: <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>,
	<igor.stoppa@gmail.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [RFC PATCH v20 0/6] mm: security: ro protection for dynamic data
Date: Tue, 27 Mar 2018 04:55:18 +0300
Message-ID: <20180327015524.14318-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596054083470028884?=
X-GMAIL-MSGID: =?utf-8?q?1596054083470028884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch-set introduces the possibility of protecting memory that has
been allocated dynamically.

The memory is managed in pools: when a memory pool is protected, all the
memory that is currently part of it, will become R/O.

A R/O pool can be expanded (adding more protectable memory).
It can also be destroyed, to recover its memory, but it cannot be
turned back into R/W mode.

This is intentional. This feature is meant for data that doesn't need
further modifications after initialization.

However the data might need to be released, for example as part of module
unloading. The pool, therefore, can be destroyed.

An example is provided, in the form of self-testing.

Changes since v19:

[http://www.openwall.com/lists/kernel-hardening/2018/03/13/68]

* dropped genalloc as allocator
* first attempt at rewriting pmalloc, as discussed with Matthew Wilcox:
  [http://www.openwall.com/lists/kernel-hardening/2018/03/14/20]
* removed free function from the API
* removed distinction between protected and unprotected pools: a pool can
  contain both protectec and unprotected areas.
* removed gpf parameter, as it didn't seem too useful (or not?)
* added option to specify alignment of allocations
* added parameter for specifying size of a refill
* removed option to pre-allocate memory for a pool (is it a bad idea?)
* changed vmap_area to allow chaining them, for tracking them in a pool
* made public the previously private find_vmap_area function

Igor Stoppa (6):
  struct page: add field for vm_struct
  vmalloc: rename llist field in vmap_area
  Protectable Memory
  Pmalloc selftest
  lkdtm: crash on overwriting protected pmalloc var
  Documentation for Pmalloc

 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 101 ++++++++++++
 drivers/misc/lkdtm.h               |   1 +
 drivers/misc/lkdtm_core.c          |   3 +
 drivers/misc/lkdtm_perms.c         |  28 ++++
 include/linux/mm_types.h           |   1 +
 include/linux/pmalloc.h            | 281 ++++++++++++++++++++++++++++++++
 include/linux/test_pmalloc.h       |  24 +++
 include/linux/vmalloc.h            |   5 +-
 init/main.c                        |   2 +
 mm/Kconfig                         |  16 ++
 mm/Makefile                        |   2 +
 mm/pmalloc.c                       | 321 +++++++++++++++++++++++++++++++++++++
 mm/test_pmalloc.c                  | 136 ++++++++++++++++
 mm/usercopy.c                      |  33 ++++
 mm/vmalloc.c                       |  10 +-
 16 files changed, 960 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/core-api/pmalloc.rst
 create mode 100644 include/linux/pmalloc.h
 create mode 100644 include/linux/test_pmalloc.h
 create mode 100644 mm/pmalloc.c
 create mode 100644 mm/test_pmalloc.c

-- 
2.14.1
