Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F24ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C4521712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="XBZWTaua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C4521712
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJUGge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:36:34 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:49228 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeJUGex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540074176; x=1571610176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=q6SDA2PkimJFoNNiw5T2G5CQx2s9QokjfN1BTitKwIw=;
  b=XBZWTauazADBJBqg6xG15b2PUsw8ipOhYzsfGPE46lElW++t+c2aFioh
   PHgpMNFVv94tHa2FPWpeu2Ykbh2vd4hHhm8f9nQjaXfUaNN3Oa0vy4pZ4
   hvVH6DdJWqy53+DvCDB4dGpMS038N35UMleNZRw7lhpMGow5PMvAmDVX9
   A=;
X-IronPort-AV: E=Sophos;i="5.54,405,1534809600"; 
   d="scan'208";a="765266633"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Oct 2018 22:22:54 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9KMMoIS033492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 20 Oct 2018 22:22:51 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9KMMnWd031611;
        Sun, 21 Oct 2018 00:22:49 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9KMMnWd031610;
        Sun, 21 Oct 2018 00:22:49 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v3 06/13] KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
Date:   Sun, 21 Oct 2018 00:22:18 +0200
Message-Id: <1540074145-31285-7-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map when mapping the L1 MSR bitmap since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Do not change the lifecycle of the mapping (pbonzini)
---
 arch/x86/kvm/vmx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d857401..5b15ca2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -847,6 +847,9 @@ struct nested_vmx {
 	struct page *apic_access_page;
 	struct page *virtual_apic_page;
 	struct page *pi_desc_page;
+
+	struct kvm_host_map msr_bitmap_map;
+
 	struct pi_desc *pi_desc;
 	bool pi_pending;
 	u16 posted_intr_nv;
@@ -11546,9 +11549,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 						 struct vmcs12 *vmcs12)
 {
 	int msr;
-	struct page *page;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
+	struct kvm_host_map *map = &to_vmx(vcpu)->nested.msr_bitmap_map;
+
 	/*
 	 * pred_cmd & spec_ctrl are trying to verify two things:
 	 *
@@ -11574,11 +11578,10 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	    !pred_cmd && !spec_ctrl)
 		return false;
 
-	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
-	if (is_error_page(page))
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), map))
 		return false;
 
-	msr_bitmap_l1 = (unsigned long *)kmap(page);
+	msr_bitmap_l1 = (unsigned long *)map->hva;
 	if (nested_cpu_has_apic_reg_virt(vmcs12)) {
 		/*
 		 * L0 need not intercept reads for MSRs between 0x800 and 0x8ff, it
@@ -11626,8 +11629,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 					MSR_IA32_PRED_CMD,
 					MSR_TYPE_W);
 
-	kunmap(page);
-	kvm_release_page_clean(page);
+	kvm_vcpu_unmap(&to_vmx(vcpu)->nested.msr_bitmap_map);
 
 	return true;
 }
-- 
2.7.4

