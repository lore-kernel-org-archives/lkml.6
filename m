Return-Path: <kernel-hardening-return-12985-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/yxcqJaueZj8fWDuR8sId1e0PX2nFO4fLVy7ikRTBcW/iMKvIyDUYoADnJPxPFJ6HPKiIa
ARC-Seal: i=1; a=rsa-sha256; t=1523626993; cv=none;
        d=google.com; s=arc-20160816;
        b=c50dKlP8nY4RqfIDfGK1FWWlTYbxkCNrjg18a0inv8XZn5oIECj8KwrbD6/XnNQxJl
         TI++PqCNZwaKiGvACUsgrQXm//81VoX0yFrBaQL8NBrhv0utmiB65dJBsVt8GZKDTT80
         5Uyp6GATdHcuclp3pyIfLB7Ik8aaqwlMOEXGI0CffMZC6WeE0zTbSW5J7rk9duKB8BzM
         3rlUaf4tHKj7kiNHIcdJSMQOFVlg3YFrJCPOKForownvUQhtVj5o0I7FeDMmnatTQVCR
         NDg12Dl1kBlNTejp7FpUJjAlY+bbLHjzNnMdvxj2MlMqSEm5BfdzSRB2UUQFdcO0Zkyx
         8DJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=ZEBErDwtm1PGD5p/H+sxYoW3gLbWChBl2slz9Nu99mo=;
        b=lm4EYz0csL9GZEWEU4W4fnS7HTuAxI4V4ndeM9Ji1+KXCbQ/VlPX/CP/w2W2rujk5D
         GdGWyoEjqPwQlXuuPLjtobmiPaLImsCEC/dbnr906fYe0m4zNZd+H6vgSBtjjZiq30LS
         ntjvVVot5a3ef/kmRfSzAL/D3tuigYevkJ9olzC5inEcXARYH74mXjJ1czuJeuR2YmsE
         76KMg4N3F/l+HX5NCnIm0A/K8tQlfD+3DFnHGqzCb1wRh7Lf7yxJ9YjSgbQiEX6UppU4
         Nsm2FcYhPeTTVQFSbYTk5Bd82bHTKDPHVJ7J0i+/WS14w/4JBcCrgibVfre3M3EFfIrt
         0Lbw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E7pPwYKm;
       spf=pass (google.com: domain of kernel-hardening-return-12985-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12985-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E7pPwYKm;
       spf=pass (google.com: domain of kernel-hardening-return-12985-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12985-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To: willy@infradead.org,
	keescook@chromium.org,
	mhocko@kernel.org,
	corbet@lwn.net
Cc: david@fromorbit.com,
	rppt@linux.vnet.ibm.com,
	labbott@redhat.com,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Igor Stoppa <igor.stoppa@huawei.com>
Subject: [RFC PATCH v22 0/6] mm: security: ro protection for dynamic data
Date: Fri, 13 Apr 2018 17:41:25 +0400
Message-Id: <20180413134131.4651-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597638698389403429?=
X-GMAIL-MSGID: =?utf-8?q?1597638698389403429?=
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

Since it was advised to give an example of protecting real kernel data
[1],
a well known vulnerability has been used to demo an effective use of
pmalloc.

[1] http://www.openwall.com/lists/kernel-hardening/2018/03/29/7

However it turned out to be almost an how-to for attacking the kernel, so
it was sent first to security@kernel.org, for obtaining clearance about
the
publication.

Changes since v21:

[http://www.openwall.com/lists/kernel-hardening/2018/03/27/23]

* fixed type mismatch error in use of max(), detected by gcc 7.3
* converted internal types into size_t
* fixed leak of vmalloc memory in the self-test code

Igor Stoppa (6):
  struct page: add field for vm_struct
  vmalloc: rename llist field in vmap_area
  Protectable Memory
  Documentation for Pmalloc
  Pmalloc selftest
  lkdtm: crash on overwriting protected pmalloc var

Igor Stoppa (6):
  struct page: add field for vm_struct
  vmalloc: rename llist field in vmap_area
  Protectable Memory
  Documentation for Pmalloc
  Pmalloc selftest
  lkdtm: crash on overwriting protected pmalloc var

 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 107 +++++++++++++++
 drivers/misc/lkdtm/core.c          |   3 +
 drivers/misc/lkdtm/lkdtm.h         |   1 +
 drivers/misc/lkdtm/perms.c         |  25 ++++
 include/linux/mm_types.h           |   1 +
 include/linux/pmalloc.h            | 166 +++++++++++++++++++++++
 include/linux/test_pmalloc.h       |  24 ++++
 include/linux/vmalloc.h            |   5 +-
 init/main.c                        |   2 +
 mm/Kconfig                         |  16 +++
 mm/Makefile                        |   2 +
 mm/pmalloc.c                       | 265 +++++++++++++++++++++++++++++++++++++
 mm/test_pmalloc.c                  | 137 +++++++++++++++++++
 mm/usercopy.c                      |  33 +++++
 mm/vmalloc.c                       |  10 +-
 16 files changed, 793 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/core-api/pmalloc.rst
 create mode 100644 include/linux/pmalloc.h
 create mode 100644 include/linux/test_pmalloc.h
 create mode 100644 mm/pmalloc.c
 create mode 100644 mm/test_pmalloc.c

-- 
2.14.1
