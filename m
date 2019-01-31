Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A568AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7674520B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KKWeXWC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfAaTaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:30:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46208 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbfAaT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so1908142pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJgFQQGso2AQAqZQWeq4F9wumM3n4pqOxB47BGoIwq8=;
        b=KKWeXWC0H0HMb7XrlA5idIUyJpQLvicgZstR6GDtON3d12RIT8JjjqDIf3nsNpa2pE
         k7fHuqsT5mzEOVQ7HcuHrxMiIPWmMZHaP0RyaJ75TpBq6xO7/Ez1gZssxNxpw8FwWSsj
         rcw7yh1u1TZMsP8AXO74gtzZ9HgnIvX7ACf0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJgFQQGso2AQAqZQWeq4F9wumM3n4pqOxB47BGoIwq8=;
        b=sn7CwBubk5uxkZ6ocjjGU8EaL8+Oe+mcKLyKYAZVj8H7bg7AQH0fSTKuh4HYFDRMdr
         geS7487nFAvOnrFXnkqo+/G5uq4W9TJg2grORpjJTX69A/Nt3s+OvlkopRt5gSJ6I5yg
         pwSTXVGP/QlSxSQAJKFRa8/sYuT2jQavxlU+qGQfxGZj6WxNJgoZDWwFZ6Nf52/yIZmr
         7bU+E5vlRBE2M/FFvdIETZI3Jc978EnBnIHdNhdO835sZ/oaufbv1aZc848zOCkF0NBD
         Fds1CkJ9hYHUTUtBl5cw4pw0v5E6LpKxXfxkAzVP7WM+USwIUK4yjQUtxVly4egFiLU+
         L6tw==
X-Gm-Message-State: AJcUukfuv6aClQS/G00yi1nZ4we0/tKtG8UPACm057J2mnyS/751ggoE
        hl7xgquWYE3z4WJQUDAFR8Pngw==
X-Google-Smtp-Source: ALg8bN5cZoHg+TGmTwqCDB4t3GL+EoaTUEAN1ziXwRUBdlB7cJ4P81Jd9eQZJQObQCzEbtMIUzCtCQ==
X-Received: by 2002:a63:5664:: with SMTP id g36mr32274176pgm.313.1548962901890;
        Thu, 31 Jan 2019 11:28:21 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:21 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/27] x86/entry/64: Adapt assembly for PIE support
Date:   Thu, 31 Jan 2019 11:24:12 -0800
Message-Id: <20190131192533.34130-6-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/entry/entry_64.S | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..16a93eb4c11f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1269,7 +1269,8 @@ ENTRY(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	leaq	.Lgs_change(%rip), %rcx
+	cmpq	%rcx, RIP+8(%rsp)
 	jne	.Lerror_entry_done
 
 	/*
@@ -1466,10 +1467,10 @@ ENTRY(nmi)
 	 * resume the outer NMI.
 	 */
 
-	movq	$repeat_nmi, %rdx
+	leaq	repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	1f
-	movq	$end_repeat_nmi, %rdx
+	leaq	end_repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	nested_nmi_out
 1:
@@ -1523,7 +1524,8 @@ nested_nmi:
 	pushq	%rdx
 	pushfq
 	pushq	$__KERNEL_CS
-	pushq	$repeat_nmi
+	leaq	repeat_nmi(%rip), %rdx
+	pushq	%rdx
 
 	/* Put stack back */
 	addq	$(6*8), %rsp
@@ -1562,7 +1564,11 @@ first_nmi:
 	addq	$8, (%rsp)	/* Fix up RSP */
 	pushfq			/* RFLAGS */
 	pushq	$__KERNEL_CS	/* CS */
-	pushq	$1f		/* RIP */
+	pushq	$0		/* Futur return address */
+	pushq	%rax		/* Save RAX */
+	leaq	1f(%rip), %rax	/* RIP */
+	movq    %rax, 8(%rsp)   /* Put 1f on return address */
+	popq	%rax		/* Restore RAX */
 	iretq			/* continues at repeat_nmi below */
 	UNWIND_HINT_IRET_REGS
 1:
-- 
2.20.1.495.gaa96b0ce6b-goog

