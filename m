Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZq/Dpcizj+cMuEc2YT4t/mIkxvYq3CPFYQy7v4UtoOVm8BN80UuUHmncpQCs3MaTg2kSAZo
ARC-Seal: i=1; a=rsa-sha256; t=1526288595; cv=none;
        d=google.com; s=arc-20160816;
        b=tqaGXooaBg6Lqgrbsoptj/s/A8reFxSJXNlxe6l30akBJ7QskfrF3m4btywEVMwYfa
         xEdd8VkKc5lFM+owdsWrPsCJNIzp3HE6ZwdEgbsUbOWiWty6nKtQ53gUP8i5hvqNYZCF
         j3fbnajglkS0PGcxea7CCGyfh/WS183+uRGcTeP9mNKXpj0/bwaGrY35LJ+p7csODDt8
         gE5WipfZYxIqTMieenalJUP4mfCiFKgD+MEnMxWcQfQozEh0K+u/sSgjxWh+Q+VgQVKg
         D15LjBZ3gk87Jxrb9ZeL48zT0zm3ZxTDgqs8Bqig387pTM3riFn5qaC0BAVF8sGqQoAu
         inFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=HesOCEyxFqq3MsNFsdYebCiWzMTq5BkyrPLXLMYsNqw=;
        b=T1olsCPivRdjiigAo+/hjECXLykB0IHaCwbt0NhsTvkp3vF+a6MuHnlXbLjTYmFW8U
         SA3OL/D+m7+PXEh7mV8kIWXlJQQvmwgqkv8/aKT9hsv+a4Iyz31GqWtNsxu4/fNULisH
         wLfcjpkK5gyNPXoGhz4Sbwld2oNlJKTeIfJVCDg/V8ZWQrI8KxZ+XRslkv/1h1ZRqzGm
         OpTFThILbsI5RAmNum52Z779oZC8DqAEojf8qrr8KJRuL5jNN6dMbD4VB2WZbfujqzdm
         4UfsPQY21HjwZjKGmrgbT45mu/s+9844TRfDiKOFwjCtWNhzek1VWxu+NZHakRluNfSr
         s2Dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701885"
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
Subject: [PATCH v8 05/12] perf/x86/intel/pt: Introduce a new function to get capability of Intel PT
Date: Mon, 14 May 2018 18:57:05 +0800
Message-Id: <1526295432-20640-6-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429589797335754?=
X-GMAIL-MSGID: =?utf-8?q?1600429589797335754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

New function pt_cap_decode() will be invoked in KVM to check
if a specific capability is available in KVM guest.
Another function pt_cap_get() can only check the hardware
capabilities but this may different with KVM guest because
some features may not be exposed to guest.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.c      | 10 ++++++++--
 arch/x86/include/asm/intel_pt.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index f65f97a..18a2e80 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -76,14 +76,20 @@
 	PT_CAP(psb_periods,		1, CPUID_EBX, 0xffff0000),
 };
 
-u32 pt_cap_get(enum pt_capabilities cap)
+u32 pt_cap_decode(u32 *caps, enum pt_capabilities cap)
 {
 	struct pt_cap_desc *cd = &pt_caps[cap];
-	u32 c = pt_pmu.caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
+	u32 c = caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
 	unsigned int shift = __ffs(cd->mask);
 
 	return (c & cd->mask) >> shift;
 }
+EXPORT_SYMBOL_GPL(pt_cap_decode);
+
+u32 pt_cap_get(enum pt_capabilities cap)
+{
+	return pt_cap_decode(pt_pmu.caps, cap);
+}
 EXPORT_SYMBOL_GPL(pt_cap_get);
 
 static ssize_t pt_cap_show(struct device *cdev,
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 2de4db0..9c71453 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -27,9 +27,11 @@ enum pt_capabilities {
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 void cpu_emergency_stop_pt(void);
 extern u32 pt_cap_get(enum pt_capabilities cap);
+extern u32 pt_cap_decode(u32 *caps, enum pt_capabilities cap);
 #else
 static inline void cpu_emergency_stop_pt(void) {}
 static inline u32 pt_cap_get(enum pt_capabilities cap) { return 0; }
+static u32 pt_cap_decode(u32 *caps, enum pt_capabilities cap) { return 0; }
 #endif
 
 #endif /* _ASM_X86_INTEL_PT_H */
-- 
1.8.3.1
