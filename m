Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754090AbeA3XDh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:03:37 -0500
Received: from terminus.zytor.com ([65.50.211.136]:41783 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753600AbeA3XDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:03:35 -0500
Date: Tue, 30 Jan 2018 15:02:27 -0800
From: tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-51d4e5daa32808df4d50db511d167fde19fa114e@git.kernel.org>
Cc: sthemmin@microsoft.com, mmorsy@redhat.com,
        Michael.H.Kelley@microsoft.com, pbonzini@redhat.com, mingo@kernel.org,
        kys@microsoft.com, vkuznets@redhat.com, cavery@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, hpa@zytor.com,
        rkrcmar@redhat.com, haiyangz@microsoft.com, tglx@linutronix.de,
        rkagan@virtuozzo.com
Reply-To: mmorsy@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, kys@microsoft.com, pbonzini@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, cavery@redhat.com,
        vkuznets@redhat.com, hpa@zytor.com, luto@kernel.org,
        rkrcmar@redhat.com, rkagan@virtuozzo.com, tglx@linutronix.de,
        haiyangz@microsoft.com
In-Reply-To: <20180124132337.30138-6-vkuznets@redhat.com>
References: <20180124132337.30138-6-vkuznets@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/irq: Count Hyper-V reenlightenment interrupts
Git-Commit-ID: 51d4e5daa32808df4d50db511d167fde19fa114e
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

Commit-ID:  51d4e5daa32808df4d50db511d167fde19fa114e
Gitweb:     https://git.kernel.org/tip/51d4e5daa32808df4d50db511d167fde19fa114e
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Wed, 24 Jan 2018 14:23:35 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 23:55:33 +0100

x86/irq: Count Hyper-V reenlightenment interrupts

Hyper-V reenlightenment interrupts arrive when the VM is migrated, While
they are not interesting in general it's important when L2 nested guests
are running.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: kvm@vger.kernel.org
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: devel@linuxdriverproject.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Cathy Avery <cavery@redhat.com>
Cc: Mohammed Gamal <mmorsy@redhat.com>
Link: https://lkml.kernel.org/r/20180124132337.30138-6-vkuznets@redhat.com

---
 arch/x86/hyperv/hv_init.c      | 2 ++
 arch/x86/include/asm/hardirq.h | 3 +++
 arch/x86/kernel/irq.c          | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e4377e2..a3adece 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -147,6 +147,8 @@ __visible void __irq_entry hyperv_reenlightenment_intr(struct pt_regs *regs)
 {
 	entering_ack_irq();
 
+	inc_irq_stat(irq_hv_reenlightenment_count);
+
 	schedule_delayed_work(&hv_reenlightenment_work, HZ/10);
 
 	exiting_irq();
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 51cc979..7c341a7 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -38,6 +38,9 @@ typedef struct {
 #if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
 	unsigned int irq_hv_callback_count;
 #endif
+#if IS_ENABLED(CONFIG_HYPERV)
+	unsigned int irq_hv_reenlightenment_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 68e1867..45fb4d2 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -142,6 +142,15 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_puts(p, "  Hypervisor callback interrupts\n");
 	}
 #endif
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (test_bit(HYPERV_REENLIGHTENMENT_VECTOR, system_vectors)) {
+		seq_printf(p, "%*s: ", prec, "HRE");
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ",
+				   irq_stats(j)->irq_hv_reenlightenment_count);
+		seq_puts(p, "  Hyper-V reenlightenment interrupts\n");
+	}
+#endif
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
 #if defined(CONFIG_X86_IO_APIC)
 	seq_printf(p, "%*s: %10u\n", prec, "MIS", atomic_read(&irq_mis_count));
