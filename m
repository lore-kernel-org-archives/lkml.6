Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeBBHM2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:12:28 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39901 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBBHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:12:06 -0500
X-Google-Smtp-Source: AH8x224r+6u5MXjlr6wIBV8AuVRlWTKyhnDUNYm5qMM2+votrq4O5p1Sm8slJf/PN1Tlkh3yxNTxlQ==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 1/2] KVM: X86: Add dedicated pCPU hint PV_DEDICATED
Date: Thu,  1 Feb 2018 23:11:12 -0800
Message-Id: <1517555473-8313-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517555473-8313-1-git-send-email-wanpengli@tencent.com>
References: <1517555473-8313-1-git-send-email-wanpengli@tencent.com>
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
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/cpuid.txt  | 6 ++++++
 arch/x86/include/uapi/asm/kvm_para.h | 1 +
 arch/x86/kernel/kvm.c                | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
index 87a7506..c0740b1 100644
--- a/Documentation/virtual/kvm/cpuid.txt
+++ b/Documentation/virtual/kvm/cpuid.txt
@@ -54,6 +54,12 @@ KVM_FEATURE_PV_UNHALT              ||     7 || guest checks this feature bit
                                    ||       || before enabling paravirtualized
                                    ||       || spinlock support.
 ------------------------------------------------------------------------------
+KVM_FEATURE_PV_DEDICATED           ||     8 || guest checks this feature bit
+                                   ||       || to determine if they run on
+                                   ||       || dedicated vCPUs, allowing opti-
+                                   ||       || mizations such as usage of
+                                   ||       || qspinlocks.
+------------------------------------------------------------------------------
 KVM_FEATURE_PV_TLB_FLUSH           ||     9 || guest checks this feature bit
                                    ||       || before enabling paravirtualized
                                    ||       || tlb flush.
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 6cfa9c8..9a5ef67 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -25,6 +25,7 @@
 #define KVM_FEATURE_STEAL_TIME		5
 #define KVM_FEATURE_PV_EOI		6
 #define KVM_FEATURE_PV_UNHALT		7
+#define KVM_FEATURE_PV_DEDICATED	8
 #define KVM_FEATURE_PV_TLB_FLUSH	9
 #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index aa2b706..6f0e43f 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -726,6 +726,12 @@ void __init kvm_spinlock_init(void)
 {
 	if (!kvm_para_available())
 		return;
+
+	if (kvm_para_has_feature(KVM_FEATURE_PV_DEDICATED)) {
+		static_branch_disable(&virt_spin_lock_key);
+		return;
+	}
+
 	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return;
-- 
2.7.4
