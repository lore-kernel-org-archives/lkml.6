Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZq7qa2hbVXOdwzDVCmoo11HK/GjCtG31Fy3DaNTs1u5RFE1+Ts/amXZM6o6hdFMjS8qbwoe
ARC-Seal: i=1; a=rsa-sha256; t=1526288589; cv=none;
        d=google.com; s=arc-20160816;
        b=TIOERhjm9ZrZgtwqXnjGx3s5zaUEUrIRGJBWK7qu3dgC5uU1W0aIwskDEURKviNsy+
         /bPU/dhyaWWZQ3WH4Scczq08AQqg1q5R6X/WeOvxd66GNXSsjg5LbHfmgsB5fJRCWL8l
         bj9zMgs+y8XNj/2AtBliXCiKANFn2yKFrlEGiUDk6FnYG49k70iBGvAzVvqJPc1Zk+Qh
         kWiqZAuSYlFWHs0YKriW3wV+enzobUEyHkUcEEKG7E0kbNI3n/v305LYNow7TA14aOIH
         V+1Z6G6u6UPHdrpQn9xKbLVUeo2DQ3aYO0kVm9YsZVjLk7sc+Ir/Tg88rBSARWT/aQVe
         jW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=oSARMHova8ckAQXE+qqZL+iAS6nh8fBZNoiR3BUv6yc=;
        b=FWo2t9CT4Ewvj1yTDLyLVO2t/hp/lOVmUadCDnW5Y9I0TNoPXVaLfjKsXOwdBDdF8s
         m/Yafje59LnqRFv1MD4q8B3FIm6AgvULABvMc09Fxflhf5nEcS+w9Z3iCeZAMXgEgkcn
         P/VcDn55fn2335fqBs/dcYOkZz6sejMe8SF3JtB7Yv93IkH0zfxUEegr07ZhusnuWfae
         UCata86YoJvqwmAzW0X3RDX8fnhS0Awx6s7jEWZuiRPiRXSW2lxh1Hs+LpGL27cH+xA3
         LX/fWd+so1NqNb3m3x++J5KtXIY0rdAah67pPabqFuLrYsZ6uqEunWkDnJ+6jxsOblwm
         m/fA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701872"
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
Subject: [PATCH v8 04/12] perf/x86/intel/pt: add new capability for Intel PT
Date: Mon, 14 May 2018 18:57:04 +0800
Message-Id: <1526295432-20640-5-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429584242007561?=
X-GMAIL-MSGID: =?utf-8?q?1600429584242007561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
