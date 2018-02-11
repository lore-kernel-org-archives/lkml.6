Return-Path: <kernel-hardening-return-11696-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226JgW5/kRfRtSw1q8iGC2qDejSq6oPZQW90cz9uwiBjYXEo9FCye1qhk33I5g6O2YQS03Ae
ARC-Seal: i=1; a=rsa-sha256; t=1518319211; cv=none;
        d=google.com; s=arc-20160816;
        b=AUa9KvgjBWEdooyz3FjEwH9FVcPXQPZvTa+H8RtoJSRRIeinrQUhT36Y4Peq1goTMr
         BlM9U66SaW3JvRTFH/O5w1jkOIJY5wz2voxeVoXAIE+gQefXHyonAS4kZ23gBU7BvtC8
         w7+cVX7MPtQY9Q+Ee6JuqUkbsh6xqIqAIjHTws+BMnm4X/BglLL1FjUv7yp7e2bb1ZI7
         Em2e/xBIgNAPguFXjKD9tgJ8BMhBLzbaIbAJahsKMUzIaw1St9Ytv2ZNoJD5Oo135V6O
         4h3k6G6/HNGQO3COSj+FEPjbcr8wXxI5ZXb1Qnlm42z23IT/kHEYAN+YvEJFjwJOw8Mb
         MjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=7zMj44DR+KVPrh4isZiUKaD/8f3BK/d2CKcmY2YwjNU=;
        b=Oxw0akVuE5cSqAz1OmpwcW+1uMjPBIXQicCYUVaQWrcQjG/cTYuLRizi4e4m2ev5zt
         Da4L2yCOUUMKJ7AOx75Pkj1RMQCTRALq3tD8zyv10cpGkPoQW+/S7OmetcAwoByL9y13
         Ztmlu7zvZMUyJ11Pqo7j/aY+AKVmNwuQ5LOhW3eyWGO6mcw27tzmpgXcJii9fVoybJC4
         2+9O4sJzeCfw2JqbCM7wA7TrENVX2Tcvko1DKulzuNS9TqV4mwfdASh/b5txrk6uE0FQ
         vLM/w+ketIowjzkMj8v3ffDjou4mKEG+QjZ/kwLl0E6pKmvui/bC1JfeyqOxlaGNKtdD
         Bo3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11696-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11696-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11696-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11696-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [RFC PATCH v15 0/6] mm: security: ro protection for dynamic data
Date: Sun, 11 Feb 2018 05:19:14 +0200
Message-ID: <20180211031920.3424-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073085229547021?=
X-GMAIL-MSGID: =?utf-8?q?1592073085229547021?=
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

Changes since v14:
[http://www.openwall.com/lists/kernel-hardening/2018/02/04/2]

- fix various warnings from sparse
- multiline comments
- fix naming of headers guards
- fix compilation of individual patches, for bisect
- split genalloc documentation about bitmap for allocation
- fix headers to match kerneldoc format for "Return:" field
- fix variable naming according to coding guidelines
- fix wrong default value for pmalloc Kconfig option
- refreshed integration of pmalloc with hardened usercopy
- removed unnecessary include that was causing compilation failures
- changed license of pmalloc documentation from GPL 2.0 to CC-BY-SA-4.0

Igor Stoppa (6):
  genalloc: track beginning of allocations
  genalloc: selftest
  struct page: add field for vm_struct
  Protectable Memory
  Pmalloc: self-test
  Documentation for Pmalloc

 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 114 ++++++++
 include/linux/genalloc-selftest.h  |  26 ++
 include/linux/genalloc.h           |   7 +-
 include/linux/mm_types.h           |   1 +
 include/linux/pmalloc.h            | 222 +++++++++++++++
 include/linux/vmalloc.h            |   1 +
 init/main.c                        |   2 +
 lib/Kconfig                        |  15 +
 lib/Makefile                       |   1 +
 lib/genalloc-selftest.c            | 400 ++++++++++++++++++++++++++
 lib/genalloc.c                     | 554 +++++++++++++++++++++++++++----------
 mm/Kconfig                         |  15 +
 mm/Makefile                        |   2 +
 mm/pmalloc-selftest.c              |  63 +++++
 mm/pmalloc-selftest.h              |  24 ++
 mm/pmalloc.c                       | 499 +++++++++++++++++++++++++++++++++
 mm/usercopy.c                      |  33 +++
 mm/vmalloc.c                       |  18 +-
 19 files changed, 1852 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/core-api/pmalloc.rst
 create mode 100644 include/linux/genalloc-selftest.h
 create mode 100644 include/linux/pmalloc.h
 create mode 100644 lib/genalloc-selftest.c
 create mode 100644 mm/pmalloc-selftest.c
 create mode 100644 mm/pmalloc-selftest.h
 create mode 100644 mm/pmalloc.c

-- 
2.14.1
