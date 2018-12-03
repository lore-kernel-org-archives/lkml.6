Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DD2C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC72321486
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="WymcfXZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC72321486
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLCJcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:32:01 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7528 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeLCJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543829505; x=1575365505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=r4w0LpTsqBQLW9Zoqc4CnRSB1y0WAxXSHwf3C4SNKHQ=;
  b=WymcfXZ9qxL4rcdcrmDTrOviJav215z44zEACHwehHUF9IZvOPubHvTX
   yYy4yyYmTTg3iYceGGXv8fPgAfWLbk5tB04Lcd+f1hQecyd2uxPxBqDg0
   RjPJi7+BeaphBnYaSHBNf92HnLTtpplkG3933NEB8N/nvjqvLvnVz2PNZ
   8=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="370600072"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Dec 2018 09:31:45 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wB39VcrM090917
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 3 Dec 2018 09:31:40 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wB39VbNM018194;
        Mon, 3 Dec 2018 10:31:37 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id wB39Vb6D018193;
        Mon, 3 Dec 2018 10:31:37 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v4 14/14] KVM/nVMX: Use kvm_vcpu_map for accessing the enhanced VMCS
Date:   Mon,  3 Dec 2018 10:31:07 +0100
Message-Id: <1543829467-18025-15-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map for accessing the enhanced VMCS since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a958700..83a614f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -894,7 +894,7 @@ struct nested_vmx {
 	} smm;
 
 	gpa_t hv_evmcs_vmptr;
-	struct page *hv_evmcs_page;
+	struct kvm_host_map hv_evmcs_map;
 	struct hv_enlightened_vmcs *hv_evmcs;
 };
 
@@ -8456,10 +8456,8 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 	if (!vmx->nested.hv_evmcs)
 		return;
 
-	kunmap(vmx->nested.hv_evmcs_page);
-	kvm_release_page_dirty(vmx->nested.hv_evmcs_page);
+	kvm_vcpu_unmap(&vmx->nested.hv_evmcs_map);
 	vmx->nested.hv_evmcs_vmptr = -1ull;
-	vmx->nested.hv_evmcs_page = NULL;
 	vmx->nested.hv_evmcs = NULL;
 }
 
@@ -8559,7 +8557,7 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 		return nested_vmx_failValid(vcpu,
 			VMXERR_VMCLEAR_VMXON_POINTER);
 
-	if (vmx->nested.hv_evmcs_page) {
+	if (vmx->nested.hv_evmcs_map.hva) {
 		if (vmptr == vmx->nested.hv_evmcs_vmptr)
 			nested_release_evmcs(vcpu);
 	} else {
@@ -9355,13 +9353,11 @@ static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
 
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
-- 
2.7.4

