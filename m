Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224OXpq5QOrJu99T82i76y5o5cy6W9tB1YQWumCLMgZCJgF/R7S/iR5r5IeQTEcwdWjcc/gM
ARC-Seal: i=1; a=rsa-sha256; t=1518708763; cv=none;
        d=google.com; s=arc-20160816;
        b=ZhM5y5ZTw6nBiDKYBav7Iz7dgSFjYTWvQrikwlSV0zTciw5S0lgoYtugGKGYoNTSw+
         kEtXtxXo2YR2vU36VSrZMRkocDVxJ/67J7pTuZEAMyK6E8Sqg/sShqJJaflEegJwPUrR
         t8kaaJ9eb7bIu2BQv4xGuyGSfbe6WhFDXqTe7SuqqcNlO2rBrBdXSnRzHRzA4wYWpKcN
         saGpX/UB/cYwkvAw3KBPyb8Xy02jXlu95L9xwEyZreFXY5NH0tqqS9pI3CRRge1JqAgd
         KM/9WGgyJplOjR5gJ68cTiyR8juCMXsw3ZtZbpt3225vvc5IcCpEjgZDw8GxwMMWNK3w
         dF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JglXPR99GwD/CtNGRA8KQMnh5M5iLF5IrrjKTJAY6+s=;
        b=akmHrlK4BMTgnKMFpDdKKNvTm6B0atUknnonA2K22pRZtnE8fUg2im+0klc8nrB2pk
         sfC3bOYTDSru3QYUVWKZFDO3UT0VX5MP00Xl65FDmSRG8IJ790mSDogwyOOrSzNJtXM5
         LFN0zgxPgngsPERol49rg6+KJT8i0lT3F78576Y0GV4aghJ1gaTanx9v6spCovAQBuuH
         7I+h845z3+BAiVfBWKXf8l7KnYP41Fd7Su3G50eMvYXxlTYeUl85FGXxJ+sM5Jd94UlU
         +4Jt4eGJ/RQJY7VXVzdYCqZWfkfsnqz0PkWzwZWktb+cvysGLUgXzEiI2HSDOA+EsABC
         19eg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 071/195] [Variant 2/Spectre-v2] arm64: Move BP hardening to check_and_switch_context
Date: Thu, 15 Feb 2018 16:16:02 +0100
Message-Id: <20180215151709.252824917@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481559754840687?=
X-GMAIL-MSGID: =?utf-8?q?1592481559754840687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit a8e4c0a919ae upstream.

We call arm64_apply_bp_hardening() from post_ttbr_update_workaround,
which has the unexpected consequence of being triggered on every
exception return to userspace when ARM64_SW_TTBR0_PAN is selected,
even if no context switch actually occured.

This is a bit suboptimal, and it would be more logical to only
invalidate the branch predictor when we actually switch to
a different mm.

In order to solve this, move the call to arm64_apply_bp_hardening()
into check_and_switch_context(), where we're guaranteed to pick
a different mm context.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/context.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -227,6 +227,9 @@ void check_and_switch_context(struct mm_
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
 switch_mm_fastpath:
+
+	arm64_apply_bp_hardening();
+
 	/*
 	 * Defer TTBR0_EL1 setting for user threads to uaccess_enable() when
 	 * emulating PAN.
@@ -242,8 +245,6 @@ asmlinkage void post_ttbr_update_workaro
 			"ic iallu; dsb nsh; isb",
 			ARM64_WORKAROUND_CAVIUM_27456,
 			CONFIG_CAVIUM_ERRATUM_27456));
-
-	arm64_apply_bp_hardening();
 }
 
 static int asids_init(void)
