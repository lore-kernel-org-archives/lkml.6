Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECCFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BA621720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbeLZINV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:13:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:64132 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeLZIMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:12:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 00:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="104759673"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.239.13.104])
  by orsmga008.jf.intel.com with ESMTP; 26 Dec 2018 00:12:41 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: [PATCH v1 3/8] kvm:vmx  Enable loading CET state bit while guest CR4.CET is being set.
Date:   Wed, 26 Dec 2018 16:15:27 +0800
Message-Id: <20181226081532.30698-4-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181226081532.30698-1-weijiang.yang@intel.com>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bit controls whether guest CET states will be loaded on guest entry.

Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/vmx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 7bbb8b26e901..25fa6bd2fb95 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1045,6 +1045,8 @@ struct vcpu_vmx {
 
 	bool req_immediate_exit;
 
+	bool vcpu_cet_on;
+
 	/* Support for PML */
 #define PML_ENTITY_NUM		512
 	struct page *pml_pg;
@@ -5409,6 +5411,23 @@ static int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 	}
 
+	/*
+	 * When CET.CR4 is being set, it means we're enabling CET for
+	 * the guest, then enable loading CET state bit in entry control.
+	 * Otherwise, clear loading CET bit to disable guest CET.
+	 */
+	if (cr4 & X86_CR4_CET) {
+		if (!to_vmx(vcpu)->vcpu_cet_on) {
+			vmcs_set_bits(VM_ENTRY_CONTROLS,
+				      VM_ENTRY_LOAD_GUEST_CET_STATE);
+			to_vmx(vcpu)->vcpu_cet_on = 1;
+		}
+	} else if (to_vmx(vcpu)->vcpu_cet_on) {
+		vmcs_clear_bits(VM_ENTRY_CONTROLS,
+				VM_ENTRY_LOAD_GUEST_CET_STATE);
+		to_vmx(vcpu)->vcpu_cet_on = 0;
+	}
+
 	if (to_vmx(vcpu)->nested.vmxon && !nested_cr4_valid(vcpu, cr4))
 		return 1;
 
-- 
2.17.1

