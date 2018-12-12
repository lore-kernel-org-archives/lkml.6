Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5973C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B457D2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B457D2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeLLQuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:50:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeLLQuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:50:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B3C2307C94C;
        Wed, 12 Dec 2018 16:50:21 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C669B6147E;
        Wed, 12 Dec 2018 16:50:19 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH v2 1/2] x86/hyper-v: Stop caring about EOI for direct stimers
Date:   Wed, 12 Dec 2018 17:50:16 +0100
Message-Id: <20181212165017.13278-2-vkuznets@redhat.com>
In-Reply-To: <20181212165017.13278-1-vkuznets@redhat.com>
References: <20181212165017.13278-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 12 Dec 2018 16:50:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out we over-engineered Direct Mode for stimers a bit: unlike
traditional stimers where we may want to try to re-inject the message upon
EOI, Direct Mode stimers just set the irq in APIC and kvm_apic_set_irq()
fails only when APIC is disabled (see APIC_DM_FIXED case in
__apic_accept_irq()). Remove the redundant part.

Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e6a2a085644a..0a16a77e6ac3 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -56,21 +56,8 @@ static inline int synic_get_sint_vector(u64 sint_value)
 static bool synic_has_vector_connected(struct kvm_vcpu_hv_synic *synic,
 				      int vector)
 {
-	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
-	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
-	struct kvm_vcpu_hv_stimer *stimer;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
-		stimer = &hv_vcpu->stimer[i];
-		if (stimer->config.enable && stimer->config.direct_mode &&
-		    stimer->config.apic_vector == vector)
-			return true;
-	}
-
-	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
-		return false;
-
 	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
 		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
 			return true;
@@ -96,14 +83,14 @@ static bool synic_has_vector_auto_eoi(struct kvm_vcpu_hv_synic *synic,
 static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
 				int vector)
 {
+	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
+		return;
+
 	if (synic_has_vector_connected(synic, vector))
 		__set_bit(vector, synic->vec_bitmap);
 	else
 		__clear_bit(vector, synic->vec_bitmap);
 
-	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
-		return;
-
 	if (synic_has_vector_auto_eoi(synic, vector))
 		__set_bit(vector, synic->auto_eoi_bitmap);
 	else
@@ -382,9 +369,7 @@ int kvm_hv_synic_set_irq(struct kvm *kvm, u32 vpidx, u32 sint)
 
 void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector)
 {
-	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
 	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
-	struct kvm_vcpu_hv_stimer *stimer;
 	int i;
 
 	trace_kvm_hv_synic_send_eoi(vcpu->vcpu_id, vector);
@@ -392,14 +377,6 @@ void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector)
 	for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
 		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
 			kvm_hv_notify_acked_sint(vcpu, i);
-
-	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
-		stimer = &hv_vcpu->stimer[i];
-		if (stimer->msg_pending && stimer->config.enable &&
-		    stimer->config.direct_mode &&
-		    stimer->config.apic_vector == vector)
-			stimer_mark_pending(stimer, false);
-	}
 }
 
 static int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vpidx, u32 sint, int gsi)
@@ -566,8 +543,6 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
 			     bool host)
 {
-	struct kvm_vcpu *vcpu = stimer_to_vcpu(stimer);
-	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
 	union hv_stimer_config new_config = {.as_uint64 = config},
 		old_config = {.as_uint64 = stimer->config.as_uint64};
 
@@ -580,11 +555,6 @@ static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
 		new_config.enable = 0;
 	stimer->config.as_uint64 = new_config.as_uint64;
 
-	if (old_config.direct_mode)
-		synic_update_vector(&hv_vcpu->synic, old_config.apic_vector);
-	if (new_config.direct_mode)
-		synic_update_vector(&hv_vcpu->synic, new_config.apic_vector);
-
 	stimer_mark_pending(stimer, false);
 	return 0;
 }
-- 
2.19.2

