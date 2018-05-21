Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpeQV5yGxAF/Zv9HFZSKGDe/r26W2unPAeEMqIaDCPzT7KSeNNol9foWmUFZb63SBBGja6X
ARC-Seal: i=1; a=rsa-sha256; t=1526937407; cv=none;
        d=google.com; s=arc-20160816;
        b=bLLlFVbNKRQatC/FrByUSvjr6XGIElrfzLNy/t4HRgbhOrBYWCpPlezbg9hzpkh0fs
         pBnoaN3uTrstuCCSa+brJ1SdP3vmjdtn/K37KSJvAeEVsW56fVf89DpxoOyh8ebRd5o8
         XHyGOH+2LfF7xcVoVLQ5lem67GDXY0ePNtWuLq19kk6KJBI1M7dUcHT6oiVZ7+GDv6Bx
         oytaVEAGrbcVMY4xrB9f+V/c2Cewg5j796kpg6effqC4JRz8xEj64ciqbT8mZA05qiYR
         rD1FXUdoqH9UgWYB9MX0kb40DuUf4qhWCPUNjCdCtu7vdH4Qfo8Jw/M7iWnJtz0KHOBp
         oX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=5weaQz6fUylRZXfWmMnx616YKv0sxcFtsoZRCO+Q1Ns=;
        b=EpT9fh0W4cojwccxLEC1Un94Oat8Z4DEZNGEB7WSkvR1lBOOnlJnsCwibblAIbGVHN
         aL1goDa/bR5J4PsyaOXYI9zwMbk3iZqPctd/ZbXVCMZYdLktLDRDnqgGGPXkKVoCgPq2
         bKanH3GTPoPY3EYgJ1oh688eeIWI/pE9gBwTDGRyajDStXZ+ZOHZXZ7dbDea9TrtDwrf
         oUFtg3dyHUy10zL+RIFy4snGWvbPTPqcQU3F1tYVo/CtKxjF9fpWTDkGUSm6uRK5y/CD
         D3//fgmKVCg6vM+vw1DKJM9nX/0HH/tLCzqej7OVYLuaHeEib26rU12iAk3GgZ2CLdxJ
         x/lQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VGwZs1Sz;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VGwZs1Sz;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 71/87] KVM: SVM: Move spec control call after restore of GS
Date: Mon, 21 May 2018 23:11:47 +0200
Message-Id: <20180521210426.247329442@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109918498873978?=
X-GMAIL-MSGID: =?utf-8?q?1601109918498873978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 15e6c22fd8e5a42c5ed6d487b7c9fe44c2517765 upstream

svm_vcpu_run() invokes x86_spec_ctrl_restore_host() after VMEXIT, but
before the host GS is restored. x86_spec_ctrl_restore_host() uses 'current'
to determine the host SSBD state of the thread. 'current' is GS based, but
host GS is not yet restored and the access causes a triple fault.

Move the call after the host GS restore.

Fixes: 885f82bfbc6f x86/process: Allow runtime control of Speculative Store Bypass
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5011,6 +5011,18 @@ static void svm_vcpu_run(struct kvm_vcpu
 #endif
 		);
 
+	/* Eliminate branch target predictions from guest mode */
+	vmexit_fill_RSB();
+
+#ifdef CONFIG_X86_64
+	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
+#else
+	loadsegment(fs, svm->host.fs);
+#ifndef CONFIG_X86_32_LAZY_GS
+	loadsegment(gs, svm->host.gs);
+#endif
+#endif
+
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
 	 * SPEC_CTRL MSR it may have left it on; save the value and
@@ -5031,18 +5043,6 @@ static void svm_vcpu_run(struct kvm_vcpu
 
 	x86_spec_ctrl_restore_host(svm->spec_ctrl);
 
-	/* Eliminate branch target predictions from guest mode */
-	vmexit_fill_RSB();
-
-#ifdef CONFIG_X86_64
-	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
-#else
-	loadsegment(fs, svm->host.fs);
-#ifndef CONFIG_X86_32_LAZY_GS
-	loadsegment(gs, svm->host.gs);
-#endif
-#endif
-
 	reload_tss(vcpu);
 
 	local_irq_disable();
