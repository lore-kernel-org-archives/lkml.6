Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E93C28CBE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520A1204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520A1204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbeI1XGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:06:42 -0400
Received: from mail78-58.sinamail.sina.com.cn ([219.142.78.58]:60965 "HELO
        mail78-58.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1726738AbeI1XGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:06:41 -0400
X-Greylist: delayed 2274 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2018 19:06:41 EDT
Received: from unknown (HELO localhost.localdomain.localdomain)([110.184.35.163])
        by sina.com with ESMTP
        id 5BAE59D300005D8A; Fri, 29 Sep 2018 00:42:04 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 573004400706
From:   Peng Hao <penghao122@sina.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  kvm/x86 : set meaningful return value
Date:   Fri, 28 Sep 2018 12:41:53 -0400
Message-Id: <1538152913-3036-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

kvm_irq_delivery_to_apic_fast()-->
    kvm_apic_map_get_dest_lapic()-->
        kvm_apic_disabled_lapic_found()
kvm_apic_map_get_dest_lapic return with bitmap==0 and dst[i]==NULL,
then (*r == -1) will be returned to qemu and "KVM: injection failed,
MSI lost(Operation not permitted)" will be recorded in qemu log. The
output is puzzling.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index fbb0e6d..a8896b3 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -944,7 +944,7 @@ bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 	int i;
 	bool ret;
 
-	*r = -1;
+	*r = -ENXIO;
 
 	if (irq->shorthand == APIC_DEST_SELF) {
 		*r = kvm_apic_set_irq(src->vcpu, irq, dest_map);
-- 
1.8.3.1


