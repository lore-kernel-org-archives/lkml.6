Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbeCYETf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 00:19:35 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33711 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeCYETe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 00:19:34 -0400
X-Google-Smtp-Source: AIpwx48IDp4mnbqdhyRYLhv04kPEQkvDK2xn5qnRsvxxm5BJS6r30qY86jum7P5T0XZj1wxrhFDPOQ==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 2/2] KVM: X86: Fix disable pv tlb flush when steal time is enabled
Date: Sat, 24 Mar 2018 21:18:35 -0700
Message-Id: <1521951515-5139-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

PV TLB FLUSH can be turned on when steal time is enabled. The condition 
reverse when the patch is sent out for several rounds review by mistake. 
This patch fixes it.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 31ac585..4f859cc 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -555,7 +555,7 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
 	    !kvm_para_has_hint(KVM_HINTS_DEDICATED) &&
-	    !kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
+	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
 		pv_mmu_ops.flush_tlb_others = kvm_flush_tlb_others;
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
@@ -651,7 +651,7 @@ static __init int kvm_setup_pv_tlb_flush(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
 	    !kvm_para_has_hint(KVM_HINTS_DEDICATED) &&
-	    !kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
+	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		for_each_possible_cpu(cpu) {
 			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_tlb_mask, cpu),
 				GFP_KERNEL, cpu_to_node(cpu));
-- 
2.7.4
