Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756854AbeD0Az5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 20:55:57 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46090 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbeD0Azz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 20:55:55 -0400
X-Google-Smtp-Source: AB8JxZoxXx2oXowQ2yJ7KpR2xmKQcBSQrPo78ZLOgelaqJoWaAaIL2xKpFQ33capI24Sse+U7PSTtA==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tonny Lu <tonnylu@tencent.com>
Subject: [PATCH v3] KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs
Date: Thu, 26 Apr 2018 17:55:03 -0700
Message-Id: <1524790503-3267-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Our virtual machines make use of device assignment by configuring
12 NVMe disks for high I/O performance. Each NVMe device has 129 
MSI-X Table entries:
Capabilities: [50] MSI-X: Enable+ Count=129 Masked-Vector table: BAR=0 offset=00002000
The windows virtual machines fail to boot since they will map the number of 
MSI-table entries that the NVMe hardware reported to the bus to msi routing 
table, this will exceed the 1024. This patch extends MAX_IRQ_ROUTES to 4096
for all archs, in the future this might be extended again if needed.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Tonny Lu <tonnylu@tencent.com>
---
v2 -> v3:
 * update comments in the code
v1 -> v2:
 * extend MAX_IRQ_ROUTES to 4096 for all archs 

 include/linux/kvm_host.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6930c63..6d6e79c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1045,13 +1045,7 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
 
 #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
 
-#ifdef CONFIG_S390
-#define KVM_MAX_IRQ_ROUTES 4096 //FIXME: we can have more than that...
-#elif defined(CONFIG_ARM64)
-#define KVM_MAX_IRQ_ROUTES 4096
-#else
-#define KVM_MAX_IRQ_ROUTES 1024
-#endif
+#define KVM_MAX_IRQ_ROUTES 4096 /* might need extension/rework in the future */
 
 bool kvm_arch_can_set_irq_routing(struct kvm *kvm);
 int kvm_set_irq_routing(struct kvm *kvm,
-- 
2.7.4
