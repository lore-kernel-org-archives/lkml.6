Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754026AbeDTAsT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 20:48:19 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37544 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeDTAsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 20:48:17 -0400
X-Google-Smtp-Source: AIpwx4/z+N3wEkZWxzMc+NKiP2ZJmZl3Hj+aoumy5aV7rnu/MyMR1ujrOt0WCW6oDahtcUpbGmLEXg==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tonny Lu <tonnylu@tencent.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2] KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs
Date: Thu, 19 Apr 2018 17:47:28 -0700
Message-Id: <1524185248-51744-1-git-send-email-wanpengli@tencent.com>
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

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Tonny Lu <tonnylu@tencent.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Tonny Lu <tonnylu@tencent.com>
---
v1 -> v2:
 * extend MAX_IRQ_ROUTES to 4096 for all archs 

 include/linux/kvm_host.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6930c63..0a5c299 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1045,13 +1045,7 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
 
 #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
 
-#ifdef CONFIG_S390
 #define KVM_MAX_IRQ_ROUTES 4096 //FIXME: we can have more than that...
-#elif defined(CONFIG_ARM64)
-#define KVM_MAX_IRQ_ROUTES 4096
-#else
-#define KVM_MAX_IRQ_ROUTES 1024
-#endif
 
 bool kvm_arch_can_set_irq_routing(struct kvm *kvm);
 int kvm_set_irq_routing(struct kvm *kvm,
-- 
2.7.4
