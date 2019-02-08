Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486E9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA45217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DeVQy5uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfBHTxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:53:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfBHTxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:53:31 -0500
Received: from zn.tnic (p200300EC2BC9F90099B658B9FC00DDBE.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:f900:99b6:58b9:fc00:ddbe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E98DB1EC09B1;
        Fri,  8 Feb 2019 20:53:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549655610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=j6OZ++W2amU1BWx4/JVhTMfJDJwLIUWo1Etk/jSd0Tc=;
        b=DeVQy5uPrbX++FHCkQpPL4xlEU/dxxOd3tz6ngNBa+5p5Rgy7itzXWE6N9uBpkvlmNANbA
        PWFIRWAePKQgDG3Cl9dY/ZCS7KtK8z8NVsRLVYUGaUlEHOr91QzveU4V04geFtBS9ukc3g
        NICG2MX3P2tI2I7EUEKjCaR20Zk3dJs=
Date:   Fri, 8 Feb 2019 20:53:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v7 04/28] x86/asm: annotate relocate_kernel
Message-ID: <20190208195324.GM674@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-5-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130124711.12463-5-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:46:47PM +0100, Jiri Slaby wrote:
> There are functions in relocate_kernel which are not annotated. This
> makes automatic annotations rather hard. So annotate all the functions
> now.
> 
> Note that these are not C-like functions, so we do not use FUNC, but
> CODE markers. Also they are not aligned, so we use the NOALIGN versions:
> - SYM_CODE_START_NOALIGN
> - SYM_CODE_START_LOCAL_NOALIGN
> - SYM_CODE_END
> 
> In return, we get:
>   0000   108 NOTYPE  GLOBAL DEFAULT    1 relocate_kernel
>   006c   165 NOTYPE  LOCAL  DEFAULT    1 identity_mapped
>   0146   127 NOTYPE  LOCAL  DEFAULT    1 swap_pages
>   0111    53 NOTYPE  LOCAL  DEFAULT    1 virtual_mapped

Err, if those last three are local symbols, you can simply remove them
from the symtable by making them a local labels. Partial diff ontop of
yours:

---
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index beb78767a5b3..e15033ce246f 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -101,12 +101,12 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	lea	PAGE_SIZE(%r8), %rsp
 
 	/* jump to identity mapped page */
-	addq	$(identity_mapped - relocate_kernel), %r8
+	addq	$(.Lidentity_mapped - relocate_kernel), %r8
 	pushq	%r8
 	ret
 SYM_CODE_END(relocate_kernel)
 
-SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
+.Lidentity_mapped:
 	/* set return address to 0 if not preserving context */
 	pushq	$0
 	/* store the start address on the stack */
@@ -155,7 +155,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 1:
 
 	movq	%rcx, %r11
-	call	swap_pages
+	call	.Lswap_pages
 
 	/*
 	 * To be certain of avoiding problems with self-modifying code
@@ -207,13 +207,12 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	CP_PA_TABLE_PAGE(%r8), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
-	call	swap_pages
-	movq	$virtual_mapped, %rax
+	call	.Lswap_pages
+	movq	$.Lvirtual_mapped, %rax
 	pushq	%rax
 	ret
-SYM_CODE_END(identity_mapped)
 
-SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
+.Lvirtual_mapped:
 	movq	RSP(%r8), %rsp
 	movq	CR4(%r8), %rax
 	movq	%rax, %cr4
@@ -231,10 +230,9 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	popq	%rbp
 	popq	%rbx
 	ret
-SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
-SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
+.Lswap_pages:
 	movq	%rdi, %rcx 	/* Put the page_list in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
@@ -287,7 +285,6 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	jmp	0b
 3:
 	ret
-SYM_CODE_END(swap_pages)
 
 	.globl kexec_control_code_size
 .set kexec_control_code_size, . - relocate_kernel

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
