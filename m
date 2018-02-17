Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeBQLmJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:42:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35761 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbeBQLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:42:07 -0500
Date: Sat, 17 Feb 2018 03:41:40 -0800
From: tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-3c9e76dbea004b2c7c3ce872022ceaf5ff0dae79@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        bhe@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, hpa@zytor.com, ebiederm@xmission.com
Reply-To: peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org, bhe@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <20180214054656.3780-3-bhe@redhat.com>
References: <20180214054656.3780-3-bhe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Split disable_IO_APIC() into two functions
 to fix CONFIG_KEXEC_JUMP=y
Git-Commit-ID: 3c9e76dbea004b2c7c3ce872022ceaf5ff0dae79
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

Commit-ID:  3c9e76dbea004b2c7c3ce872022ceaf5ff0dae79
Gitweb:     https://git.kernel.org/tip/3c9e76dbea004b2c7c3ce872022ceaf5ff0dae79
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Wed, 14 Feb 2018 13:46:52 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 11:47:44 +0100

x86/apic: Split disable_IO_APIC() into two functions to fix CONFIG_KEXEC_JUMP=y

Split  following patches disable_IO_APIC() will be broken up into
clear_IO_APIC() and restore_boot_irq_mode().

These two functions will be called separately where they are needed
to fix a regression introduced by:

  522e66464467 ("x86/apic: Disable I/O APIC before shutdown of the local APIC").

While the CONFIG_KEXEC_JUMP=y code doesn't call lapic_shutdown() before jump
like kexec/kdump, so it's not impacted by commit 522e66464467.

Hence here change clear_IO_APIC() as public, and replace disable_IO_APIC()
with clear_IO_APIC() and restore_boot_irq_mode() to keep CONFIG_KEXEC_JUMP=y
code unchanged in essence. No functional change.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Eric W. Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: douly.fnst@cn.fujitsu.com
Cc: joro@8bytes.org
Cc: prarit@redhat.com
Cc: uobergfe@redhat.com
Link: http://lkml.kernel.org/r/20180214054656.3780-3-bhe@redhat.com
[ Rewrote the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/io_apic.h     | 1 +
 arch/x86/kernel/apic/io_apic.c     | 2 +-
 arch/x86/kernel/machine_kexec_32.c | 3 ++-
 arch/x86/kernel/machine_kexec_64.c | 3 ++-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 4e3bb13..2ae1b424c 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -193,6 +193,7 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
 extern void setup_IO_APIC(void);
 extern void enable_IO_APIC(void);
 extern void disable_IO_APIC(void);
+extern void clear_IO_APIC(void);
 extern void restore_boot_irq_mode(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
 extern void print_IO_APICs(void);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7b73b6b..2d7cd2d 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -587,7 +587,7 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 		       mpc_ioapic_id(apic), pin);
 }
 
-static void clear_IO_APIC (void)
+void clear_IO_APIC (void)
 {
 	int apic, pin;
 
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index edfede7..4cd79d8 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -199,7 +199,8 @@ void machine_kexec(struct kimage *image)
 		 * one form or other. kexec jump path also need
 		 * one.
 		 */
-		disable_IO_APIC();
+		clear_IO_APIC();
+		restore_boot_irq_mode();
 #endif
 	}
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1f790cf..2ab14b9 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -297,7 +297,8 @@ void machine_kexec(struct kimage *image)
 		 * one form or other. kexec jump path also need
 		 * one.
 		 */
-		disable_IO_APIC();
+		clear_IO_APIC();
+		restore_boot_irq_mode();
 #endif
 	}
 
