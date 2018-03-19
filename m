Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsLkUDvwf1vzQQXvqFzS5PH0iOr0KLmQMmlU4zea544memIah6M2eh53DhSQEOQWpok9aaM
ARC-Seal: i=1; a=rsa-sha256; t=1521484328; cv=none;
        d=google.com; s=arc-20160816;
        b=YfKygTVp7Thhbc0yn1Tl2d/YgLSgayFziaOUsXQSyEj0+PKHR8byn86uMR/7OwHA/a
         Dr/RyVHpoVqia8V8Qp3SjZdON2594jDCqU0ghFtH2b6xdd0Ymc8FWI2YGv9rUoH4EOja
         RtGMlgoZGN0TCgf+tFulF+Ko8dwTv37SyWV/KB7q3ueUBd5LTUOftYGWldiaQaUf6RVp
         Og1pKpi4ZDfSGZpjXK1lGMLek0XhmUyVgBRH/lwFtbvsKBy24Z9JR1IMJdMlz7vezvDL
         HTI1a8QYHSLTayM5WNmBjIL8oOT8IGYh4Okek6mdTVjWNwzGy1zhy0aSXqRmijez3mEo
         ckFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PRb2gUtC+7J6CmScFXcN1PrJq8Z5gwO+sldtw7tDm1Y=;
        b=vRBPrj1ZtcQaWPGbeuilLyF92H5g9u1fLEWHUOI5ovsKlOoJULrHQeY3TL9JeVi8sV
         0n0VuL6EC/d6CzkgJu350PyWKrEJjdQeGX4vm00SlNJCpw6O0GOT6Si0LXd6fUjkGE8R
         e8SsQDdR37U9OZgtpJL48Vj/E8miQGvfEolQ1zKVjbPyMPl1SNDnAVoxpmA8apjmc5ma
         C1dGfS0cYHt4YOdyoTEaNQdnlJTc6N38jY9a475mKnSCxq1fTwwDKJIL6jBP1mELVPIm
         JT50OUVfQsERsSHcoYOeIZg6Fd7/OkMmQiBRhRGbL7Ks9AGQFDkW2D7yrxhuV86o/05F
         OETw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.15 08/52] KVM: x86: Fix device passthrough when SME is active
Date: Mon, 19 Mar 2018 19:08:06 +0100
Message-Id: <20180319180735.523818156@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391767318739773?=
X-GMAIL-MSGID: =?utf-8?q?1595391951449141268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit daaf216c06fba4ee4dc3f62715667da929d68774 upstream.

When using device passthrough with SME active, the MMIO range that is
mapped for the device should not be mapped encrypted.  Add a check in
set_spte() to insure that a page is not mapped encrypted if that page
is a device MMIO page as indicated by kvm_is_mmio_pfn().

Cc: <stable@vger.kernel.org> # 4.14.x-
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2758,8 +2758,10 @@ static int set_spte(struct kvm_vcpu *vcp
 	else
 		pte_access &= ~ACC_WRITE_MASK;
 
+	if (!kvm_is_mmio_pfn(pfn))
+		spte |= shadow_me_mask;
+
 	spte |= (u64)pfn << PAGE_SHIFT;
-	spte |= shadow_me_mask;
 
 	if (pte_access & ACC_WRITE_MASK) {
 
