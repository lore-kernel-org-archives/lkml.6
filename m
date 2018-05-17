Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeEQVaG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:30:06 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36994 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQVaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:30:05 -0400
X-Google-Smtp-Source: AB8JxZrnE1ecxFGN+2ILmK3whX8VCM5RYwQ0XnVL9bBtrZP8Y9eL9nWD34uc7e7smXkyP0PiA7uYFw==
Date: Fri, 18 May 2018 00:30:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86: verify_cpu: use 32-bit arithmetic
Message-ID: <20180517213001.GA4047@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit instructions are 1 byte shorter than 16-bit instructions.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/kernel/verify_cpu.S |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -56,14 +56,14 @@ ENTRY(verify_cpu)
 	cmpl	$0x1,%eax
 	jb	.Lverify_cpu_no_longmode	# no cpuid 1
 
-	xor	%di,%di
+	xor	%edi, %edi
 	cmpl	$0x68747541,%ebx	# AuthenticAMD
 	jnz	.Lverify_cpu_noamd
 	cmpl	$0x69746e65,%edx
 	jnz	.Lverify_cpu_noamd
 	cmpl	$0x444d4163,%ecx
 	jnz	.Lverify_cpu_noamd
-	mov	$1,%di			# cpu is from AMD
+	mov	$1, %edi		# cpu is from AMD
 	jmp	.Lverify_cpu_check
 
 .Lverify_cpu_noamd:
@@ -122,13 +122,13 @@ ENTRY(verify_cpu)
 	andl	$SSE_MASK,%edx
 	cmpl	$SSE_MASK,%edx
 	je	.Lverify_cpu_sse_ok
-	test	%di,%di
+	test	%edi, %edi
 	jz	.Lverify_cpu_no_longmode	# only try to force SSE on AMD
 	movl	$MSR_K7_HWCR,%ecx
 	rdmsr
 	btr	$15,%eax		# enable SSE
 	wrmsr
-	xor	%di,%di			# don't loop
+	xor	%edi, %edi		# don't loop
 	jmp	.Lverify_cpu_sse_test	# try again
 
 .Lverify_cpu_no_longmode:
