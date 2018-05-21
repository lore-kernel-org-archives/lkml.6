Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrcgjc8bXm+MwsByN1TumvqNAaGeFwCN4Kh+jaBRKaQ0GbKncPCiF2KzA8gACGOUSJ8NFdH
ARC-Seal: i=1; a=rsa-sha256; t=1526937755; cv=none;
        d=google.com; s=arc-20160816;
        b=ezk1lVKTL9T+KAoodhxrYFKfuArdM/SBqQTtkppoq7Wdp4GvzPstH6stuQ3dyVSU9K
         mGuWoao45EuYGknS2DxIq+Rk7u3cRhLZzLe2SdPrPGyVJG2uvQ72z10k3UykxkxvPIOB
         hOSzbkeb1Yf9t5BvKIoRIVbomCzpwU3YP0pRTnOvRBhNHWjfDN9wfhXudN+Gxnne96rJ
         +DEZUw2wGld3vSr4SsKjBQGC3Rnaow8yjvRuHH+Q3i/mRApj+JxSOISdA1sGmDG2BdNZ
         sEFYN0+5oIeEGyDPiEuLchWNc98reJQY1r95Fxnqtg+4kSHvhi+EAwdXuVDVSrFt/WBJ
         xOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=SQRW3y5exWiW4tpapJbw1CKQwJbsu29IWvtj0Xx5m9k=;
        b=NIhM9KTZZSIcAJZOrILHqW2CxQbctpzV5CgZK22Dcsprc020lOTFWeCn4S8MFeA1rw
         LjCxuvwkSJlJ37Hs7S7T98QwxpgUHuvY9hroTuvGOO2/6mHlK++PbqdbHce6b3r2peC7
         lILA0Dcae9sDbJYHv6y5YryDYr+0VKTaW4FskuT2eeHxOkEbRdDjg1xD1qLHS9jM+8wa
         eJPpSvsoLoZ0Lp3dHoR2BJSF2dJTItf6VpXt9mh3YyFGc9VM9Cdq6kRl8tO00S8tCTM0
         WSZieU9edMwnjVwSIoCvA2ArDDFS0QhgS3ok9x6CrzSqn+oCJdCJFpAzqYYuOn1vYdyG
         h7Cg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Vive7OSm;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Vive7OSm;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Zeppegno <pzeppegno@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C3=84m=C3=83=C2=A1=C3=85=E2=84=A2?= <rkrcmar@redhat.com>,
	Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 4.16 014/110] KVM: vmx: update sec exec controls for UMIP iff emulating UMIP
Date: Mon, 21 May 2018 23:11:11 +0200
Message-Id: <20180521210505.201252497@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110283477050202?=
X-GMAIL-MSGID: =?utf-8?q?1601110283477050202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 64f7a11586ab9262f00b8b6eceef6d8154921bd8 upstream.

Update SECONDARY_EXEC_DESC for UMIP emulation if and only UMIP
is actually being emulated.  Skipping the VMCS update eliminates
unnecessary VMREAD/VMWRITE when UMIP is supported in hardware,
and on platforms that don't have SECONDARY_VM_EXEC_CONTROL.  The
latter case resolves a bug where KVM would fill the kernel log
with warnings due to failed VMWRITEs on older platforms.

Fixes: 0367f205a3b7 ("KVM: vmx: add support for emulating UMIP")
Cc: stable@vger.kernel.org #4.16
Reported-by: Paolo Zeppegno <pzeppegno@gmail.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Radim KrÄmÃ¡Å™ <rkrcmar@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1314,6 +1314,12 @@ static inline bool cpu_has_vmx_vmfunc(vo
 		SECONDARY_EXEC_ENABLE_VMFUNC;
 }
 
+static bool vmx_umip_emulated(void)
+{
+	return vmcs_config.cpu_based_2nd_exec_ctrl &
+		SECONDARY_EXEC_DESC;
+}
+
 static inline bool report_flexpriority(void)
 {
 	return flexpriority_enabled;
@@ -4494,14 +4500,16 @@ static int vmx_set_cr4(struct kvm_vcpu *
 		(to_vmx(vcpu)->rmode.vm86_active ?
 		 KVM_RMODE_VM_CR4_ALWAYS_ON : KVM_PMODE_VM_CR4_ALWAYS_ON);
 
-	if ((cr4 & X86_CR4_UMIP) && !boot_cpu_has(X86_FEATURE_UMIP)) {
-		vmcs_set_bits(SECONDARY_VM_EXEC_CONTROL,
-			      SECONDARY_EXEC_DESC);
-		hw_cr4 &= ~X86_CR4_UMIP;
-	} else if (!is_guest_mode(vcpu) ||
-	           !nested_cpu_has2(get_vmcs12(vcpu), SECONDARY_EXEC_DESC))
-		vmcs_clear_bits(SECONDARY_VM_EXEC_CONTROL,
+	if (!boot_cpu_has(X86_FEATURE_UMIP) && vmx_umip_emulated()) {
+		if (cr4 & X86_CR4_UMIP) {
+			vmcs_set_bits(SECONDARY_VM_EXEC_CONTROL,
 				SECONDARY_EXEC_DESC);
+			hw_cr4 &= ~X86_CR4_UMIP;
+		} else if (!is_guest_mode(vcpu) ||
+			!nested_cpu_has2(get_vmcs12(vcpu), SECONDARY_EXEC_DESC))
+			vmcs_clear_bits(SECONDARY_VM_EXEC_CONTROL,
+					SECONDARY_EXEC_DESC);
+	}
 
 	if (cr4 & X86_CR4_VMXE) {
 		/*
@@ -9243,12 +9251,6 @@ static bool vmx_xsaves_supported(void)
 		SECONDARY_EXEC_XSAVES;
 }
 
-static bool vmx_umip_emulated(void)
-{
-	return vmcs_config.cpu_based_2nd_exec_ctrl &
-		SECONDARY_EXEC_DESC;
-}
-
 static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
 {
 	u32 exit_intr_info;
