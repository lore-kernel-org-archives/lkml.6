Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD383C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E13221712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="CIhnigyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E13221712
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJUGeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:34:50 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57222 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeJUGeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540074172; x=1571610172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sKnDBujqJdwdKhom39UVYA9acRoCkGtukAs5R/JDLEg=;
  b=CIhnigyJjx5FIy9otFWXWv81UO+0maNxsGFbUuSOLSqm8wUCTz6lS1Mx
   sdyi2GS7yF77U1Y161cLRK8jEATNc2Rr+KLwXyBFw1iVIFqV5AkDuMo9F
   SYVYGUh6tNlEM+1G6hkewg/Uj1z9VIBXbWnezmmX2twn/svihpH/U4BFa
   0=;
X-IronPort-AV: E=Sophos;i="5.54,405,1534809600"; 
   d="scan'208";a="637420936"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Oct 2018 22:22:48 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9KMMi01003423
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 20 Oct 2018 22:22:46 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9KMMieM031591;
        Sun, 21 Oct 2018 00:22:44 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9KMMhwJ031590;
        Sun, 21 Oct 2018 00:22:43 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v3 01/13] X86/nVMX: handle_vmon: Read 4 bytes from guest memory
Date:   Sun, 21 Oct 2018 00:22:13 +0200
Message-Id: <1540074145-31285-2-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the data directly from guest memory instead of the map->read->unmap
sequence. This also avoids using kvm_vcpu_gpa_to_page() and kmap() which
assumes that there is a "struct page" for guest memory.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Massage commit message a bit.
---
 arch/x86/kvm/vmx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4f5d4bd..358759a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8321,7 +8321,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 {
 	int ret;
 	gpa_t vmptr;
-	struct page *page;
+	uint32_t revision;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
 		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
@@ -8373,19 +8373,11 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
-	page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
-	if (is_error_page(page)) {
+	if (kvm_read_guest(vcpu->kvm, vmptr, &revision, sizeof(revision)) ||
+	    revision != VMCS12_REVISION) {
 		nested_vmx_failInvalid(vcpu);
 		return kvm_skip_emulated_instruction(vcpu);
 	}
-	if (*(u32 *)kmap(page) != VMCS12_REVISION) {
-		kunmap(page);
-		kvm_release_page_clean(page);
-		nested_vmx_failInvalid(vcpu);
-		return kvm_skip_emulated_instruction(vcpu);
-	}
-	kunmap(page);
-	kvm_release_page_clean(page);
 
 	vmx->nested.vmxon_ptr = vmptr;
 	ret = enter_vmx_operation(vcpu);
-- 
2.7.4

