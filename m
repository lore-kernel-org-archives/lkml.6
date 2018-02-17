Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeBQLnI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:43:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49927 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeBQLnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:43:06 -0500
Date: Sat, 17 Feb 2018 03:42:38 -0800
From: tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-50374b96d2d30c03c8d42b3f8846d8938748d454@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org, ebiederm@xmission.com,
        bhe@redhat.com, hpa@zytor.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com, bhe@redhat.com,
        hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20180214054656.3780-5-bhe@redhat.com>
References: <20180214054656.3780-5-bhe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Remove the (now) unused disable_IO_APIC()
 function
Git-Commit-ID: 50374b96d2d30c03c8d42b3f8846d8938748d454
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

Commit-ID:  50374b96d2d30c03c8d42b3f8846d8938748d454
Gitweb:     https://git.kernel.org/tip/50374b96d2d30c03c8d42b3f8846d8938748d454
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Wed, 14 Feb 2018 13:46:54 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 11:47:45 +0100

x86/apic: Remove the (now) unused disable_IO_APIC() function

No one uses it anymore.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Eric W. Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: douly.fnst@cn.fujitsu.com
Cc: joro@8bytes.org
Cc: prarit@redhat.com
Cc: uobergfe@redhat.com
Link: http://lkml.kernel.org/r/20180214054656.3780-5-bhe@redhat.com
[ Rewrote the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/io_apic.h     |  1 -
 arch/x86/kernel/apic/io_apic.c     | 13 -------------
 arch/x86/kernel/machine_kexec_32.c |  5 ++---
 arch/x86/kernel/machine_kexec_64.c |  5 ++---
 4 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 2ae1b424c..8018fc4 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -192,7 +192,6 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
 
 extern void setup_IO_APIC(void);
 extern void enable_IO_APIC(void);
-extern void disable_IO_APIC(void);
 extern void clear_IO_APIC(void);
 extern void restore_boot_irq_mode(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 2d7cd2d..9d86b10 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1438,19 +1438,6 @@ void native_disable_io_apic(void)
 		disconnect_bsp_APIC(ioapic_i8259.pin != -1);
 }
 
-/*
- * Not an __init, needed by the reboot code
- */
-void disable_IO_APIC(void)
-{
-	/*
-	 * Clear the IO-APIC before rebooting:
-	 */
-	clear_IO_APIC();
-
-	restore_boot_irq_mode();
-}
-
 void restore_boot_irq_mode(void)
 {
 	if (!nr_legacy_irqs())
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 4cd79d8..60cdec6 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -195,9 +195,8 @@ void machine_kexec(struct kimage *image)
 		/*
 		 * We need to put APICs in legacy mode so that we can
 		 * get timer interrupts in second kernel. kexec/kdump
-		 * paths already have calls to disable_IO_APIC() in
-		 * one form or other. kexec jump path also need
-		 * one.
+		 * paths already have calls to restore_boot_irq_mode()
+		 * in one form or other. kexec jump path also need one.
 		 */
 		clear_IO_APIC();
 		restore_boot_irq_mode();
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 2ab14b9..5ffbc55 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -293,9 +293,8 @@ void machine_kexec(struct kimage *image)
 		/*
 		 * We need to put APICs in legacy mode so that we can
 		 * get timer interrupts in second kernel. kexec/kdump
-		 * paths already have calls to disable_IO_APIC() in
-		 * one form or other. kexec jump path also need
-		 * one.
+		 * paths already have calls to restore_boot_irq_mode()
+		 * in one form or other. kexec jump path also need one.
 		 */
 		clear_IO_APIC();
 		restore_boot_irq_mode();
