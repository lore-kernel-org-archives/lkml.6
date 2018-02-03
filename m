Return-Path: <kernel-hardening-return-11562-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226/gc+H4JlNjEY0q8MuN4FvIiTNNVg1HwtbJtd11Oi/J2PXFAIpmt+uYjPLGzIhAqS7mHXl
ARC-Seal: i=1; a=rsa-sha256; t=1517687026; cv=none;
        d=google.com; s=arc-20160816;
        b=gxltQ23SOVrVcWsTMo8Kudd70ik4TBW0CVZuClG0/d4c/3lyW2OriYI0FQPt7OQ1mo
         yUSOOAsUInMW5x78hSpHUTNz57m1p/HhyLCURwVE4d5ZqA7eJEAGbuiMNd69AvXHUVq4
         Xh+QiNuBe2wkr5HTXakRPwxvE8tboRAWknN3jSb/tZbqTdVx5tDcZ+qPEpBsI+jP4TTc
         cDTCDHzq64wU8el5XqwKlLoLE8znA985ZMS//s8y9CxLLwKqW7vYOEGdB0yXSI3wxf/q
         slWDE6ZjQBfSsZKuUmGG0Qq+qwCp3d06vlDBXTIV4fscPNqLxWphXk5d7X8eoc8F6kkx
         jdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=cCjx1l42K2L82GNJd2t6q59xGwtBsUJg/NZMB2xfkyk=;
        b=ZKnkMnnK1aCZegOj0X1MqedzYHhFWRhmp596mJYihub/BNzOSPqmqiTfHirzM4yWsW
         6swi0FUp4IPMuNmLlhxxpYk3QOFkrgAGju4UXao8D3aw3QQ2D+SHvNQf/AAO9EWOCddk
         Yp+9OmZEKB7zufGHpFZjo6TArWfW6NKoRjwqNq/m30Dn6Tg2WXpWcKPAtdAiUsMvxz80
         JPx8BtzuMgcvVqftEGiW3qakr95B+gSshDiRXto7rH1DhlWMcWV31lM87bBuFPMKkq7d
         4upiGlLmhG8ZZ94G/WL3tZQN4Ubm4Rmb+YimZDNW26M12dA/dru46AXPXEKsuhT9uK5P
         Uqfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11562-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11562-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11562-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11562-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [RFC PATCH v13 0/6] mm: security: ro protection for dynamic data
Date: Sat, 3 Feb 2018 21:42:52 +0200
Message-ID: <20180203194258.28454-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591410191388132274?=
X-GMAIL-MSGID: =?utf-8?q?1591410191388132274?=
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

Changes since v12
[https://lkml.org/lkml/2018/1/30/397]

- fixed Kconfig dependency for pmalloc-test
- fixed warning for size_t treated as %ul on i386
- moved to SPDX license reference
- rewrote pmalloc docs

Igor Stoppa (6):
  genalloc: track beginning of allocations
  genalloc: selftest
  struct page: add field for vm_struct
  Protectable Memory
  Pmalloc: self-test
  Documentation for Pmalloc

 Documentation/core-api/pmalloc.rst | 114 ++++++++
 include/linux/genalloc-selftest.h  |  30 +++
 include/linux/genalloc.h           |   7 +-
 include/linux/mm_types.h           |   1 +
 include/linux/pmalloc.h            | 211 +++++++++++++++
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
 18 files changed, 1742 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/core-api/pmalloc.rst
 create mode 100644 include/linux/genalloc-selftest.h
 create mode 100644 include/linux/pmalloc.h
 create mode 100644 lib/genalloc-selftest.c
 create mode 100644 mm/pmalloc-selftest.c
 create mode 100644 mm/pmalloc-selftest.h
 create mode 100644 mm/pmalloc.c

-- 
2.9.3
