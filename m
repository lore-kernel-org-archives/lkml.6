Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098FAC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C631B21939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="g2EfUyJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfAaU2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:28:09 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:45295 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfAaU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966424; x=1580502424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mllvbMuI+hb6yPgBVYrhWq18u7HhXUYfrIcLxoipIIY=;
  b=g2EfUyJsLL4a/CQds3QPnRNUDG1cifjcTrobHlUd8fqg352zxLIFi2fN
   NEB3eiSPdOYwV8pWVNdpIujIecAzD0P+oexU4ARJZEOtloi1EjZdzXq+j
   DBnSvVQsjDti6XeggkhYKv13jlKa9xnqYJNniAK04BbQm/Ly6lDsMbC80
   s=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="780024417"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 31 Jan 2019 20:27:04 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id 92CF4A2246;
        Thu, 31 Jan 2019 20:27:03 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKR16Z028991;
        Thu, 31 Jan 2019 21:27:01 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKR0Ae028990;
        Thu, 31 Jan 2019 21:27:00 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 08/14] KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt descriptor table
Date:   Thu, 31 Jan 2019 21:24:38 +0100
Message-Id: <1548966284-28642-9-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map when mapping the posted interrupt descriptor table since
using kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory
that has a "struct page".

One additional semantic change is that the virtual host mapping lifecycle
has changed a bit. It now has the same lifetime of the pinning of the
interrupt descriptor table page on the host side.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v4 -> v5:
- unmap with dirty flag

v1 -> v2:
- Do not change the lifecycle of the mapping (pbonzini)
---
 arch/x86/kvm/vmx/nested.c | 43 ++++++++++++-------------------------------
 arch/x86/kvm/vmx/vmx.h    |  2 +-
 2 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 31b352c..53b1063 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -230,12 +230,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 		vmx->nested.apic_access_page = NULL;
 	}
 	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
-	if (vmx->nested.pi_desc_page) {
-		kunmap(vmx->nested.pi_desc_page);
-		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc_page = NULL;
-		vmx->nested.pi_desc = NULL;
-	}
+	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map, true);
+	vmx->nested.pi_desc = NULL;
 
 	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
 
@@ -2868,26 +2864,15 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
-		if (vmx->nested.pi_desc_page) { /* shouldn't happen */
-			kunmap(vmx->nested.pi_desc_page);
-			kvm_release_page_dirty(vmx->nested.pi_desc_page);
-			vmx->nested.pi_desc_page = NULL;
-			vmx->nested.pi_desc = NULL;
-			vmcs_write64(POSTED_INTR_DESC_ADDR, -1ull);
+		map = &vmx->nested.pi_desc_map;
+
+		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->posted_intr_desc_addr), map)) {
+			vmx->nested.pi_desc =
+				(struct pi_desc *)(((void *)map->hva) +
+				offset_in_page(vmcs12->posted_intr_desc_addr));
+			vmcs_write64(POSTED_INTR_DESC_ADDR,
+				     pfn_to_hpa(map->pfn) + offset_in_page(vmcs12->posted_intr_desc_addr));
 		}
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->posted_intr_desc_addr);
-		if (is_error_page(page))
-			return;
-		vmx->nested.pi_desc_page = page;
-		vmx->nested.pi_desc = kmap(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc =
-			(struct pi_desc *)((void *)vmx->nested.pi_desc +
-			(unsigned long)(vmcs12->posted_intr_desc_addr &
-			(PAGE_SIZE - 1)));
-		vmcs_write64(POSTED_INTR_DESC_ADDR,
-			page_to_phys(vmx->nested.pi_desc_page) +
-			(unsigned long)(vmcs12->posted_intr_desc_addr &
-			(PAGE_SIZE - 1)));
 	}
 	if (nested_vmx_prepare_msr_bitmap(vcpu, vmcs12))
 		vmcs_set_bits(CPU_BASED_VM_EXEC_CONTROL,
@@ -3911,12 +3896,8 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 		vmx->nested.apic_access_page = NULL;
 	}
 	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
-	if (vmx->nested.pi_desc_page) {
-		kunmap(vmx->nested.pi_desc_page);
-		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc_page = NULL;
-		vmx->nested.pi_desc = NULL;
-	}
+	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map, true);
+	vmx->nested.pi_desc = NULL;
 
 	/*
 	 * We are now running in L2, mmu_notifier will force to reload the
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index f618f52..bd04725 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -143,7 +143,7 @@ struct nested_vmx {
 	 */
 	struct page *apic_access_page;
 	struct kvm_host_map virtual_apic_map;
-	struct page *pi_desc_page;
+	struct kvm_host_map pi_desc_map;
 
 	struct kvm_host_map msr_bitmap_map;
 
-- 
2.7.4

