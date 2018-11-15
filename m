Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBACC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2B3223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2B3223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeKOQ6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:58:33 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:64382 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbeKOQ6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:58:32 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BBFEBC0FA753D29C14F9;
        Thu, 15 Nov 2018 14:51:56 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAF6phup015813;
        Thu, 15 Nov 2018 14:51:43 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018111514521267-10831359 ;
          Thu, 15 Nov 2018 14:52:12 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     christoffer.dall@arm.com, marc.zyngier@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  kvm: arm/arm64 : fix vm's hanging at startup time
Date:   Thu, 15 Nov 2018 23:14:08 +0800
Message-Id: <1542294848-73839-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-15 14:52:12,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-15 14:51:31,
        Serialize complete at 2018-11-15 14:51:31
X-MAIL: mse01.zte.com.cn wAF6phup015813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When virtual machine starts, hang up. The kernel version of guest
is 4.16. Host support vgic_v3.
It was mainly due to the incorrect vgic_irq's(intid=27) group value
during injection interruption. when kvm_vgic_vcpu_init is called,
dist is not initialized at this time. Unable to get vgic V3 or V2
correctly, so group is not set.
group is setted to 1 when vgic_mmio_write_group is invoked at some
time.
when irq->group=0 (intid=27), No ICH_LR_GROUP flag was set and
interrupt injection failed.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 virt/kvm/arm/vgic/vgic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 9c0dd23..d101000 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -198,7 +198,7 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
 	if (vgic_irq_is_mapped_level(irq) && (val & ICH_LR_PENDING_BIT))
 		irq->line_level = false;
 
-	if (irq->group)
+	if (model == KVM_DEV_TYPE_ARM_VGIC_V3)
 		val |= ICH_LR_GROUP;
 
 	val |= (u64)irq->priority << ICH_LR_PRIORITY_SHIFT;
-- 
1.8.3.1

