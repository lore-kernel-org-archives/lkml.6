Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD2EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D383214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="u0wQbVcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfAIJno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:43:44 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:6461 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbfAIJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547026942; x=1578562942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bnzeuEUS60UibzIf6CzBfmI0leq/yGJtjEHqDSi8SqA=;
  b=u0wQbVcj0b2W2Oc62pUa0gBdlkSeg2wtriq/7bB/b4kqOYdOSZQZK1uD
   uhpG58GBn73SHwIUh/hjXF95Xh9jdGgUJpaZO5NC/bb12+hMOtcQ3SqIt
   QPqcNpPc/6kxuLbF3P7NSTxVPee5h0PdBb0A6iTkxdWSX5/ntjdpjkiJG
   w=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="712024356"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jan 2019 09:42:21 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x099gHWC054039
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 9 Jan 2019 09:42:18 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x099gG6N031298;
        Wed, 9 Jan 2019 10:42:17 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x099gGAj031297;
        Wed, 9 Jan 2019 10:42:16 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 02/13] X86/nVMX: Update the PML table without mapping and unmapping the page
Date:   Wed,  9 Jan 2019 10:42:02 +0100
Message-Id: <1547026933-31226-3-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the PML table without mapping and unmapping the page. This also
avoids using kvm_vcpu_gpa_to_page(..) which assumes that there is a "struct
page" for guest memory.

As a side-effect of using kvm_write_guest_page the page is also properly
marked as dirty.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
v1 -> v2:
- Use kvm_write_guest_page instead of kvm_write_guest (pbonzini)
- Do not use pointer arithmetic for pml_address (pbonzini)
---
 arch/x86/kvm/vmx/vmx.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4d39f73..71d88df 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7199,9 +7199,7 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	gpa_t gpa;
-	struct page *page = NULL;
-	u64 *pml_address;
+	gpa_t gpa, dst;
 
 	if (is_guest_mode(vcpu)) {
 		WARN_ON_ONCE(vmx->nested.pml_full);
@@ -7221,15 +7219,13 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 		}
 
 		gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS) & ~0xFFFull;
+		dst = vmcs12->pml_address + sizeof(u64) * vmcs12->guest_pml_index;
 
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->pml_address);
-		if (is_error_page(page))
+		if (kvm_write_guest_page(vcpu->kvm, gpa_to_gfn(dst), &gpa,
+					 offset_in_page(dst), sizeof(gpa)))
 			return 0;
 
-		pml_address = kmap(page);
-		pml_address[vmcs12->guest_pml_index--] = gpa;
-		kunmap(page);
-		kvm_release_page_clean(page);
+		vmcs12->guest_pml_index--;
 	}
 
 	return 0;
-- 
2.7.4

