Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeEVDAZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:00:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:35887 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752566AbeEVC6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 22:58:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="201335931"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        chao.p.peng@linux.intel.com, thomas.lendacky@amd.com, bp@suse.de,
        Kan.liang@intel.com, Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mathieu.poirier@linaro.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, david@redhat.com,
        bsd@redhat.com, yu.c.zhang@linux.intel.com, joro@8bytes.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v9 04/12] perf/x86/intel/pt: add new capability for Intel PT
Date: Tue, 22 May 2018 12:52:07 +0800
Message-Id: <1526964735-16566-5-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
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
index c80e2f5..f65f97a 100644
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
