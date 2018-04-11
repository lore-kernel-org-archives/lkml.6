Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDKHR2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:17:28 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42052 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752785AbeDKHR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:17:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=huhuajun@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0T.-qiW6_1523431001;
From: hu huajun <huhuajun@linux.alibaba.com>
To: joro@8bytes.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hu huajun <huhuajun@linux.alibaba.com>
Subject: [PATCH] KVM: X86: fix incorrect reference of trace_kvm_pi_irte_update
Date: Wed, 11 Apr 2018 15:16:40 +0800
Message-Id: <1523431000-44137-1-git-send-email-huhuajun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/x86/kvm/trace.h, this function is declared as host_irq the
first input, and vcpu_id the second, instead of otherwise.

Signed-off-by: hu huajun <huhuajun@linux.alibaba.com>
---
 arch/x86/kvm/svm.c | 5 ++---
 arch/x86/kvm/vmx.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index be9c839..f4e9fb4 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5118,9 +5118,8 @@ static int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 		}
 
 		if (!ret && svm) {
-			trace_kvm_pi_irte_update(svm->vcpu.vcpu_id,
-						 host_irq, e->gsi,
-						 vcpu_info.vector,
+			trace_kvm_pi_irte_update(host_irq, svm->vcpu.vcpu_id,
+						 e->gsi, vcpu_info.vector,
 						 vcpu_info.pi_desc_addr, set);
 		}
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f0fd50b..86fd775 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -12204,7 +12204,7 @@ static int vmx_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 		vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
 		vcpu_info.vector = irq.vector;
 
-		trace_kvm_pi_irte_update(vcpu->vcpu_id, host_irq, e->gsi,
+		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, e->gsi,
 				vcpu_info.vector, vcpu_info.pi_desc_addr, set);
 
 		if (set)
-- 
1.8.3.1
