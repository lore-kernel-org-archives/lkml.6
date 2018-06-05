Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeFERbG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:31:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35125 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbeFERbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:31:04 -0400
Subject: Re: [PATCH v2 2/2] x86: paravirt: make native_save_fl extern inline
To: Nick Desaulniers <ndesaulniers@google.com>, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, aryabinin@virtuozzo.com,
        akataria@vmware.com, boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        caoj.fnst@cn.fujitsu.com, gregkh@linuxfoundation.org,
        jan.kiszka@siemens.com, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        mingo@redhat.com, mjg59@google.com, mka@chromium.org,
        pombredanne@nexb.com, rostedt@goodmis.org, tglx@linutronix.de,
        thomas.lendacky@amd.com, tweek@google.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        astrachan@google.com, manojgupta@google.com, ghackmann@google.com,
        sedat.dilek@gmail.com, tstellar@redhat.com, keescook@google.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, geert@linux-m68k.org,
        will.deacon@arm.com, mawilcox@microsoft.com, arnd@arndb.de,
        rientjes@google.com
References: <20180605170532.170361-1-ndesaulniers@google.com>
 <20180605170532.170361-3-ndesaulniers@google.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <26c7fd1c-ab40-368f-c2e3-43a6b45157fd@zytor.com>
Date: Tue, 5 Jun 2018 10:28:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605170532.170361-3-ndesaulniers@google.com>
Content-Type: multipart/mixed;
 boundary="------------440690091998480EBFAA1FD9"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------440690091998480EBFAA1FD9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 06/05/18 10:05, Nick Desaulniers wrote:
> +
> +/*
> + * void native_restore_fl(unsigned long flags)
> + * %rdi: flags
> + */
> +ENTRY(native_restore_fl)
> +	push %_ASM_DI
> +	popf
> +	ret
> +ENDPROC(native_restore_fl)
> +EXPORT_SYMBOL(native_restore_fl)
> 

To work on i386, this would have to be %_ASM_AX in that case.

Something like this added to <asm/asm.h> might be useful; then you can
simply:

	push %_ASM_ARG1

--------------440690091998480EBFAA1FD9
Content-Type: text/x-patch;
 name="0001-x86-asm-add-_ASM_ARG-constants-for-argument-registes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-x86-asm-add-_ASM_ARG-constants-for-argument-registes.pa";
 filename*1="tch"

>From 83a7c1b7167dceee0eb731cf4ae3af7f9b2c05ea Mon Sep 17 00:00:00 2001
From: "H. Peter Anvin" <hpa@linux.intel.com>
Date: Tue, 5 Jun 2018 10:21:35 -0700
Subject: [PATCH] x86/asm: add _ASM_ARG* constants for argument registes to
 <asm/asm.h>

i386 and x86-64 uses different registers for arguments; make them
available so we don't have to #ifdef in the actual code.

Native size and specified size (q, l, w, b) versions are provided.

Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
---
 arch/x86/include/asm/asm.h | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 219faaec51df..3cab54bce51d 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -46,6 +46,65 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+#ifndef __x86_64__
+/* 32 bit */
+
+#define _ASM_ARG1	_ASM_AX
+#define _ASM_ARG2	_ASM_DX
+#define _ASM_ARG3	_ASM_CX
+
+#define _ASM_ARG1L	eax
+#define _ASM_ARG2L	edx
+#define _ASM_ARG3L	ecx
+
+#define _ASM_ARG1W	ax
+#define _ASM_ARG2W	dx
+#define _ASM_ARG3W	cx
+
+#define _ASM_ARG1B	al
+#define _ASM_ARG2B	dl
+#define _ASM_ARG3B	cl
+
+#else
+/* 64 bit */
+
+#define _ASM_ARG1	_ASM_DI
+#define _ASM_ARG2	_ASM_SI
+#define _ASM_ARG3	_ASM_DX
+#define _ASM_ARG4	_ASM_CX
+#define _ASM_ARG5	r8
+#define _ASM_ARG6	r9
+
+#define _ASM_ARG1Q	rdi
+#define _ASM_ARG2Q	rsi
+#define _ASM_ARG3Q	rdx
+#define _ASM_ARG4Q	rcx
+#define _ASM_ARG5Q	r8
+#define _ASM_ARG6Q	r9
+
+#define _ASM_ARG1L	edi
+#define _ASM_ARG2L	esi
+#define _ASM_ARG3L	edx
+#define _ASM_ARG4L	ecx
+#define _ASM_ARG5L	r8d
+#define _ASM_ARG6L	r9d
+
+#define _ASM_ARG1W	di
+#define _ASM_ARG2W	di
+#define _ASM_ARG3W	dx
+#define _ASM_ARG4W	cx
+#define _ASM_ARG5W	r8w
+#define _ASM_ARG6W	r9w
+
+#define _ASM_ARG1B	dil
+#define _ASM_ARG2B	sil
+#define _ASM_ARG3B	dl
+#define _ASM_ARG4B	cl
+#define _ASM_ARG5B	r8b
+#define _ASM_ARG6B	r9b
+
+#endif
+
 /*
  * Macros to generate condition code outputs from inline assembly,
  * The output operand must be type "bool".
-- 
2.14.4


--------------440690091998480EBFAA1FD9--
