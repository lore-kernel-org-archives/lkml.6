Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D5DC07520
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2EC2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbeLYEfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 23:35:42 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:49284 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeLYEfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 23:35:42 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 3C490B1CB244D08CF0E4;
        Tue, 25 Dec 2018 12:35:40 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBP4ZYcA091904;
        Tue, 25 Dec 2018 12:35:34 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018122512354674-18598224 ;
          Tue, 25 Dec 2018 12:35:46 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     christoffer.dall@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  kvm/arm : remove unnecessary local variable
Date:   Tue, 25 Dec 2018 12:56:15 +0800
Message-Id: <1545713775-69870-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-25 12:35:46,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-25 12:35:30,
        Serialize complete at 2018-12-25 12:35:30
X-MAIL: mse01.zte.com.cn wBP4ZYcA091904
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary local variable in vgic_set_common_attr

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 virt/kvm/arm/vgic/vgic-kvm-device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
index 114dce9..53e5df7 100644
--- a/virt/kvm/arm/vgic/vgic-kvm-device.c
+++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
@@ -163,7 +163,7 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
 static int vgic_set_common_attr(struct kvm_device *dev,
 				struct kvm_device_attr *attr)
 {
-	int r;
+	int r = 0;
 
 	switch (attr->group) {
 	case KVM_DEV_ARM_VGIC_GRP_ADDR: {
@@ -180,7 +180,6 @@ static int vgic_set_common_attr(struct kvm_device *dev,
 	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
 		u32 val;
-		int ret = 0;
 
 		if (get_user(val, uaddr))
 			return -EFAULT;
@@ -199,14 +198,14 @@ static int vgic_set_common_attr(struct kvm_device *dev,
 		mutex_lock(&dev->kvm->lock);
 
 		if (vgic_ready(dev->kvm) || dev->kvm->arch.vgic.nr_spis)
-			ret = -EBUSY;
+			r = -EBUSY;
 		else
 			dev->kvm->arch.vgic.nr_spis =
 				val - VGIC_NR_PRIVATE_IRQS;
 
 		mutex_unlock(&dev->kvm->lock);
 
-		return ret;
+		return r;
 	}
 	case KVM_DEV_ARM_VGIC_GRP_CTRL: {
 		switch (attr->attr) {
-- 
1.8.3.1

