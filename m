Return-Path: <kernel-hardening-return-12911-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx480EzPb05WasOnJWbHn/oS8dc8WLfloDb7sjkZjtRdoWiwmvosbBIu6Y9yM5bEHue0r+kR3
ARC-Seal: i=1; a=rsa-sha256; t=1523275446; cv=none;
        d=google.com; s=arc-20160816;
        b=IJ1dKkgiV1dvvIBUsByyD3tDdoad9q50Imdptvvefhc4gY6ZDWPcNDeglc+BjCsaj0
         m1+dHVNbm7Fcjv/mrKz/UXjcJA4eyg8kQtuLQtJccC6rLVbWeCXckwMCeDObuG7TbGlH
         kmctcyOGzMQ6Cd9eF8fJTv7au0oPx2W2JiaYsLfQFMs0wf6L6ZXMT03UJBcW3OdxTypv
         iBRRyTCaNnH3bFqIeWrkwFExE8pOoDIyQqWxXq8mFcgxYsJhbTGeVROo4PabPmZjH/y6
         aZXIXx+beOhS9CdF1noskIHK++TbqAwPjCHpA37WtqlP9YYOwT+g4bXwGBclxvRkeI4f
         xTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=RrdZPaVavLktS3vTNYrx3N9l8IFBOnQbFfcLierXxUE=;
        b=OFmiBF81USnPLjNYsotCeyRgDKfkLqJUUJNneH/A5LTUm8G18ZwjzTeJXM8Mxoxc24
         U7jYr/2Bi2bCE6tRmEB0xr64l7xyg46XE+A7SQt3MqwCt3QCNaXnZt99HmmEhEH1qumE
         ISqqIgbWw7W0/2/OZ0UYo15lP/wwB4yWo7VKp1e1y4Ybdzh5RYfAYOy7paFRQmu50bKE
         7MJWdOImfLI8DVypG3a98kHvVqI8EEpfobM6QuCrLrPsKsgDgOc+E4QPedAVWZVDGqbl
         ZEFfMEtVDvjDliUL/jLwxIXdM8pHQtwKj+aQL4Tmd30Oy7yNMn2Rg8TzI/w3ux1PPyMh
         vsaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Nwl6ocAm;
       spf=pass (google.com: domain of kernel-hardening-return-12911-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12911-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Nwl6ocAm;
       spf=pass (google.com: domain of kernel-hardening-return-12911-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12911-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH v3 0/3] usercopy: reimplement arch_within_stack_frames
Date: Mon,  9 Apr 2018 15:59:13 +0400
Message-Id: <1523275156-29087-1-git-send-email-kpark3469@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597247862609672513?=
X-GMAIL-MSGID: =?utf-8?q?1597270074850598723?=
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
 include/linux/page_ext.h           |  1 -
 include/linux/stacktrace.h         | 24 +++++++++++
 include/linux/thread_info.h        | 21 ---------
 mm/usercopy.c                      |  2 +-
 11 files changed, 197 insertions(+), 77 deletions(-)

-- 
2.7.4
