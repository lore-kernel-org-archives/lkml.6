Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C02C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB4421571
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB4421571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeHXGin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:38:43 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:38226 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbeHXGik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:38:40 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E3618BDAA02D0235AB2E;
        Fri, 24 Aug 2018 11:06:01 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7O35sN7036757;
        Fri, 24 Aug 2018 11:05:54 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018082411060215-5963664 ;
          Fri, 24 Aug 2018 11:06:02 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, wanpeng.li@hotmail.com,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V3 1/2] kvm/x86 : add coalesced pio support
Date:   Fri, 24 Aug 2018 19:20:31 +0800
Message-Id: <1535109632-59745-2-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1535109632-59745-1-git-send-email-peng.hao2@zte.com.cn>
References: <1535109632-59745-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-24 11:06:02,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-24 11:05:39,
        Serialize complete at 2018-08-24 11:05:39
X-MAIL: mse01.zte.com.cn w7O35sN7036757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 include/uapi/linux/kvm.h  | 5 +++--
 virt/kvm/coalesced_mmio.c | 8 +++++---
 virt/kvm/kvm_main.c       | 2 ++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b6270a3..9cc56d3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -420,13 +420,13 @@ struct kvm_run {
 struct kvm_coalesced_mmio_zone {
 	__u64 addr;
 	__u32 size;
-	__u32 pad;
+	__u32 pio;
 };
 
 struct kvm_coalesced_mmio {
 	__u64 phys_addr;
 	__u32 len;
-	__u32 pad;
+	__u32 pio;
 	__u8  data[8];
 };
 
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_COALESCED_PIO 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 9e65feb..beea7d1 100644
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
@@ -149,8 +150,8 @@ int kvm_vm_ioctl_register_coalesced_mmio(struct kvm *kvm,
 	dev->zone = *zone;
 
 	mutex_lock(&kvm->slots_lock);
-	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, zone->addr,
-				      zone->size, &dev->dev);
+	ret = kvm_io_bus_register_dev(kvm,
+		zone->pio ? KVM_PIO_BUS : KVM_MMIO_BUS, zone->size, &dev->dev);
 	if (ret < 0)
 		goto out_free_dev;
 	list_add_tail(&dev->list, &kvm->coalesced_zones);
@@ -174,7 +175,8 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 
 	list_for_each_entry_safe(dev, tmp, &kvm->coalesced_zones, list)
 		if (coalesced_mmio_in_range(dev, zone->addr, zone->size)) {
-			kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &dev->dev);
+			kvm_io_bus_unregister_dev(kvm,
+				zone->pio ? KVM_PIO_BUS : KVM_MMIO_BUS,	&dev->dev);
 			kvm_iodevice_destructor(&dev->dev);
 		}
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b47507f..a587fb9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2936,6 +2936,8 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
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

