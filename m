Return-Path: <kernel-hardening-return-11572-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224xCa9ZjeKwSXcjwnABu1qJ22MWe/i7gXbRuyX3W6nTD1R+RilsphCqj/NhgR38ocX6kNaH
ARC-Seal: i=1; a=rsa-sha256; t=1517762902; cv=none;
        d=google.com; s=arc-20160816;
        b=UsoGZJOMaqKU5Z26rffTy9Z2DV9HD35XYjJZug0/qAILDEFP1FyJxJLsYqn2aCyqqe
         7sfW3C1Gpyr3fUnWMRkzVFo5CXqMwgWpwSCzX/wtE9iLlSVuFniikXNmyh2ynOE6B9am
         xU4+gx+W741XA9wDq6HtJe0El4XhvtiklfG3L5UD1U4yJKm6qwNE3awzCq74FYSgVhvD
         J2HkNhUI/ltvaGaBC9NPqvYsIw1PF35hhmRDQp8Xc5TPR9z5kwgkNevJ36AifB3JjkY/
         t9cLr53oOI3c6AjdXUijtICDutpYnemJQTnwazsKTWJaueyioUu4t19N5f1S/1/XFjNV
         bbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=1Kf6gmx6PAE0YsOy/iq4CT3Vsn7xEZI5fuoW+PTOpK4=;
        b=Hi9xhv0Kq3D2lNUraNHl7RuGJNPWma8xvDyk1YkHqVef6xQ0OmbBbWpzIhCAnsIZND
         j/oPUw++vSXhdBjclNNx46K1k6AzILUFMxRZC90wDX2K54gkqxrAjKlATHTGYHfanPCT
         o1tPvyJIcaP5tM0xaBZ/4bIf3psot42FiphSG36A0CvCajGzRiBMEotmEl9lKRTc868H
         N03Mza6juq+xV0JyGbQUKIC0JVJ+wSW5FbiDSKc1NXSv2H/eiFzQ/r9w05lf8tUXRsNP
         RAkMjwPwdhS/IVoMDxulORiTsVjD74NHaZ1rcxqOsEz8dnYi3wrga3lyqW+O4T7LKEZE
         oPGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11572-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11572-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11572-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11572-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <jglisse@redhat.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <hch@infradead.org>, <willy@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [RFC PATCH v14 0/6] mm: security: ro protection for dynamic data
Date: Sun, 4 Feb 2018 18:47:26 +0200
Message-ID: <20180204164732.28241-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.16.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489753647484167?=
X-GMAIL-MSGID: =?utf-8?q?1591489753647484167?=
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

Changes since v13:
[http://www.openwall.com/lists/kernel-hardening/2018/02/03/3]

- fixed warnings from "make htmldocs"
- added documentation to core-api index


Igor Stoppa (6):
  genalloc: track beginning of allocations
  genalloc: selftest
  struct page: add field for vm_struct
  Protectable Memory
  Pmalloc: self-test
  Documentation for Pmalloc

 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 114 ++++++++
 include/linux/genalloc-selftest.h  |  30 +++
 include/linux/genalloc.h           |   7 +-
 include/linux/mm_types.h           |   1 +
 include/linux/pmalloc.h            | 213 +++++++++++++++
 include/linux/vmalloc.h            |   1 +
 init/main.c                        |   2 +
 lib/Kconfig                        |  15 ++
 lib/Makefile                       |   1 +
 lib/genalloc-selftest.c            | 402 +++++++++++++++++++++++++++++
 lib/genalloc.c                     | 444 ++++++++++++++++++++++----------
 mm/Kconfig                         |   9 +
 mm/Makefile                        |   2 +
 mm/pmalloc-selftest.c              |  61 +++++
 mm/pmalloc-selftest.h              |  26 ++
 mm/pmalloc.c                       | 514 +++++++++++++++++++++++++++++++++++++
 mm/usercopy.c                      |  25 +-
 mm/vmalloc.c                       |  18 +-
 19 files changed, 1745 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/core-api/pmalloc.rst
 create mode 100644 include/linux/genalloc-selftest.h
 create mode 100644 include/linux/pmalloc.h
 create mode 100644 lib/genalloc-selftest.c
 create mode 100644 mm/pmalloc-selftest.c
 create mode 100644 mm/pmalloc-selftest.h
 create mode 100644 mm/pmalloc.c

-- 
2.16.0
