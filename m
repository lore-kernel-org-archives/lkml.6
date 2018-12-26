Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F251C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF08C21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeLZIM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:12:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:64132 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeLZIMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:12:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 00:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="104759733"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.239.13.104])
  by orsmga008.jf.intel.com with ESMTP; 26 Dec 2018 00:12:51 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: [PATCH v1 8/8] kvm:cpuid  Report CET SHSTK and IBT support in CPUID.(EAX=0x7,ECX=0).
Date:   Wed, 26 Dec 2018 16:15:32 +0800
Message-Id: <20181226081532.30698-9-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181226081532.30698-1-weijiang.yang@intel.com>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest OS can query CET SHSTK and IBT support by CPUID.(EAX=0x7,ECX=0),
in return, ECX[bit 7] corresponds to SHSTK feature, and EDX[bit 20]
corresponds to IBT feature.

Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/cpuid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 55c282f71f93..d7b60b3c4326 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -67,6 +67,8 @@ u64 kvm_supported_xcr0(void)
 
 #define F(x) bit(X86_FEATURE_##x)
 
+#define CET_IBT_BIT bit(20)
+
 /* For scattered features from cpufeatures.h; we currently expose none */
 #define KF(x) bit(KVM_CPUID_BIT_##x)
 
@@ -407,12 +409,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ |
 		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
 		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
-		F(CLDEMOTE);
+		F(CLDEMOTE) | F(SHSTK);
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
 		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
-		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
+		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | CET_IBT_BIT;
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
-- 
2.17.1

