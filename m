Return-Path: <kernel-hardening-return-12766-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtjzyvz2SOdCKcAnBA8X41bkV4YGo45RTc4Uuq34dD90kZMGIanRWad1vpjCRv7AaGw6Mtw
ARC-Seal: i=1; a=rsa-sha256; t=1522165118; cv=none;
        d=google.com; s=arc-20160816;
        b=uiTKcXdQpJZAnBNdTXSjzlRLi2J6w9AWJiGUERoSqQqSAzsevgOCGjmIIh+YQwB4YT
         P4jx93wJ4i3wTWorAx3HW4O+pYshM/VwTJbG4oTZ4Gc2Joa4TjFyBjLFZSEWi/2BavUa
         ZPEfXEjR7AB1SeS9H/aDCdgq24ipBeGpkQfgBOsfrIXRmiPGsPdu7k2EBMcNTfmQzU67
         pNhvEulVWOsIXJkO/w2UudW4ts0+A6jFLyS4+7wxVFxw3tarFT6ZCstMA/eCu2k1JSQR
         T3qi7ZxMNj35q6vSooDoSZco+ufLOikuCc/JpAervrVGEOqJWAxoviaQcYwiN0SOO5Gh
         tdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=oPq+COxaiYMwEjctFPcEkc0a9Du0nzCPWUhSYTXvpXQ=;
        b=GK+Wul0497MxRkn6cmoTTk6OFSwJMF1Fk+ZIef7UbcqXk7OR32DEhMzyJpW43EC4JW
         HyaBJHfS/S5RqrBIBVnetx6jbcV2vHLJa287mt1eIHESpsaNu60K6i5FPKmVetJ1tVL0
         rMQ2N8D5tPVdO9yBGOtn8n5k8xzHmZwfh9O7Wb+DEcEd9rgvi8LVQViVXaH67S/P1FzD
         bv0A+n8UP+cQb7hcIKEjCnl2mPPnzddbaOO3YCYSjvVlFQZey5c3zNmRyme774W2PlzA
         NfSvVOpQDewmVdO10NW6bBX2nQvoZwUaBknc1c5cwpcilhFQ4Li0O5e5+9ANj4R9tP04
         10Og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12766-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12766-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12766-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12766-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [RFC PATCH v21 0/6] mm: security: ro protection for dynamic data
Date: Tue, 27 Mar 2018 18:37:36 +0300
Message-ID: <20180327153742.17328-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596105811324274585?=
X-GMAIL-MSGID: =?utf-8?q?1596105811324274585?=
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

Changes since v20:

[http://www.openwall.com/lists/kernel-hardening/2018/03/27/2]

* removed the align_order parameter from allocation functions
* improved documentation with more explanation
* fixed lkdt test
* reworked the destroy function, removing a possible race with
  use-after-free code.


Igor Stoppa (6):
  struct page: add field for vm_struct
  vmalloc: rename llist field in vmap_area
  Protectable Memory
  Pmalloc selftest
  lkdtm: crash on overwriting protected pmalloc var
  Documentation for Pmalloc

 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 107 +++++++++++++++
 drivers/misc/lkdtm.h               |   1 +
 drivers/misc/lkdtm_core.c          |   3 +
 drivers/misc/lkdtm_perms.c         |  25 ++++
 include/linux/mm_types.h           |   1 +
 include/linux/pmalloc.h            | 166 +++++++++++++++++++++++
 include/linux/test_pmalloc.h       |  24 ++++
 include/linux/vmalloc.h            |   5 +-
 init/main.c                        |   2 +
 mm/Kconfig                         |  16 +++
 mm/Makefile                        |   2 +
 mm/pmalloc.c                       | 264 +++++++++++++++++++++++++++++++++++++
 mm/test_pmalloc.c                  | 136 +++++++++++++++++++
 mm/usercopy.c                      |  33 +++++
 mm/vmalloc.c                       |  10 +-
 16 files changed, 791 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/core-api/pmalloc.rst
 create mode 100644 include/linux/pmalloc.h
 create mode 100644 include/linux/test_pmalloc.h
 create mode 100644 mm/pmalloc.c
 create mode 100644 mm/test_pmalloc.c

-- 
2.14.1
