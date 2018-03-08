Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755499AbeCHJbB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:31:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755101AbeCHJa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:30:59 -0500
Date: Thu, 8 Mar 2018 01:30:47 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-c996f3802006a585a6c3f8eaa73e375330efc0e7@git.kernel.org>
Cc: hpa@zytor.com, bp@suse.de, darren.kenny@oracle.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: bp@suse.de, hpa@zytor.com, mingo@kernel.org, darren.kenny@oracle.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180301151336.12948-1-bp@alien8.de>
References: <20180301151336.12948-1-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/MSR: Move native_* variants to msr.h
Git-Commit-ID: c996f3802006a585a6c3f8eaa73e375330efc0e7
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

Commit-ID:  c996f3802006a585a6c3f8eaa73e375330efc0e7
Gitweb:     https://git.kernel.org/tip/c996f3802006a585a6c3f8eaa73e375330efc0e7
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 1 Mar 2018 16:13:36 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 10:22:57 +0100

x86/MSR: Move native_* variants to msr.h

... where they belong.

No functional change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Cc: kvm@vger.kernel.org
Link: https://lkml.kernel.org/r/20180301151336.12948-1-bp@alien8.de

---
 arch/x86/include/asm/microcode.h | 14 --------------
 arch/x86/include/asm/msr.h       | 14 ++++++++++++++
 arch/x86/kvm/svm.c               |  1 -
 arch/x86/kvm/vmx.c               |  1 -
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 7fb1047d61c7..871714e2e4c6 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -6,20 +6,6 @@
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
 
-#define native_rdmsr(msr, val1, val2)			\
-do {							\
-	u64 __val = __rdmsr((msr));			\
-	(void)((val1) = (u32)__val);			\
-	(void)((val2) = (u32)(__val >> 32));		\
-} while (0)
-
-#define native_wrmsr(msr, low, high)			\
-	__wrmsr(msr, low, high)
-
-#define native_wrmsrl(msr, val)				\
-	__wrmsr((msr), (u32)((u64)(val)),		\
-		       (u32)((u64)(val) >> 32))
-
 struct ucode_patch {
 	struct list_head plist;
 	void *data;		/* Intel uses only this one */
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 30df295f6d94..77254c9c8f61 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -108,6 +108,20 @@ static inline void notrace __wrmsr(unsigned int msr, u32 low, u32 high)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
+#define native_rdmsr(msr, val1, val2)			\
+do {							\
+	u64 __val = __rdmsr((msr));			\
+	(void)((val1) = (u32)__val);			\
+	(void)((val2) = (u32)(__val >> 32));		\
+} while (0)
+
+#define native_wrmsr(msr, low, high)			\
+	__wrmsr(msr, low, high)
+
+#define native_wrmsrl(msr, val)				\
+	__wrmsr((msr), (u32)((u64)(val)),		\
+		       (u32)((u64)(val) >> 32))
+
 static inline unsigned long long native_read_msr(unsigned int msr)
 {
 	unsigned long long val;
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index be9c839e2c89..9d2043f94e29 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -49,7 +49,6 @@
 #include <asm/debugreg.h>
 #include <asm/kvm_para.h>
 #include <asm/irq_remapping.h>
-#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include <asm/virtext.h>
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 051dab74e4e9..ee5ed44bc284 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -51,7 +51,6 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/mmu_context.h>
-#include <asm/microcode.h>
 #include <asm/nospec-branch.h>
 
 #include "trace.h"
