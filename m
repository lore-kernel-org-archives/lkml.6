Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9379BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523E0204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523E0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJSWWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:22:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeJSWWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:22:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 868913024646;
        Fri, 19 Oct 2018 14:16:06 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5FAA5D77C;
        Fri, 19 Oct 2018 14:16:03 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kvm/nVMX: tweak shadow fields
Date:   Fri, 19 Oct 2018 16:16:03 +0200
Message-Id: <20181019141603.15995-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 19 Oct 2018 14:16:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems we have some leftovers from times when 'unrestricted guest'
wasn't exposed to L1. Stop shadowing GUEST_CS_{BASE,LIMIT,AR_SELECTOR}
and GUEST_ES_BASE, shadow GUEST_SS_AR_BYTES as it was found that some
hypervisors (e.g. Hyper-V without Enlightened VMCS) access it pretty
often.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c               | 10 +++++-----
 arch/x86/kvm/vmx_shadow_fields.h |  5 +----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index abeeb45d1c33..641a65b30685 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -12715,6 +12715,7 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
 			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
 		vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
+		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
 		vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
 		vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
 		vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
@@ -12722,6 +12723,7 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 		vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
 		vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
 		vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
+		vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
 		vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
 		vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
 		vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
@@ -12731,12 +12733,13 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 		vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
 		vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
 		vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
-		vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
 		vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
 		vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
 		vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
 		vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
 		vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
+		vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
+		vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
 		vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
 		vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
 		vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
@@ -12838,11 +12841,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	 */
 	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
 			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
-		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
-		vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
 		vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
-		vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
-		vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
+		vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
 	}
 
 	if (vmx->nested.nested_run_pending &&
diff --git a/arch/x86/kvm/vmx_shadow_fields.h b/arch/x86/kvm/vmx_shadow_fields.h
index cd0c75f6d037..132432f375c2 100644
--- a/arch/x86/kvm/vmx_shadow_fields.h
+++ b/arch/x86/kvm/vmx_shadow_fields.h
@@ -28,7 +28,6 @@
  */
 
 /* 16-bits */
-SHADOW_FIELD_RW(GUEST_CS_SELECTOR)
 SHADOW_FIELD_RW(GUEST_INTR_STATUS)
 SHADOW_FIELD_RW(GUEST_PML_INDEX)
 SHADOW_FIELD_RW(HOST_FS_SELECTOR)
@@ -47,8 +46,8 @@ SHADOW_FIELD_RW(VM_ENTRY_EXCEPTION_ERROR_CODE)
 SHADOW_FIELD_RW(VM_ENTRY_INTR_INFO_FIELD)
 SHADOW_FIELD_RW(VM_ENTRY_INSTRUCTION_LEN)
 SHADOW_FIELD_RW(TPR_THRESHOLD)
-SHADOW_FIELD_RW(GUEST_CS_LIMIT)
 SHADOW_FIELD_RW(GUEST_CS_AR_BYTES)
+SHADOW_FIELD_RW(GUEST_SS_AR_BYTES)
 SHADOW_FIELD_RW(GUEST_INTERRUPTIBILITY_INFO)
 SHADOW_FIELD_RW(VMX_PREEMPTION_TIMER_VALUE)
 
@@ -61,8 +60,6 @@ SHADOW_FIELD_RW(GUEST_CR0)
 SHADOW_FIELD_RW(GUEST_CR3)
 SHADOW_FIELD_RW(GUEST_CR4)
 SHADOW_FIELD_RW(GUEST_RFLAGS)
-SHADOW_FIELD_RW(GUEST_CS_BASE)
-SHADOW_FIELD_RW(GUEST_ES_BASE)
 SHADOW_FIELD_RW(CR0_GUEST_HOST_MASK)
 SHADOW_FIELD_RW(CR0_READ_SHADOW)
 SHADOW_FIELD_RW(CR4_READ_SHADOW)
-- 
2.17.2

