Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E08C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC012147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfBZGdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:33:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:18116 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfBZGdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:33:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 22:33:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,414,1544515200"; 
   d="scan'208";a="141666222"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2019 22:32:59 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v3 8/8] KVM:X86: Add user-space read/write interface for CET MSRs.
Date:   Mon, 25 Feb 2019 21:27:16 +0800
Message-Id: <20190225132716.6982-9-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225132716.6982-1-weijiang.yang@intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Guest MSRs are stored in fpu storage area, they are
operated by XSAVES/XRSTORS, so use kvm_load_guest_fpu
to restore them is a convenient way to let KVM access
them. After finish operation, need to restore Host MSR
contents by kvm_put_guest_fpu.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/x86.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a0f8b71b2132..a4bdbef3a712 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -75,6 +75,8 @@
 
 #define MAX_IO_MSRS 256
 #define KVM_MAX_MCE_BANKS 32
+#define MAX_GUEST_CET_MSRS 5
+
 u64 __read_mostly kvm_mce_cap_supported = MCG_CTL_P | MCG_SER_P;
 EXPORT_SYMBOL_GPL(kvm_mce_cap_supported);
 
@@ -214,6 +216,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 u64 __read_mostly host_xcr0;
 
 static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
+static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
+static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
 
 static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
 {
@@ -2889,21 +2893,57 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 }
 EXPORT_SYMBOL_GPL(kvm_get_msr_common);
 
+static int do_cet_msrs(struct kvm_vcpu *vcpu, int entry_num,
+		       struct kvm_msr_entry *entries, bool read)
+{
+	int i = entry_num;
+	int j = MAX_GUEST_CET_MSRS;
+	bool has_cet;
+
+	has_cet = guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) |
+		  guest_cpuid_has(vcpu, X86_FEATURE_IBT);
+	/*
+	 * Guest CET MSRs are saved by XSAVES, so need to restore
+	 * them first, then read out or update the contents and
+	 * restore Host ones.
+	 */
+	if (has_cet) {
+		kvm_load_guest_fpu(vcpu);
+
+		if (read) {
+			for (j = 0; j < MAX_GUEST_CET_MSRS; j++, i++)
+				rdmsrl(entries[i].index, entries[i].data);
+		} else {
+			for (j = 0; j < MAX_GUEST_CET_MSRS; j++, i++)
+				wrmsrl(entries[i].index, entries[i].data);
+		}
+
+		kvm_put_guest_fpu(vcpu);
+	}
+	return j;
+}
 /*
  * Read or write a bunch of msrs. All parameters are kernel addresses.
  *
  * @return number of msrs set successfully.
  */
 static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
-		    struct kvm_msr_entry *entries,
+		    struct kvm_msr_entry *entries, bool read,
 		    int (*do_msr)(struct kvm_vcpu *vcpu,
 				  unsigned index, u64 *data))
 {
 	int i;
 
-	for (i = 0; i < msrs->nmsrs; ++i)
+	for (i = 0; i < msrs->nmsrs; ++i) {
+		/* If it comes to CET related MSRs, read them together. */
+		if (entries[i].index == MSR_IA32_U_CET) {
+			i += do_cet_msrs(vcpu, i, entries, read) - 1;
+			continue;
+		}
+
 		if (do_msr(vcpu, entries[i].index, &entries[i].data))
 			break;
+	}
 
 	return i;
 }
@@ -2938,7 +2978,7 @@ static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
 		goto out;
 	}
 
-	r = n = __msr_io(vcpu, &msrs, entries, do_msr);
+	r = n = __msr_io(vcpu, &msrs, entries, !!writeback, do_msr);
 	if (r < 0)
 		goto out_free;
 
-- 
2.17.1

