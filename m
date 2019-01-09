Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA03EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83D121741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="H/OnXORX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfAIJmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:42:53 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:53731 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbfAIJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547026949; x=1578562949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+OgXWLij7az0MI49TyIaysFnRbjS1cbJdhcZ2MrJgNU=;
  b=H/OnXORXG6HPuoaFq8UxrhjRMAcuQaSEutKi9ysm6MDusHdZegUJkURh
   ohS7jnrYlMzrCnWsTfn2v3BmaHdFAeLy1Fx4HGXTLbtT92Lsb32PBtfd8
   3CCojkHVse8IwO0CrkbtlTlMK52CTOjtBugVNnvXkWdE5taJR7VQPtPtb
   Y=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="380876339"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jan 2019 09:42:28 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x099gKoT101493
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 9 Jan 2019 09:42:22 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x099gKS4031323;
        Wed, 9 Jan 2019 10:42:20 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x099gKT9031322;
        Wed, 9 Jan 2019 10:42:20 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 08/13] KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt descriptor table
Date:   Wed,  9 Jan 2019 10:42:08 +0100
Message-Id: <1547026933-31226-9-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
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
index dcff99d..b4230ce 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -230,12 +230,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 		vmx->nested.apic_access_page = NULL;
 	}
 	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map, true);
-	if (vmx->nested.pi_desc_page) {
-		kunmap(vmx->nested.pi_desc_page);
-		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc_page = NULL;
-		vmx->nested.pi_desc = NULL;
-	}
+	kvm_vcpu_unmap(&vmx->nested.pi_desc_map, true);
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
 	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map, true);
-	if (vmx->nested.pi_desc_page) {
-		kunmap(vmx->nested.pi_desc_page);
-		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc_page = NULL;
-		vmx->nested.pi_desc = NULL;
-	}
+	kvm_vcpu_unmap(&vmx->nested.pi_desc_map, true);
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

