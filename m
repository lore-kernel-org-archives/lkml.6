Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BE7C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A1521712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="EqwLP1M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A1521712
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJUGeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:34:50 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:46818 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeJUGeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540074172; x=1571610172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1Rx8lhuGoqxEyIRAUuNLtWy0WA2jVprcH1UfNgGaEAE=;
  b=EqwLP1M/QQmXQYGhXPuR52uCTjDi9L9AtLSepSczRVcVXCkJPfDVaKv7
   a4cLENZtwraqrGEidqA/aKipWedJ0RIcIn5p/79/NfROryhVnukdMlRNl
   RhCkVvrLbFlVpcpmSxeu9T61phf/TeEHWExvWpB9BTLh54cJWefuRaP91
   k=;
X-IronPort-AV: E=Sophos;i="5.54,405,1534809600"; 
   d="scan'208";a="364167573"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Oct 2018 22:22:50 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9KMMk2x126561
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 20 Oct 2018 22:22:47 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9KMMjQ6031595;
        Sun, 21 Oct 2018 00:22:45 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9KMMi4F031594;
        Sun, 21 Oct 2018 00:22:44 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v3 02/13] X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory
Date:   Sun, 21 Oct 2018 00:22:14 +0200
Message-Id: <1540074145-31285-3-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the VMCS12 directly from guest memory instead of the map->copy->unmap
sequence. This also avoids using kvm_vcpu_gpa_to_page() and kmap() which
assumes that there is a "struct page" for guest memory.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Massage commit message a bit.
---
 arch/x86/kvm/vmx.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 358759a..bc45347 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8879,33 +8879,28 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	}
 
 	if (vmx->nested.current_vmptr != vmptr) {
-		struct vmcs12 *new_vmcs12;
-		struct page *page;
-		page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
-		if (is_error_page(page)) {
+		struct vmcs12 *new_vmcs12 = (struct vmcs12 *)__get_free_page(GFP_KERNEL);
+
+		if (!new_vmcs12 ||
+		    kvm_read_guest(vcpu->kvm, vmptr, new_vmcs12,
+				   sizeof(*new_vmcs12))) {
+			free_page((unsigned long)new_vmcs12);
 			nested_vmx_failInvalid(vcpu);
 			return kvm_skip_emulated_instruction(vcpu);
 		}
-		new_vmcs12 = kmap(page);
+
 		if (new_vmcs12->hdr.revision_id != VMCS12_REVISION ||
 		    (new_vmcs12->hdr.shadow_vmcs &&
 		     !nested_cpu_has_vmx_shadow_vmcs(vcpu))) {
-			kunmap(page);
-			kvm_release_page_clean(page);
+			free_page((unsigned long)new_vmcs12);
 			nested_vmx_failValid(vcpu,
 				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
 			return kvm_skip_emulated_instruction(vcpu);
 		}
 
 		nested_release_vmcs12(vmx);
-		/*
-		 * Load VMCS12 from guest memory since it is not already
-		 * cached.
-		 */
 		memcpy(vmx->nested.cached_vmcs12, new_vmcs12, VMCS12_SIZE);
-		kunmap(page);
-		kvm_release_page_clean(page);
-
+		free_page((unsigned long)new_vmcs12);
 		set_current_vmptr(vmx, vmptr);
 	}
 
-- 
2.7.4

