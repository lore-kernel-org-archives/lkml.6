Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeC1IqS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:46:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43109 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbeC1IqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:46:14 -0400
Date: Wed, 28 Mar 2018 01:45:59 -0700
From: tip-bot for Andrew Banman <tipbot@zytor.com>
Message-ID: <tip-151ad17fbe5e56afa59709f41980508672c777ce@git.kernel.org>
Cc: hpa@zytor.com, rja@hpe.com, mingo@kernel.org, mike.travis@hpe.com,
        abanman@hpe.com, linux-kernel@vger.kernel.org, sivanich@hpe.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, sivanich@hpe.com, abanman@hpe.com,
        mike.travis@hpe.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rja@hpe.com, hpa@zytor.com
In-Reply-To: <1522188546-196177-1-git-send-email-abanman@hpe.com>
References: <1522188546-196177-1-git-send-email-abanman@hpe.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/platform/uv/BAU: Add APIC idt entry
Git-Commit-ID: 151ad17fbe5e56afa59709f41980508672c777ce
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

Commit-ID:  151ad17fbe5e56afa59709f41980508672c777ce
Gitweb:     https://git.kernel.org/tip/151ad17fbe5e56afa59709f41980508672c777ce
Author:     Andrew Banman <abanman@hpe.com>
AuthorDate: Tue, 27 Mar 2018 17:09:06 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Mar 2018 10:40:55 +0200

x86/platform/uv/BAU: Add APIC idt entry

BAU uses the old alloc_initr_gate90 method to setup its interrupt. This
fails silently as the BAU vector is in the range of APIC vectors that are
registered to the spurious interrupt handler. As a consequence BAU
broadcasts are not handled, and the broadcast source CPU hangs.

Update BAU to use new idt structure.

Fixes: dc20b2d52653 ("x86/idt: Move interrupt gate initialization to IDT code")
Signed-off-by: Andrew Banman <abanman@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Cc: stable@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1522188546-196177-1-git-send-email-abanman@hpe.com

---
 arch/x86/include/asm/hw_irq.h | 1 +
 arch/x86/kernel/idt.c         | 3 +++
 arch/x86/platform/uv/tlb_uv.c | 2 --
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 2851077b6051..32e666e1231e 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -36,6 +36,7 @@ extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
 extern asmlinkage void kvm_posted_intr_nested_ipi(void);
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void irq_work_interrupt(void);
+extern asmlinkage void uv_bau_message_intr1(void);
 
 extern asmlinkage void spurious_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 56d99be3706a..5d039c848bd9 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -140,6 +140,9 @@ static const __initconst struct idt_data apic_idts[] = {
 # ifdef CONFIG_IRQ_WORK
 	INTG(IRQ_WORK_VECTOR,		irq_work_interrupt),
 # endif
+#ifdef CONFIG_X86_UV
+	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
+#endif
 	INTG(SPURIOUS_APIC_VECTOR,	spurious_interrupt),
 	INTG(ERROR_APIC_VECTOR,		error_interrupt),
 #endif
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index db77e087adaf..b36caae0fb2f 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2255,8 +2255,6 @@ static int __init uv_bau_init(void)
 			init_uvhub(uvhub, vector, uv_base_pnode);
 	}
 
-	alloc_intr_gate(vector, uv_bau_message_intr1);
-
 	for_each_possible_blade(uvhub) {
 		if (uv_blade_nr_possible_cpus(uvhub)) {
 			unsigned long val;
