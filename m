Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224zjmz2MUVKRdi5Zbo7PyIlYWkHO6nbrrxuWK13c9cHu7SJNIq5exnn5p6QYodc8HS1LVNB
ARC-Seal: i=1; a=rsa-sha256; t=1519411732; cv=none;
        d=google.com; s=arc-20160816;
        b=dGlRi/qZk5NwQnHtAn34sob/uiWHM6mHPZ1XDesIZ3qgCniRVe3i/Uvp/37S6gPiM3
         YbkFiBjSyrzfPuZ3RjHSum0EEORgzVP1NnMqeZ+YlrYVM9Y7SGggj0+hIeCX042N+pEz
         oS6lktCwXy11vHcJ9VhPHt94uRS7s+68W/GBZFqJv3US9jer4DiWWCFB3RMLwVEbIVXh
         m/HcynxHgjo35RsZj5CAWPBhy/4lequlV8BOFCTOKgZFewInEfvrvW+aDN/0X4c9C95N
         5XcmZUQkjz9zt4O3VSefb8x2LAh8FI7lOpFK7EI+Llnem3LmB6GX7mn634I1USEm9KGF
         /TzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1TctMHoO2CQzCxK52zCFvT7h5Ct6vw/Bqp0G9tgXhrI=;
        b=FYklf4VzVmV77SmxSOVb1Dq8//0rVQ4vCb/xDAftTsKvQWf2P3niMsJlCnmf1uHpPH
         FLOC+20hyIJ7jDWET/kebJ64D6JnlZSOOQSoytUUCAh5fcVNxmnFJzTcB/GpPQu7iS2g
         n7EUOFHTNjqgKCDfrzp8k0qbShHzyY9+IdFcMtK7HeNy58j2y++r+QwR8Ftfj8JD2ewr
         JJs9vPeY/bo6Km9CAPAeZnxuOOD9wmWnW2Iu7rUTENFsj32llYnMOAehD119mnSF48HM
         bO6i+ZrpWfs8iP66kfNz3n9/NtX4Id2NYS/gxB0CkrtX9reJBaXMu6ffTPhce3TIww30
         taZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Dakinevich <jan.dakinevich@gmail.com>,
	Ladi Prosek <lprosek@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.9 144/145] KVM: nVMX: invvpid handling improvements
Date: Fri, 23 Feb 2018 19:27:30 +0100
Message-Id: <20180223170743.322639977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218259279654464?=
X-GMAIL-MSGID: =?utf-8?q?1593218677008353111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Dakinevich <jan.dakinevich@gmail.com>

commit bcdde302b8268ef7dbc4ddbdaffb5b44eafe9a1e upstream

 - Expose all invalidation types to the L1

 - Reject invvpid instruction, if L1 passed zero vpid value to single
   context invalidations

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
Tested-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[jwang: port to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -142,6 +142,12 @@ module_param_named(preemption_timer, ena
 
 #define VMX_MISC_EMULATED_PREEMPTION_TIMER_RATE 5
 
+#define VMX_VPID_EXTENT_SUPPORTED_MASK		\
+	(VMX_VPID_EXTENT_INDIVIDUAL_ADDR_BIT |	\
+	VMX_VPID_EXTENT_SINGLE_CONTEXT_BIT |	\
+	VMX_VPID_EXTENT_GLOBAL_CONTEXT_BIT |	\
+	VMX_VPID_EXTENT_SINGLE_NON_GLOBAL_BIT)
+
 /*
  * These 2 parameters are used to config the controls for Pause-Loop Exiting:
  * ple_gap:    upper bound on the amount of time between two successive
@@ -2839,8 +2845,7 @@ static void nested_vmx_setup_ctls_msrs(s
 	 */
 	if (enable_vpid)
 		vmx->nested.nested_vmx_vpid_caps = VMX_VPID_INVVPID_BIT |
-				VMX_VPID_EXTENT_SINGLE_CONTEXT_BIT |
-				VMX_VPID_EXTENT_GLOBAL_CONTEXT_BIT;
+			VMX_VPID_EXTENT_SUPPORTED_MASK;
 	else
 		vmx->nested.nested_vmx_vpid_caps = 0;
 
@@ -7685,7 +7690,8 @@ static int handle_invvpid(struct kvm_vcp
 	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
 	type = kvm_register_readl(vcpu, (vmx_instruction_info >> 28) & 0xf);
 
-	types = (vmx->nested.nested_vmx_vpid_caps >> 8) & 0x7;
+	types = (vmx->nested.nested_vmx_vpid_caps &
+			VMX_VPID_EXTENT_SUPPORTED_MASK) >> 8;
 
 	if (type >= 32 || !(types & (1 << type))) {
 		nested_vmx_failValid(vcpu,
@@ -7707,21 +7713,27 @@ static int handle_invvpid(struct kvm_vcp
 	}
 
 	switch (type) {
+	case VMX_VPID_EXTENT_INDIVIDUAL_ADDR:
 	case VMX_VPID_EXTENT_SINGLE_CONTEXT:
-		/*
-		 * Old versions of KVM use the single-context version so we
-		 * have to support it; just treat it the same as all-context.
-		 */
+	case VMX_VPID_EXTENT_SINGLE_NON_GLOBAL:
+		if (!vpid) {
+			nested_vmx_failValid(vcpu,
+				VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
+			skip_emulated_instruction(vcpu);
+			return 1;
+		}
+		break;
 	case VMX_VPID_EXTENT_ALL_CONTEXT:
-		__vmx_flush_tlb(vcpu, to_vmx(vcpu)->nested.vpid02);
-		nested_vmx_succeed(vcpu);
 		break;
 	default:
-		/* Trap individual address invalidation invvpid calls */
-		BUG_ON(1);
-		break;
+		WARN_ON_ONCE(1);
+		skip_emulated_instruction(vcpu);
+		return 1;
 	}
 
+	__vmx_flush_tlb(vcpu, vmx->nested.vpid02);
+	nested_vmx_succeed(vcpu);
+
 	skip_emulated_instruction(vcpu);
 	return 1;
 }
