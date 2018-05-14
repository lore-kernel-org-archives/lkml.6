Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZpw5ihCKSo+eBxJAVuaT8Ms/XuimZw9RTaVv1jCoxULhzAKyYO6MlkNSYVKtr08eh+ysDdt
ARC-Seal: i=1; a=rsa-sha256; t=1526288629; cv=none;
        d=google.com; s=arc-20160816;
        b=ArASQCb/HWDsqyhdtsVswEgqJVCjPY8ws8wASaXqrh4V6b5zQ4XC3wFjBTmuUPLUib
         z7FjXpDl2JpCoSdSqMRyKQWeV3uDtGTvBu0M2bb37TTuO87JQfOICFyhHUYjrDvvJJHq
         thxH7mSPLxq9UnZ4aNC55dJ4Y1k67jxlhINSWq4uM75kuzP4DIhlBu02z+UgyXIOftMj
         c8ass4QWHv1sQniYgRg3bT68c+pifrWsCXkfomwsT00N/mjj4J+6+E/Lb/vGTP0ERZqs
         thk0tIdzoQu2pb2Ly2MZOY6Sv+CIPY2pAeHLuAM96QsbUDW9MGJE2wgAjJHffgZy4YU7
         eMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=R4+wRut1Xg8c8aS+O6cnIQI8PthC3Jsa62XRQAoLc20=;
        b=Jg4WbWzQBFyRcTXYiYamSb+SNxWXeA3D5b866M+qFnlD94kFUUSoKH6Efw/aod0V8E
         szZofKI9hi6lrzuimEVPCqBccUrieGObB8ZszINFWo/hQuuDX5weZMvCsrODslIVam/Z
         xqMkNLITiHP+BbZOgToHuUz0wWQzqPRDtZ1ectE61F+XrkeKdHdMBi27k5BRPlu9MFGg
         Ff1m2KV8FPjrjtY+M9fyzYHmPLPLU5Jt911536PyC1jC3XJUJpp2SpE70k/m/vcfrrDo
         BFQ1Aq8CblOSKl9xTMMzKw9seblq0tQxaG8BTOZltlM/S4iDZl+Ce3S/NZCs3MLgq8Gz
         Vb0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701991"
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
Subject: [PATCH v8 12/12] KVM: x86: Disable Intel Processor Trace when VMXON in L1 guest
Date: Mon, 14 May 2018 18:57:12 +0800
Message-Id: <1526295432-20640-13-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429625880390868?=
X-GMAIL-MSGID: =?utf-8?q?1600429625880390868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently, Intel Processor Trace do not support tracing in L1 guest
VMX operation(IA32_VMX_MISC[bit 14] is 0). As mentioned in SDM,
on these type of processors, execution of the VMXON instruction will
clears IA32_RTIT_CTL.TraceEn and any attempt to write IA32_RTIT_CTL
causes a general-protection exception (#GP).

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 170cd48..7ace11a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3996,7 +3996,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_RTIT_CTL:
 		if ((pt_mode != PT_MODE_HOST_GUEST) ||
-			vmx_rtit_ctl_check(vcpu, data))
+			vmx_rtit_ctl_check(vcpu, data) ||
+			vmx->nested.vmxon)
 			return 1;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
 		pt_set_intercept_for_msr(vmx, !(data & RTIT_CTL_TRACEEN));
@@ -8089,6 +8090,11 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	if (ret)
 		return ret;
 
+	if (pt_mode == PT_MODE_HOST_GUEST) {
+		vmx->pt_desc.guest.ctl = 0;
+		pt_set_intercept_for_msr(vmx, 1);
+	}
+
 	nested_vmx_succeed(vcpu);
 	return kvm_skip_emulated_instruction(vcpu);
 }
-- 
1.8.3.1
