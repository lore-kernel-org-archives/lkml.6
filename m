Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74BFC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D27821712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="qp3yC8Mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D27821712
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbeJUGew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:34:52 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57222 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeJUGev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540074173; x=1571610173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XltyXaRYUgbt+yHnlA8aYv0hy36rYz8hd7y1tmpKdTo=;
  b=qp3yC8MiZvO8kpK3py7uDAI94vaGUtvx73IORMHYmWiraof3+/dhRokS
   9nUURJKKssPC0v8IQxytrxUKbhGlVdFiIh+rmnorMUd03fWP8otZUN2Uw
   0mqkQY7ppaesvmhCik3fXYDmmXL8z5QsaGtOb3MP/uwfiZAYNWdmYiBW1
   g=;
X-IronPort-AV: E=Sophos;i="5.54,405,1534809600"; 
   d="scan'208";a="637420939"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Oct 2018 22:22:51 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9KMMlsj028168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 20 Oct 2018 22:22:48 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9KMMkO4031599;
        Sun, 21 Oct 2018 00:22:46 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9KMMjP1031598;
        Sun, 21 Oct 2018 00:22:45 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v3 03/13] X86/nVMX: Update the PML table without mapping and unmapping the page
Date:   Sun, 21 Oct 2018 00:22:15 +0200
Message-Id: <1540074145-31285-4-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the PML table without mapping and unmapping the page. This also
avoids using kvm_vcpu_gpa_to_page(..) which assumes that there is a "struct
page" for guest memory.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Use kvm_write_guest_page instead of kvm_write_guest (pbonzini)
- Do not use pointer arithmetic for pml_address (pbonzini)
---
 arch/x86/kvm/vmx.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index bc45347..d857401 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -13571,9 +13571,7 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	gpa_t gpa;
-	struct page *page = NULL;
-	u64 *pml_address;
+	gpa_t gpa, dst;
 
 	if (is_guest_mode(vcpu)) {
 		WARN_ON_ONCE(vmx->nested.pml_full);
@@ -13593,15 +13591,13 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
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

