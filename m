Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBIOtQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:49:16 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37457 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeBIOtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:49:14 -0500
X-Google-Smtp-Source: AH8x225+XoNPpUBa6yQMyTY3xUdAGRM9DYe1Ky162H/sN1tNdtHd49KxymmvPPSIUL5/f1EXHgTw1w==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v2 2/2] KVM: X86: Don't use PV TLB flush with dedicated vCPUs and steal time disabled
Date: Fri,  9 Feb 2018 06:47:53 -0800
Message-Id: <1518187673-70832-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518187673-70832-1-git-send-email-wanpengli@tencent.com>
References: <1518187673-70832-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

vCPUs are very unlikely to get preempted when they are the only task
running on a CPU.  PV TLB flush is slower that the native flush in that
case. In addition, avoid traversing all the cpus for pv tlb flush when 
steal time is disabled since pv tlb flush depends on the field in steal 
time for shared data.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v1 -> v2:
 * update to KVM_HINTS_DEDICATED

 arch/x86/kernel/kvm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7f4c92d..b92311a 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -545,7 +545,9 @@ static void __init kvm_guest_init(void)
 		pv_time_ops.steal_clock = kvm_steal_clock;
 	}
 
-	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH))
+	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
+		!kvm_para_has_feature(KVM_HINTS_DEDICATED) &&
+		!kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
 		pv_mmu_ops.flush_tlb_others = kvm_flush_tlb_others;
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
@@ -633,7 +635,9 @@ static __init int kvm_setup_pv_tlb_flush(void)
 {
 	int cpu;
 
-	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH)) {
+	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
+		!kvm_para_has_feature(KVM_HINTS_DEDICATED) &&
+		!kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		for_each_possible_cpu(cpu) {
 			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_tlb_mask, cpu),
 				GFP_KERNEL, cpu_to_node(cpu));
-- 
2.7.4
