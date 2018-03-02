Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtfDiloDtT0EQu7T9NnGLLGecOvnyt9LKLf3NEdyNkZ0i+EVqpOpsZuQdlzhfRBENb3fe6l
ARC-Seal: i=1; a=rsa-sha256; t=1519981143; cv=none;
        d=google.com; s=arc-20160816;
        b=yqkffAduEVoYwyTnktruAJDvtgyJRDWa6kqQFkCbduPlQ7wzEBZXnjEWYv6IS0LB3+
         sisqB5+eKLipsJ2peeuhw4ljhm0IaUBurBlyJ9ITq2g+h5VhMxRNnKSzqvBfczVjJJjx
         VL4wIWynQRXXFWwhI/w605dgmLqRts5ER7btS8diL9SviAs5JxJRHIPtABOJCR31V8Nq
         IF1jMyWPq8kK8aTS8BJfwsTbYeS6LkZg/edfb6ecdQmZUZFNdVmKHvf8OPFWh0iuccAe
         uDvwLLMfDaOja37ZFmILmct1w4S7ujLfiJS8PZub2Ci9weq0CLFMkLyBjXLl1OlemZcn
         GZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tdgllXIeXDu8DrI38pj+xLo0FQIZk5Us4HYLmEfH6cE=;
        b=KFQd0JGsZdz6PIpV1ehVpOJDcZfPUoEUreWvPDgH1ZITyxfhVNaj8yLAaqIN+vzcQH
         TT/aak2L0gFse8OcSxtMcaSGvnvGuCL+VG8ilz8yIAyEaiIQiFwcS8yNkB01ZjmA4sNW
         T3jmkSL+Zyo+yANnGH9Wpyf3INr1YyhK8ZhmmPVv1sCrcs1npsL7Zr2qxsYu1hzlEh2V
         P/ZpJ5gKXX17f4KSN4gOJ8diIODPpVihJi2Rhcmo9cnUhBbqj6Tw60x6bTrp0idTZJb4
         SMEnfIqRaokFbhmYSBYbAzXZY22aLe/HK94dF01Yg7yZ8lkZLERLszfaazs4Ewj4XQKX
         MGPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 4.9 55/56] KVM: arm/arm64: Fix check for hugepage size when allocating at Stage 2
Date: Fri,  2 Mar 2018 09:51:41 +0100
Message-Id: <20180302084452.305135827@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815747293852483?=
X-GMAIL-MSGID: =?utf-8?q?1593815747293852483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Punit Agrawal <punit.agrawal@arm.com>

Commit 45ee9d5e97a4 ("KVM: arm/arm64: Check pagesize when allocating a
hugepage at Stage 2") lost the check for PMD_SIZE during the backport
to 4.9.

Fix this by correcting the condition to detect hugepages during stage
2 allocation.

Fixes: 45ee9d5e97a4 ("KVM: arm/arm64: Check pagesize when allocating a hugepage at Stage 2")
Reported-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kvm/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1284,7 +1284,7 @@ static int user_mem_abort(struct kvm_vcp
 		return -EFAULT;
 	}
 
-	if (vma_kernel_pagesize(vma) && !logging_active) {
+	if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
