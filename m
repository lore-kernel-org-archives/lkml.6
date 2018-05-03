Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeECKPB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:15:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:44393 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbeECKO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:14:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="38109765"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 04/13] perf/x86/intel/pt: add new capability for Intel PT
Date: Thu,  3 May 2018 20:08:34 +0800
Message-Id: <1525349323-9938-5-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUID(EAX=14H,ECX=0):EBX[bit 3] = 1 indicates support of
output to Trace Transport subsystem.
MSR IA32_RTIT_CTL.FabricEn[bit 6] is reserved if
CPUID.(EAX=14H, ECX=0):ECX[bit 3] = 0.
This is use for emulate IA32_RTIT_CTL MSR read/write
in KVM. KVM guest write IA32_RTIT_CTL will trap to
root mode and a #GP would be injected to guest if set
IA32_RTIT_CTL.FabricEn with
CPUID.(EAX=14H, ECX=0):ECX[bit 3] = 0.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.c      | 1 +
 arch/x86/include/asm/intel_pt.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index a5a7e44..d5819a2 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -68,6 +68,7 @@
 	PT_CAP(topa_output,		0, CPUID_ECX, BIT(0)),
 	PT_CAP(topa_multiple_entries,	0, CPUID_ECX, BIT(1)),
 	PT_CAP(single_range_output,	0, CPUID_ECX, BIT(2)),
+	PT_CAP(output_subsys,		0, CPUID_ECX, BIT(3)),
 	PT_CAP(payloads_lip,		0, CPUID_ECX, BIT(31)),
 	PT_CAP(num_address_ranges,	1, CPUID_EAX, 0x3),
 	PT_CAP(mtc_periods,		1, CPUID_EAX, 0xffff0000),
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 4270421..2de4db0 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -16,6 +16,7 @@ enum pt_capabilities {
 	PT_CAP_topa_output,
 	PT_CAP_topa_multiple_entries,
 	PT_CAP_single_range_output,
+	PT_CAP_output_subsys,
 	PT_CAP_payloads_lip,
 	PT_CAP_num_address_ranges,
 	PT_CAP_mtc_periods,
-- 
1.8.3.1
