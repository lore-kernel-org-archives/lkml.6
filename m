Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43114C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A8C21470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A8C21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeJQAls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbeJQAlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:41:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E34CA80F88;
        Tue, 16 Oct 2018 16:50:31 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E61F6A039;
        Tue, 16 Oct 2018 16:50:29 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v6 06/13] KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case
Date:   Tue, 16 Oct 2018 18:50:04 +0200
Message-Id: <20181016165011.6607-7-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-1-vkuznets@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 16 Oct 2018 16:50:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Enlightened VMCS is in use by L1 hypervisor we can avoid vmwriting
VMCS fields which did not change.

Our first goal is to achieve minimal impact on traditional VMCS case so
we're not wrapping each vmwrite() with an if-changed checker. We also can't
utilize static keys as Enlightened VMCS usage is per-guest.

This patch implements the simpliest solution: checking fields in groups.
We skip single vmwrite() statements as doing the check will cost us
something even in non-evmcs case and the win is tiny. Unfortunately, this
makes prepare_vmcs02_full{,_full}() code Enlightened VMCS-dependent (and
a bit ugly).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 118 +++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index cfb44acd4291..0b665c74fadc 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -12699,43 +12699,62 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 
 static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 {
-	vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
-	vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
-	vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
-	vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
-	vmcs_write16(GUEST_GS_SELECTOR, vmcs12->guest_gs_selector);
-	vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
-	vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
-	vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
-	vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
-	vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
-	vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
-	vmcs_write32(GUEST_GS_LIMIT, vmcs12->guest_gs_limit);
-	vmcs_write32(GUEST_LDTR_LIMIT, vmcs12->guest_ldtr_limit);
-	vmcs_write32(GUEST_TR_LIMIT, vmcs12->guest_tr_limit);
-	vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
-	vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
-	vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
-	vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
-	vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
-	vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
-	vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
-	vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
-	vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
-	vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
-	vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
-	vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
-	vmcs_writel(GUEST_GS_BASE, vmcs12->guest_gs_base);
-	vmcs_writel(GUEST_LDTR_BASE, vmcs12->guest_ldtr_base);
-	vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
-	vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
-	vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
-
-	vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
-	vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
-		vmcs12->guest_pending_dbg_exceptions);
-	vmcs_writel(GUEST_SYSENTER_ESP, vmcs12->guest_sysenter_esp);
-	vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->guest_sysenter_eip);
+	struct hv_enlightened_vmcs *hv_evmcs = vmx->nested.hv_evmcs;
+
+	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
+			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
+		vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
+		vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
+		vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
+		vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
+		vmcs_write16(GUEST_GS_SELECTOR, vmcs12->guest_gs_selector);
+		vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
+		vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
+		vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
+		vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
+		vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
+		vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
+		vmcs_write32(GUEST_GS_LIMIT, vmcs12->guest_gs_limit);
+		vmcs_write32(GUEST_LDTR_LIMIT, vmcs12->guest_ldtr_limit);
+		vmcs_write32(GUEST_TR_LIMIT, vmcs12->guest_tr_limit);
+		vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
+		vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
+		vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
+		vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
+		vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
+		vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
+		vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
+		vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
+		vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
+		vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
+		vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
+		vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
+		vmcs_writel(GUEST_GS_BASE, vmcs12->guest_gs_base);
+		vmcs_writel(GUEST_LDTR_BASE, vmcs12->guest_ldtr_base);
+		vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
+		vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
+		vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
+	}
+
+	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
+			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1)) {
+		vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
+		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
+			    vmcs12->guest_pending_dbg_exceptions);
+		vmcs_writel(GUEST_SYSENTER_ESP, vmcs12->guest_sysenter_esp);
+		vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->guest_sysenter_eip);
+
+		/*
+		 * L1 may access the L2's PDPTR, so save them to construct
+		 * vmcs12
+		 */
+		if (enable_ept) {
+			vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
+			vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
+			vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
+			vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
+		}
+	}
 
 	if (nested_cpu_has_xsaves(vmcs12))
 		vmcs_write64(XSS_EXIT_BITMAP, vmcs12->xss_exit_bitmap);
@@ -12778,16 +12797,6 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 		else
 			vmcs_write64(GUEST_BNDCFGS, vmx->nested.vmcs01_guest_bndcfgs);
 	}
-
-	/*
-	 * L1 may access the L2's PDPTR, so save them to construct vmcs12
-	 */
-	if (enable_ept) {
-		vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
-		vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
-		vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
-		vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
-	}
 }
 
 /*
@@ -12805,6 +12814,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			  u32 *entry_failure_code)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct hv_enlightened_vmcs *hv_evmcs = vmx->nested.hv_evmcs;
 
 	if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs) {
 		prepare_vmcs02_full(vmx, vmcs12);
@@ -12815,12 +12825,14 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	 * First, the fields that are shadowed.  This must be kept in sync
 	 * with vmx_shadow_fields.h.
 	 */
-
-	vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
-	vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
-	vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
-	vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
-	vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
+	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
+			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
+		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
+		vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
+		vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
+		vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
+		vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
+	}
 
 	if (vmx->nested.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
-- 
2.17.1

