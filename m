Return-Path: <kernel-hardening-return-12905-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+qrrear+odi9+t+K94bmWJdycad6OxVM4b25QdS0kgcEFVZVbRtkfIwPDDKuFlMdGIZ+mK
ARC-Seal: i=1; a=rsa-sha256; t=1523254263; cv=none;
        d=google.com; s=arc-20160816;
        b=MviBX+gwswY1TgEOd5XE4T1Q/NpFYtE5Txi94MaQl7Ycem3cTxRF5q7ZO/ewmSvBxV
         FVkf5nfd+tKZC0Tb4+INMWM2YYNHB81KfF3qwppNMCuN3rin8AeWsNcY25juEF3+2p4o
         oER1qT1sxjLSERKY8bTcAvBqQ2OCpXjR9hleOzfeHw5s0C0KVbr6AOdo9t526aHFHiKa
         SISLFu2m3taElLkUL4sWxE64+J/uAeb8qS1fJ+2p5CtUDSVQqNTGwfEcee/h5RM8+fWa
         sG1IHXSyy3B8+YVcUZAOAQb04nmOveG29ovADDD7+tW0Ays2qoZYos7Bh+/+gVLAocpu
         WkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=5C39Z4TxRBtTayuPgjJzD4v6OkXWJ42ngJUq9CxUmxI=;
        b=M1CSSYF5um9g97i9UTnTWUjy+EOmB68A7UhSakr4Zx4wPkGtRqaA4NbQEIT0LdeRQI
         0hXPhmpS+4ZESMJuBMMjFZtnIyH1ML/87jcutVaTrycb33CCLU2wjKlV3XUvBqYEO9BH
         LasroP/FiGOZ36b2pyZfTvkvyee/lccQ+M1aCZ2jZDXIUpYAsGjXDS0kDW/WJLEZttig
         AsXoZPB2TWp1BEvrBtq5D/D/Of4F+V4am+g+g7tWipCbyuI+G2clwBjcwpClyKXJw78A
         uyXmx/6wSMo7MSx+7qkRty5Bo6OPw5/NDI9v4/XPG2kWS6fU33ZXtiRKmEwXl2rLyVoR
         czow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VU44+hWd;
       spf=pass (google.com: domain of kernel-hardening-return-12905-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12905-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VU44+hWd;
       spf=pass (google.com: domain of kernel-hardening-return-12905-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12905-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: kpark3469@gmail.com
To: kernel-hardening@lists.openwall.com
Cc: catalin.marinas@arm.com,
	keescook@chromium.org,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	james.morse@arm.com,
	panand@redhat.com,
	keun-o.park@darkmatter.ae,
	psodagud@codeaurora.org,
	jpoimboe@redhat.com,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] usercopy: reimplement arch_within_stack_frames
Date: Mon,  9 Apr 2018 10:06:06 +0400
Message-Id: <1523253969-31699-1-git-send-email-kpark3469@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597247862609672513?=
X-GMAIL-MSGID: =?utf-8?q?1597247862609672513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sahara <keun-o.park@darkmatter.ae>

This series of patches introduce the arm64 arch_within_stack_frames
implementation using stacktrace functions. Also the base code is
moved from thread_info.h to stacktrace.h. x86 code is reimplemented
to use frame pointer unwinder functions.

Note: The code is still missing in case of using x86 ORC unwinder and
guess unwinder.

v2 changes:
 - Remove 'arm64: usercopy: consider dynamic array stack variable'
 - minor fix in x86 arch_within_stack_frames code.

James Morse (1):
  arm64: usercopy: implement arch_within_stack_frames

Sahara (2):
  stacktrace: move arch_within_stack_frames from thread_info.h
  x86: usercopy: reimplement arch_within_stack_frames with unwinder

 arch/arm/kernel/stacktrace.c       |  1 -
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/kernel/stacktrace.c     | 77 ++++++++++++++++++++++++++++++++-
 arch/mips/kernel/stacktrace.c      |  1 -
 arch/mips/oprofile/backtrace.c     |  1 -
 arch/sh/kernel/stacktrace.c        |  1 -
 arch/sparc/kernel/stacktrace.c     |  1 -
 arch/um/kernel/stacktrace.c        |  1 -
 arch/unicore32/kernel/process.c    |  1 -
 arch/unicore32/kernel/stacktrace.c |  2 -
 arch/x86/include/asm/thread_info.h | 51 +---------------------
 arch/x86/include/asm/unwind.h      |  5 +++
 arch/x86/kernel/Makefile           |  2 +-
 arch/x86/kernel/stacktrace.c       | 88 +++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/unwind_frame.c     |  4 +-
 arch/xtensa/kernel/stacktrace.c    |  1 -
 include/linux/page_ext.h           |  1 -
 include/linux/stacktrace.h         | 25 +++++++++++
 include/linux/thread_info.h        | 21 ---------
 kernel/sysctl.c                    |  1 -
 mm/usercopy.c                      |  2 +-
 21 files changed, 198 insertions(+), 90 deletions(-)

-- 
2.7.4
