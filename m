Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeECCQr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 22:16:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:10026 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751837AbeECCQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 22:16:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="51086587"
From: Jingqi Liu <jingqi.liu@intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jingqi Liu <jingqi.liu@intel.com>,
        Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH] KVM: x86: Expose CLDEMOTE CPU feature to guest VM
Date: Fri,  4 May 2018 11:55:46 +0800
Message-Id: <1525406146-54791-1-git-send-email-jingqi.liu@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CLDEMOTE instruction hints to hardware that the cache line that
contains the linear address should be moved("demoted") from
the cache(s) closest to the processor core to a level more distant
from the processor core. This may accelerate subsequent accesses
to the line by other cores in the same coherence domain,
especially if the line was written by the core that demotes the line.

This patch exposes the cldemote feature to the guest.

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf
This patch has a dependency on https://lkml.org/lkml/2018/4/23/928

Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 82055b9..72d8c49 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -403,7 +403,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 	const u32 kvm_cpuid_7_0_ecx_x86_features =
 		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ |
 		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
-		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG);
+		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
+		F(CLDEMOTE);
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-- 
1.8.3.1
