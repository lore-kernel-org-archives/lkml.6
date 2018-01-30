Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeA3XEH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:04:07 -0500
Received: from terminus.zytor.com ([65.50.211.136]:37339 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753738AbeA3XEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:04:01 -0500
Date: Tue, 30 Jan 2018 15:02:52 -0800
From: tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-b0c39dc68e3b3d22bf9d2984f62f6c86788a49e7@git.kernel.org>
Cc: mmorsy@redhat.com, sthemmin@microsoft.com, luto@kernel.org,
        kys@microsoft.com, tglx@linutronix.de, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
        pbonzini@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rkagan@virtuozzo.com, haiyangz@microsoft.com, cavery@redhat.com
Reply-To: tglx@linutronix.de, luto@kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, mmorsy@redhat.com, rkrcmar@redhat.com,
        hpa@zytor.com, vkuznets@redhat.com, Michael.H.Kelley@microsoft.com,
        pbonzini@redhat.com, cavery@redhat.com, haiyangz@microsoft.com,
        rkagan@virtuozzo.com, linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180124132337.30138-7-vkuznets@redhat.com>
References: <20180124132337.30138-7-vkuznets@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/kvm: Pass stable clocksource to guests when
 running nested on Hyper-V
Git-Commit-ID: b0c39dc68e3b3d22bf9d2984f62f6c86788a49e7
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

Commit-ID:  b0c39dc68e3b3d22bf9d2984f62f6c86788a49e7
Gitweb:     https://git.kernel.org/tip/b0c39dc68e3b3d22bf9d2984f62f6c86788a49e7
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Wed, 24 Jan 2018 14:23:36 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 23:55:34 +0100

x86/kvm: Pass stable clocksource to guests when running nested on Hyper-V

Currently, KVM is able to work in 'masterclock' mode passing
PVCLOCK_TSC_STABLE_BIT to guests when the clocksource which is used on the
host is TSC.

When running nested on Hyper-V the guest normally uses a different one: TSC
page which is resistant to TSC frequency changes on events like L1
migration. Add support for it in KVM.

The only non-trivial change is in vgettsc(): when updating the gtod copy
both the clock readout and tsc value have to be updated now.

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
Link: https://lkml.kernel.org/r/20180124132337.30138-7-vkuznets@redhat.com

---
 arch/x86/kvm/x86.c | 93 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c53298d..b1ce368 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -67,6 +67,7 @@
 #include <asm/pvclock.h>
 #include <asm/div64.h>
 #include <asm/irq_remapping.h>
+#include <asm/mshyperv.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -1377,6 +1378,11 @@ static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
 	return tsc;
 }
 
+static inline int gtod_is_based_on_tsc(int mode)
+{
+	return mode == VCLOCK_TSC || mode == VCLOCK_HVCLOCK;
+}
+
 static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_X86_64
@@ -1396,7 +1402,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
 	 * perform request to enable masterclock.
 	 */
 	if (ka->use_master_clock ||
-	    (gtod->clock.vclock_mode == VCLOCK_TSC && vcpus_matched))
+	    (gtod_is_based_on_tsc(gtod->clock.vclock_mode) && vcpus_matched))
 		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
 
 	trace_kvm_track_tsc(vcpu->vcpu_id, ka->nr_vcpus_matched_tsc,
@@ -1459,6 +1465,19 @@ static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 	vcpu->arch.tsc_offset = offset;
 }
 
+static inline bool kvm_check_tsc_unstable(void)
+{
+#ifdef CONFIG_X86_64
+	/*
+	 * TSC is marked unstable when we're running on Hyper-V,
+	 * 'TSC page' clocksource is good.
+	 */
+	if (pvclock_gtod_data.clock.vclock_mode == VCLOCK_HVCLOCK)
+		return false;
+#endif
+	return check_tsc_unstable();
+}
+
 void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -1504,7 +1523,7 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr)
          */
 	if (synchronizing &&
 	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
-		if (!check_tsc_unstable()) {
+		if (!kvm_check_tsc_unstable()) {
 			offset = kvm->arch.cur_tsc_offset;
 			pr_debug("kvm: matched tsc offset for %llu\n", data);
 		} else {
@@ -1604,18 +1623,43 @@ static u64 read_tsc(void)
 	return last;
 }
 
-static inline u64 vgettsc(u64 *cycle_now)
+static inline u64 vgettsc(u64 *tsc_timestamp, int *mode)
 {
 	long v;
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
+	u64 tsc_pg_val;
+
+	switch (gtod->clock.vclock_mode) {
+	case VCLOCK_HVCLOCK:
+		tsc_pg_val = hv_read_tsc_page_tsc(hv_get_tsc_page(),
+						  tsc_timestamp);
+		if (tsc_pg_val != U64_MAX) {
+			/* TSC page valid */
+			*mode = VCLOCK_HVCLOCK;
+			v = (tsc_pg_val - gtod->clock.cycle_last) &
+				gtod->clock.mask;
+		} else {
+			/* TSC page invalid */
+			*mode = VCLOCK_NONE;
+		}
+		break;
+	case VCLOCK_TSC:
+		*mode = VCLOCK_TSC;
+		*tsc_timestamp = read_tsc();
+		v = (*tsc_timestamp - gtod->clock.cycle_last) &
+			gtod->clock.mask;
+		break;
+	default:
+		*mode = VCLOCK_NONE;
+	}
 
-	*cycle_now = read_tsc();
+	if (*mode == VCLOCK_NONE)
+		*tsc_timestamp = v = 0;
 
-	v = (*cycle_now - gtod->clock.cycle_last) & gtod->clock.mask;
 	return v * gtod->clock.mult;
 }
 
-static int do_monotonic_boot(s64 *t, u64 *cycle_now)
+static int do_monotonic_boot(s64 *t, u64 *tsc_timestamp)
 {
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 	unsigned long seq;
@@ -1624,9 +1668,8 @@ static int do_monotonic_boot(s64 *t, u64 *cycle_now)
 
 	do {
 		seq = read_seqcount_begin(&gtod->seq);
-		mode = gtod->clock.vclock_mode;
 		ns = gtod->nsec_base;
-		ns += vgettsc(cycle_now);
+		ns += vgettsc(tsc_timestamp, &mode);
 		ns >>= gtod->clock.shift;
 		ns += gtod->boot_ns;
 	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
@@ -1635,7 +1678,7 @@ static int do_monotonic_boot(s64 *t, u64 *cycle_now)
 	return mode;
 }
 
-static int do_realtime(struct timespec *ts, u64 *cycle_now)
+static int do_realtime(struct timespec *ts, u64 *tsc_timestamp)
 {
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 	unsigned long seq;
@@ -1644,10 +1687,9 @@ static int do_realtime(struct timespec *ts, u64 *cycle_now)
 
 	do {
 		seq = read_seqcount_begin(&gtod->seq);
-		mode = gtod->clock.vclock_mode;
 		ts->tv_sec = gtod->wall_time_sec;
 		ns = gtod->nsec_base;
-		ns += vgettsc(cycle_now);
+		ns += vgettsc(tsc_timestamp, &mode);
 		ns >>= gtod->clock.shift;
 	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
 
@@ -1657,25 +1699,26 @@ static int do_realtime(struct timespec *ts, u64 *cycle_now)
 	return mode;
 }
 
-/* returns true if host is using tsc clocksource */
-static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *cycle_now)
+/* returns true if host is using TSC based clocksource */
+static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 {
 	/* checked again under seqlock below */
-	if (pvclock_gtod_data.clock.vclock_mode != VCLOCK_TSC)
+	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
 		return false;
 
-	return do_monotonic_boot(kernel_ns, cycle_now) == VCLOCK_TSC;
+	return gtod_is_based_on_tsc(do_monotonic_boot(kernel_ns,
+						      tsc_timestamp));
 }
 
-/* returns true if host is using tsc clocksource */
+/* returns true if host is using TSC based clocksource */
 static bool kvm_get_walltime_and_clockread(struct timespec *ts,
-					   u64 *cycle_now)
+					   u64 *tsc_timestamp)
 {
 	/* checked again under seqlock below */
-	if (pvclock_gtod_data.clock.vclock_mode != VCLOCK_TSC)
+	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
 		return false;
 
-	return do_realtime(ts, cycle_now) == VCLOCK_TSC;
+	return gtod_is_based_on_tsc(do_realtime(ts, tsc_timestamp));
 }
 #endif
 
@@ -2869,13 +2912,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 	}
 
-	if (unlikely(vcpu->cpu != cpu) || check_tsc_unstable()) {
+	if (unlikely(vcpu->cpu != cpu) || kvm_check_tsc_unstable()) {
 		s64 tsc_delta = !vcpu->arch.last_host_tsc ? 0 :
 				rdtsc() - vcpu->arch.last_host_tsc;
 		if (tsc_delta < 0)
 			mark_tsc_unstable("KVM discovered backwards TSC");
 
-		if (check_tsc_unstable()) {
+		if (kvm_check_tsc_unstable()) {
 			u64 offset = kvm_compute_tsc_offset(vcpu,
 						vcpu->arch.last_guest_tsc);
 			kvm_vcpu_write_tsc_offset(vcpu, offset);
@@ -6110,9 +6153,9 @@ static int pvclock_gtod_notify(struct notifier_block *nb, unsigned long unused,
 	update_pvclock_gtod(tk);
 
 	/* disable master clock if host does not trust, or does not
-	 * use, TSC clocksource
+	 * use, TSC based clocksource.
 	 */
-	if (gtod->clock.vclock_mode != VCLOCK_TSC &&
+	if (!gtod_is_based_on_tsc(gtod->clock.vclock_mode) &&
 	    atomic_read(&kvm_guest_has_master_clock) != 0)
 		queue_work(system_long_wq, &pvclock_gtod_work);
 
@@ -7767,7 +7810,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 {
 	struct kvm_vcpu *vcpu;
 
-	if (check_tsc_unstable() && atomic_read(&kvm->online_vcpus) != 0)
+	if (kvm_check_tsc_unstable() && atomic_read(&kvm->online_vcpus) != 0)
 		printk_once(KERN_WARNING
 		"kvm: SMP vm created on host with unstable TSC; "
 		"guest TSC will not be reliable\n");
@@ -7924,7 +7967,7 @@ int kvm_arch_hardware_enable(void)
 		return ret;
 
 	local_tsc = rdtsc();
-	stable = !check_tsc_unstable();
+	stable = !kvm_check_tsc_unstable();
 	list_for_each_entry(kvm, &vm_list, vm_list) {
 		kvm_for_each_vcpu(i, vcpu, kvm) {
 			if (!stable && vcpu->cpu == smp_processor_id())
