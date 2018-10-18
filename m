Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6429FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242262145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242262145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeJRTcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:32:52 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:61360 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeJRTcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:32:52 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D4291A0399B36B23A7ED;
        Thu, 18 Oct 2018 19:32:14 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9IBW89K093624;
        Thu, 18 Oct 2018 19:32:08 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018101819323982-5326716 ;
          Thu, 18 Oct 2018 19:32:39 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, stefanha@gmail.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [RESEND PATCH V6 1/5]  target/i386 : add coalesced pio support
Date:   Fri, 19 Oct 2018 03:43:35 +0800
Message-Id: <1539891815-30605-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-18 19:32:39,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-18 19:31:55,
        Serialize complete at 2018-10-18 19:31:55
X-MAIL: mse01.zte.com.cn w9IBW89K093624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add coalesced_pio's struct and KVM_CAP_COALESCED_PIO header.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 accel/kvm/kvm-all.c       |  4 ++--
 linux-headers/linux/kvm.h | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 799966f..7724055 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -538,7 +538,7 @@ static void kvm_coalesce_mmio_region(MemoryListener *listener,
 
         zone.addr = start;
         zone.size = size;
-        zone.pad = 0;
+        zone.pio = 0;
 
         (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
     }
@@ -555,7 +555,7 @@ static void kvm_uncoalesce_mmio_region(MemoryListener *listener,
 
         zone.addr = start;
         zone.size = size;
-        zone.pad = 0;
+        zone.pio = 0;
 
         (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
     }
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 83ba4eb..670a3d1 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -420,13 +420,19 @@ struct kvm_run {
 struct kvm_coalesced_mmio_zone {
 	__u64 addr;
 	__u32 size;
-	__u32 pad;
+   union {
+       __u32 pad;
+       __u32 pio;
+   };
 };
 
 struct kvm_coalesced_mmio {
 	__u64 phys_addr;
 	__u32 len;
-	__u32 pad;
+   union {
+       __u32 pad;
+       __u32 pio;
+   };
 	__u8  data[8];
 };
 
@@ -953,6 +959,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
 #define KVM_CAP_MSR_PLATFORM_INFO 159
+#define KVM_CAP_COALESCED_PIO 162
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.3.1

