Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE41C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F642148E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="pzeXZKSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F642148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLCJcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:32:01 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:14192 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeLCJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543829506; x=1575365506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lgrScxqxrin9gHDSNDALlt+wU02MV7kz+wyDztmLnes=;
  b=pzeXZKSW4/BgEl/cuzXS7QJG0mD9zSAzRQNJPKi1xALpvPd7YsaH/VE+
   e01WM/XaKHAmZkBCGJ7yZRhGBoKymnbQT9SnZ7Ad3YAhEN/NyqmCmghIg
   dxz9dcn090uTdVbn5wrs26UTizUCLqX+tlf28ST890kMm8cJN8nGGl5vR
   g=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="645647494"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Dec 2018 09:31:41 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wB39VbQQ038740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 3 Dec 2018 09:31:39 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wB39Va0v018183;
        Mon, 3 Dec 2018 10:31:36 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id wB39VaTZ018171;
        Mon, 3 Dec 2018 10:31:36 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v4 13/14] KVM/nVMX: Use kvm_vcpu_map for accessing the shadow VMCS
Date:   Mon,  3 Dec 2018 10:31:06 +0100
Message-Id: <1543829467-18025-14-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map for accessing the shadow VMCS since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 390a971..a958700 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -12138,20 +12138,20 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
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
+	kvm_vcpu_unmap(&map);
 }
 
 static void nested_flush_cached_shadow_vmcs12(struct kvm_vcpu *vcpu,
@@ -13133,9 +13133,9 @@ static int check_vmentry_prereqs(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
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
@@ -13143,17 +13143,16 @@ static int nested_vmx_check_vmcs_link_ptr(struct kvm_vcpu *vcpu,
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
+	kvm_vcpu_unmap(&map);
 	return r;
 }
 
-- 
2.7.4

