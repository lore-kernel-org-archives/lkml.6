Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BBDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61BF21741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="RaSCcnM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfAIJm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:42:29 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:26334 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfAIJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547026946; x=1578562946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UZb1p4sLrN6RruG6/MmAj6BS9+S+F2r8tm9M137yg1M=;
  b=RaSCcnM8MhuNmrXnybZ41DCPniFqGIpATsQpSJ0VLLCUozJIERtxEJoq
   ivl5TV1elG/2bx2Wh8Fn8xZ3GVKoOvY++scyzz7qAWkWODJc4cK3YvX+E
   iFoPtfRY9oY9czdBzePYK7LBaPLUZ0xSX/v/jIL/g8wqm9V1hw+gWbgi+
   A=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="753236067"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 09 Jan 2019 09:42:24 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id C05BEA1F2A;
        Wed,  9 Jan 2019 09:42:23 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x099gLhk031343;
        Wed, 9 Jan 2019 10:42:21 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x099gLqY031341;
        Wed, 9 Jan 2019 10:42:21 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 11/13] KVM/nVMX: Use kvm_vcpu_map for accessing the shadow VMCS
Date:   Wed,  9 Jan 2019 10:42:11 +0100
Message-Id: <1547026933-31226-12-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map for accessing the shadow VMCS since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v4 -> v5:
- unmap with dirty flag
---
 arch/x86/kvm/vmx/nested.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b4230ce..04a8b43 100644
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
+	kvm_vcpu_unmap(&map, false);
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
+	kvm_vcpu_unmap(&map, false);
 	return r;
 }
 
-- 
2.7.4

