Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39884C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6182081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6182081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbeKFPZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:25:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:36469 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbeKFPZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:25:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 22:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,470,1534834800"; 
   d="scan'208";a="271698846"
Received: from optiplex-7050.sh.intel.com ([10.239.161.26])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2018 22:01:30 -0800
From:   Liu Jingqi <jingqi.liu@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com
Cc:     bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, tao3.xu@intel.com,
        Liu Jingqi <jingqi.liu@intel.com>
Subject: [PATCH v2 2/2] KVM: x86: expose MOVDIR64B CPU feature into VM.
Date:   Tue,  6 Nov 2018 13:55:28 +0800
Message-Id: <1541483728-7826-3-git-send-email-jingqi.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541483728-7826-1-git-send-email-jingqi.liu@intel.com>
References: <1541483728-7826-1-git-send-email-jingqi.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOVDIR64B moves 64-bytes as direct-store with 64-bytes write atomicity.
Direct store is implemented by using write combining (WC) for writing
data directly into memory without caching the data.

Availability of the MOVDIR64B instruction is indicated by the presence
of the CPUID feature flag MOVDIR64B (CPUID.0x07.0x0:ECX[bit 28]).

This patch exposes the movdir64b feature to the guest.

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Cc: Xu Tao <tao3.xu@intel.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index cbfeaa7..721893a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -406,7 +406,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ |
 		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
 		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
-		F(CLDEMOTE) | F(MOVDIRI);
+		F(CLDEMOTE) | F(MOVDIRI) | F(MOVDIR64B);
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-- 
2.7.4

