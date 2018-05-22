Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751063AbeEUHW3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 03:22:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:23127 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbeEUHW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 03:22:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="56096309"
From: Jingqi Liu <jingqi.liu@intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, wei.w.wang@intel.com,
        Jingqi Liu <jingqi.liu@intel.com>
Subject: [PATCH RESEND] KVM: x86: Expose CLDEMOTE CPU feature to guest VM
Date: Tue, 22 May 2018 17:01:27 +0800
Message-Id: <1526979687-1262-1-git-send-email-jingqi.liu@intel.com>
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
