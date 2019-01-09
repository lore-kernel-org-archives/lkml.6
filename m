Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD57C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A42B214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="HY1FBOXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfAIJnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:43:05 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:36776 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbfAIJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547026949; x=1578562949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mrS5sHBF2Bp0bkUto+MdSOKAViZi4pVaQiASa7uszCc=;
  b=HY1FBOXEUDXyM7NZupv0S/kxgIQQX+zTy5QGbXZav1bVCnY98FL50yIj
   djVLFe526logRlFBXmxtcM4fYGQVw3XcyhSiGZwvltWD2f+hTwYxwEoWe
   lIYslzg/jxY4nBipMd9qEYNWviXdCQKthMm4eTqxNITK+fibUCIhkcK2z
   c=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="652219862"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jan 2019 09:42:24 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x099gJl4036140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 9 Jan 2019 09:42:21 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x099gJQr031315;
        Wed, 9 Jan 2019 10:42:19 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x099gIn8031314;
        Wed, 9 Jan 2019 10:42:18 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 06/13] KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
Date:   Wed,  9 Jan 2019 10:42:06 +0100
Message-Id: <1547026933-31226-7-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map when mapping the L1 MSR bitmap since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v4 -> v5:
- unmap with dirty flag

v1 -> v2:
- Do not change the lifecycle of the mapping (pbonzini)
---
 arch/x86/kvm/vmx/nested.c | 11 +++++------
 arch/x86/kvm/vmx/vmx.h    |  3 +++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 5602b0c..4127ad9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -507,9 +507,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 						 struct vmcs12 *vmcs12)
 {
 	int msr;
-	struct page *page;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
+	struct kvm_host_map *map = &to_vmx(vcpu)->nested.msr_bitmap_map;
+
 	/*
 	 * pred_cmd & spec_ctrl are trying to verify two things:
 	 *
@@ -535,11 +536,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	    !pred_cmd && !spec_ctrl)
 		return false;
 
-	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
-	if (is_error_page(page))
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), map))
 		return false;
 
-	msr_bitmap_l1 = (unsigned long *)kmap(page);
+	msr_bitmap_l1 = (unsigned long *)map->hva;
 	if (nested_cpu_has_apic_reg_virt(vmcs12)) {
 		/*
 		 * L0 need not intercept reads for MSRs between 0x800 and 0x8ff, it
@@ -587,8 +587,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 					MSR_IA32_PRED_CMD,
 					MSR_TYPE_W);
 
-	kunmap(page);
-	kvm_release_page_clean(page);
+	kvm_vcpu_unmap(&to_vmx(vcpu)->nested.msr_bitmap_map, false);
 
 	return true;
 }
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9932895..6fb69d8 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -144,6 +144,9 @@ struct nested_vmx {
 	struct page *apic_access_page;
 	struct page *virtual_apic_page;
 	struct page *pi_desc_page;
+
+	struct kvm_host_map msr_bitmap_map;
+
 	struct pi_desc *pi_desc;
 	bool pi_pending;
 	u16 posted_intr_nv;
-- 
2.7.4

