Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbeBKDaa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 22:30:30 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33797 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbeBKD3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 22:29:55 -0500
X-Google-Smtp-Source: AH8x227OY4gaK9SkQAVgaUusf3w53NVuCVNfGeMEEFHqHuZ5xOdTYvFJmvkG50UKLAWhc+oWZurTDg==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v3 2/3] KVM: X86: Choose qspinlock when dedicated vCPUs available
Date: Sun, 11 Feb 2018 11:29:45 +0800
Message-Id: <1518319786-1466-3-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518319786-1466-1-git-send-email-wanpengli@tencent.com>
References: <1518319786-1466-1-git-send-email-wanpengli@tencent.com>
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

This patch uses a KVM_HINTS_DEDICATED performance hint to allow 
hypervisor admin to choose the qspinlock to be used when a dedicated 
vCPU is available.

PV_DEDICATED = 1, PV_UNHALT = anything: default is qspinlock
PV_DEDICATED = 0, PV_UNHALT = 1: default is Hybrid PV queued/unfair lock
PV_DEDICATED = 0, PV_UNHALT = 0: default is tas

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 77a0723..c5566d9 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -733,6 +733,11 @@ void __init kvm_spinlock_init(void)
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return;
 
+	if (kvm_hint_has_feature(KVM_HINTS_DEDICATED)) {
+		static_branch_disable(&virt_spin_lock_key);
+		return;
+	}
+
 	__pv_init_lock_hash();
 	pv_lock_ops.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
 	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-- 
2.7.4
