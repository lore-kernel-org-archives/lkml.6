Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Trfvc+Du2hyxMC4eIFAqJmY1P2LcAc/0j2XFvL69Q9FaBC+MaIEzkOaNcsb/viWsbg6TY
ARC-Seal: i=1; a=rsa-sha256; t=1523472590; cv=none;
        d=google.com; s=arc-20160816;
        b=n1qsT3a+xOz6EFaUPzl39iw8uoUB2HzYk3fGzhGOl0KuHxWc0G1RmfrN3VEHxvmwd4
         E0fJyAAXXCudf2noMbt9awBIK74pCXpnkyQANvVPC7IvIwbiHGzeBR6gDOWhRYAVAnm1
         l2etf8hZ+rpmXrHAnqreg3o2xOc1mRoi4cutjhWiSF8cR4wrf9C/TeEZL8YUUWXPpZBl
         i2tmSpIyClPn6sn9SO8Id6CmmwPr+wnpXBcOzTKJcjQme9JD4FiUKV25pp+owDC/Huws
         2FrGD45vDz9z42m59H5i/J8tNVF54hBUbj0AQx1iN8QM24hp0U7aPhD1U5xs1xHtUcA6
         yxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lTMUg53GxsOijY517cuQznKXXMzbEMGw7xEpLgUSS9c=;
        b=kdEXrWeabePa5oOva5RfxBTLpbv9ZAk5lpwngDpkDRN6r6v16EWBeMOr5JoeORcOd6
         UZJHzCGEW6qmb3J9T+O5quFMhMHGaXmC/2Cy/ssXJ2GIwp+LM895NC3oZcaJccYmA3Rj
         YOGrYmduUgH3YCG1kGwXD6bccUja3S3OjLURw8MwpfiUF7llElv1w0HqJ7jfe66jMhtj
         /zuBABTvpNIhcKtIx+hAWC9vtuvTEPmnRlbKr4JNQc8JDnyut+xzWkLPAJc77jCrU8Gx
         KmHmpQfdDMTI30bmYtiHCihHEOM0HIAYAP0uuNPjpK+S2TyiZKKuPTmw2WPn4+YsN5fE
         jvlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roman Pen <roman.penyaev@profitbricks.com>,
	Mikhail Sennikovskii <mikhail.sennikovskii@profitbricks.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C3=84m=C3=83=C2=A1=C3=85=E2=84=A2?= <rkrcmar@redhat.com>,
	kvm@vger.kernel.org,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 106/190] KVM: SVM: do not zero out segment attributes if segment is unusable or not present
Date: Wed, 11 Apr 2018 20:35:52 +0200
Message-Id: <20180411183556.840005904@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476194137000503?=
X-GMAIL-MSGID: =?utf-8?q?1597476795822268236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Pen <roman.penyaev@profitbricks.com>


[ Upstream commit d9c1b5431d5f0e07575db785a022bce91051ac1d ]

This is a fix for the problem [1], where VMCB.CPL was set to 0 and interrupt
was taken on userspace stack.  The root cause lies in the specific AMD CPU
behaviour which manifests itself as unusable segment attributes on SYSRET.
The corresponding work around for the kernel is the following:

61f01dd941ba ("x86_64, asm: Work around AMD SYSRET SS descriptor attribute issue")

In other turn virtualization side treated unusable segment incorrectly and
restored CPL from SS attributes, which were zeroed out few lines above.

In current patch it is assured only that P bit is cleared in VMCB.save state
and segment attributes are not zeroed out if segment is not presented or is
unusable, therefore CPL can be safely restored from DPL field.

This is only one part of the fix, since QEMU side should be fixed accordingly
not to zero out attributes on its side.  Corresponding patch will follow.

[1] Message id: CAJrWOzD6Xq==b-zYCDdFLgSRMPM-NkNuTSDFEtX=7MreT45i7Q@mail.gmail.com

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Signed-off-by: Mikhail Sennikovskii <mikhail.sennikovskii@profitbricks.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim KrÄmÃ¡Å™ <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1386,6 +1386,7 @@ static void svm_get_segment(struct kvm_v
 		 */
 		if (var->unusable)
 			var->db = 0;
+		/* This is symmetric with svm_set_segment() */
 		var->dpl = to_svm(vcpu)->vmcb->save.cpl;
 		break;
 	}
@@ -1531,18 +1532,14 @@ static void svm_set_segment(struct kvm_v
 	s->base = var->base;
 	s->limit = var->limit;
 	s->selector = var->selector;
-	if (var->unusable)
-		s->attrib = 0;
-	else {
-		s->attrib = (var->type & SVM_SELECTOR_TYPE_MASK);
-		s->attrib |= (var->s & 1) << SVM_SELECTOR_S_SHIFT;
-		s->attrib |= (var->dpl & 3) << SVM_SELECTOR_DPL_SHIFT;
-		s->attrib |= (var->present & 1) << SVM_SELECTOR_P_SHIFT;
-		s->attrib |= (var->avl & 1) << SVM_SELECTOR_AVL_SHIFT;
-		s->attrib |= (var->l & 1) << SVM_SELECTOR_L_SHIFT;
-		s->attrib |= (var->db & 1) << SVM_SELECTOR_DB_SHIFT;
-		s->attrib |= (var->g & 1) << SVM_SELECTOR_G_SHIFT;
-	}
+	s->attrib = (var->type & SVM_SELECTOR_TYPE_MASK);
+	s->attrib |= (var->s & 1) << SVM_SELECTOR_S_SHIFT;
+	s->attrib |= (var->dpl & 3) << SVM_SELECTOR_DPL_SHIFT;
+	s->attrib |= ((var->present & 1) && !var->unusable) << SVM_SELECTOR_P_SHIFT;
+	s->attrib |= (var->avl & 1) << SVM_SELECTOR_AVL_SHIFT;
+	s->attrib |= (var->l & 1) << SVM_SELECTOR_L_SHIFT;
+	s->attrib |= (var->db & 1) << SVM_SELECTOR_DB_SHIFT;
+	s->attrib |= (var->g & 1) << SVM_SELECTOR_G_SHIFT;
 
 	/*
 	 * This is always accurate, except if SYSRET returned to a segment
@@ -1551,7 +1548,8 @@ static void svm_set_segment(struct kvm_v
 	 * would entail passing the CPL to userspace and back.
 	 */
 	if (seg == VCPU_SREG_SS)
-		svm->vmcb->save.cpl = (s->attrib >> SVM_SELECTOR_DPL_SHIFT) & 3;
+		/* This is symmetric with svm_get_segment() */
+		svm->vmcb->save.cpl = (var->dpl & 3);
 
 	mark_dirty(svm->vmcb, VMCB_SEG);
 }
