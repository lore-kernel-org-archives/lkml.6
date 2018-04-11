Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx484/Lgw8gMCta8SnNncn9z0qsI5Z0OJrPS6A8MOnN2YjajpBFSHWxNcKcRJ068X1tzWDoJJ
ARC-Seal: i=1; a=rsa-sha256; t=1523473231; cv=none;
        d=google.com; s=arc-20160816;
        b=xVMNLzrfpq+6fclUv8UHt8yRIYKwFiQKvl4AjIEup2f0CS/VQAF+C+6bw9Y2DowUiB
         07b6TwpyZkWST4OhCIyUL0mj9HVESS0A7rqmhL8E914VyLVhWTbteVVVJ1CG7dZrAouK
         eT2Ao5spcVALmFiD4J6tnHfkHys0SdhtiJbpcMJQV6oF8bm3LjcXS+gacuPEzqMO9c2X
         bkBX53XgdUNaYuL11mrG66qkN9qHW4kkX77Pyx0f7axEe5nWuIdN/3Km1GfJlx+oim3v
         D0OEsGs8qjTE/TY1wXZw11otACGMKd6hyNx61W3nv/6hWmnk+vZ43A3/2qmQjJYnR3Vt
         j3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xq8b+0fG4tgpuiSCTjLmf7ugR0UMyNxtdC1faCnR7wg=;
        b=rDvEQHFoHuLAgo1iffODlDlGeVhQOYs5OGN0jhPuQYhZ9EPSls1DJ4lsTUm9EZ2p9y
         SUa3elPX0xxmj1qjYbywK5MiDPzCI6ukE9yC/zTza9YIT6K6UYsJ4W6zO1LEiZaOhHp7
         FiRUQwuSU0uOAdyNp6h+YGhL6jPswA6TS/RpjFB8n8vwK4TuUDL7VD+X204rD9/V0XYl
         uUBZeY6kA4VCg5MU/mZ+7LzfqCgK4AmmX1xAxu0tYNGdCcHXhfRhDpiZI7w0ULNYc9Yv
         vQxD/AWN2peScgAQ5K3WZNE48LT3otgGB2vJnDf4acyK4au4G+9c1EyDuPsOwyLvivka
         2PoQ==
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
Subject: [PATCH 4.9 171/310] KVM: SVM: do not zero out segment attributes if segment is unusable or not present
Date: Wed, 11 Apr 2018 20:35:10 +0200
Message-Id: <20180411183629.998050864@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476194137000503?=
X-GMAIL-MSGID: =?utf-8?q?1597477467448990156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1879,6 +1879,7 @@ static void svm_get_segment(struct kvm_v
 		 */
 		if (var->unusable)
 			var->db = 0;
+		/* This is symmetric with svm_set_segment() */
 		var->dpl = to_svm(vcpu)->vmcb->save.cpl;
 		break;
 	}
@@ -2024,18 +2025,14 @@ static void svm_set_segment(struct kvm_v
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
@@ -2044,7 +2041,8 @@ static void svm_set_segment(struct kvm_v
 	 * would entail passing the CPL to userspace and back.
 	 */
 	if (seg == VCPU_SREG_SS)
-		svm->vmcb->save.cpl = (s->attrib >> SVM_SELECTOR_DPL_SHIFT) & 3;
+		/* This is symmetric with svm_get_segment() */
+		svm->vmcb->save.cpl = (var->dpl & 3);
 
 	mark_dirty(svm->vmcb, VMCB_SEG);
 }
