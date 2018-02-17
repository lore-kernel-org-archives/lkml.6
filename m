Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbeBQLld (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:41:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52301 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeBQLlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:41:31 -0500
Date: Sat, 17 Feb 2018 03:41:10 -0800
From: tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-ce279cdc04aafd5c41ae49f941ee2c3342e35e3e@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, hpa@zytor.com
Reply-To: hpa@zytor.com, bhe@redhat.com, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, ebiederm@xmission.com
In-Reply-To: <20180214054656.3780-2-bhe@redhat.com>
References: <20180214054656.3780-2-bhe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Split out restore_boot_irq_mode() from
 disable_IO_APIC()
Git-Commit-ID: ce279cdc04aafd5c41ae49f941ee2c3342e35e3e
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

Commit-ID:  ce279cdc04aafd5c41ae49f941ee2c3342e35e3e
Gitweb:     https://git.kernel.org/tip/ce279cdc04aafd5c41ae49f941ee2c3342e35e3e
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Wed, 14 Feb 2018 13:46:51 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 11:47:29 +0100

x86/apic: Split out restore_boot_irq_mode() from disable_IO_APIC()

This is a preparation patch. Split out the code which restores boot
irq mode from disable_IO_APIC() into the new restore_boot_irq_mode()
function.

No functional changes.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Eric W. Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: douly.fnst@cn.fujitsu.com
Cc: joro@8bytes.org
Cc: prarit@redhat.com
Cc: uobergfe@redhat.com
Link: http://lkml.kernel.org/r/20180214054656.3780-2-bhe@redhat.com
[ Build fix for !CONFIG_IO_APIC and rewrote the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/io_apic.h | 2 ++
 arch/x86/kernel/apic/io_apic.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index a8834dd..4e3bb13 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -193,6 +193,7 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
 extern void setup_IO_APIC(void);
 extern void enable_IO_APIC(void);
 extern void disable_IO_APIC(void);
+extern void restore_boot_irq_mode(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
 extern void print_IO_APICs(void);
 #else  /* !CONFIG_X86_IO_APIC */
@@ -232,6 +233,7 @@ static inline void io_apic_init_mappings(void) { }
 
 static inline void setup_IO_APIC(void) { }
 static inline void enable_IO_APIC(void) { }
+static inline void restore_boot_irq_mode(void) { }
 
 #endif
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 8ad2e41..7b73b6b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1448,6 +1448,11 @@ void disable_IO_APIC(void)
 	 */
 	clear_IO_APIC();
 
+	restore_boot_irq_mode();
+}
+
+void restore_boot_irq_mode(void)
+{
 	if (!nr_legacy_irqs())
 		return;
 
