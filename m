Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715B9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5D721939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="LrbIgBi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfAaU1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:27:14 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:4315 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfAaU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966430; x=1580502430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4i3LOAT8bW3OPM1hrquX4BTCGnfV2n1KS9LBtSPYG50=;
  b=LrbIgBi7ZqOV7eSwPCavFVcV+FeShgph82hSvrnj/VxhLDDTJaX0sLcX
   asi9h8Kv9Ty28eCj1awPWaLBn92mLsXfICTltkSyi+aKOnLatyqo+Itvc
   YTM0AhxDVNHDIW314vtIm9DeB6VNwaLsv5NqspsSG6bTjqw7b5a7qOfte
   I=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="656822833"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 31 Jan 2019 20:27:09 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 06D32A26FF;
        Thu, 31 Jan 2019 20:27:08 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKR6bo029026;
        Thu, 31 Jan 2019 21:27:06 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKR6l3029025;
        Thu, 31 Jan 2019 21:27:06 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 12/14] KVM/nVMX: Use kvm_vcpu_map for accessing the enlightened VMCS
Date:   Thu, 31 Jan 2019 21:24:42 +0100
Message-Id: <1548966284-28642-13-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map for accessing the enlightened VMCS since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v4 -> v5:
- s/enhanced/enlightened
- unmap with dirty flag
---
 arch/x86/kvm/vmx/nested.c | 14 +++++---------
 arch/x86/kvm/vmx/vmx.h    |  2 +-
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3c173b9..60ba582 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -193,10 +193,8 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 	if (!vmx->nested.hv_evmcs)
 		return;
 
-	kunmap(vmx->nested.hv_evmcs_page);
-	kvm_release_page_dirty(vmx->nested.hv_evmcs_page);
+	kvm_vcpu_unmap(vcpu, &vmx->nested.hv_evmcs_map, true);
 	vmx->nested.hv_evmcs_vmptr = -1ull;
-	vmx->nested.hv_evmcs_page = NULL;
 	vmx->nested.hv_evmcs = NULL;
 }
 
@@ -1769,13 +1767,11 @@ static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
 
 		nested_release_evmcs(vcpu);
 
-		vmx->nested.hv_evmcs_page = kvm_vcpu_gpa_to_page(
-			vcpu, assist_page.current_nested_vmcs);
-
-		if (unlikely(is_error_page(vmx->nested.hv_evmcs_page)))
+		if (kvm_vcpu_map(vcpu, gpa_to_gfn(assist_page.current_nested_vmcs),
+				 &vmx->nested.hv_evmcs_map))
 			return 0;
 
-		vmx->nested.hv_evmcs = kmap(vmx->nested.hv_evmcs_page);
+		vmx->nested.hv_evmcs = vmx->nested.hv_evmcs_map.hva;
 
 		/*
 		 * Currently, KVM only supports eVMCS version 1
@@ -4278,7 +4274,7 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 		return nested_vmx_failValid(vcpu,
 			VMXERR_VMCLEAR_VMXON_POINTER);
 
-	if (vmx->nested.hv_evmcs_page) {
+	if (vmx->nested.hv_evmcs_map.hva) {
 		if (vmptr == vmx->nested.hv_evmcs_vmptr)
 			nested_release_evmcs(vcpu);
 	} else {
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index bd04725..a130139 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -172,7 +172,7 @@ struct nested_vmx {
 	} smm;
 
 	gpa_t hv_evmcs_vmptr;
-	struct page *hv_evmcs_page;
+	struct kvm_host_map hv_evmcs_map;
 	struct hv_enlightened_vmcs *hv_evmcs;
 };
 
-- 
2.7.4

