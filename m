Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8762C71123
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DA620877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DA620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJMWfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:35:52 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:33508 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbeJMWfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:35:51 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 735E9BCD0A01CD6358BC;
        Sat, 13 Oct 2018 22:58:22 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9DEwFvY096842;
        Sat, 13 Oct 2018 22:58:15 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018101322585844-4289318 ;
          Sat, 13 Oct 2018 22:58:58 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, stefanha@gmail.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V5 1/3]  kvm/x86 : add coalesced pio support
Date:   Sun, 14 Oct 2018 07:09:55 +0800
Message-Id: <1539472197-111085-2-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539472197-111085-1-git-send-email-peng.hao2@zte.com.cn>
References: <1539472197-111085-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-13 22:58:58,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-13 22:57:55,
        Serialize complete at 2018-10-13 22:57:55
X-MAIL: mse01.zte.com.cn w9DEwFvY096842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add coalesced pio support.
 
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 include/uapi/linux/kvm.h  | 11 +++++++++--
 virt/kvm/coalesced_mmio.c | 12 +++++++++---
 virt/kvm/kvm_main.c       |  2 ++
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 251be35..3c55ecd 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -420,13 +420,19 @@ struct kvm_run {
 struct kvm_coalesced_mmio_zone {
 	__u64 addr;
 	__u32 size;
-	__u32 pad;
+	union {
+		__u32 pad;
+		__u32 pio;
+	};
 };
 
 struct kvm_coalesced_mmio {
 	__u64 phys_addr;
 	__u32 len;
-	__u32 pad;
+	union {
+		__u32 pad;
+		__u32 pio;
+	};
 	__u8  data[8];
 };
 
@@ -953,6 +959,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
 #define KVM_CAP_MSR_PLATFORM_INFO 159
+#define KVM_CAP_COALESCED_PIO 160
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 9e65feb..3710342 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -83,6 +83,7 @@ static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
 	ring->coalesced_mmio[ring->last].phys_addr = addr;
 	ring->coalesced_mmio[ring->last].len = len;
 	memcpy(ring->coalesced_mmio[ring->last].data, val, len);
+	ring->coalesced_mmio[ring->last].pio = dev->zone.pio;
 	smp_wmb();
 	ring->last = (ring->last + 1) % KVM_COALESCED_MMIO_MAX;
 	spin_unlock(&dev->kvm->ring_lock);
@@ -140,6 +141,9 @@ int kvm_vm_ioctl_register_coalesced_mmio(struct kvm *kvm,
 	int ret;
 	struct kvm_coalesced_mmio_dev *dev;
 
+	if (zone->pio != 1 && zone->pio != 0)
+		return -EINVAL;
+
 	dev = kzalloc(sizeof(struct kvm_coalesced_mmio_dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
@@ -149,8 +153,9 @@ int kvm_vm_ioctl_register_coalesced_mmio(struct kvm *kvm,
 	dev->zone = *zone;
 
 	mutex_lock(&kvm->slots_lock);
-	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, zone->addr,
-				      zone->size, &dev->dev);
+	ret = kvm_io_bus_register_dev(kvm,
+				zone->pio ? KVM_PIO_BUS : KVM_MMIO_BUS,
+				zone->addr, zone->size, &dev->dev);
 	if (ret < 0)
 		goto out_free_dev;
 	list_add_tail(&dev->list, &kvm->coalesced_zones);
@@ -174,7 +179,8 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 
 	list_for_each_entry_safe(dev, tmp, &kvm->coalesced_zones, list)
 		if (coalesced_mmio_in_range(dev, zone->addr, zone->size)) {
-			kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &dev->dev);
+			kvm_io_bus_unregister_dev(kvm,
+				zone->pio ? KVM_PIO_BUS : KVM_MMIO_BUS, &dev->dev);
 			kvm_iodevice_destructor(&dev->dev);
 		}
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f986e31f..37965f9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2946,6 +2946,8 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #ifdef CONFIG_KVM_MMIO
 	case KVM_CAP_COALESCED_MMIO:
 		return KVM_COALESCED_MMIO_PAGE_OFFSET;
+	case KVM_CAP_COALESCED_PIO:
+		return 1;
 #endif
 #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
 	case KVM_CAP_IRQ_ROUTING:
-- 
1.8.3.1

