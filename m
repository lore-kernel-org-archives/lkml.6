Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063CDC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC86C20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DMIJ9SqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfAaT2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37985 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfAaT2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so1781296pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A12aDa+5W9QhGLlMyggdoqeIT915Z4nL+XYgIaJs8iA=;
        b=DMIJ9SqTyTde2e6/edb0iUiqB/YWAlTIXk1HF/cV82SJSRh6iHAS5wrDLvl1z06QKX
         d/wlYIs1n1akJahncaDUsonXmlWuhQJ76+D5nH6z3BOs3FwOy5l4W8WKRwHCd8SbPPT+
         UTLcz+Eev1GO58YgPJ9+nc1pytrfUM/jx0aw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A12aDa+5W9QhGLlMyggdoqeIT915Z4nL+XYgIaJs8iA=;
        b=gnrRWq+xHMds+xBxMKyOY7VJDF08XPIev8MzqF4+F8hjjEp9DfJO2RUy3b3r78KON8
         mOpY94i9eF1uLWKFoHqW9YyPa98p/slM2W11GFUyvrgY3SBIwPZ7wp5vKkEuHPWhmoW/
         QZAI8FYXPKrilPINZr33HTuMc5YAor4oUcb83R9O85IWSVyiT6mrVqPWiZ2rJXFwKgh1
         V5KJHo1PSzcGSx70HU6SRVn59AnGTaAYK2z6tiP91MtMieSjVecNGF77aT1WwMFAPX/W
         32LLgVnQOFvdr6HlAZIFlxQg5bUMJz9okhycLqyKr9liD91JQjsgno4UlHTG5prdkTBY
         r8Cw==
X-Gm-Message-State: AJcUukclgEi8kTCpsmkxElETTNOsL5jc7cgpbu/KDpZENOirvzORySbN
        ycmP5DU8KkVCHhjmkoi4ubT6+Q==
X-Google-Smtp-Source: ALg8bN5IM0GYFT//+GQN2VFpKvrJY9g13VsgGe/d5fetq37bbsch0jTBo09cq86uNLrKDCQizOTqhg==
X-Received: by 2002:a63:1408:: with SMTP id u8mr32850734pgl.271.1548962909228;
        Thu, 31 Jan 2019 11:28:29 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:28 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Garnier <thgarnie@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/27] x86/boot/64: Adapt assembly for PIE support
Date:   Thu, 31 Jan 2019 11:24:16 -0800
Message-Id: <20190131192533.34130-10-thgarnie@chromium.org>
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

Early at boot, the kernel is mapped at a temporary address while preparing
the page table. To know the changes needed for the page table with KASLR,
the boot code calculate the difference between the expected address of the
kernel and the one chosen by KASLR. It does not work with PIE because all
symbols in code are relatives. Instead of getting the future relocated
virtual address, you will get the current temporary mapping.
Instructions were changed to have absolute 64-bit references.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/kernel/head_64.S | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d1dbe8e4eb82..b9b6c6aa0313 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -90,8 +90,10 @@ startup_64:
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+	movabs  $(early_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 	jmp 1f
+
 ENTRY(secondary_startup_64)
 	UNWIND_HINT_EMPTY
 	/*
@@ -120,7 +122,8 @@ ENTRY(secondary_startup_64)
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+	movabs	$(init_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 1:
 
 	/* Enable PAE mode, PGE and LA57 */
@@ -138,7 +141,7 @@ ENTRY(secondary_startup_64)
 	movq	%rax, %cr3
 
 	/* Ensure I am executing from virtual addresses */
-	movq	$1f, %rax
+	movabs  $1f, %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
@@ -235,11 +238,12 @@ ENTRY(secondary_startup_64)
 	 *	REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
 	 *		address given in m16:64.
 	 */
-	pushq	$.Lafter_lret	# put return address on stack for unwinder
+	movabs  $.Lafter_lret, %rax
+	pushq	%rax		# put return address on stack for unwinder
 	xorl	%ebp, %ebp	# clear frame pointer
-	movq	initial_code(%rip), %rax
+	leaq	initial_code(%rip), %rax
 	pushq	$__KERNEL_CS	# set correct cs
-	pushq	%rax		# target address in negative space
+	pushq	(%rax)		# target address in negative space
 	lretq
 .Lafter_lret:
 END(secondary_startup_64)
-- 
2.20.1.495.gaa96b0ce6b-goog

