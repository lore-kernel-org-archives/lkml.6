Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbeCYES2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 00:18:28 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45269 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeCYES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 00:18:26 -0400
X-Google-Smtp-Source: AIpwx49uCgOlc9V/lc9El+aG3K9a393PDeqFSbckMqAIp/FWG/8fqQkLIqOTvBkq6jR0TqFEzJ3LvQ==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] KVM: X86: Fix setup the virt_spin_lock_key before static key get initialized
Date: Sat, 24 Mar 2018 21:17:24 -0700
Message-Id: <1521951444-5087-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

 static_key_disable_cpuslocked(): static key 'virt_spin_lock_key+0x0/0x20' used before call to jump_label_init()
 WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:161 static_key_disable_cpuslocked+0x61/0x80
 RIP: 0010:static_key_disable_cpuslocked+0x61/0x80
 Call Trace:
  static_key_disable+0x16/0x20
  start_kernel+0x192/0x4b3
  secondary_startup_64+0xa5/0xb0

Qspinlock will be choosed when dedicated pCPUs are available, however, the 
static virt_spin_lock_key is set in kvm_spinlock_init() before jump_label_init() 
has been called, which will result in a WARN(). This patch fixes it by delaying
the virt_spin_lock_key setup to .smp_prepare_cpus().

Reported-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
Note: Peterz pointed out in the IRC we have to audit all the architectures that 
implement smp_prepare_boot_cpu() to see what they depend on if we want to move 
jump_label_init() before smp_prepare_boot_cpu(). So what this patch does is 
similar to the issue which handled in xen ca5d376e.

 arch/x86/kernel/kvm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 4ccbff6..747c61b 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -454,6 +454,13 @@ static void __init sev_map_percpu_data(void)
 }
 
 #ifdef CONFIG_SMP
+static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
+{
+	native_smp_prepare_cpus(max_cpus);
+	if (kvm_para_has_hint(KVM_HINTS_DEDICATED))
+		static_branch_disable(&virt_spin_lock_key);
+}
+
 static void __init kvm_smp_prepare_boot_cpu(void)
 {
 	/*
@@ -557,6 +564,7 @@ static void __init kvm_guest_init(void)
 		kvm_setup_vsyscall_timeinfo();
 
 #ifdef CONFIG_SMP
+	smp_ops.smp_prepare_cpus = kvm_smp_prepare_cpus;
 	smp_ops.smp_prepare_boot_cpu = kvm_smp_prepare_boot_cpu;
 	if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/kvm:online",
 				      kvm_cpu_online, kvm_cpu_down_prepare) < 0)
@@ -737,10 +745,8 @@ void __init kvm_spinlock_init(void)
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return;
 
-	if (kvm_para_has_hint(KVM_HINTS_DEDICATED)) {
-		static_branch_disable(&virt_spin_lock_key);
+	if (kvm_para_has_hint(KVM_HINTS_DEDICATED))
 		return;
-	}
 
 	__pv_init_lock_hash();
 	pv_lock_ops.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-- 
2.7.4
