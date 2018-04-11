Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/nZGWBrnG+0+ufnVz7/SQnyM9wnVZJBHf43kcBOtTq1SVsHdyap9yS+rmbf9O9ga+YrMHP
ARC-Seal: i=1; a=rsa-sha256; t=1523473061; cv=none;
        d=google.com; s=arc-20160816;
        b=w5nhuMRCwgmki0jVBrwS35V0IL1Cw5b3HZuBSxuz3DKN06tzfmzyntOcr0kNDebqa8
         uvY4HJvOUXmyjak/smEi+phE+N8fKyP305kdImE7daaOcwmLrCiIXoXtBDtZviDt2OH1
         V3o3HM5+ms4xnfoxM64BtXegGJgnMMSC+YK1u9GXq4gxp/oT+JTAumy30MUEaftxWVLT
         HprBpoj0/ihLX7VIsJ9L5film90nEZdT7DN8UhNCt5ehv6hb1dgKEbT0Fma0lFCTMpBY
         pjsF/762fJTaThf2u5/QAsk4K09fa8r5P4TZ49Z9VlPukAT+qcjHhRDjlHOd5+2rvLX3
         6awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qtQwRWuGLh4bSeFuam4jqa+ycqC6imRCbxaOl46JdAo=;
        b=cTsDJHb7b0jjflPS6XY9xgmylGYr5JYfMi1poYxk8nQJIvmiPyY+JYXsBgNJukqd1N
         AeQgQRI1ajkOCeSBm7rTIXR1/ZB2W8VqeG7xackrc/ex4jzZo9Z0MMdIGkjr18lyYfUh
         3Q2w1tmKlgaHUBSx14RDKGrOD9b/ZfvSv96+u1IjXWHVRmECjPioG8249AQap5RW0SlM
         suSOaZW1qUtxgIElQLOZzVTrfW0KADX8lNI7lmro3ZcNgyociszvQKV9ROvTAIUVobLW
         lksJawdsRgWvCKXZB5AJKcH+drNEnAQi5c2VCsjY7bmOsNGq3ByaPM5WPPy3MJqU0yA/
         /Guw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Jan=20H . =20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 116/310] KVM: nVMX: Fix handling of lmsw instruction
Date: Wed, 11 Apr 2018 20:34:15 +0200
Message-Id: <20180411183627.165459858@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476294885821216?=
X-GMAIL-MSGID: =?utf-8?q?1597477288731669447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Jan H. Schönherr" <jschoenh@amazon.de>


[ Upstream commit e1d39b17e044e8ae819827810d87d809ba5f58c0 ]

The decision whether or not to exit from L2 to L1 on an lmsw instruction is
based on bogus values: instead of using the information encoded within the
exit qualification, it uses the data also used for the mov-to-cr
instruction, which boils down to using whatever is in %eax at that point.

Use the correct values instead.

Without this fix, an L1 may not get notified when a 32-bit Linux L2
switches its secondary CPUs to protected mode; the L1 is only notified on
the next modification of CR0. This short time window poses a problem, when
there is some other reason to exit to L1 in between. Then, L2 will be
resumed in real mode and chaos ensues.

Signed-off-by: Jan H. SchÃ¶nherr <jschoenh@amazon.de>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7924,11 +7924,13 @@ static bool nested_vmx_exit_handled_cr(s
 {
 	unsigned long exit_qualification = vmcs_readl(EXIT_QUALIFICATION);
 	int cr = exit_qualification & 15;
-	int reg = (exit_qualification >> 8) & 15;
-	unsigned long val = kvm_register_readl(vcpu, reg);
+	int reg;
+	unsigned long val;
 
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
+		reg = (exit_qualification >> 8) & 15;
+		val = kvm_register_readl(vcpu, reg);
 		switch (cr) {
 		case 0:
 			if (vmcs12->cr0_guest_host_mask &
@@ -7983,6 +7985,7 @@ static bool nested_vmx_exit_handled_cr(s
 		 * lmsw can change bits 1..3 of cr0, and only set bit 0 of
 		 * cr0. Other attempted changes are ignored, with no exit.
 		 */
+		val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
 		if (vmcs12->cr0_guest_host_mask & 0xe &
 		    (val ^ vmcs12->cr0_read_shadow))
 			return true;
