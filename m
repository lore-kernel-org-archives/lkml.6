Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965329AbeBMQ7b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:59:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49811 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964939AbeBMQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:59:28 -0500
Date: Tue, 13 Feb 2018 08:59:04 -0800
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-ccf5355d05cd891522267f04b2723002e7f061de@git.kernel.org>
Cc: mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        douly.fnst@cn.fujitsu.com, hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <20180117073748.23905-1-douly.fnst@cn.fujitsu.com>
References: <20180117073748.23905-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Simplify init_bsp_APIC() usage
Git-Commit-ID: ccf5355d05cd891522267f04b2723002e7f061de
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

Commit-ID:  ccf5355d05cd891522267f04b2723002e7f061de
Gitweb:     https://git.kernel.org/tip/ccf5355d05cd891522267f04b2723002e7f061de
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Wed, 17 Jan 2018 15:37:48 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 17:30:38 +0100

x86/apic: Simplify init_bsp_APIC() usage

Since CONFIG_X86_64 selects CONFIG_X86_LOCAL_APIC, the following
condition:

  #if defined(CONFIG_X86_64) || defined(CONFIG_X86_LOCAL_APIC)

is equivalent to:

  #if defined(CONFIG_X86_LOCAL_APIC)

... and we can eliminate that #ifdef by providing an empty
init_bsp_APIC() stub in the !CONFIG_X86_LOCAL_APIC case.

Also add some comments to explain why we call init_bsp_APIC().

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: mroos@linux.ee
Cc: ville.syrjala@linux.intel.com
Link: http://lkml.kernel.org/r/20180117073748.23905-1-douly.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/apic.h | 1 +
 arch/x86/kernel/irqinit.c   | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9872277..6e1990d 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -183,6 +183,7 @@ static inline void disable_local_APIC(void) { }
 # define setup_boot_APIC_clock x86_init_noop
 # define setup_secondary_APIC_clock x86_init_noop
 static inline void lapic_update_tsc_freq(void) { }
+static inline void init_bsp_APIC(void) { }
 static inline void apic_intr_mode_init(void) { }
 static inline void lapic_assign_system_vectors(void) { }
 static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index a539410..772196c 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -61,9 +61,14 @@ void __init init_ISA_irqs(void)
 	struct irq_chip *chip = legacy_pic->chip;
 	int i;
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_X86_LOCAL_APIC)
+	/*
+	 * Try to set up the through-local-APIC virtual wire mode earlier.
+	 *
+	 * On some 32-bit UP machines, whose APIC has been disabled by BIOS
+	 * and then got re-enabled by "lapic", it hangs at boot time without this.
+	 */
 	init_bsp_APIC();
-#endif
+
 	legacy_pic->init(0);
 
 	for (i = 0; i < nr_legacy_irqs(); i++)
