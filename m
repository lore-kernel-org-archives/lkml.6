Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49inrXMeHu2XWuRGn6jYgfgtl8c9SQ4btbYXzBQxaRkTE6ASDpipMhv746Rq34twfZc2ntA
ARC-Seal: i=1; a=rsa-sha256; t=1523981324; cv=none;
        d=google.com; s=arc-20160816;
        b=ZKdE3n/FoKHDKp6zteQhvVOhNfZRI2S42nHxlGB0OYwAOV3Z9P03wjbXmynrjoezIu
         A2/VeLO6S2lXnHmlMb9T7Eu+37FvcjXN+Owf80diVydKLUoJ1MV32Zg1v3pDueWiXGti
         rzJVHZ9LITviRW+wKime+tdjaWs0HjyJQqkGhFcPOaoMnTjK9akk6Vx0h1mC/d8DtxW+
         yw3g3nw/SX1Jl3dm4jR3Q2DPijlH7wp2JcjF+2VfblRK8n7rXXcGXEX0x+J6bKSM5bL7
         57cLSUFt20706QNMmK+2bjm+U4BkuUUtyQ37h+9zS22okqKCEANjJJL6QPzbSE71OAMa
         6TIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E5rpdM/pdwRZpE3PuYCWU0KpyJtSAX9NuCnu7n10TTg=;
        b=GRWCqUaqIaAqryPkVUBXljNs4YewInvoajHj2oPGybSOWaoZsPiVOPq6Q0Voyf7Ild
         lztjTPgoYmONCaztq8emCm+/knILroODJ+xZKYz80SV4xW4azlj0QTE9EgtN6gw+28hk
         QxfN+XHl/7dKbzX4BZy302kfQ2VMFZjkBWaXy0PerrXKwFPBsNsG+jKZzgNOhFpfGSO5
         EbQup8X3szFKr403k57Syqv+h/NhzAWwNjeD8VmDOR9ngN09TNh4AcrlYbb4+PS31fnB
         IlraifeRBw9/xKhWG0ykesZ9c8uXnEhi51tXreUapgQU3lKhJPDvDPToSnOrcnVD2VMk
         iCtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.9 23/66] arm64: Factor out TTBR0_EL1 post-update workaround into a specific asm macro
Date: Tue, 17 Apr 2018 17:58:56 +0200
Message-Id: <20180417155646.856330651@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010241096704382?=
X-GMAIL-MSGID: =?utf-8?q?1598010241096704382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Catalin Marinas <catalin.marinas@arm.com>

commit f33bcf03e6079668da6bf4eec4a7dcf9289131d0 upstream.

This patch takes the errata workaround code out of cpu_do_switch_mm into
a dedicated post_ttbr0_update_workaround macro which will be reused in a
subsequent patch.

Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |   14 ++++++++++++++
 arch/arm64/mm/proc.S               |    6 +-----
 2 files changed, 15 insertions(+), 5 deletions(-)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -434,4 +434,18 @@ alternative_endif
 	.macro	pte_to_phys, phys, pte
 	and	\phys, \pte, #(((1 << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 	.endm
+
+/*
+ * Errata workaround post TTBR0_EL1 update.
+ */
+	.macro	post_ttbr0_update_workaround
+#ifdef CONFIG_CAVIUM_ERRATUM_27456
+alternative_if ARM64_WORKAROUND_CAVIUM_27456
+	ic	iallu
+	dsb	nsh
+	isb
+alternative_else_nop_endif
+#endif
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -139,11 +139,7 @@ ENTRY(cpu_do_switch_mm)
 	isb
 	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
-alternative_if ARM64_WORKAROUND_CAVIUM_27456
-	ic	iallu
-	dsb	nsh
-	isb
-alternative_else_nop_endif
+	post_ttbr0_update_workaround
 	ret
 ENDPROC(cpu_do_switch_mm)
 
