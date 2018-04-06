Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49e85cgIcv8V7Qt4my07y8dfnpOJrf2aC/7GnrjMt0TSEBgN0G4+Ewby1uoa48qNir3V+DX
ARC-Seal: i=1; a=rsa-sha256; t=1523021701; cv=none;
        d=google.com; s=arc-20160816;
        b=Pilo2lKkaiXO40X3E++/4F1kPr80LnvFJPi1XT9qaIkg8NQqRr48BIEVx11/6mS/58
         VJRoG3y6l3eM7GeLylj2m0TZV7uTvZK1JNw2XCBYHgEB3pBUYENiN45Po0lqmnCMSjj7
         wr6Nb47rYB+Q/8uQT64xSX4Zv/7eZb+aVhHhn1BKWF/QEUSPGrIHLmq9fjMNj7hiLAtu
         n9v9/kKpH+nLmRs8QTH7lo6f3D76CDURIFUBsvHcmJvEv4eOX6kTwHfLghg+yiaGqeDa
         bPgih8Zy/C8zrxKVeddUVvL7HksI3fxs4nX3c71XsEUdZMZQHb6OfFcTuPP5hBF71R6J
         Qbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S2orbjwKU+aI9mFCOxcmgmWbcnzK9lypiy3jiJe89Wc=;
        b=iZmgRqD/y/994eqRXk7w5ABpoh+fYHLmGDjBB/66K10bKGm5GarIstRpfQA8By8eZ5
         8IDRekDCh0F6uw//nhIbodM1fMdr7F4vlX01tBotO/V/BLPMmYzpN/A4OEUGW87dGDCM
         21AvfzCN20zPSuSecO0Ibbp7q+XvLGBZ8itLrlwW3+sGpyJ6CmUM54XzVc6FsNLS3/3H
         R9WW1x/IDS4dgktxJuW1ifklumE6Xp2RkL48GBTsDFkeC16vFvFkfg8nTMZcxZgLIK1I
         d51aTNwV23sqpEHwUxZv0dwD67dUq8EEuswg6RN7Sx6vkhTuqZ5NoenXVg3q9VsjNrp2
         AaqA==
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
Subject: [PATCH 4.9 059/102] arm64: entry: Explicitly pass exception level to kernel_ventry macro
Date: Fri,  6 Apr 2018 15:23:40 +0200
Message-Id: <20180406084339.887782436@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004003369745565?=
X-GMAIL-MSGID: =?utf-8?q?1597004003369745565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 5b1f7fe41909 upstream.

We will need to treat exceptions from EL0 differently in kernel_ventry,
so rework the macro to take the exception level as an argument and
construct the branch target using that.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
[Mark: avoid dependency on C error handler backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   48 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -70,10 +70,10 @@
 #define BAD_FIQ		2
 #define BAD_ERROR	3
 
-	.macro kernel_ventry	label
+	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
 	sub	sp, sp, #S_FRAME_SIZE
-	b	\label
+	b	el\()\el\()_\label
 	.endm
 
 	.macro	kernel_entry, el, regsize = 64
@@ -264,31 +264,31 @@ tsk	.req	x28		// current thread_info
 
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
 
