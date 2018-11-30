Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734E3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419D8206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419D8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeK3TSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:18:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:29561 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbeK3TSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:18:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="94509030"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2018 00:09:45 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id 3FFB5580213;
        Fri, 30 Nov 2018 00:09:43 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 11/11] KVM: VMX: implement setup SPP page structure in spp miss.
Date:   Fri, 30 Nov 2018 16:09:28 +0800
Message-Id: <cfe03ace30dc441f12d11851933e041f2d7548c0.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We also should setup SPP page structure while we catch
a SPP miss, some case, such as hotplug vcpu, should update
the SPP page table in SPP miss handler.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/mmu.c              | 12 ++++++++++++
 arch/x86/kvm/vmx.c              |  8 ++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ce6d258..a09ea39 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1406,6 +1406,8 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t gva, u64 error_code,
 int kvm_mmu_setup_spp_structure(struct kvm_vcpu *vcpu,
 				u32 access_map, gfn_t gfn);
 
+int kvm_mmu_get_spp_acsess_map(struct kvm *kvm, u32 *access_map, gfn_t gfn);
+
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
 void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid);
 void kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3, bool skip_tlb_flush);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 287ee62..01cf85e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4299,6 +4299,17 @@ static void mmu_spp_spte_set(u64 *sptep, u64 new_spte)
 	__set_spte(sptep, new_spte);
 }
 
+int kvm_mmu_get_spp_acsess_map(struct kvm *kvm, u32 *access_map, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot;
+
+	slot = gfn_to_memslot(kvm, gfn);
+	*access_map = *gfn_to_subpage_wp_info(slot, gfn);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_mmu_get_spp_acsess_map);
+
 int kvm_mmu_setup_spp_structure(struct kvm_vcpu *vcpu,
 				u32 access_map, gfn_t gfn)
 {
@@ -4344,6 +4355,7 @@ int kvm_mmu_setup_spp_structure(struct kvm_vcpu *vcpu,
 	spin_unlock(&kvm->mmu_lock);
 	return -EFAULT;
 }
+EXPORT_SYMBOL_GPL(kvm_mmu_setup_spp_structure);
 
 int kvm_mmu_get_subpages(struct kvm *kvm, struct kvm_subpage *spp_info)
 {
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index b660812..b0ab645 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9706,6 +9706,9 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 static int handle_spp(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qualification;
+	gpa_t gpa;
+	gfn_t gfn;
+	u32 map;
 
 	exit_qualification = vmcs_readl(EXIT_QUALIFICATION);
 
@@ -9732,6 +9735,11 @@ static int handle_spp(struct kvm_vcpu *vcpu)
 		 * SPP table here.
 		 */
 		pr_debug("SPP: %s: SPPT Miss!!!\n", __func__);
+
+		gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
+		gfn = gpa >> PAGE_SHIFT;
+		kvm_mmu_get_spp_acsess_map(vcpu->kvm, &map, gfn);
+		kvm_mmu_setup_spp_structure(vcpu, map, gfn);
 		return 1;
 	}
 
-- 
2.7.4

