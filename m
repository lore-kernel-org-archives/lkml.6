Return-Path: <kernel-hardening-return-13088-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48BVoGXIWfAY2ooEoFNhlwFuppltG7qKmKJdAqHtzqcS8VEzON+A+aMsc/iY0kmSulxnyj4
ARC-Seal: i=1; a=rsa-sha256; t=1524488144; cv=none;
        d=google.com; s=arc-20160816;
        b=ziGHq1IelZNTivYQOLt+q5+aqil47qxi3+nsdkYeXsKY3TIrXISO89ow76YZqWOCHi
         kkGYUug7LeL+3SAe6fc+nTNPrRVKwKX0KjSu15FA+xhn2PJdc6s24gUStDFDilc946mL
         mKSr31IVL7OxZC1jgKX5zOvE0O1RopvPqyETl+PABZNghtznsrAmg6sFNiLadwHHpE5b
         BFt/QeE16pGUheUNxUXQj6AW1P68vQ4hkVTxfWEFfL4trc0UMYcDg2wXsGXPPRoYHRF9
         zLMQL5WKy6UjPT2xpc8gR5GQVdFM5PZTV8lCyfxPH6QqyljAw9K91MK1tJVNgUJE41AD
         0FJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=e9HDvz/LcbcDeAwauzFQKVn+N2jmZd9EmEcqwM4Ck7Q=;
        b=mns/Jp1kUbKCxHq2WJTRY6Yrkdc+Q5Wl0rdPQ33tJoXDiedJVoYjdsPyA8FEQInjH6
         rkAlxQWrZkVRTA7X+VUs6IWqGnr8DLwdpj6qr1rLy7qjCB8vqy/NmYEiIIgloRK1OvDW
         hKDbAHwdkp5F8FwPVAUYPBnTyHu48t5BZs1FeIhG2OrpV4AAW+MeG+tOtR5EixB6LHIl
         4RtDAwy916acyYG8cGxVpJySLiMXVyIoTCyGpyzD5b++qbRngX7vMxSvCokCHkXYQgGs
         BaCFFU4zpwAxHRJrUa/VASw3iQcge1EdqDqOyizvz4FOS6TnwyDl1qJNWe8qTutvDttJ
         XVWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BejYbuPy;
       spf=pass (google.com: domain of kernel-hardening-return-13088-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13088-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BejYbuPy;
       spf=pass (google.com: domain of kernel-hardening-return-13088-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13088-gregkh=linuxfoundation.org@lists.openwall.com;
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
	paul@paul-moore.com,
	sds@tycho.nsa.gov,
	mhocko@kernel.org,
	corbet@lwn.net
Cc: labbott@redhat.com,
	linux-cc=david@fromorbit.com,
	--cc=rppt@linux.vnet.ibm.com,
	--security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	igor.stoppa@gmail.com,
	Igor Stoppa <igor.stoppa@huawei.com>
Subject: [RFC PATCH v23 0/6] mm: security: write protection for dynamic data
Date: Mon, 23 Apr 2018 16:54:49 +0400
Message-Id: <20180423125458.5338-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541680355567743?=
X-GMAIL-MSGID: =?utf-8?q?1598541680355567743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch-set introduces the possibility of protecting memory that has
been allocated dynamically.

The memory is managed in pools: when a memory pool is protected, all the
memory that is currently part of it, will become R/O.

A R/O pool can be expanded (adding more protectable memory).
It can also be destroyed, to recover its memory, but it cannot be
turned back into normal R/W mode.

This is intentional. This feature is meant for data that either doesn't
need further modifications after initialization, or it will change very
seldom.

The data might need to be released, for example as part of module unloading.
The pool, therefore, can be destroyed.

For those cases where the data is never completely stable, however it can
stay unmodified for very long periods, there is a possibility of
allocating it from a "rare write" pool, which allows modification to its
data, through an helper function.

I did not want to overcomplicate the first version of rare write, but it
might be needed to add disabling/enabling of preemption, however I would
appreciate comments in general about the implementation through transient
remapping.

An example is provided, showing how to protect one of hte internal states
of SELinux.

Changes since v22:
[http://www.openwall.com/lists/kernel-hardening/2018/04/13/3]

- refactored some helper functions in a separate local header
- expanded the documentation
- introduction of rare write support
- example with SELinux "initialized" field


Igor Stoppa (9):
  struct page: add field for vm_struct
  vmalloc: rename llist field in vmap_area
  Protectable Memory
  Documentation for Pmalloc
  Pmalloc selftest
  lkdtm: crash on overwriting protected pmalloc var
  Pmalloc Rare Write: modify selected pools
  Preliminary self test for pmalloc rare write
  Protect SELinux initialized state with pmalloc

 Documentation/core-api/index.rst    |   1 +
 Documentation/core-api/pmalloc.rst  | 189 ++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c           |   3 +
 drivers/misc/lkdtm/lkdtm.h          |   1 +
 drivers/misc/lkdtm/perms.c          |  25 ++++
 include/linux/mm_types.h            |   1 +
 include/linux/pmalloc.h             | 170 ++++++++++++++++++++++++
 include/linux/test_pmalloc.h        |  24 ++++
 include/linux/vmalloc.h             |   6 +-
 init/main.c                         |   2 +
 mm/Kconfig                          |  16 +++
 mm/Makefile                         |   2 +
 mm/pmalloc.c                        | 258 ++++++++++++++++++++++++++++++++++++
 mm/pmalloc_helpers.h                | 210 +++++++++++++++++++++++++++++
 mm/test_pmalloc.c                   | 213 +++++++++++++++++++++++++++++
 mm/usercopy.c                       |   9 ++
 mm/vmalloc.c                        |  10 +-
 security/selinux/hooks.c            |  12 +-
 security/selinux/include/security.h |   2 +-
 security/selinux/ss/services.c      |  51 ++++---
 20 files changed, 1174 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/core-api/pmalloc.rst
 create mode 100644 include/linux/pmalloc.h
 create mode 100644 include/linux/test_pmalloc.h
 create mode 100644 mm/pmalloc.c
 create mode 100644 mm/pmalloc_helpers.h
 create mode 100644 mm/test_pmalloc.c

-- 
2.14.1
