Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+DkkXU5tyMws73M73/2SUNvm3upI+xD0w/Bz7ZnkUwPkCFZAxnUWTo17fPsyynyPgQe4L1
ARC-Seal: i=1; a=rsa-sha256; t=1523021707; cv=none;
        d=google.com; s=arc-20160816;
        b=ddOSt4kEclwceblDqUXHhvHGTEWRA1TZEjyFtyiEsmgdZiVAULrc+N/jkZCpZxY46d
         QZM6ndHI08DlbqfFnPskSdG/gEeR2G3xbT+tRtVivYrFHq4O8hTZNTqNBcE6Xwx/WvNH
         uHntDS9ptFNfbC79LLgMBuAol2tclxWPye1Oz4orx3GcwC4G5duZNJjLiaGQ0MHk6Rhw
         fv2b4jr3scVcJMwwwbyHVuRS/9Ei9yCS7hRruoCPejollkby5Pv+Qts5gfWH7VMtClvR
         2wxQtBx64uSgUtTdrIB1HzQb8HViwNfl7PUCQOrwhNve/M5yg3GgNPEZCQCicrRnn0mV
         U8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XukNshtXclaBv8jW/sn9Q/GDvNS/WMqQ1pfD1gvb8T0=;
        b=FfNBW/1BUKLdkKG8hUYJO8mZ9vH93zv6NeteF+agFZ3imcvtr1nlw7iOR8iMooCVku
         FHtdLzVKN2ALj5dkf++AfwoImKoCz4WBQp/cQoxJXIpL7Nl4qN4KHPp69kZ5dP0zi088
         7tbvT2XygxePCQye81HUrBmNJq3nvzveKXYQgOPqsbUec1W4LBIOZt5mbAu+540ppkOu
         eFzzdHG+fB3W0ngYUzkEVLnthKTNWaMq21MnI9STTeFBc7ypEWPD85z1A1+mp0AvHK0H
         aFjNdq3kkScpcIrJJuDKBsdmDnUp9/H+kecujNzHIDbFBFjCZCmBVYgaSFENjH9KBSFI
         6lUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 4.9 060/102] arm64: entry: Hook up entry trampoline to exception vectors
Date: Fri,  6 Apr 2018 15:23:41 +0200
Message-Id: <20180406084340.016494702@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004010758387874?=
X-GMAIL-MSGID: =?utf-8?q?1597004010758387874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 4bf3286d29f3 upstream.

Hook up the entry trampoline to our exception vectors so that all
exceptions from and returns to EL0 go via the trampoline, which swizzles
the vector base register accordingly. Transitioning to and from the
kernel clobbers x30, so we use tpidrro_el0 and far_el1 as scratch
registers for native tasks.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -72,10 +72,26 @@
 
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
@@ -157,18 +173,20 @@
 	ct_user_enter
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
 	msr	spsr_el1, x22
@@ -189,7 +207,22 @@ alternative_else_nop_endif
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
 
 	.macro	get_thread_info, rd
