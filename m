Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Hl3WOlHxavs+vgJF1JJzFJ5SWxLS5UnoUVdLuC5EpO5GZ3difNgnrtd5mB3pL3USbZaK/
ARC-Seal: i=1; a=rsa-sha256; t=1518709186; cv=none;
        d=google.com; s=arc-20160816;
        b=GgeQyZpoGrxKNije4tICo1FTYVYDNb2rHZtny2iPFFtMvDKHmQupeRWiWhsQOcvXlO
         nmIPoW3FfRCAwEV7IuNyCWUajLgdLegQ3ZWwsbXs3zY/SwgFy8Avp5QuZEWl/y6DpHwR
         sH7DQkFI9Too2FUwMcc1tIi1zYQYzpazDEgj4Z3D229mHCtiPlWVpJwiuLm9ZOrtqJI9
         0pkaX8cPsgtdTAMKVUa1XoCeBpPOGIUwbIKz05LMPWA/SXmDJUSyYUYd5zLq/DP59V9+
         fsQtphXQx1P1vdH7n0cPNXqZvAwJgMQ6ynQELdRllqlWR1oWbapk7Cw2fRVdBFWEncQu
         rKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=n/OtUdmAywOZ574eIQq3Aehza9bbgtLtI2gnGa7714k=;
        b=m4k9Ux6H6cMLGUu80VXSUYKsL/26w15f8INWKME65HKz7FUTGod29GcN70TMCtwWDO
         fZxcLEOUnRWBWW/L/fEqW4avygWmcORRkLugdcOdUKmNAJ8E5E2ELAqntOnMrHNY+Rs6
         S6+AxxL3qfS2gyv3BC9rjKxHiy1dsHkodNVzL6iSznth9WaL9Mdxv5epKz22jPWsPQ9H
         lYxLV2YIwmZc/ohGUnLD0KkjIdWFaviIY/HG5MwDFx5a6xQ+rpXPQg1LX8HDheZ5PMq/
         pWrPjU89aHJNR3fSFhrh9HVr8RqrZDnRRjMfcvkpci64Ye7y8DoRrkPztLVpxVbnu+Cd
         O4Kg==
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
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 027/202] [Variant 3/Meltdown] arm64: entry: Hook up entry trampoline to exception vectors
Date: Thu, 15 Feb 2018 16:15:27 +0100
Message-Id: <20180215151714.347148508@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481457484988866?=
X-GMAIL-MSGID: =?utf-8?q?1592482004326905522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -271,18 +287,20 @@ alternative_else_nop_endif
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
@@ -304,7 +322,22 @@ alternative_else_nop_endif
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
