Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DE5C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F0421916
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Zgy1gWU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfAaU1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:27:06 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:49881 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfAaU1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966421; x=1580502421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yyv/ktHqXfbgyu4K/Sv+eYMPLlWFGHe4R+6uDph1f1A=;
  b=Zgy1gWU2cH4x4KiMEl0go19cDGM+GzECgJW1uP5PR5htdShR71E5yn7Z
   yUJB65volDgHalDQZITjZz8NjyKKiv0l/DvSIOBwBqy2rlpWJ/l3cz4mT
   S7TLJB2r2A6ADK7zWrWP14Tc7JQ6h5MZbXj7KBS8pE0prF6fs8ZQ4fGuS
   s=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="384482656"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 31 Jan 2019 20:27:00 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 8E1D6A23A5;
        Thu, 31 Jan 2019 20:26:59 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKQvDb028959;
        Thu, 31 Jan 2019 21:26:57 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKQuJf028958;
        Thu, 31 Jan 2019 21:26:56 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 05/14] X86/nVMX: handle_vmptrld: Use kvm_vcpu_map when copying VMCS12 from guest memory
Date:   Thu, 31 Jan 2019 21:24:35 +0100
Message-Id: <1548966284-28642-6-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map to the map the VMCS12 from guest memory because
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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
index 11b44a9..8fc327f 100644
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
@@ -4535,12 +4534,13 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 			return nested_vmx_failValid(vcpu,
 				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
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
+			kvm_vcpu_unmap(vcpu, &map, false);
 			return nested_vmx_failValid(vcpu,
 				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
 		}
@@ -4552,8 +4552,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		 * cached.
 		 */
 		memcpy(vmx->nested.cached_vmcs12, new_vmcs12, VMCS12_SIZE);
-		kunmap(page);
-		kvm_release_page_clean(page);
+		kvm_vcpu_unmap(vcpu, &map, false);
 
 		set_current_vmptr(vmx, vmptr);
 	}
-- 
2.7.4

