Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C620C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3DA214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="q8yKGqg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfAIJmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:42:33 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:7747 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbfAIJmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547026943; x=1578562943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XbWRGoXnn2oE8QHX9uLOJdr6uqyHPEfkHSA8iqnU1AQ=;
  b=q8yKGqg66sjdHXLEUxOD8/YV+fKhTAvHT6aHUc3dR6ArdDHemQ8bhmS8
   /n6B8Py/oVFx96FxAIh3aiQrNO7oSuFQQfy4QgnYdkTy+xazTYZk60Zfq
   imiQWQO/2T0rFdTJXS11cw81LxdmeP9zRx2E5EwcaYWnb+tMBGWj+eWGd
   4=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="775449725"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Jan 2019 09:42:21 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 75161A2774;
        Wed,  9 Jan 2019 09:42:20 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x099gIuC031311;
        Wed, 9 Jan 2019 10:42:18 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x099gIc4031310;
        Wed, 9 Jan 2019 10:42:18 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 05/13] X86/nVMX: handle_vmptrld: Use kvm_vcpu_map when copying VMCS12 from guest memory
Date:   Wed,  9 Jan 2019 10:42:05 +0100
Message-Id: <1547026933-31226-6-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map to the map the VMCS12 from guest memory because
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v4 -> v5:
- Switch to the new guest mapping API instead of reading directly from
  guest.
- unmap with dirty flag
v3 -> v4:
- Return VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID on failure (jmattson@)
v1 -> v2:
- Massage commit message a bit.
---
 arch/x86/kvm/vmx/nested.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 536468a..5602b0c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4521,11 +4521,10 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		return 1;
 
 	if (vmx->nested.current_vmptr != vmptr) {
+		struct kvm_host_map map;
 		struct vmcs12 *new_vmcs12;
-		struct page *page;
 
-		page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
-		if (is_error_page(page)) {
+		if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmptr), &map)) {
 			/*
 			 * Reads from an unbacked page return all 1s,
 			 * which means that the 32 bits located at the
@@ -4536,12 +4535,13 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
 			return kvm_skip_emulated_instruction(vcpu);
 		}
-		new_vmcs12 = kmap(page);
+
+		new_vmcs12 = map.hva;
+
 		if (new_vmcs12->hdr.revision_id != VMCS12_REVISION ||
 		    (new_vmcs12->hdr.shadow_vmcs &&
 		     !nested_cpu_has_vmx_shadow_vmcs(vcpu))) {
-			kunmap(page);
-			kvm_release_page_clean(page);
+			kvm_vcpu_unmap(&map, false);
 			return nested_vmx_failValid(vcpu,
 				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
 		}
@@ -4553,8 +4553,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		 * cached.
 		 */
 		memcpy(vmx->nested.cached_vmcs12, new_vmcs12, VMCS12_SIZE);
-		kunmap(page);
-		kvm_release_page_clean(page);
+		kvm_vcpu_unmap(&map, false);
 
 		set_current_vmptr(vmx, vmptr);
 	}
-- 
2.7.4

