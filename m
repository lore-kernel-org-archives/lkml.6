Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227fekTx5Q/bnWqK9QKOdanPd+tQpVS88W379z9XVbtaR397+QiNq6/wmxpyH3yqeRs3yv2q
ARC-Seal: i=1; a=rsa-sha256; t=1518708665; cv=none;
        d=google.com; s=arc-20160816;
        b=KXt4MWtbbIY7NXdNNgH8Dms7PiytezcbXuNCRzEKfj5ekeE+p+LOklXAonE/gMk3Z2
         OE8pKN06M2Hhx8n5SFaicC3P2bW+vTPm6KHQ8EP9CMFf3WxtW7/EuJ/qRGl/96uv+kfl
         vQhnkPCoHojfUpxjpBBXzFpJXBeSafZw5kuB78KfWYd+fI2eRTMEfDReKPMTsjag6iJf
         tqsSucgnQDAWm0kTJKswK+cTgbGX4r2WBuFyBN1UZ9KnfD4pbfujWY44bF8q8Lx/jR6E
         ycCa3YtqR7ZCwvmpWhNLv1PR8hbmkCMs7N/ZmRT8LThsOkruQlcp1o7yHTlmP1XjoQ0/
         lYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jr0hRGrVxP5c6ZId/yGOgaWglGtGmfrkdVmZ7u6ntOA=;
        b=s6TSL6+skKaT0s9TShQtc+Utg4gPIn58WSAcMXmW6Ab8AcK3/aGYJ3voKp29hAdXg2
         720RCvBsm2+Cxh7iVEE1ALFI5TEwrdLJO4LFifKE/hoInLa5k4TWSp9XDnHSAfnvAs2Z
         bOu8zcd2hYUWBgfSaWj0emyeI9DPIZ2wboPt+u+lrOye55LOMyWf1IRhTq/zRqgKRm0S
         PZ755D0a0S63RArg4V/U7V88FZ+XnXZfxRHXUGi1esgz4/4gTKhhJjycWWbGFkjn2pSO
         RPVMdHbP2IVPWNkqfDKJZNArUXOx4FuGHAmweoTmZAuyM5+SgLnchzwLueC5KNYl94ec
         wnog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 035/195] [Variant 3/Meltdown] arm64: entry: Hook up entry trampoline to exception vectors
Date: Thu, 15 Feb 2018 16:15:26 +0100
Message-Id: <20180215151707.504392097@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481457484988866?=
X-GMAIL-MSGID: =?utf-8?q?1592481457484988866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 4bf3286d29f3 upstream.

Hook up the entry trampoline to our exception vectors so that all
exceptions from and returns to EL0 go via the trampoline, which swizzles
the vector base register accordingly. Transitioning to and from the
kernel clobbers x30, so we use tpidrro_el0 and far_el1 as scratch
registers for native tasks.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -73,6 +73,17 @@
 
 	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	.if	\el == 0
+	.if	\regsize == 64
+	mrs	x30, tpidrro_el0
+	msr	tpidrro_el0, xzr
+	.else
+	mov	x30, xzr
+	.endif
+	.endif
+#endif
+
 	sub	sp, sp, #S_FRAME_SIZE
 #ifdef CONFIG_VMAP_STACK
 	/*
@@ -119,6 +130,11 @@
 	b	el\()\el\()_\label
 	.endm
 
+	.macro tramp_alias, dst, sym
+	mov_q	\dst, TRAMP_VALIAS
+	add	\dst, \dst, #(\sym - .entry.tramp.text)
+	.endm
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
@@ -269,18 +285,20 @@ alternative_else_nop_endif
 	.if	\el == 0
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
+	tst	x22, #PSR_MODE32_BIT		// native task?
+	b.eq	3f
+
 #ifdef CONFIG_ARM64_ERRATUM_845719
 alternative_if ARM64_WORKAROUND_845719
-	tbz	x22, #4, 1f
 #ifdef CONFIG_PID_IN_CONTEXTIDR
 	mrs	x29, contextidr_el1
 	msr	contextidr_el1, x29
 #else
 	msr contextidr_el1, xzr
 #endif
-1:
 alternative_else_nop_endif
 #endif
+3:
 	.endif
 
 	msr	elr_el1, x21			// set up the return data
@@ -302,7 +320,22 @@ alternative_else_nop_endif
 	ldp	x28, x29, [sp, #16 * 14]
 	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #S_FRAME_SIZE		// restore sp
-	eret					// return to kernel
+
+#ifndef CONFIG_UNMAP_KERNEL_AT_EL0
+	eret
+#else
+	.if	\el == 0
+	bne	4f
+	msr	far_el1, x30
+	tramp_alias	x30, tramp_exit_native
+	br	x30
+4:
+	tramp_alias	x30, tramp_exit_compat
+	br	x30
+	.else
+	eret
+	.endif
+#endif
 	.endm
 
 	.macro	irq_stack_entry
