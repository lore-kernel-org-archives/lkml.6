Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeB1O2K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:28:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36355 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeB1O2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:28:08 -0500
Date: Wed, 28 Feb 2018 06:27:46 -0800
From: tip-bot for Tom Lendacky <tipbot@zytor.com>
Message-ID: <tip-ae8d1d0061ad7996c2c5e769e809a593544fa145@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, bp@alien8.de, bp@suse.de,
        mingo@kernel.org, torvalds@linux-foundation.org
Reply-To: kirill.shutemov@linux.intel.com, bp@alien8.de, bp@suse.de,
        mingo@kernel.org, torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, hpa@zytor.com
In-Reply-To: <20180226232554.14108.16881.stgit@tlendack-t1.amdoffice.net>
References: <20180226232554.14108.16881.stgit@tlendack-t1.amdoffice.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/sme: Disable stack protection for
 mem_encrypt_identity.c
Git-Commit-ID: ae8d1d0061ad7996c2c5e769e809a593544fa145
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

Commit-ID:  ae8d1d0061ad7996c2c5e769e809a593544fa145
Gitweb:     https://git.kernel.org/tip/ae8d1d0061ad7996c2c5e769e809a593544fa145
Author:     Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate: Mon, 26 Feb 2018 17:25:54 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 15:24:12 +0100

x86/mm/sme: Disable stack protection for mem_encrypt_identity.c

Stack protection is not compatible with early boot code.  All of the early
SME boot code is now isolated in a separate file, mem_encrypt_identity.c,
so arch/x86/mm/Makefile can be updated to turn off stack protection for
the entire file.  This eliminates the need to worry about other functions
within the file being instrumented with stack protection (as was seen
when a newer version of GCC instrumented sme_encrypt_kernel() where an
older version hadn't).  It also allows removal of the __nostackprotector
attribute from individual functions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20180226232554.14108.16881.stgit@tlendack-t1.amdoffice.net

---
 arch/x86/mm/Makefile               | 1 +
 arch/x86/mm/mem_encrypt_identity.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 03c6c8561623..4b101dd6e52f 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -19,6 +19,7 @@ obj-y	:=  init.o init_$(BITS).o fault.o ioremap.o extable.o pageattr.o mmap.o \
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_physaddr.o		:= $(nostackp)
 CFLAGS_setup_nx.o		:= $(nostackp)
+CFLAGS_mem_encrypt_identity.o	:= $(nostackp)
 
 CFLAGS_fault.o := -I$(src)/../include/asm/trace
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index b4139c5ab972..1b2197d13832 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -266,7 +266,7 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init __nostackprotector sme_encrypt_kernel(struct boot_params *bp)
+void __init sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -468,7 +468,7 @@ void __init __nostackprotector sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __init __nostackprotector sme_enable(struct boot_params *bp)
+void __init sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
 	unsigned int eax, ebx, ecx, edx;
