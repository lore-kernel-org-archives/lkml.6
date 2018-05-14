Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZpcVazRELomrC+A/AhdtfZ/ncSCZrjqFPPDpHckhBjVPmdNnwCe2wS9pgJiHjq56Rt8TRd+
ARC-Seal: i=1; a=rsa-sha256; t=1526288579; cv=none;
        d=google.com; s=arc-20160816;
        b=MsKus97zcii/wKM6sKcgB/q9W79M8vuEU64DUIBWBxV/anDllo6tIGahc/R5Bsue4w
         VK58eugXW+mQdG0Y1X24fzo/DuFmE5Au4loQM24UmZFOlQu04m9zCEWKSwMi1ooJgZ3R
         Ev101uL83lISqsG2szIaYhpmi9rVZaJSRS+VyClITDj/LW4M5ldYuKVEZsWg8jiuvb7A
         gybQY1q90iSXjRKTWXtN56Wl3HBswWcjSpPu1dgTvnYHttb/nJQ+5h5cfJwVxKNYfm4s
         D6uW1RLmtDndFgjZohH8sigQbQd5rbofkcSZQVOfjkHZmyzOterQeTaKlVndjDFQNvKJ
         WM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Qga+XYuw5xmy11ruZ+MPl0BoXMXLic1P7zATOf+8+dY=;
        b=ZJdcB6bwERrZIuiQDmCpxAUo12Odj2texwo/NsUDUNrijpkSx+r0PkgcrDoCcfT/DD
         jTivRWiM/F0+ph5zbXlBx46ZahD1YMKoUNIrjISooo7BpSQAwbQKa7Ljys3Y4rHdcdcx
         zaZZiUb0Ecfw9vip2hkuZ9MOi5B61pxDwymfr4ID0KsRZm+EQ85IheARTXj0FyvIieUk
         kjXogXQ+STlf5NwRkETl2kGk5vrQOAnQXv1WiZmDzNM1SUIpcpG2AJczekhLufABKOab
         rGbtdJzgKseqyxZb4YqAd0L4uvmRe+SgAe0lsayVYCItnRlTUVQRm8dQ18SFcLqvwis5
         TLAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701827"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	chao.p.peng@linux.intel.com,
	thomas.lendacky@amd.com,
	bp@suse.de,
	Kan.liang@intel.com,
	Janakarajan.Natarajan@amd.com,
	dwmw@amazon.co.uk,
	linux-kernel@vger.kernel.org,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mathieu.poirier@linaro.org,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	david@redhat.com,
	bsd@redhat.com,
	yu.c.zhang@linux.intel.com,
	joro@8bytes.org,
	Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v8 02/12] perf/x86/intel/pt: Change pt_cap_get() to a public function
Date: Mon, 14 May 2018 18:57:02 +0800
Message-Id: <1526295432-20640-3-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429573601015380?=
X-GMAIL-MSGID: =?utf-8?q?1600429573601015380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chao Peng <chao.p.peng@linux.intel.com>

Change pt_cap_get() to a public function that KVM
can access this function to check if specific
feature is supported on hardware.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.c      |  3 ++-
 arch/x86/events/intel/pt.h      | 21 ---------------------
 arch/x86/include/asm/intel_pt.h | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 3b99394..c80e2f5 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -75,7 +75,7 @@
 	PT_CAP(psb_periods,		1, CPUID_EBX, 0xffff0000),
 };
 
-static u32 pt_cap_get(enum pt_capabilities cap)
+u32 pt_cap_get(enum pt_capabilities cap)
 {
 	struct pt_cap_desc *cd = &pt_caps[cap];
 	u32 c = pt_pmu.caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
@@ -83,6 +83,7 @@ static u32 pt_cap_get(enum pt_capabilities cap)
 
 	return (c & cd->mask) >> shift;
 }
+EXPORT_SYMBOL_GPL(pt_cap_get);
 
 static ssize_t pt_cap_show(struct device *cdev,
 			   struct device_attribute *attr,
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 0050ca1..269e15a 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -45,30 +45,9 @@ struct topa_entry {
 	u64	rsvd4	: 16;
 };
 
-#define PT_CPUID_LEAVES		2
-#define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
-
 /* TSC to Core Crystal Clock Ratio */
 #define CPUID_TSC_LEAF		0x15
 
-enum pt_capabilities {
-	PT_CAP_max_subleaf = 0,
-	PT_CAP_cr3_filtering,
-	PT_CAP_psb_cyc,
-	PT_CAP_ip_filtering,
-	PT_CAP_mtc,
-	PT_CAP_ptwrite,
-	PT_CAP_power_event_trace,
-	PT_CAP_topa_output,
-	PT_CAP_topa_multiple_entries,
-	PT_CAP_single_range_output,
-	PT_CAP_payloads_lip,
-	PT_CAP_num_address_ranges,
-	PT_CAP_mtc_periods,
-	PT_CAP_cycle_thresholds,
-	PT_CAP_psb_periods,
-};
-
 struct pt_pmu {
 	struct pmu		pmu;
 	u32			caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index b523f51..4270421 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -2,10 +2,33 @@
 #ifndef _ASM_X86_INTEL_PT_H
 #define _ASM_X86_INTEL_PT_H
 
+#define PT_CPUID_LEAVES		2
+#define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
+
+enum pt_capabilities {
+	PT_CAP_max_subleaf = 0,
+	PT_CAP_cr3_filtering,
+	PT_CAP_psb_cyc,
+	PT_CAP_ip_filtering,
+	PT_CAP_mtc,
+	PT_CAP_ptwrite,
+	PT_CAP_power_event_trace,
+	PT_CAP_topa_output,
+	PT_CAP_topa_multiple_entries,
+	PT_CAP_single_range_output,
+	PT_CAP_payloads_lip,
+	PT_CAP_num_address_ranges,
+	PT_CAP_mtc_periods,
+	PT_CAP_cycle_thresholds,
+	PT_CAP_psb_periods,
+};
+
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 void cpu_emergency_stop_pt(void);
+extern u32 pt_cap_get(enum pt_capabilities cap);
 #else
 static inline void cpu_emergency_stop_pt(void) {}
+static inline u32 pt_cap_get(enum pt_capabilities cap) { return 0; }
 #endif
 
 #endif /* _ASM_X86_INTEL_PT_H */
-- 
1.8.3.1
