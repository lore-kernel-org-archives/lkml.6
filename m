Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78878C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4914421939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="s8rwtno1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfAaU1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:27:16 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:4315 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfAaU1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966434; x=1580502434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=me9z6wzjmpjhEX2s1lpu2qPDIfP/6uqKoj24b307Bsw=;
  b=s8rwtno15R2v+TQU8IKosQOWeWpZyu/F8/XlJbM4NICwixTUToNu5s2A
   ssxEloPsxzvi24xrjnOKHi4XlL75M4EjI2cBi5hP9Pt2uyUqbQYdegyPh
   p/qhcXUHzkc0/Fi9/ejIwi/8eY4MjTzaTunv1yTh3o2CZSS5eJfyKaQVQ
   0=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="656822847"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 20:27:13 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0VKR6Xs007883
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 31 Jan 2019 20:27:08 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKR5b9029022;
        Thu, 31 Jan 2019 21:27:05 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKR4cU029015;
        Thu, 31 Jan 2019 21:27:04 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 11/14] KVM/nVMX: Use kvm_vcpu_map for accessing the shadow VMCS
Date:   Thu, 31 Jan 2019 21:24:41 +0100
Message-Id: <1548966284-28642-12-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map for accessing the shadow VMCS since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Konrad Rzessutek Wilk <konrad.wilk@oracle.com>
---
v4 -> v5:
- unmap with dirty flag
---
 arch/x86/kvm/vmx/nested.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 53b1063..3c173b9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -588,20 +588,20 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 static void nested_cache_shadow_vmcs12(struct kvm_vcpu *vcpu,
 				       struct vmcs12 *vmcs12)
 {
+	struct kvm_host_map map;
 	struct vmcs12 *shadow;
-	struct page *page;
 
 	if (!nested_cpu_has_shadow_vmcs(vmcs12) ||
 	    vmcs12->vmcs_link_pointer == -1ull)
 		return;
 
 	shadow = get_shadow_vmcs12(vcpu);
-	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->vmcs_link_pointer);
 
-	memcpy(shadow, kmap(page), VMCS12_SIZE);
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->vmcs_link_pointer), &map))
+		return;
 
-	kunmap(page);
-	kvm_release_page_clean(page);
+	memcpy(shadow, map.hva, VMCS12_SIZE);
+	kvm_vcpu_unmap(vcpu, &map, false);
 }
 
 static void nested_flush_cached_shadow_vmcs12(struct kvm_vcpu *vcpu,
@@ -2637,9 +2637,9 @@ static int nested_vmx_check_vmentry_prereqs(struct kvm_vcpu *vcpu,
 static int nested_vmx_check_vmcs_link_ptr(struct kvm_vcpu *vcpu,
 					  struct vmcs12 *vmcs12)
 {
-	int r;
-	struct page *page;
+	int r = 0;
 	struct vmcs12 *shadow;
+	struct kvm_host_map map;
 
 	if (vmcs12->vmcs_link_pointer == -1ull)
 		return 0;
@@ -2647,17 +2647,16 @@ static int nested_vmx_check_vmcs_link_ptr(struct kvm_vcpu *vcpu,
 	if (!page_address_valid(vcpu, vmcs12->vmcs_link_pointer))
 		return -EINVAL;
 
-	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->vmcs_link_pointer);
-	if (is_error_page(page))
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->vmcs_link_pointer), &map))
 		return -EINVAL;
 
-	r = 0;
-	shadow = kmap(page);
+	shadow = map.hva;
+
 	if (shadow->hdr.revision_id != VMCS12_REVISION ||
 	    shadow->hdr.shadow_vmcs != nested_cpu_has_shadow_vmcs(vmcs12))
 		r = -EINVAL;
-	kunmap(page);
-	kvm_release_page_clean(page);
+
+	kvm_vcpu_unmap(vcpu, &map, false);
 	return r;
 }
 
-- 
2.7.4

