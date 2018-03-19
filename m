Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvRAUUpejlqVWBVIhCLtH2v63Qe2ieW/mHAdzMT9OpKHvumTcVqImWjaqRS3BKG17PxOu0P
ARC-Seal: i=1; a=rsa-sha256; t=1521483789; cv=none;
        d=google.com; s=arc-20160816;
        b=wmn/IiG++grkrJnX6iEYJJASxr63M6LexorvX5uGpGTevGXg7OSnk+LPlseUWXtDex
         JQGL3u3XMmokznjbY5FtH9RY6HoFPlPWIc3Ty52WYlKSRCBwUKzkYvO9fLaO4EVTRTLc
         4Da/CqINxulTK22c491E4XRAhRZ3GnvDuHw9it+7f0BaOy8XEDrd6vhTkrqOAxxnCnZo
         K0gkv/SHWbAtRfZbfFFDN1Fymb1430GRPFb6D66AQuhIM8K/yWIeWEgnV0dn2he4SJ42
         I7yTI85cSLMeYvMPiHVWTE9Bz4ewe1P0TXX6AE/CgwzGkRCl5tsrjazMeth3mk1TV27Z
         J5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4nnZnbRfRvqs1mKNWCUmsv9l2d3tlJ1QCf3IJiVGxHU=;
        b=aeCooCe4FJYRgmoLbS7PqU+okXYQ/q4qY82u9cQaF9HF4w5/GpowpVgEQFnrGmLpQi
         /xmTQipNK8ZbVbqMgtktrjSrytMesc95Ee0LPriSclRQTWLa7ubis2Bt1QrAPu2Zpy6t
         RAPcYyEckrW5VEifvqIq3//1ivwo0uc7rxbyYxZcm+m3X8p0KfTIR9zq+vOS+stbwqxZ
         92InVLbYTkKsGmXgyxjkhhG7jT/LiYoSmLZcsQOP2AbMagYKb0C5gB2p/fbxX5WpcaS2
         lCLfbKoLuh0O6keT7pWaY7mD26jnNpwe4UHb+MqtwtkPNURisSrsdWmgALnM8SqH4cWb
         CQbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Joerg Roedel <joro@8bytes.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 118/241] kvm/svm: Setup MCG_CAP on AMD properly
Date: Mon, 19 Mar 2018 19:06:23 +0100
Message-Id: <20180319180756.087087758@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391385524420391?=
X-GMAIL-MSGID: =?utf-8?q?1595391385524420391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>


[ Upstream commit 74f169090b6f36b867c9df0454366dd9af6f62d1 ]

MCG_CAP[63:9] bits are reserved on AMD. However, on an AMD guest, this
MSR returns 0x100010a. More specifically, bit 24 is set, which is simply
wrong. That bit is MCG_SER_P and is present only on Intel. Thus, clean
up the reserved bits in order not to confuse guests.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5449,6 +5449,12 @@ static inline void avic_post_state_resto
 	avic_handle_ldr_update(vcpu);
 }
 
+static void svm_setup_mce(struct kvm_vcpu *vcpu)
+{
+	/* [63:9] are reserved. */
+	vcpu->arch.mcg_cap &= 0x1ff;
+}
+
 static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = has_svm,
 	.disabled_by_bios = is_disabled,
@@ -5564,6 +5570,7 @@ static struct kvm_x86_ops svm_x86_ops __
 	.pmu_ops = &amd_pmu_ops,
 	.deliver_posted_interrupt = svm_deliver_avic_intr,
 	.update_pi_irte = svm_update_pi_irte,
+	.setup_mce = svm_setup_mce,
 };
 
 static int __init svm_init(void)
