Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpkQHlCos0MkQOTGvt2C/PIA8QiypE76c0Mud+WgY88lyV9NfNXNT1l/PIUZkN5gkcK3UGM
ARC-Seal: i=1; a=rsa-sha256; t=1526937673; cv=none;
        d=google.com; s=arc-20160816;
        b=AGVKt8rUpEXiVhTNvNE5fbbznM71sGiR7h8T5rkmmLJMNg2vgzNfd5YdVWuaKuBjP5
         eGsk+i/ESu0xZERHqFA0e6Zt1m3RHBMf5TQbdXIh5cxFkgG1mIkQ24QIvM8wVt/89xrb
         3s5fp8jga8Snoc2WJ+9BPcfrI+77EFjoZ7kIeChv/FXLPb2WUXfVZsJvZMAbhw6LGhR3
         zQLaLlbbvmnxZTFc1U8MKhNLnuBcYTq0fEfysVTCmO0f6hE5RB4T3w2z86zwuisJfwg5
         q4KfyznqSLs+Rbcd9CCjYlyAp02MSmbTapQjYh+JK0++Y+eRZ3+n8iKo25wf68sRVzke
         rRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=RpNqB8htOLb9BU72Zf8W3G7J47rJdrkBvt5pcKXY9Ok=;
        b=Drsv9HXbgdvlvyJ/FmAQcrBuqnDjzbA1Zv2zUEgzAqa47AQwFwOq2qA8P0HzXZ+e+M
         wAPu+UG2uAsZw/rKPJ1rDSVZSdW/7paUoBBbMf53rNqw5sgTQVbA/5DaO0/UL0FAQq7o
         yUIxKFRqRzOFkwocG4vN9vv5VuSVk1NwOyYFX3yKR/OArIOLqOvO3zlWlxbov4SXMItC
         OLJ9Bky5E/Z1LQK58FkqOXf3i+a1inszJfWz9x6UhCNHU5sNYouf5GIZ/ojgcl21DuDb
         oeJUeCNtDn9C4LzP9QH7lXyyn+bHHuLoxJGnZWXWu9B/8TpbYE8FjT5Dn+bRTien4NIp
         WjTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=B18Gs3Rj;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=B18Gs3Rj;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 80/95] KVM: SVM: Move spec control call after restore of GS
Date: Mon, 21 May 2018 23:12:10 +0200
Message-Id: <20180521210502.137698771@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109918498873978?=
X-GMAIL-MSGID: =?utf-8?q?1601110197990867824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5109,6 +5109,18 @@ static void svm_vcpu_run(struct kvm_vcpu
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
@@ -5129,18 +5141,6 @@ static void svm_vcpu_run(struct kvm_vcpu
 
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
