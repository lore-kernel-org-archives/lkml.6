Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZpcALYV3ez/c0+6/v8nn60IQNQ+bI2Ousf3jJaIHDlJusei1fbjJu297+k+CS1t0b2AupPx
ARC-Seal: i=1; a=rsa-sha256; t=1526288624; cv=none;
        d=google.com; s=arc-20160816;
        b=n0aKYkTvQS2YA2lIWogPF8sXjyO/7XhYnQV2woMtytqYWTu1hsGApDn76yvHZ6EqE3
         jiYaqPdROvuxX+RpsB3SzI3LAx6i+C0rJqBd9JoVskR9GnXBpbO1EgdmZAgVohmAni9n
         qZGOQHaBK3iUcMYCX0l43MQN1iGzts4MOvoh6vrqoQFqYMJhkYYOW55X3bUGKHVQfb+4
         pGG8WWmA6KYbE5tpKb9k622C6tbQhnWSBILYQOQnUbQs7931eHptDOlkpS9fcKoovPI2
         gWDw28pdeK3JNcr1Hxms+81BqUEMly3Cp+k2kh5+LemyVqzDWxdNQyJfeHz8D/f6qmww
         xaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=oRLnxTEOfsqScAP04o2s1OgepAZMo3cuwRMZ1Ox5taI=;
        b=jnHmbnSpFMThL6aJN1BGIDRCzBaIc/+oEWZaY20wOHmlKLE/vhMcK7bHOjwzZFc+Zc
         tJzjECT3RXnfF02anmp4UBEBtZ/prGluKy51rfldVuHdwZv13aFBNAbLmbEBmlA9bJvn
         RUlBgEeEQxvurVgRbqtYWgr+P4C7IxUmD/IhtgFqZH5XZIRrQUv9TrKrFM8Xiqr2H0gE
         QfyLzwVY3j5sN1H4jCJAFYIhfib0T6cbp04tgvlcmAlfsawEwxoRpEQVuzWhrIdaBbvW
         3iyARYKu2rfpomh2t+6V225fRGNWvelfAuCgWK1jSNEzLfOTuiCjlZCSDYtLGR8XCtMY
         rCRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701980"
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
Subject: [PATCH v8 11/12] KVM: x86: Set intercept for Intel PT MSRs read/write
Date: Mon, 14 May 2018 18:57:11 +0800
Message-Id: <1526295432-20640-12-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429621378647463?=
X-GMAIL-MSGID: =?utf-8?q?1600429621378647463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chao Peng <chao.p.peng@linux.intel.com>

Disable intercept Intel PT MSRs only when Intel PT is
enabled in guest. But MSR_IA32_RTIT_CTL will alway be
intercept.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d04b235..170cd48 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -947,6 +947,7 @@ static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
+static void pt_set_intercept_for_msr(struct vcpu_vmx *vmx, bool flag);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -3998,6 +3999,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vmx_rtit_ctl_check(vcpu, data))
 			return 1;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
+		pt_set_intercept_for_msr(vmx, !(data & RTIT_CTL_TRACEEN));
 		vmx->pt_desc.guest.ctl = data;
 		break;
 	case MSR_IA32_RTIT_STATUS:
@@ -5819,6 +5821,27 @@ static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
 	vmx->msr_bitmap_mode = mode;
 }
 
+static void pt_set_intercept_for_msr(struct vcpu_vmx *vmx, bool flag)
+{
+	unsigned long *msr_bitmap = vmx->vmcs01.msr_bitmap;
+	u32 i;
+
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_STATUS,
+							MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_OUTPUT_BASE,
+							MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_OUTPUT_MASK,
+							MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_CR3_MATCH,
+							MSR_TYPE_RW, flag);
+	for (i = 0; i < vmx->pt_desc.addr_range; i++) {
+		vmx_set_intercept_for_msr(msr_bitmap,
+			MSR_IA32_RTIT_ADDR0_A + i * 2, MSR_TYPE_RW, flag);
+		vmx_set_intercept_for_msr(msr_bitmap,
+			MSR_IA32_RTIT_ADDR0_B + i * 2, MSR_TYPE_RW, flag);
+	}
+}
+
 static bool vmx_get_enable_apicv(struct kvm_vcpu *vcpu)
 {
 	return enable_apicv;
-- 
1.8.3.1
