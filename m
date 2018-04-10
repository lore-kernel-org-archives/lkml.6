Return-Path: <kernel-hardening-return-12947-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+n99hTLhuqqNCESMYCptB4GdUy6gOAF43y5yTT6kv2skmoeQjHN4BdXMQ+AXT9Cdo+sOqj
ARC-Seal: i=1; a=rsa-sha256; t=1523345492; cv=none;
        d=google.com; s=arc-20160816;
        b=iuG7eW6Uek7RkobGO0I18svEhLc1ywwBLiPf2k5Nros51Hudo+JRuOlPebQpj3CCBq
         vmDk2FERoEUVh3f1eHkd2pWQSreEdSkKQrs5Z7teU4g79eFitkaBO6bG1y7IsbFwJAVF
         wnHL3vjmdmCrLo5y/Po2/RUnD3WNRb9L6NT2GnFGYWyP75xHloyKq4HFibsZjyNP/nw1
         Iw8BOj7jfdGnNmSQ33wmq0o1XmXX3cm0TeMMf3HYYjn+aDAzbSLUPoWArwrV8cI9ogLh
         F6EiGZZuCQIV7l15f/Emxphn5Sov6N1Vfns6CJIeEdQLeBu/WnGlifAb0n1Kes/YeWZc
         Okmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=wN4oVuPw5D1BDaM1x9hgdeSnp1DNUmZMeRfu5HpjdU0=;
        b=ofsk8Xeu4R+M2G5qX2Lgq5wfaIBcSJT6hpCBSUHEWKP6iKe4Fb5WFmHa3pe4fe3Hjw
         4xTi3ObkvYKrG6K/3iGoi/+WvaeTmkmbW1Y396LsW7dXE8Z8262/ycTkZ+idX0xbj87m
         TVKLGhAOFsiPdD0/YnyXe0rXAiWuRK1jeyZxQTkzdbq1DFCpCsZfgx+DuovsMTpzvT3B
         2Ik9Q8Y+wEaB9+YEffa6P+uRaE/sdE6YMRjhvFTgTGGsGYttjcWLuQKzCG5f3UYGpr2H
         s/6xP00K6usGjJptqk1i8qGxbv6vXcVLXZ6qefoCHexv2jwWPpNhpQ7RmFBtUzw6nD1G
         iTiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SislbEi6;
       spf=pass (google.com: domain of kernel-hardening-return-12947-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12947-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SislbEi6;
       spf=pass (google.com: domain of kernel-hardening-return-12947-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12947-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH v4 0/3] usercopy: reimplement arch_within_stack_frames
Date: Tue, 10 Apr 2018 11:30:44 +0400
Message-Id: <1523345447-10725-1-git-send-email-kpark3469@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597343523233967320?=
X-GMAIL-MSGID: =?utf-8?q?1597343523233967320?=
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
v3 changes:
 - Fix build problem caused by circular inclusion of header in x86 UP config
v4 changes:
 - Fix build problem caused by page_ext.h change

James Morse (1):
  arm64: usercopy: implement arch_within_stack_frames

Sahara (2):
  stacktrace: move arch_within_stack_frames from thread_info.h
  x86: usercopy: reimplement arch_within_stack_frames with unwinder

 arch/arm64/Kconfig                 |  1 +
 arch/arm64/kernel/stacktrace.c     | 76 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/thread_info.h | 51 +---------------------
 arch/x86/include/asm/unwind.h      |  5 +++
 arch/x86/kernel/Makefile           |  2 +-
 arch/x86/kernel/stacktrace.c       | 87 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/unwind_frame.c     |  4 +-
 include/linux/stacktrace.h         | 24 +++++++++++
 include/linux/thread_info.h        | 21 ---------
 mm/usercopy.c                      |  2 +-
 10 files changed, 197 insertions(+), 76 deletions(-)

-- 
2.7.4
