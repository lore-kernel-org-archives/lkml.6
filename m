Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420BDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B8721741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="nF37EElz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfAIJmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:42:21 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:29960 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547026939; x=1578562939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ZYLquAt/UJH2B+U3x9AIYwZ9ehf1JWHBceR3nijqvug=;
  b=nF37EElzlTFix/lTX4pB4ZIwX7wSnizZ3ThbEtVEmu561ng55sSPIyMW
   F2TqzsNtQkbV9oxzeF2vWnbJjCgRmw+HNPmj38EjyMfWUIcZzBlERwTgC
   Tso04uT5EYOXanBhnUQrsS1A98aJpXhILiITjhJioxZgLWYM3CoS+8ufy
   0=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="380876324"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 09 Jan 2019 09:42:18 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 4B0E9A243A;
        Wed,  9 Jan 2019 09:42:18 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x099gGpp031294;
        Wed, 9 Jan 2019 10:42:16 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x099gGSo031293;
        Wed, 9 Jan 2019 10:42:16 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 01/13] X86/nVMX: handle_vmon: Read 4 bytes from guest memory
Date:   Wed,  9 Jan 2019 10:42:01 +0100
Message-Id: <1547026933-31226-2-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the data directly from guest memory instead of the map->read->unmap
sequence. This also avoids using kvm_vcpu_gpa_to_page() and kmap() which
assumes that there is a "struct page" for guest memory.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

---
v1 -> v2:
- Massage commit message a bit.
---
 arch/x86/kvm/vmx/nested.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3170e29..536468a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4192,7 +4192,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 {
 	int ret;
 	gpa_t vmptr;
-	struct page *page;
+	uint32_t revision;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
 		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
@@ -4241,18 +4241,10 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	if (!PAGE_ALIGNED(vmptr) || (vmptr >> cpuid_maxphyaddr(vcpu)))
 		return nested_vmx_failInvalid(vcpu);
 
-	page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
-	if (is_error_page(page))
+	if (kvm_read_guest(vcpu->kvm, vmptr, &revision, sizeof(revision)) ||
+	    revision != VMCS12_REVISION)
 		return nested_vmx_failInvalid(vcpu);
 
-	if (*(u32 *)kmap(page) != VMCS12_REVISION) {
-		kunmap(page);
-		kvm_release_page_clean(page);
-		return nested_vmx_failInvalid(vcpu);
-	}
-	kunmap(page);
-	kvm_release_page_clean(page);
-
 	vmx->nested.vmxon_ptr = vmptr;
 	ret = enter_vmx_operation(vcpu);
 	if (ret)
-- 
2.7.4

