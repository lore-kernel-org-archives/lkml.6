Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeEQWpX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 18:45:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43797 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeEQWpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 18:45:22 -0400
Date: Thu, 17 May 2018 15:45:05 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180517213001.GA4047@avx2>
References: <20180517213001.GA4047@avx2>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 1/3] x86: verify_cpu: use 32-bit arithmetic
To: Alexey Dobriyan <adobriyan@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com
CC: x86@kernel, linux-kernel@vger.kernel.org
From: hpa@zytor.com
Message-ID: <8143B7B9-65E5-4467-BD14-B8CF2DD9AD62@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 17, 2018 2:30:01 PM PDT, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>32-bit instructions are 1 byte shorter than 16-bit instructions.
>
>Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>---
>
> arch/x86/kernel/verify_cpu.S |    8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>--- a/arch/x86/kernel/verify_cpu.S
>+++ b/arch/x86/kernel/verify_cpu.S
>@@ -56,14 +56,14 @@ ENTRY(verify_cpu)
> 	cmpl	$0x1,%eax
> 	jb	.Lverify_cpu_no_longmode	# no cpuid 1
> 
>-	xor	%di,%di
>+	xor	%edi, %edi
> 	cmpl	$0x68747541,%ebx	# AuthenticAMD
> 	jnz	.Lverify_cpu_noamd
> 	cmpl	$0x69746e65,%edx
> 	jnz	.Lverify_cpu_noamd
> 	cmpl	$0x444d4163,%ecx
> 	jnz	.Lverify_cpu_noamd
>-	mov	$1,%di			# cpu is from AMD
>+	mov	$1, %edi		# cpu is from AMD
> 	jmp	.Lverify_cpu_check
> 
> .Lverify_cpu_noamd:
>@@ -122,13 +122,13 @@ ENTRY(verify_cpu)
> 	andl	$SSE_MASK,%edx
> 	cmpl	$SSE_MASK,%edx
> 	je	.Lverify_cpu_sse_ok
>-	test	%di,%di
>+	test	%edi, %edi
> 	jz	.Lverify_cpu_no_longmode	# only try to force SSE on AMD
> 	movl	$MSR_K7_HWCR,%ecx
> 	rdmsr
> 	btr	$15,%eax		# enable SSE
> 	wrmsr
>-	xor	%di,%di			# don't loop
>+	xor	%edi, %edi		# don't loop
> 	jmp	.Lverify_cpu_sse_test	# try again
> 
> .Lverify_cpu_no_longmode:

Well, in 32/64-bit mode... this code is also assembled in 16-bit mode, and the 16-but code is more space sensitive.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
