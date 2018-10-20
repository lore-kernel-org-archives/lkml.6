Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED05ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B7321748
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="MOGqwr3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B7321748
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeJUGfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:35:04 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23520 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeJUGfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540074185; x=1571610185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/9C5LGVbote9to9sNOZF9663W0zu7XSglnpTY2FbEgs=;
  b=MOGqwr3PVMBspdizIrqVNzx/EeQ4QcHprj0lEjFmOXZUZC+UmDN2yUxK
   fcAn6HqjUws9GXznV6OIk3v59OOQSM3jUDQxZ6OqX1gq5nBfrVyRdZKBk
   55dkwDMXZMK6xCC7LU2pjvjUtBAAzH1tujN1Igr0mZLCOK4L3VTnjZHgq
   8=;
X-IronPort-AV: E=Sophos;i="5.54,405,1534809600"; 
   d="scan'208";a="369482181"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-2eab95aa.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Oct 2018 22:23:03 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-2eab95aa.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9KMMxxE058755
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 20 Oct 2018 22:23:00 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9KMMwOP031686;
        Sun, 21 Oct 2018 00:22:58 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9KMMwkY031682;
        Sun, 21 Oct 2018 00:22:58 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v3 13/13] KVM/nVMX: Use kvm_vcpu_map for accessing the shadow VMCS
Date:   Sun, 21 Oct 2018 00:22:25 +0200
Message-Id: <1540074145-31285-14-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
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
index 0ae25c3..2892770 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11616,20 +11616,20 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
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
@@ -12494,9 +12494,9 @@ static int check_vmentry_prereqs(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
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
@@ -12504,17 +12504,16 @@ static int nested_vmx_check_vmcs_link_ptr(struct kvm_vcpu *vcpu,
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

