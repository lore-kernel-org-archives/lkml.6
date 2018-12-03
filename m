Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F81C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C461214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="noz8bO8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C461214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbeLCJbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:31:46 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:13385 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLCJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543829492; x=1575365492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=X4es+NJuNC6iZZeU80yTmojLERaaQaac8L1xu90z+gg=;
  b=noz8bO8Dg1tHEOQTRsbmnoXyKZIEK92bI29suNE3Hi75IUnsouAg7PI7
   UVyMtqPXtlkk5YdFwo19UrS4lDo6tKSw7jsNZOjGmKopZOWkpSsTNNyTy
   /HcUpjnnprG4OevmnBIiRrEjFTj7cqniAlKdv0nGu6jOkgDSC9JRLUNsC
   Q=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="375919223"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Dec 2018 09:31:30 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wB39VQCg112700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 3 Dec 2018 09:31:27 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wB39VP8D018116;
        Mon, 3 Dec 2018 10:31:25 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id wB39VPPC018115;
        Mon, 3 Dec 2018 10:31:25 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v4 02/14] X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory
Date:   Mon,  3 Dec 2018 10:30:55 +0100
Message-Id: <1543829467-18025-3-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the VMCS12 directly from guest memory instead of the map->copy->unmap
sequence. This also avoids using kvm_vcpu_gpa_to_page() and kmap() which
assumes that there is a "struct page" for guest memory.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v3 -> v4:
- Return VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID on failure (jmattson@)
v1 -> v2:
- Massage commit message a bit.
---
 arch/x86/kvm/vmx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index b84f230..75817cb 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9301,20 +9301,22 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		return 1;
 
 	if (vmx->nested.current_vmptr != vmptr) {
-		struct vmcs12 *new_vmcs12;
-		struct page *page;
-		page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
-		if (is_error_page(page))
-			return nested_vmx_failInvalid(vcpu);
+		struct vmcs12 *new_vmcs12 = (struct vmcs12 *)__get_free_page(GFP_KERNEL);
+
+		if (!new_vmcs12 ||
+		    kvm_read_guest(vcpu->kvm, vmptr, new_vmcs12,
+				   sizeof(*new_vmcs12))) {
+			free_page((unsigned long)new_vmcs12);
+			return nested_vmx_failValid(vcpu,
+						    VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
+		}
 
-		new_vmcs12 = kmap(page);
 		if (new_vmcs12->hdr.revision_id != VMCS12_REVISION ||
 		    (new_vmcs12->hdr.shadow_vmcs &&
 		     !nested_cpu_has_vmx_shadow_vmcs(vcpu))) {
-			kunmap(page);
-			kvm_release_page_clean(page);
+			free_page((unsigned long)new_vmcs12);
 			return nested_vmx_failValid(vcpu,
-				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
+						    VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
 		}
 
 		nested_release_vmcs12(vcpu);
@@ -9324,9 +9326,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		 * cached.
 		 */
 		memcpy(vmx->nested.cached_vmcs12, new_vmcs12, VMCS12_SIZE);
-		kunmap(page);
-		kvm_release_page_clean(page);
-
+		free_page((unsigned long)new_vmcs12);
 		set_current_vmptr(vmx, vmptr);
 	}
 
-- 
2.7.4

