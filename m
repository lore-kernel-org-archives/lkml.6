Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224tAYsuOAXNWt857N3G0+Ysy3qoKqjAe7wkzQ65S9167hlaFrECIEERS8iX6M01q7ggF82E
ARC-Seal: i=1; a=rsa-sha256; t=1518708663; cv=none;
        d=google.com; s=arc-20160816;
        b=BW5UGB/x4qJtmxdAFEiy+yiPk4/3gABZ+yttWWxQSQOQPKpO/lW4hOB+cpR+9anESS
         xE9SGnnXSvwEAsh5F9bMqOOgb7NMS1D0Z4ZzdClqZ8NHwBuHk/XZbhI+3TtF57OQeutX
         nokACpI3AhOZE8yeNveIQshwqF07tRze1zfjKK7/dPfer1/Ukd+J5f2G0FpzoLnPY+/b
         zxiVCD9toR09YnxbnnnrQv86iRJWdYRbF5S2n6rYEtyD7/FM3BS1nQMnPmDCHaqhCqAV
         zKlniA+YAFGKUKX+7AN4JIoXx6+SENjQmRmW5dfhVOpaiPqzQ+96+ngkKRwW1hGNf+dA
         Zi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4iJKdl+pBSRvO0sxardda0LVXuY7BzwXQiMhyIpFsko=;
        b=zrTNDy4DPAGvqFd0+XXu+an+MT5A77BoWsNiGnEYmndzFCTQfHZe7L6lTpzzY0SiDl
         9v018zt+kMRC7kXwZzYBqhgVePiJwschLtTASUj9QMuVBNLjbLpX6w8xlcn0oBYyMsRj
         Hoi24/C5kRdOoMuiKCl9INkehmVEX7S2HXnz2LhLgt/dfGAcGG7DAqZuJ5kwARbvnW+9
         J+crABVThGHpuA04m5mejguHiMFg+/wie1DG5lk1YyKvRl1Sb7+zc0A5aHLUO6b5iKNT
         0rJjVKSs9aG5c444UIdl94veQLLmy9B62C807y+1ygPQqG4OymOiEKbuIeLMhykVLLEk
         pg+g==
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
Subject: [PATCH 4.14 034/195] [Variant 3/Meltdown] arm64: entry: Explicitly pass exception level to kernel_ventry macro
Date: Thu, 15 Feb 2018 16:15:25 +0100
Message-Id: <20180215151707.463484280@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481454823379099?=
X-GMAIL-MSGID: =?utf-8?q?1592481454823379099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 5b1f7fe41909 upstream.

We will need to treat exceptions from EL0 differently in kernel_ventry,
so rework the macro to take the exception level as an argument and
construct the branch target using that.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -71,7 +71,7 @@
 #define BAD_FIQ		2
 #define BAD_ERROR	3
 
-	.macro kernel_ventry	label
+	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
 	sub	sp, sp, #S_FRAME_SIZE
 #ifdef CONFIG_VMAP_STACK
@@ -84,7 +84,7 @@
 	tbnz	x0, #THREAD_SHIFT, 0f
 	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
 	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
-	b	\label
+	b	el\()\el\()_\label
 
 0:
 	/*
@@ -116,7 +116,7 @@
 	sub	sp, sp, x0
 	mrs	x0, tpidrro_el0
 #endif
-	b	\label
+	b	el\()\el\()_\label
 	.endm
 
 	.macro	kernel_entry, el, regsize = 64
@@ -367,31 +367,31 @@ tsk	.req	x28		// current thread_info
 
 	.align	11
 ENTRY(vectors)
-	kernel_ventry	el1_sync_invalid		// Synchronous EL1t
-	kernel_ventry	el1_irq_invalid			// IRQ EL1t
-	kernel_ventry	el1_fiq_invalid			// FIQ EL1t
-	kernel_ventry	el1_error_invalid		// Error EL1t
-
-	kernel_ventry	el1_sync			// Synchronous EL1h
-	kernel_ventry	el1_irq				// IRQ EL1h
-	kernel_ventry	el1_fiq_invalid			// FIQ EL1h
-	kernel_ventry	el1_error_invalid		// Error EL1h
-
-	kernel_ventry	el0_sync			// Synchronous 64-bit EL0
-	kernel_ventry	el0_irq				// IRQ 64-bit EL0
-	kernel_ventry	el0_fiq_invalid			// FIQ 64-bit EL0
-	kernel_ventry	el0_error_invalid		// Error 64-bit EL0
+	kernel_ventry	1, sync_invalid			// Synchronous EL1t
+	kernel_ventry	1, irq_invalid			// IRQ EL1t
+	kernel_ventry	1, fiq_invalid			// FIQ EL1t
+	kernel_ventry	1, error_invalid		// Error EL1t
+
+	kernel_ventry	1, sync				// Synchronous EL1h
+	kernel_ventry	1, irq				// IRQ EL1h
+	kernel_ventry	1, fiq_invalid			// FIQ EL1h
+	kernel_ventry	1, error_invalid		// Error EL1h
+
+	kernel_ventry	0, sync				// Synchronous 64-bit EL0
+	kernel_ventry	0, irq				// IRQ 64-bit EL0
+	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
+	kernel_ventry	0, error_invalid		// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
-	kernel_ventry	el0_sync_compat			// Synchronous 32-bit EL0
-	kernel_ventry	el0_irq_compat			// IRQ 32-bit EL0
-	kernel_ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
-	kernel_ventry	el0_error_invalid_compat	// Error 32-bit EL0
+	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
+	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
+	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
+	kernel_ventry	0, error_invalid_compat, 32	// Error 32-bit EL0
 #else
-	kernel_ventry	el0_sync_invalid		// Synchronous 32-bit EL0
-	kernel_ventry	el0_irq_invalid			// IRQ 32-bit EL0
-	kernel_ventry	el0_fiq_invalid			// FIQ 32-bit EL0
-	kernel_ventry	el0_error_invalid		// Error 32-bit EL0
+	kernel_ventry	0, sync_invalid, 32		// Synchronous 32-bit EL0
+	kernel_ventry	0, irq_invalid, 32		// IRQ 32-bit EL0
+	kernel_ventry	0, fiq_invalid, 32		// FIQ 32-bit EL0
+	kernel_ventry	0, error_invalid, 32		// Error 32-bit EL0
 #endif
 END(vectors)
 
