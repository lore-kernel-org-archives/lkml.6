Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeA3XE2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:04:28 -0500
Received: from terminus.zytor.com ([65.50.211.136]:54713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753615AbeA3XE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:04:27 -0500
Date: Tue, 30 Jan 2018 15:03:17 -0800
From: tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-0092e4346f49558e5fe5a927c6d78d401dc4ed73@git.kernel.org>
Cc: vkuznets@redhat.com, linux-kernel@vger.kernel.org,
        sthemmin@microsoft.com, mmorsy@redhat.com, kys@microsoft.com,
        tglx@linutronix.de, pbonzini@redhat.com, hpa@zytor.com,
        rkrcmar@redhat.com, Michael.H.Kelley@microsoft.com,
        rkagan@virtuozzo.com, haiyangz@microsoft.com, mingo@kernel.org,
        cavery@redhat.com, luto@kernel.org
Reply-To: vkuznets@redhat.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org, mmorsy@redhat.com, kys@microsoft.com,
        pbonzini@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        rkrcmar@redhat.com, Michael.H.Kelley@microsoft.com,
        rkagan@virtuozzo.com, haiyangz@microsoft.com, mingo@kernel.org,
        cavery@redhat.com, luto@kernel.org
In-Reply-To: <20180124132337.30138-8-vkuznets@redhat.com>
References: <20180124132337.30138-8-vkuznets@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/kvm: Support Hyper-V reenlightenment
Git-Commit-ID: 0092e4346f49558e5fe5a927c6d78d401dc4ed73
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

Commit-ID:  0092e4346f49558e5fe5a927c6d78d401dc4ed73
Gitweb:     https://git.kernel.org/tip/0092e4346f49558e5fe5a927c6d78d401dc4ed73
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Wed, 24 Jan 2018 14:23:37 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 23:55:34 +0100

x86/kvm: Support Hyper-V reenlightenment

When running nested KVM on Hyper-V guests its required to update
masterclocks for all guests when L1 migrates to a host with different TSC
frequency.

Implement the procedure in the following way:
  - Pause all guests.
  - Tell the host (Hyper-V) to stop emulating TSC accesses.
  - Update the gtod copy, recompute clocks.
  - Unpause all guests.

This is somewhat similar to cpufreq but there are two important differences:
 - TSC emulation can only be disabled globally (on all CPUs)
 - The new TSC frequency is not known until emulation is turned off so
   there is no way to 'prepare' for the event upfront.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: kvm@vger.kernel.org
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: devel@linuxdriverproject.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Cathy Avery <cavery@redhat.com>
Cc: Mohammed Gamal <mmorsy@redhat.com>
Link: https://lkml.kernel.org/r/20180124132337.30138-8-vkuznets@redhat.com

---
 arch/x86/kvm/x86.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b1ce368..879a999 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -68,6 +68,7 @@
 #include <asm/div64.h>
 #include <asm/irq_remapping.h>
 #include <asm/mshyperv.h>
+#include <asm/hypervisor.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -5932,6 +5933,43 @@ static void tsc_khz_changed(void *data)
 	__this_cpu_write(cpu_tsc_khz, khz);
 }
 
+static void kvm_hyperv_tsc_notifier(void)
+{
+#ifdef CONFIG_X86_64
+	struct kvm *kvm;
+	struct kvm_vcpu *vcpu;
+	int cpu;
+
+	spin_lock(&kvm_lock);
+	list_for_each_entry(kvm, &vm_list, vm_list)
+		kvm_make_mclock_inprogress_request(kvm);
+
+	hyperv_stop_tsc_emulation();
+
+	/* TSC frequency always matches when on Hyper-V */
+	for_each_present_cpu(cpu)
+		per_cpu(cpu_tsc_khz, cpu) = tsc_khz;
+	kvm_max_guest_tsc_khz = tsc_khz;
+
+	list_for_each_entry(kvm, &vm_list, vm_list) {
+		struct kvm_arch *ka = &kvm->arch;
+
+		spin_lock(&ka->pvclock_gtod_sync_lock);
+
+		pvclock_update_vm_gtod_copy(kvm);
+
+		kvm_for_each_vcpu(cpu, vcpu, kvm)
+			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+
+		kvm_for_each_vcpu(cpu, vcpu, kvm)
+			kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
+
+		spin_unlock(&ka->pvclock_gtod_sync_lock);
+	}
+	spin_unlock(&kvm_lock);
+#endif
+}
+
 static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 				     void *data)
 {
@@ -6217,6 +6255,9 @@ int kvm_arch_init(void *opaque)
 	kvm_lapic_init();
 #ifdef CONFIG_X86_64
 	pvclock_gtod_register_notifier(&pvclock_gtod_notifier);
+
+	if (x86_hyper_type == X86_HYPER_MS_HYPERV)
+		set_hv_tscchange_cb(kvm_hyperv_tsc_notifier);
 #endif
 
 	return 0;
@@ -6229,6 +6270,10 @@ out:
 
 void kvm_arch_exit(void)
 {
+#ifdef CONFIG_X86_64
+	if (x86_hyper_type == X86_HYPER_MS_HYPERV)
+		clear_hv_tscchange_cb();
+#endif
 	kvm_lapic_exit();
 	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
 
