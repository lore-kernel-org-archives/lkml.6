Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B476C282DB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1141021925
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="db9VY9v1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfAaU1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:27:09 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62606 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfAaU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966425; x=1580502425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QZVMhKVWbWjBs9t9fXnfD9E4/yA59hBZ75kOCaTDCc0=;
  b=db9VY9v1/Ope5aL8oXwm3QLyED+GGeAYcolPAtiaP4SlbrjxFcQaWhn+
   HqQm3kdz7UmJnnXKmrqN9HDzXx5qxXu8IHPg4fOXaDpDVrPpJbhDiDBXR
   E9tvbgoU+PtUhmU5rcnYF6BuYTT2r4wJNQs+BTXAGJlz74w3uGv1k+uXx
   U=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="656822804"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 31 Jan 2019 20:27:02 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 34F5FA226F;
        Thu, 31 Jan 2019 20:27:02 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKQxfW028987;
        Thu, 31 Jan 2019 21:26:59 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKQxCk028976;
        Thu, 31 Jan 2019 21:26:59 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 07/14] KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
Date:   Thu, 31 Jan 2019 21:24:37 +0100
Message-Id: <1548966284-28642-8-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map when mapping the virtual APIC page since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

One additional semantic change is that the virtual host mapping lifecycle
has changed a bit. It now has the same lifetime of the pinning of the
virtual APIC page on the host side.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v4 -> v5:
- unmap with dirty flag

v1 -> v2:
- Do not change the lifecycle of the mapping (pbonzini)
- Use pfn_to_hpa instead of gfn_to_gpa
---
 arch/x86/kvm/vmx/nested.c | 32 +++++++++++---------------------
 arch/x86/kvm/vmx/vmx.c    |  5 ++---
 arch/x86/kvm/vmx/vmx.h    |  2 +-
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1813211..31b352c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -229,10 +229,7 @@ static void free_nested(struct kvm_vcpu *vcpu)
 		kvm_release_page_dirty(vmx->nested.apic_access_page);
 		vmx->nested.apic_access_page = NULL;
 	}
-	if (vmx->nested.virtual_apic_page) {
-		kvm_release_page_dirty(vmx->nested.virtual_apic_page);
-		vmx->nested.virtual_apic_page = NULL;
-	}
+	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
 	if (vmx->nested.pi_desc_page) {
 		kunmap(vmx->nested.pi_desc_page);
 		kvm_release_page_dirty(vmx->nested.pi_desc_page);
@@ -2817,6 +2814,7 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct kvm_host_map *map;
 	struct page *page;
 	u64 hpa;
 
@@ -2849,11 +2847,7 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	}
 
 	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
-		if (vmx->nested.virtual_apic_page) { /* shouldn't happen */
-			kvm_release_page_dirty(vmx->nested.virtual_apic_page);
-			vmx->nested.virtual_apic_page = NULL;
-		}
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->virtual_apic_page_addr);
+		map = &vmx->nested.virtual_apic_map;
 
 		/*
 		 * If translation failed, VM entry will fail because
@@ -2868,11 +2862,9 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		 * control.  But such a configuration is useless, so
 		 * let's keep the code simple.
 		 */
-		if (!is_error_page(page)) {
-			vmx->nested.virtual_apic_page = page;
-			hpa = page_to_phys(vmx->nested.virtual_apic_page);
-			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
-		}
+		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr), map))
+			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, pfn_to_hpa(map->pfn));
+
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
@@ -3279,11 +3271,12 @@ static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 
 	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
 	if (max_irr != 256) {
-		vapic_page = kmap(vmx->nested.virtual_apic_page);
+		vapic_page = vmx->nested.virtual_apic_map.hva;
+		if (!vapic_page)
+			return;
+
 		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
 			vapic_page, &max_irr);
-		kunmap(vmx->nested.virtual_apic_page);
-
 		status = vmcs_read16(GUEST_INTR_STATUS);
 		if ((u8)max_irr > ((u8)status & 0xff)) {
 			status &= ~0xff;
@@ -3917,10 +3910,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 		kvm_release_page_dirty(vmx->nested.apic_access_page);
 		vmx->nested.apic_access_page = NULL;
 	}
-	if (vmx->nested.virtual_apic_page) {
-		kvm_release_page_dirty(vmx->nested.virtual_apic_page);
-		vmx->nested.virtual_apic_page = NULL;
-	}
+	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
 	if (vmx->nested.pi_desc_page) {
 		kunmap(vmx->nested.pi_desc_page);
 		kvm_release_page_dirty(vmx->nested.pi_desc_page);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a3da75a..ea9cffc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3627,14 +3627,13 @@ static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 
 	if (WARN_ON_ONCE(!is_guest_mode(vcpu)) ||
 		!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
-		WARN_ON_ONCE(!vmx->nested.virtual_apic_page))
+		WARN_ON_ONCE(!vmx->nested.virtual_apic_map.gfn))
 		return false;
 
 	rvi = vmx_get_rvi();
 
-	vapic_page = kmap(vmx->nested.virtual_apic_page);
+	vapic_page = vmx->nested.virtual_apic_map.hva;
 	vppr = *((u32 *)(vapic_page + APIC_PROCPRI));
-	kunmap(vmx->nested.virtual_apic_page);
 
 	return ((rvi & 0xf0) > (vppr & 0xf0));
 }
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 6fb69d8..f618f52 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -142,7 +142,7 @@ struct nested_vmx {
 	 * pointers, so we must keep them pinned while L2 runs.
 	 */
 	struct page *apic_access_page;
-	struct page *virtual_apic_page;
+	struct kvm_host_map virtual_apic_map;
 	struct page *pi_desc_page;
 
 	struct kvm_host_map msr_bitmap_map;
-- 
2.7.4

