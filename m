Return-Path: <kernel-hardening-return-11725-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225biB3Rh/5R2ccWSHKwAwKcGmWZQtaZRN0LNj558UqSeorXgL0Gx3C/CzqZQZ7JXkGgeKoR
ARC-Seal: i=1; a=rsa-sha256; t=1518454428; cv=none;
        d=google.com; s=arc-20160816;
        b=GA2LYvw1tG0YALZtLfqOwnI+HUvWq9UNbZ1mMRaxdtH7o94wbQgqBAhpIp2uKDvjy8
         l+Bm76ecfdMydHWsS7afXQTn9Lgan9cHkg9NlazfUY6WAJ7xbWGy108ne2XZJ0WQXHHr
         gIumE5anQjtDZuIq0y03NtEmq8uvWyXegttzgQ+Yp/Vt5yK5gIei55TJEMI4M9ZkrvuW
         YQHp7E52Es+XWH/+gaszJO/WA1m6M2y1LUy9TcWTj8RUB/OwIIRhN3kOrW8KdW7sQiGy
         BG8YEc3/YKAhD6WqA1qf/GeSPzWdS0n9hLSPLjJxsUDu1JWkFS1tdLbkNXoS9/KkocmY
         Pa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=WMd+ZWs25BOmow0yV9qMvXM3VeKLLFbH8J74Kss7QZ8=;
        b=HTuGJfrT0KMg//YVM+xMpTwDG/sgquM4BzoXN5ZjtYiuC41M2/3NzW37Gp7Yr6gWcS
         32UW+Gs+n/ZkCVRAopB/DfqvLAEeCJHoHSpZ+vIMzFaG36SKhntXSz2OfRtMnS7P5w4X
         UpH7hdxrz0oYToLDD/dJB4v2Ksd3+OPUOY9Ps2ezJH+OamfgACTyPjD0RuZNSm3Q3m1o
         yhsKfc2Kwan9aTsSc8750uJNzrJ9UUPspQenVDE7bd5wN3u+o9agMLPDE6zsqwltV9V2
         /mNdUYOONmuueepbg5xmFfFxOXRSly9LmSfGBYGE1v52dijPm8jEAFJiLJ6DyWn54Iy1
         7JVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11725-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11725-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11725-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11725-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <willy@infradead.org>, <rdunlap@infradead.org>, <corbet@lwn.net>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<jglisse@redhat.com>, <hch@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [RFC PATCH v16 0/6] mm: security: ro protection for dynamic data
Date: Mon, 12 Feb 2018 18:52:55 +0200
Message-ID: <20180212165301.17933-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214870438978682?=
X-GMAIL-MSGID: =?utf-8?q?1592214870438978682?=
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

Changes since v15:
[http://www.openwall.com/lists/kernel-hardening/2018/02/11/4]

- Fixed remaining broken comments
- Fixed remaining broken "Returns" instead of "Return:" in kernel-doc
- Converted "Return:" values to lists
- Fixed SPDX license statements

Igor Stoppa (6):
  genalloc: track beginning of allocations
  genalloc: selftest
  struct page: add field for vm_struct
  Protectable Memory
  Pmalloc: self-test
  Documentation for Pmalloc

 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 114 +++++++
 include/linux/genalloc-selftest.h  |  26 ++
 include/linux/genalloc.h           |   7 +-
 include/linux/mm_types.h           |   1 +
 include/linux/pmalloc.h            | 242 ++++++++++++++
 include/linux/vmalloc.h            |   1 +
 init/main.c                        |   2 +
 lib/Kconfig                        |  15 +
 lib/Makefile                       |   1 +
 lib/genalloc-selftest.c            | 400 ++++++++++++++++++++++
 lib/genalloc.c                     | 658 +++++++++++++++++++++++++++----------
 mm/Kconfig                         |  15 +
 mm/Makefile                        |   2 +
 mm/pmalloc-selftest.c              |  64 ++++
 mm/pmalloc-selftest.h              |  24 ++
 mm/pmalloc.c                       | 501 ++++++++++++++++++++++++++++
 mm/usercopy.c                      |  33 ++
 mm/vmalloc.c                       |  18 +-
 19 files changed, 1950 insertions(+), 175 deletions(-)
 create mode 100644 Documentation/core-api/pmalloc.rst
 create mode 100644 include/linux/genalloc-selftest.h
 create mode 100644 include/linux/pmalloc.h
 create mode 100644 lib/genalloc-selftest.c
 create mode 100644 mm/pmalloc-selftest.c
 create mode 100644 mm/pmalloc-selftest.h
 create mode 100644 mm/pmalloc.c

-- 
2.14.1
