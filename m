Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004A1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D6D21939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="QeVhQt/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfAaU2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:28:01 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:24204 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfAaU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966424; x=1580502424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9sgF47MrbxyAsS7U5ZelyCSmc8JbJdu5SVylQaC5hcI=;
  b=QeVhQt/Q+ergf8evqtjBMulqQHZ1j1pVo6G/DGwGrTQNlWdiL1VUkmku
   QmM2groth0WfoHqhVAB/OoX9+23oIlVEO+jmSWGoeYe8g8LbiYLs8onxr
   yjNuDoAYnPYbqZrTEXJ+bURQ8AGGonoeCHxh6GabnHGCJUYTRjeiCffwf
   Q=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="656822797"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 31 Jan 2019 20:27:01 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (Postfix) with ESMTPS id DE4B8A2185;
        Thu, 31 Jan 2019 20:27:00 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKQwAW028967;
        Thu, 31 Jan 2019 21:26:58 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKQv24028963;
        Thu, 31 Jan 2019 21:26:57 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 06/14] KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
Date:   Thu, 31 Jan 2019 21:24:36 +0100
Message-Id: <1548966284-28642-7-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
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
index 8fc327f..1813211 100644
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
+	kvm_vcpu_unmap(vcpu, &to_vmx(vcpu)->nested.msr_bitmap_map, false);
 
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

