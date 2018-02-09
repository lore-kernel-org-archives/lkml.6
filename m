Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeBIOtC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:49:02 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45877 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeBIOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:49:00 -0500
X-Google-Smtp-Source: AH8x224JNj/r9ZvzoAofNP7D+GMVt4XVP+jNdEqpgUORzw/Wa1y23fsjdeSybpsVTyQtaRarcEgacw==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v2 1/2] KVM: x86: Add dedicated vCPU hint KVM_HINTS_DEDICATED
Date: Fri,  9 Feb 2018 06:47:52 -0800
Message-Id: <1518187673-70832-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Waiman Long mentioned that:

 Generally speaking, unfair lock performs well for VMs with a small
 number of vCPUs. Native qspinlock may perform better than pvqspinlock
 if there is vCPU pinning and there is no vCPU over-commitment.

This patch adds a performance hint to allow hypervisor admin to choose
the qspinlock to be used when a dedicated pCPU is available.

PV_DEDICATED = 1, PV_UNHALT = anything: default is qspinlock
PV_DEDICATED = 0, PV_UNHALT = 1: default is Hybrid PV queued/unfair lock
PV_DEDICATED = 0, PV_UNHALT = 0: default is tas

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v1 -> v2:
 * update to KVM_HINTS_DEDICATED

 Documentation/virtual/kvm/cpuid.txt  | 6 ++++++
 arch/x86/include/uapi/asm/kvm_para.h | 2 ++
 arch/x86/kernel/kvm.c                | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
index 87a7506..d54cc79 100644
--- a/Documentation/virtual/kvm/cpuid.txt
+++ b/Documentation/virtual/kvm/cpuid.txt
@@ -66,3 +66,9 @@ KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
                                    ||       || per-cpu warps are expected in
                                    ||       || kvmclock.
 ------------------------------------------------------------------------------
+KVM_HINTS_DEDICATED                ||     0 || guest checks this feature bit
+                                   ||       || to determine if they run on
+                                   ||       || dedicated vCPUs, allowing opti-
+                                   ||       || mizations such as usage of
+                                   ||       || qspinlocks.
+------------------------------------------------------------------------------
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 6cfa9c8..d65b16b 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -28,6 +28,8 @@
 #define KVM_FEATURE_PV_TLB_FLUSH	9
 #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
 
+#define KVM_HINTS_DEDICATED 0
+
 /* The last 8 bits are used to indicate how to interpret the flags field
  * in pvclock structure. If no bits are set, all flags are ignored.
  */
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 971babe..7f4c92d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -724,6 +724,12 @@ void __init kvm_spinlock_init(void)
 {
 	if (!kvm_para_available())
 		return;
+
+	if (kvm_para_has_feature(KVM_HINTS_DEDICATED)) {
+		static_branch_disable(&virt_spin_lock_key);
+		return;
+	}
+
 	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return;
-- 
2.7.4
