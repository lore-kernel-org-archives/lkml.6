Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224h/XYdVKsa5YUhuP5I14ba4RYmAYRpCq2SRoJ5m9yA9BnVo9ds5TasxeLhPl2e2pRP5mTQ
ARC-Seal: i=1; a=rsa-sha256; t=1519411334; cv=none;
        d=google.com; s=arc-20160816;
        b=B78gY3fC4Otq1sZqE2MDwSZVf42HIu12S6FA7UObz4uw9lmJZWj143HpOqx9rCZyTw
         Lvi4NdjP6UEul+x+mjvF8ShutgA9/YLMVvOoxVma+9ok9guQcakjPsoiUwi3krrh9IU/
         TVSJn1Cc/hnfwSk7xIxW8uJGZwHTsWlz1pFcci8LBhgD3XBMzzX90sVgLEDLe9Ifr7Jv
         KeNJBuskClxaekIz9XsbC69+LTLVQlB5PZ/SMMR1J/Ds5DWlAcuh8C+nwx+MaIDCfrH7
         bZZqsHlafXJ8H2pPkNrDvZd4h6OjSN+AOuWx0UziISXL1uaEmbBsjbM5xBW/gSpMhrcD
         TY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yqDuDNM7pH09jrq1E8L78Eo1sPDw8Z834TxPhvi7Srw=;
        b=c2QR0gVx15Z1XYyzax87ogIHKpdTp3r+RXR4rbOCf7/5ddDTD2Iws6ofxQUlfDo7x2
         fTVO1tsn+CUFLXDvOvLZMQO3CearlyAw4de8sVecMRsK/BD+MOhp8rZYOvx9KyjA/35o
         cR8+XoAnzf5Ov53LGGMlzJmSjazqIiH0+XduoMrJxLmtHFlREn2QnYcnR170oPiPBTay
         dRIVksXQePiQgrMLcu5wCJPmC51jTFQRf2SDELZTya0uRdJUXkfp0AuvqCr/a2rUYktc
         YaBaQwQPe0ZIPzfxbX67vo1HvWZ9u4R32yxORvKZPl90wePPIE4iWJ1Zu3cyG9BBleTL
         YyWw==
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
Subject: [PATCH 4.4 192/193] KVM: nVMX: invvpid handling improvements
Date: Fri, 23 Feb 2018 19:27:05 +0100
Message-Id: <20180223170356.519362179@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218259279654464?=
X-GMAIL-MSGID: =?utf-8?q?1593218259279654464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -126,6 +126,12 @@ module_param_named(pml, enable_pml, bool
 
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
@@ -2657,8 +2663,7 @@ static void nested_vmx_setup_ctls_msrs(s
 	 */
 	if (enable_vpid)
 		vmx->nested.nested_vmx_vpid_caps = VMX_VPID_INVVPID_BIT |
-				VMX_VPID_EXTENT_SINGLE_CONTEXT_BIT |
-				VMX_VPID_EXTENT_GLOBAL_CONTEXT_BIT;
+			VMX_VPID_EXTENT_SUPPORTED_MASK;
 	else
 		vmx->nested.nested_vmx_vpid_caps = 0;
 
@@ -7418,7 +7423,8 @@ static int handle_invvpid(struct kvm_vcp
 	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
 	type = kvm_register_readl(vcpu, (vmx_instruction_info >> 28) & 0xf);
 
-	types = (vmx->nested.nested_vmx_vpid_caps >> 8) & 0x7;
+	types = (vmx->nested.nested_vmx_vpid_caps &
+			VMX_VPID_EXTENT_SUPPORTED_MASK) >> 8;
 
 	if (type >= 32 || !(types & (1 << type))) {
 		nested_vmx_failValid(vcpu,
@@ -7440,21 +7446,27 @@ static int handle_invvpid(struct kvm_vcp
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
