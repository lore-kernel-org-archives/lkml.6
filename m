Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02711C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87713244E4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UMSbfvvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87713244E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754943AbeFYQdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:33:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeFYQdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bad/G5DDLrWAZOUdYmoQYIyINNBA/1tkdw6ALSwVV1E=; b=UMSbfvvfz67s4sX1kC8HYtrw5
        +xIVdEzAD3xQAicFzsuuPsooL6jP6KNWg+9s9wXXIYQSpq5MrHfgRCtpoUen0Jgi3oBGXHzrGWLX7
        7g8QGOzx82WA1HwUBLD/LXZ763Crgtp/CG0AgIl5CsJqIf7BnoJNcRAGBpi2h7LKN2INOMKvAvcWQ
        mn9cJhrJ2ODj5Js3WcIA1oetnBmiKn9n44sqsQ6DIuSBVJLVGWpj1WfafA2d363XT6VF5//u6Q33v
        R7leJcyp7NDFPmVk7A+2oVD28MH8W765yYQEFco63IBLdJ3n4Y5meB9+1qiT7NWgn2yeuZJhe19/v
        dsvnXKw1A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXUQq-00024Q-EY; Mon, 25 Jun 2018 16:33:36 +0000
Subject: Re: [PATCH] x86-64: use 32-bit XOR to zero registers
To:     Jan Beulich <JBeulich@suse.com>, mingo@elte.hu, tglx@linutronix.de,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org
References: <5B30C32902000078001CD6D5@prv1-mh.provo.novell.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a68a703f-5d74-a2eb-4b26-0fe3e6e48705@infradead.org>
Date:   Mon, 25 Jun 2018 09:33:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B30C32902000078001CD6D5@prv1-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 03:25 AM, Jan Beulich wrote:
> Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms - use
> 32-bit ones instead.

Hmph.  Is that considered a bug (errata)?

URL/references?

Are these changes really only zeroing the lower 32 bits of the register?
and that's all that the code cares about?

thanks.

> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> ---
>  arch/x86/crypto/aegis128-aesni-asm.S     |    2 +-
>  arch/x86/crypto/aegis128l-aesni-asm.S    |    2 +-
>  arch/x86/crypto/aegis256-aesni-asm.S     |    2 +-
>  arch/x86/crypto/aesni-intel_asm.S        |    8 ++++----
>  arch/x86/crypto/aesni-intel_avx-x86_64.S |    4 ++--
>  arch/x86/crypto/morus1280-avx2-asm.S     |    2 +-
>  arch/x86/crypto/morus1280-sse2-asm.S     |    2 +-
>  arch/x86/crypto/morus640-sse2-asm.S      |    2 +-
>  arch/x86/crypto/sha1_ssse3_asm.S         |    2 +-
>  arch/x86/kernel/head_64.S                |    2 +-
>  arch/x86/kernel/paravirt_patch_64.c      |    2 +-
>  arch/x86/lib/memcpy_64.S                 |    2 +-
>  arch/x86/power/hibernate_asm_64.S        |    2 +-
>  13 files changed, 17 insertions(+), 17 deletions(-)
> 
> --- 4.18-rc2/arch/x86/crypto/aegis128-aesni-asm.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/aegis128-aesni-asm.S
> @@ -75,7 +75,7 @@
>   *   %r9
>   */
>  __load_partial:
> -	xor %r9, %r9
> +	xor %r9d, %r9d
>  	pxor MSG, MSG
>  
>  	mov LEN, %r8
> --- 4.18-rc2/arch/x86/crypto/aegis128l-aesni-asm.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/aegis128l-aesni-asm.S
> @@ -66,7 +66,7 @@
>   *   %r9
>   */
>  __load_partial:
> -	xor %r9, %r9
> +	xor %r9d, %r9d
>  	pxor MSG0, MSG0
>  	pxor MSG1, MSG1
>  
> --- 4.18-rc2/arch/x86/crypto/aegis256-aesni-asm.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/aegis256-aesni-asm.S
> @@ -59,7 +59,7 @@
>   *   %r9
>   */
>  __load_partial:
> -	xor %r9, %r9
> +	xor %r9d, %r9d
>  	pxor MSG, MSG
>  
>  	mov LEN, %r8
> --- 4.18-rc2/arch/x86/crypto/aesni-intel_asm.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/aesni-intel_asm.S
> @@ -258,7 +258,7 @@ ALL_F:      .octa 0xffffffffffffffffffff
>  .macro GCM_INIT Iv SUBKEY AAD AADLEN
>  	mov \AADLEN, %r11
>  	mov %r11, AadLen(%arg2) # ctx_data.aad_length = aad_length
> -	xor %r11, %r11
> +	xor %r11d, %r11d
>  	mov %r11, InLen(%arg2) # ctx_data.in_length = 0
>  	mov %r11, PBlockLen(%arg2) # ctx_data.partial_block_length = 0
>  	mov %r11, PBlockEncKey(%arg2) # ctx_data.partial_block_enc_key = 0
> @@ -286,7 +286,7 @@ ALL_F:      .octa 0xffffffffffffffffffff
>  	movdqu HashKey(%arg2), %xmm13
>  	add %arg5, InLen(%arg2)
>  
> -	xor %r11, %r11 # initialise the data pointer offset as zero
> +	xor %r11d, %r11d # initialise the data pointer offset as zero
>  	PARTIAL_BLOCK %arg3 %arg4 %arg5 %r11 %xmm8 \operation
>  
>  	sub %r11, %arg5		# sub partial block data used
> @@ -702,7 +702,7 @@ _no_extra_mask_1_\@:
>  
>  	# GHASH computation for the last <16 Byte block
>  	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
> -	xor	%rax,%rax
> +	xor	%eax, %eax
>  
>  	mov	%rax, PBlockLen(%arg2)
>  	jmp	_dec_done_\@
> @@ -737,7 +737,7 @@ _no_extra_mask_2_\@:
>  
>  	# GHASH computation for the last <16 Byte block
>  	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
> -	xor	%rax,%rax
> +	xor	%eax, %eax
>  
>  	mov	%rax, PBlockLen(%arg2)
>  	jmp	_encode_done_\@
> --- 4.18-rc2/arch/x86/crypto/aesni-intel_avx-x86_64.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/aesni-intel_avx-x86_64.S
> @@ -463,7 +463,7 @@ _get_AAD_rest_final\@:
>  
>  _get_AAD_done\@:
>  	# initialize the data pointer offset as zero
> -	xor     %r11, %r11
> +	xor     %r11d, %r11d
>  
>  	# start AES for num_initial_blocks blocks
>  	mov     arg5, %rax                     # rax = *Y0
> @@ -1770,7 +1770,7 @@ _get_AAD_rest_final\@:
>  
>  _get_AAD_done\@:
>  	# initialize the data pointer offset as zero
> -	xor     %r11, %r11
> +	xor     %r11d, %r11d
>  
>  	# start AES for num_initial_blocks blocks
>  	mov     arg5, %rax                     # rax = *Y0
> --- 4.18-rc2/arch/x86/crypto/morus1280-avx2-asm.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/morus1280-avx2-asm.S
> @@ -113,7 +113,7 @@ ENDPROC(__morus1280_update_zero)
>   *   %r9
>   */
>  __load_partial:
> -	xor %r9, %r9
> +	xor %r9d, %r9d
>  	vpxor MSG, MSG, MSG
>  
>  	mov %rcx, %r8
> --- 4.18-rc2/arch/x86/crypto/morus1280-sse2-asm.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/morus1280-sse2-asm.S
> @@ -235,7 +235,7 @@ ENDPROC(__morus1280_update_zero)
>   *   %r9
>   */
>  __load_partial:
> -	xor %r9, %r9
> +	xor %r9d, %r9d
>  	pxor MSG_LO, MSG_LO
>  	pxor MSG_HI, MSG_HI
>  
> --- 4.18-rc2/arch/x86/crypto/morus640-sse2-asm.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/morus640-sse2-asm.S
> @@ -113,7 +113,7 @@ ENDPROC(__morus640_update_zero)
>   *   %r9
>   */
>  __load_partial:
> -	xor %r9, %r9
> +	xor %r9d, %r9d
>  	pxor MSG, MSG
>  
>  	mov %rcx, %r8
> --- 4.18-rc2/arch/x86/crypto/sha1_ssse3_asm.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/sha1_ssse3_asm.S
> @@ -96,7 +96,7 @@
>  	# cleanup workspace
>  	mov	$8, %ecx
>  	mov	%rsp, %rdi
> -	xor	%rax, %rax
> +	xor	%eax, %eax
>  	rep stosq
>  
>  	mov	%rbp, %rsp		# deallocate workspace
> --- 4.18-rc2/arch/x86/kernel/head_64.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/kernel/head_64.S
> @@ -235,7 +235,7 @@ ENTRY(secondary_startup_64)
>  	 *		address given in m16:64.
>  	 */
>  	pushq	$.Lafter_lret	# put return address on stack for unwinder
> -	xorq	%rbp, %rbp	# clear frame pointer
> +	xorl	%ebp, %ebp	# clear frame pointer
>  	movq	initial_code(%rip), %rax
>  	pushq	$__KERNEL_CS	# set correct cs
>  	pushq	%rax		# target address in negative space
> --- 4.18-rc2/arch/x86/kernel/paravirt_patch_64.c
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/kernel/paravirt_patch_64.c
> @@ -20,7 +20,7 @@ DEF_NATIVE(, mov64, "mov %rdi, %rax");
>  
>  #if defined(CONFIG_PARAVIRT_SPINLOCKS)
>  DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%rdi)");
> -DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %rax, %rax");
> +DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %eax, %eax");
>  #endif
>  
>  unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
> --- 4.18-rc2/arch/x86/lib/memcpy_64.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/lib/memcpy_64.S
> @@ -256,7 +256,7 @@ ENTRY(__memcpy_mcsafe)
>  
>  	/* Copy successful. Return zero */
>  .L_done_memcpy_trap:
> -	xorq %rax, %rax
> +	xorl %eax, %eax
>  	ret
>  ENDPROC(__memcpy_mcsafe)
>  EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
> --- 4.18-rc2/arch/x86/power/hibernate_asm_64.S
> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/power/hibernate_asm_64.S
> @@ -137,7 +137,7 @@ ENTRY(restore_registers)
>  	/* Saved in save_processor_state. */
>  	lgdt	saved_context_gdt_desc(%rax)
>  
> -	xorq	%rax, %rax
> +	xorl	%eax, %eax
>  
>  	/* tell the hibernation core that we've just restored the memory */
>  	movq	%rax, in_suspend(%rip)
> 
> 
> 


-- 
~Randy
