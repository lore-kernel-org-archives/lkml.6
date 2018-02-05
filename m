Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeBEG7L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:59:11 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:40259 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbeBEG6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:58:49 -0500
X-Google-Smtp-Source: AH8x225gowk0HQANfNb76UkXWEdf4kve2FtZUcdUFSri3n9E6q/7jTMdx9eIgcqZslNDp1cBDiSTEA==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 2/2] KVM: X86: Avoid traversing all the cpus for pv tlb flush when steal time is disabled
Date: Sun,  4 Feb 2018 22:57:58 -0800
Message-Id: <1517813878-22248-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517813878-22248-1-git-send-email-wanpengli@tencent.com>
References: <1517813878-22248-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Avoid traversing all the cpus for pv tlb flush when steal time 
is disabled since pv tlb flush depends on the field in steal time 
for shared data.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index f2a09cf..4f3c997 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -546,7 +546,8 @@ static void __init kvm_guest_init(void)
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
-			!kvm_para_has_feature(KVM_FEATURE_PV_DEDICATED))
+			!kvm_para_has_feature(KVM_FEATURE_PV_DEDICATED) &&
+			kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
 		pv_mmu_ops.flush_tlb_others = kvm_flush_tlb_others;
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
@@ -635,7 +636,8 @@ static __init int kvm_setup_pv_tlb_flush(void)
 	int cpu;
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
-			!kvm_para_has_feature(KVM_FEATURE_PV_DEDICATED)) {
+			!kvm_para_has_feature(KVM_FEATURE_PV_DEDICATED) &&
+			kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		for_each_possible_cpu(cpu) {
 			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_tlb_mask, cpu),
 				GFP_KERNEL, cpu_to_node(cpu));
-- 
2.7.4
