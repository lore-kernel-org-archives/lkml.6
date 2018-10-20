Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF221ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A6B21712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="vFq6KLXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A6B21712
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJUGe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:34:58 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:56397 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeJUGe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540074179; x=1571610179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=RJg3pN5dO/l5CvDyHcsvfScPyBcEk0q0fpKPOO0lu6I=;
  b=vFq6KLXkDWHnp0YjvQO0Np9s6K4Qsa9WUWGcQP7IxExWuexP3Q1KoFF0
   kg5+KXpq6XzNCRXhz0uNNc5CFHwnY4M0yTD5o2MFH5C0SLg98708Ok4n8
   //3IPNMB/hAn/XIP2Cfrox7n7VzCds/JHIjIME00LBUCPFq8faQpWeuRK
   E=;
X-IronPort-AV: E=Sophos;i="5.54,405,1534809600"; 
   d="scan'208";a="364167577"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Oct 2018 22:22:58 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9KMMqa6114297
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 20 Oct 2018 22:22:54 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9KMMpHx031623;
        Sun, 21 Oct 2018 00:22:51 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9KMMpoS031622;
        Sun, 21 Oct 2018 00:22:51 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v3 08/13] KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt descriptor table
Date:   Sun, 21 Oct 2018 00:22:20 +0200
Message-Id: <1540074145-31285-9-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
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
v1 -> v2:
- Do not change the lifecycle of the mapping (pbonzini)
---
 arch/x86/kvm/vmx.c | 45 +++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 83a5e95..0ae25c3 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -846,7 +846,7 @@ struct nested_vmx {
 	 */
 	struct page *apic_access_page;
 	struct kvm_host_map virtual_apic_map;
-	struct page *pi_desc_page;
+	struct kvm_host_map pi_desc_map;
 	struct kvm_host_map msr_bitmap_map;
 
 	struct pi_desc *pi_desc;
@@ -8469,12 +8469,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.apic_access_page = NULL;
 	}
 	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map);
-	if (vmx->nested.pi_desc_page) {
-		kunmap(vmx->nested.pi_desc_page);
-		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc_page = NULL;
-		vmx->nested.pi_desc = NULL;
-	}
+	kvm_vcpu_unmap(&vmx->nested.pi_desc_map);
+	vmx->nested.pi_desc = NULL;
 
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
@@ -11444,24 +11440,16 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
-		if (vmx->nested.pi_desc_page) { /* shouldn't happen */
-			kunmap(vmx->nested.pi_desc_page);
-			kvm_release_page_dirty(vmx->nested.pi_desc_page);
-			vmx->nested.pi_desc_page = NULL;
+		map = &vmx->nested.pi_desc_map;
+
+		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->posted_intr_desc_addr), map)) {
+			vmx->nested.pi_desc =
+				(struct pi_desc *)(((void *)map->hva) +
+				offset_in_page(vmcs12->posted_intr_desc_addr));
+			vmcs_write64(POSTED_INTR_DESC_ADDR, pfn_to_hpa(map->pfn) +
+							    offset_in_page(vmcs12->posted_intr_desc_addr));
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
+
 	}
 	if (nested_vmx_prepare_msr_bitmap(vcpu, vmcs12))
 		vmcs_set_bits(CPU_BASED_VM_EXEC_CONTROL,
@@ -13344,13 +13332,10 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 		kvm_release_page_dirty(vmx->nested.apic_access_page);
 		vmx->nested.apic_access_page = NULL;
 	}
+
 	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map);
-	if (vmx->nested.pi_desc_page) {
-		kunmap(vmx->nested.pi_desc_page);
-		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc_page = NULL;
-		vmx->nested.pi_desc = NULL;
-	}
+	kvm_vcpu_unmap(&vmx->nested.pi_desc_map);
+	vmx->nested.pi_desc = NULL;
 
 	/*
 	 * We are now running in L2, mmu_notifier will force to reload the
-- 
2.7.4

