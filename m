Return-Path: <kernel-hardening-return-13175-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZplXKot93Kc61bFmk6AoSKYm5E0DdFwcV5faDiu3G3hK2k003g6toUKZYPrdffP+9ITg+c+
ARC-Seal: i=1; a=rsa-sha256; t=1525223153; cv=none;
        d=google.com; s=arc-20160816;
        b=u2y16xxR/wsX3aXc/ZVmBKy05mKhsg3Yuc9OqHNq1WvYZPEW7O/U4ird/zs1KVxXhD
         YL9AF3caCDOrseg1nSMnclMhSPbcYsF3ZuQm/Lbf0QiKRQtHkHMKniy8lur2m3NqXaKA
         jpNOWZhoz+l6Wzv52Gm+BqNMac3qeKvpoIPf3NDFXdbmdfZ3JMCY3dCJLCWAYGGVcvpQ
         8TvAN0d89DIFwngQIacDNQD/DoBoiqooGauJZ1P2LTyGa4BzfRJ8WpvB0G7jTnFgHJ6v
         rsLV5vPd+B8p3d4ZphlXZcFUF+b3q3eQEf2oTMJqryZNutEm22XjqmPXZ+Tu2o6nBwfD
         mSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=L+JDF9iTaljm+FXparRmo0KN96D2OqblEqICBrv6xUM=;
        b=XQ1ggntewLvKiHIpHVo9LX/mWFs7+PlTQJpJZBkP/ip7LCK0gfITrdjVovL6QWkDBH
         IS7jwrT5AqH5vPDQ6MvwqTSQFJWbrozOwvQ+OUKtEEZrZhy/vmUnJt71nec73G6nJuV9
         YgEVjvv4BN2tWRfFIVqU3E2iBqJw9H98h45du1DVvYfP77UzHMK+qE0H7/n9jfow7l6N
         2//u1MPrsFCkkbIzUmqcLBaHP+fkLxsiGdFw5LXMsFgaKSJoO1qNc5Z2GY1O8D0jK4Vy
         u56zfoQT/Yeqp0UhKEYzdVm3q/IWDStSLB/759MYOyDCBQZ52x5rGR6wHIbOE6/IF8J0
         1J1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EHRlsBjr;
       spf=pass (google.com: domain of kernel-hardening-return-13175-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13175-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EHRlsBjr;
       spf=pass (google.com: domain of kernel-hardening-return-13175-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13175-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH 0/3 v2] linux-next: mm: Track genalloc allocations
Date: Wed,  2 May 2018 05:05:19 +0400
Message-Id: <20180502010522.28767-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599312393247232673?=
X-GMAIL-MSGID: =?utf-8?q?1599312393247232673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset was created as part of an older version of pmalloc, however
it has value per-se, as it hardens the memory management for the generic
allocator genalloc.

Genalloc does not currently track the size of the allocations it hands
out.

Either by mistake, or due to an attack, it is possible that more memory
than what was initially allocated is freed, leaving behind dangling
pointers, ready for an use-after-free attack.

With this patch, genalloc becomes capable of tracking the size of each
allocation it has handed out, when it's time to free it.

It can either verify that the size received is correct, when free is
invoked, or it can decide autonomously how much memory to free, if the
value received for the size parameter is 0.

These patches are proposed for beign merged into linux-next, to verify
that they do not introduce regressions, by comparing the value received
from the callers of the free function with the internal tracking.

For this reason, the patchset does not contain the removal of the size
parameter from users of the free() function.

Later on, the "size" parameter can be dropped, and each caller can be
adjusted accordingly.

However, I do not have access to most of the HW required for confirming
that all of its users are not negatively affected.
This is where I believe having the patches in linux-next would help to
coordinate with the maintaiers of the code that uses gen_alloc.

Since there were comments about the (lack-of) efficiency introduced by
this patchset, I have added some more explanations and calculations to the
description of the first patch, the one adding the bitmap.
My conclusion is that this patch should not cause any major perfomance
problem.

Regarding the possibility of completely changing genalloc into some other
type of allocator, I think it should not be a showstopper for this
patchset, which aims to plug a security hole in genalloc, without
introducing any major regression.

The security flaw is clear and present, while the benefit of introducing a
new allocator is not clear, at least for the current users of genalloc.

And anyway the users of genalloc should be fixed to not pass any size
parameter, which can be done after this patch is merged.

A newer, more efficient allocator will still benefit from not receiving a
spurious parameter (size), when freeing memory.

Changes since v1:

[http://www.openwall.com/lists/kernel-hardening/2018/04/29/1]

* make the tester code a kernel module
* turn selftest BUG() error exit paths into WARN()
* add analysis of impact on current users of genalloc


Igor Stoppa (3):
  genalloc: track beginning of allocations
  Add label and license to genalloc.rst
  genalloc: selftest

 Documentation/core-api/genalloc.rst |   4 +
 include/linux/genalloc.h            | 112 +++---
 lib/Kconfig.debug                   |  23 ++
 lib/Makefile                        |   1 +
 lib/genalloc.c                      | 742 ++++++++++++++++++++++++++----------
 lib/test_genalloc.c                 | 419 ++++++++++++++++++++
 6 files changed, 1046 insertions(+), 255 deletions(-)
 create mode 100644 lib/test_genalloc.c

-- 
2.14.1
