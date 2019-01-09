Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384F2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B35214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ZsSP0QFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfAIJmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:42:32 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:61119 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbfAIJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547026945; x=1578562945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bbUzyXEn7+H8jznV1aoKSeYm2H8zK0EFV3W69c1iCPw=;
  b=ZsSP0QFFxG4Z5M0cBGCsbMu7kdv0Hw3nw4REVsH5Kto7Enib9pcCgT11
   1XSCG59JMKSnN98wezM5WkQmBqa8pxABMY0FntGqkS/Opk6xa6U3tp9Ge
   BVqxt8eWM0NRTTgQf0PO7oyO43LhxLNW6FKMcNE1gXSVA2Le2SEnxStYP
   g=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="780512369"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jan 2019 09:42:24 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x099gK7Q042848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 9 Jan 2019 09:42:22 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x099gJ1R031319;
        Wed, 9 Jan 2019 10:42:19 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x099gJsw031318;
        Wed, 9 Jan 2019 10:42:19 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 07/13] KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
Date:   Wed,  9 Jan 2019 10:42:07 +0100
Message-Id: <1547026933-31226-8-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
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
index 4127ad9..dcff99d 100644
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
+	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map, true);
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
+	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map, true);
 	if (vmx->nested.pi_desc_page) {
 		kunmap(vmx->nested.pi_desc_page);
 		kvm_release_page_dirty(vmx->nested.pi_desc_page);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 71d88df..e13308e 100644
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

