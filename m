Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZqM6FCKvzCZsD5k+pLcvOOCPz6fbmiads+wT5RKuo4tgPRTbjNBv/6VN+Th5I3ZBLyTfkaG
ARC-Seal: i=1; a=rsa-sha256; t=1526288614; cv=none;
        d=google.com; s=arc-20160816;
        b=0e0czSN40BHgjc7kvPYlKFLhAIjU82vza2Sfpn66o3MTEdDeqNq9RljWVwqYXZGTqC
         Tc0AZSX3U47fVT184zVqeDIMa+g+NlqdYeak2uf1olL3hfdEF6WSXILp6x5Tli/yF5TB
         8FzquMr28CMieNXMD05B2NlEFI+AH0ZohLcbfbApDLcgG7yOxdLFmKtjAUxmMX5h8W0T
         pIhM+7hSXBEIvsNdb5wmEYz7Tio0UXsz1SdPRSW0FCJn5p14i16VB1XQLLIFRd3s1aDs
         sTeJwPoiHJ8G307OjMOwOWhv2g76P/ub/G4f3dFGQzxJESWPDDpGHItOaJHev9fruKGJ
         JEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ZlzZ2wILymj15rUB6M+Pk1tVxOWn1LvqA7tSlUIN7QU=;
        b=LyfcphKO5aUOuY4BmK7Q+vdo4069NsKfq4ncmlXuLSMWobhYi7Ma0si+dIkCBU8XKH
         KF8v2QIK0+sPCl63RcfXM2YbQ69Qjxg2ClCnSoRPJCVoYFgWzMMrkq2/B6vmpyllkfL0
         J8yandvSs5k7eMbCCnY9q3XTW1eThUFY4zac+GmgP5lW6y0seWWSVTCgLzzjBNf8Qt53
         D1wJkC8DDiO5ubyFndt4R0wG0bqzm6DZZOVRHwC7Xnazlo4pJ9Bm+M8FcYhzcX0kYA7R
         dc3Gz+O518c1iBfFkTJcgjHDXX59WYmL6rVA2Rq9G9y9zQvuQWL9Me6Sg0H5AM01QFKB
         i1og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701955"
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
Subject: [PATCH v8 09/12] KVM: x86: Introduce a function to initialize the PT configuration
Date: Mon, 14 May 2018 18:57:09 +0800
Message-Id: <1526295432-20640-10-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429610474677352?=
X-GMAIL-MSGID: =?utf-8?q?1600429610474677352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Initialize the Intel PT configuration when cpuid update.
Include cpuid inforamtion, rtit_ctl bit mask and the number of
address ranges.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index eb5f50a..5c321cd 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10413,6 +10413,71 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 #undef cr4_fixed1_update
 }
 
+static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct kvm_cpuid_entry2 *best = NULL;
+	int i;
+
+	for (i = 0; i < PT_CPUID_LEAVES; i++) {
+		best = kvm_find_cpuid_entry(vcpu, 0x14, i);
+		if (!best)
+			return;
+		vmx->pt_desc.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM] = best->eax;
+		vmx->pt_desc.caps[CPUID_EBX + i*PT_CPUID_REGS_NUM] = best->ebx;
+		vmx->pt_desc.caps[CPUID_ECX + i*PT_CPUID_REGS_NUM] = best->ecx;
+		vmx->pt_desc.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM] = best->edx;
+	}
+
+	/* Get the number of configurable Address Ranges for filtering */
+	vmx->pt_desc.addr_range = pt_cap_decode(vmx->pt_desc.caps,
+						PT_CAP_num_address_ranges);
+
+	/* Clear the no dependency bits */
+	vmx->pt_desc.ctl_bitmask = ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
+			RTIT_CTL_USR | RTIT_CTL_TSC_EN | RTIT_CTL_DISRETC);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[0]=1 CR3Filter can be set */
+	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_CR3EN;
+
+	/*
+	 * If CPUID.(EAX=14H,ECX=0):EBX[1]=1 CYCEn, CycThresh and
+	 * PSBFreq can be set
+	 */
+	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_psb_cyc))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_CYCLEACC |
+			RTIT_CTL_CYC_THRESH | RTIT_CTL_PSB_FREQ);
+
+	/*
+	 * If CPUID.(EAX=14H,ECX=0):EBX[3]=1 MTCEn BranchEn and
+	 * MTCFreq can be set
+	 */
+	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_mtc))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_MTC_EN |
+			RTIT_CTL_BRANCH_EN | RTIT_CTL_MTC_RANGE);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[4]=1 FUPonPTW and PTWEn can be set */
+	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_ptwrite))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_FUP_ON_PTW |
+						RTIT_CTL_PTW_EN);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[5]=1 PwrEvEn can be set */
+	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_power_event_trace))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_PWR_EVT_EN;
+
+	/* If CPUID.(EAX=14H,ECX=0):ECX[0]=1 ToPA can be set */
+	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_topa_output))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_TOPA;
+	/* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabircEn can be set */
+	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_output_subsys))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_FABRIC_EN;
+
+	/* unmask address range configure area */
+	for (i = 0; i < vmx->pt_desc.addr_range; i++)
+		vmx->pt_desc.ctl_bitmask &= ~(0xf << (32 + i * 4));
+}
+
 static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -10431,6 +10496,10 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 
 	if (nested_vmx_allowed(vcpu))
 		nested_vmx_cr_fixed1_bits_update(vcpu);
+
+	if (boot_cpu_has(X86_FEATURE_INTEL_PT) &&
+		guest_cpuid_has(vcpu, X86_FEATURE_INTEL_PT))
+		update_intel_pt_cfg(vcpu);
 }
 
 static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
-- 
1.8.3.1
