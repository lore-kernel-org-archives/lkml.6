Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933925AbeBMKLM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:11:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751132AbeBMKLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:11:08 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Cc: mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        douly.fnst@cn.fujitsu.com, joro@8bytes.org, uobergfe@redhat.com,
        prarit@redhat.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 1/5] x86/apic: Split out restore_boot_irq_mode from disable_IO_APIC
Date: Tue, 13 Feb 2018 18:10:47 +0800
Message-Id: <20180213101051.13630-2-bhe@redhat.com>
In-Reply-To: <20180213101051.13630-1-bhe@redhat.com>
References: <20180213101051.13630-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch. Split out the code which restores boot
irq mode from disable_IO_APIC() and wrap into a new function
restore_boot_irq_mode(). No functional change.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/io_apic.h | 1 +
 arch/x86/kernel/apic/io_apic.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index a8834dd546cd..558d1a6a13ad 100644
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
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 8ad2e410974f..7b73b6b9b4b6 100644
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
 
-- 
2.13.6
