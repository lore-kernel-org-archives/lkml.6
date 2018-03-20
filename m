Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeCTLFi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:05:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40627 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbeCTLF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:26 -0400
Date: Tue, 20 Mar 2018 04:03:47 -0700
From: "tip-bot for H.J. Lu" <tipbot@zytor.com>
Message-ID: <tip-e3d03598e8ae7d195af5d3d049596dec336f569f@git.kernel.org>
Cc: jgross@suse.com, mingo@kernel.org, kirill.shutemov@linux.intel.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        andy.shevchenko@gmail.com, ebiederm@xmission.com,
        keescook@chromium.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        hjl.tools@gmail.com, peterz@infradead.org
Reply-To: keescook@chromium.org, hpa@zytor.com, ebiederm@xmission.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        andy.shevchenko@gmail.com, jgross@suse.com,
        kirill.shutemov@linux.intel.com, mingo@kernel.org,
        peterz@infradead.org, hjl.tools@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <CAMe9rOp4_=_8twdpTyAP2DhONOCeaTOsniJLoppzhoNptL8xzA@mail.gmail.com>
References: <CAMe9rOp4_=_8twdpTyAP2DhONOCeaTOsniJLoppzhoNptL8xzA@mail.gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/build/64: Force the linker to use 2MB page size
Git-Commit-ID: e3d03598e8ae7d195af5d3d049596dec336f569f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e3d03598e8ae7d195af5d3d049596dec336f569f
Gitweb:     https://git.kernel.org/tip/e3d03598e8ae7d195af5d3d049596dec336f569f
Author:     H.J. Lu <hjl.tools@gmail.com>
AuthorDate: Mon, 19 Mar 2018 13:57:46 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:03:03 +0100

x86/build/64: Force the linker to use 2MB page size

Binutils 2.31 will enable -z separate-code by default for x86 to avoid
mixing code pages with data to improve cache performance as well as
security.  To reduce x86-64 executable and shared object sizes, the
maximum page size is reduced from 2MB to 4KB.  But x86-64 kernel must
be aligned to 2MB.  Pass -z max-page-size=0x200000 to linker to force
2MB page size regardless of the default page size used by linker.

Tested with Linux kernel 4.15.6 on x86-64.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/CAMe9rOp4_%3D_8twdpTyAP2DhONOCeaTOsniJLoppzhoNptL8xzA@mail.gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 498c1b812300..1c4d012550ec 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -223,6 +223,15 @@ KBUILD_CFLAGS += $(cfi) $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr)
 
 LDFLAGS := -m elf_$(UTS_MACHINE)
 
+#
+# The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
+# the linker to force 2MB page size regardless of the default page size used
+# by the linker.
+#
+ifdef CONFIG_X86_64
+LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
+endif
+
 # Speed up the build
 KBUILD_CFLAGS += -pipe
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
