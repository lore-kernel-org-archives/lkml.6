Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7073CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAC7218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="OOVnKzZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfAaU04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:26:56 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:49881 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfAaU04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966415; x=1580502415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6FryeP5zW/W8eKl4Lc0QwnIwqwlVY+oDxaL0wA5absw=;
  b=OOVnKzZxVOkruDarVz7QLxzT+dUSyagA+GUkMhMIMT8ZpBURvT1r3EW4
   vYcjAG1GEYVhZXntI6K/xRXLoAL0bU9iacHDbpDuzBU59pQ7LhgNmMGyn
   yMxmVBxLwg2GQyWW1S+/K757X99FuwE8u1/ecnKBPiBgjAKjj8H5TwgWl
   c=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="384482626"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 20:26:54 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0VKQnw9084336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 31 Jan 2019 20:26:51 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKQl3I028888;
        Thu, 31 Jan 2019 21:26:47 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKQkXx028887;
        Thu, 31 Jan 2019 21:26:46 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 02/14] X86/nVMX: Update the PML table without mapping and unmapping the page
Date:   Thu, 31 Jan 2019 21:24:32 +0100
Message-Id: <1548966284-28642-3-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
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
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

---
v1 -> v2:
- Use kvm_write_guest_page instead of kvm_write_guest (pbonzini)
- Do not use pointer arithmetic for pml_address (pbonzini)
---
 arch/x86/kvm/vmx/vmx.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4341175..a3da75a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7206,9 +7206,7 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	gpa_t gpa;
-	struct page *page = NULL;
-	u64 *pml_address;
+	gpa_t gpa, dst;
 
 	if (is_guest_mode(vcpu)) {
 		WARN_ON_ONCE(vmx->nested.pml_full);
@@ -7228,15 +7226,13 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
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

