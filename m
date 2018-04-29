Return-Path: <kernel-hardening-return-13152-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqJIGFFIFRsDkNCZaWKHxsDUTGdANx0mJgtnToZpedIbT8aFmevA/gC+5p0JgI2SSe072Vz
ARC-Seal: i=1; a=rsa-sha256; t=1524969987; cv=none;
        d=google.com; s=arc-20160816;
        b=yzWwznb/G9hO9Ac/WDuuRfdrnAc4C/jgaKzxNSn0dqonf1g3GEl+AdIRFEo/Km7wbv
         is8xO423yEoEWFkP/tUIvIvDa3zf+MU2V+Rs+RlQ92OTi1XtlRjCAZO9Uzrkpqu/wEWE
         G8kiHRVPs1ugibstLihDi43dau2LdjiLisfhlRimWp6EpFlpRJEKiD2aChXJqiXx2fzB
         kobEPjVwx2j893ajYG/TH938P/NerD6AN/SM+WYdUwZsoE9ERyUF6MQOV/12S7mL+7Id
         2VLlPtLZhi1x29KlKaq4kwmk0JIa+aPTdqXGUG3YQxiv19Yu+5T+l5IPZq2PWVdHuQXr
         4o9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=ydCSrnZZM5I2bKXXk9GAcyOaZOJuejdJqo+Y9L++rh8=;
        b=ACNGGcDl4wYjKP6BhYXzvF/6aT9oHwbO1t0ANHRSLsIVLW2tpggicNIR+tu3plCQNo
         qYo1UaHdMtU29IjGVgqMduzAGUUQHyLeiq46RJlBfVkb/aIy1PaVfRZ/Nltf6Ilw130y
         ugPMiKZf27dLzl2ZBr4+ARAQYrQi1ariRNh2fbvBoiTF7iJ8XLG3QcV5/gwGQBtja7Jm
         EmY7BjdXCsBlX9XxaGGR+N7MrxwygS8EapfCfnjU2vu74gk/bg/2n5OseaUXJBsNJXSl
         6gSxLbNeJ1CfCGrjD7OD0aynMEihXILx9nV6nlNtHYoySU4Gm0lOE9fE3FIkxKZPDJt6
         sSvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gQjleNAX;
       spf=pass (google.com: domain of kernel-hardening-return-13152-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13152-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gQjleNAX;
       spf=pass (google.com: domain of kernel-hardening-return-13152-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13152-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To: mhocko@kernel.org,
	akpm@linux-foundation.org,
	keescook@chromium.org,
	linux-mm@kvack.org,
	kernel-hardening@lists.openwall.com,
	linux-security-module@vger.kernel.org
Cc: willy@infradead.org,
	labbott@redhat.com,
	linux-kernel@vger.kernel.org,
	igor.stoppa@huawei.com
Subject: [PATCH 0/3] linux-next: mm: hardening: Track genalloc allocations
Date: Sun, 29 Apr 2018 06:45:39 +0400
Message-Id: <20180429024542.19475-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599046930013437561?=
X-GMAIL-MSGID: =?utf-8?q?1599046930013437561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset was created as part of an older version of pmalloc, however
it has value per-se, as it hardens the memory management for the generic
allocator genalloc.

Genalloc does not currently track the size of the allocations it hands out.

Either by mistake, or due to an attack, it is possible that more memory
than what was initially allocated is freed, leaving behind dangling
pointers, ready for an use-after-free attack.

With this patch, genalloc becomes capable of tracking the size of each
allocation it has handed out, when it's time to free it.

It can either verify that the size received, when free is invoked, is
correct, or it can decide autonomously how much memory to free, if the
value received for the size parameter is 0.

These patches are proposed for beign merged into linux-next, to verify
that they do not introduce regressions, by comparing the value received
from the callers of the free function with the internal tracking.

Later on, the "size" parameter can be dropped, and each caller can be
adjusted accordingly.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

Igor Stoppa (3):
  genalloc: track beginning of allocations
  Add label and license to genalloc.rst
  genalloc: selftest

 Documentation/core-api/genalloc.rst |   4 +
 include/linux/genalloc.h            | 112 +++---
 init/main.c                         |   2 +
 lib/Kconfig                         |  15 +
 lib/Makefile                        |   1 +
 lib/genalloc.c                      | 742 ++++++++++++++++++++++++++----------
 lib/test_genalloc.c                 | 410 ++++++++++++++++++++
 7 files changed, 1031 insertions(+), 255 deletions(-)
 create mode 100644 lib/test_genalloc.c

-- 
2.14.1
