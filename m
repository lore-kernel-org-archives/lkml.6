Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4242CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122B820989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122B820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLFQ6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:58:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeLFQ6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:58:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15BAE3003D20;
        Thu,  6 Dec 2018 16:58:39 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3CB528DF0;
        Thu,  6 Dec 2018 16:58:36 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 3/6] x86/kvm/hyper-v: Introduce nested_get_evmcs_version() helper
Date:   Thu,  6 Dec 2018 17:58:22 +0100
Message-Id: <20181206165825.1832-4-vkuznets@redhat.com>
In-Reply-To: <20181206165825.1832-1-vkuznets@redhat.com>
References: <20181206165825.1832-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 06 Dec 2018 16:58:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming KVM_GET_SUPPORTED_HV_CPUID ioctl will need to return
Enlightened VMCS version in HYPERV_CPUID_NESTED_FEATURES.EAX when
it was enabled.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/svm.c              |  7 +++++++
 arch/x86/kvm/vmx.c              | 24 +++++++++++++++++-------
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e1a40e649cdc..184669d48d80 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1185,6 +1185,7 @@ struct kvm_x86_ops {
 
 	int (*nested_enable_evmcs)(struct kvm_vcpu *vcpu,
 				   uint16_t *vmcs_version);
+	uint16_t (*nested_get_evmcs_version)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 0e21ccc46792..472f950ccab7 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7037,6 +7037,12 @@ static int svm_unregister_enc_region(struct kvm *kvm,
 	return ret;
 }
 
+static uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu)
+{
+	/* Not supported */
+	return 0;
+}
+
 static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 				   uint16_t *vmcs_version)
 {
@@ -7175,6 +7181,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.mem_enc_unreg_region = svm_unregister_enc_region,
 
 	.nested_enable_evmcs = nested_enable_evmcs,
+	.nested_get_evmcs_version = nested_get_evmcs_version,
 };
 
 static int __init svm_init(void)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4555077d69ce..f5d865e88095 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1605,6 +1605,21 @@ static inline void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf) {}
 static inline void evmcs_touch_msr_bitmap(void) {}
 #endif /* IS_ENABLED(CONFIG_HYPERV) */
 
+static uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	/*
+	 * vmcs_version represents the range of supported Enlightened VMCS
+	 * versions: lower 8 bits is the minimal version, higher 8 bits is the
+	 * maximum supported version. KVM supports versions from 1 to
+	 * KVM_EVMCS_VERSION.
+	 */
+	if (vmx->nested.enlightened_vmcs_enabled)
+		return (KVM_EVMCS_VERSION << 8) | 1;
+
+	return 0;
+}
+
 static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			       uint16_t *vmcs_version)
 {
@@ -1616,14 +1631,8 @@ static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 
 	vmx->nested.enlightened_vmcs_enabled = true;
 
-	/*
-	 * vmcs_version represents the range of supported Enlightened VMCS
-	 * versions: lower 8 bits is the minimal version, higher 8 bits is the
-	 * maximum supported version. KVM supports versions from 1 to
-	 * KVM_EVMCS_VERSION.
-	 */
 	if (vmcs_version)
-		*vmcs_version = (KVM_EVMCS_VERSION << 8) | 1;
+		*vmcs_version = nested_get_evmcs_version(vcpu);
 
 	vmx->nested.msrs.pinbased_ctls_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
 	vmx->nested.msrs.entry_ctls_high &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
@@ -15107,6 +15116,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.enable_smi_window = enable_smi_window,
 
 	.nested_enable_evmcs = nested_enable_evmcs,
+	.nested_get_evmcs_version = nested_get_evmcs_version,
 };
 
 static void vmx_cleanup_l1d_flush(void)
-- 
2.19.2

