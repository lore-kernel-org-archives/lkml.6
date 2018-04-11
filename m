Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+F6dSu9qGbX5orvZoi6tPVVvmF5NOY+UnNLgNxDQIXePd1GWY7GtXgP0WHWhrKv7sCnVfi
ARC-Seal: i=1; a=rsa-sha256; t=1523472017; cv=none;
        d=google.com; s=arc-20160816;
        b=L314vXPOpO69QEjU1UEoV4h3Twt0SmRxJyt8F1ETdqWa/2htUWufK+Mte18BPB5hp7
         JGXlWKloeWv92f2zNcCs5EjjVUZE7xUUZk2cYc72wYi7GOo+kRA51rVUfiCrMmZ4DTP2
         NfGrP7WrwF/Qt7B8kxVt0SD4rzOwyebaiAgVHLT5ewIgqWU2t9K2/soG9w8QYxNgj2Iu
         VJ7b5kQbUgoUTapHLDM2Yo5h5e4+m32BAhtBDpzzw1A71OCo/k9TRtUPXg1/U2+GRcIO
         O3LlLfBiJ8Fx+TvARgIqQHsK1Gi6cLgxoO6ESqZXeVgLWhjS0Qo8ic4NV9Oa169qroIe
         eEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=os1DF92V6w96pos2SYvWd16lxwa0goGY9morEeksX48=;
        b=1HKSdLoPOgmY5pN6qkaY68tuvsp8eXsIK/KJZJ74legwsQR596bGSlL/9ecZrJ3qMl
         zDFf4z4ka20pMm44BrHZJwphDTF82U4StXU6b+gUrKc94R0XUPtMfZpA2zzZK+5XlH2H
         DlbEL69jOVzuetc9bSd7HO0sxD9I2+OLOS//pMC6oQnca0qdyv9IghIlP3d1HlaakVI4
         j+iVTBjJ+yzA30hFCO3jeQyXjki/LNQiP3xfPjNVQvwi/ugmBoPc5Fbs22axrnciEApp
         cIFl3tkfoa/CbRIAuA/ALOAK8okrEDTz7Yk6DxexLHcIhVCtbWoxtEAd8bPN5YnvS3I1
         au8A==
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
Subject: [PATCH 3.18 059/121] KVM: SVM: do not zero out segment attributes if segment is unusable or not present
Date: Wed, 11 Apr 2018 20:36:02 +0200
Message-Id: <20180411183459.864433517@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476194137000503?=
X-GMAIL-MSGID: =?utf-8?q?1597476194137000503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1467,6 +1467,7 @@ static void svm_get_segment(struct kvm_v
 		 */
 		if (var->unusable)
 			var->db = 0;
+		/* This is symmetric with svm_set_segment() */
 		var->dpl = to_svm(vcpu)->vmcb->save.cpl;
 		break;
 	}
@@ -1611,18 +1612,14 @@ static void svm_set_segment(struct kvm_v
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
@@ -1631,7 +1628,8 @@ static void svm_set_segment(struct kvm_v
 	 * would entail passing the CPL to userspace and back.
 	 */
 	if (seg == VCPU_SREG_SS)
-		svm->vmcb->save.cpl = (s->attrib >> SVM_SELECTOR_DPL_SHIFT) & 3;
+		/* This is symmetric with svm_get_segment() */
+		svm->vmcb->save.cpl = (var->dpl & 3);
 
 	mark_dirty(svm->vmcb, VMCB_SEG);
 }
