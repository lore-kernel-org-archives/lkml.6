Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3200C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B9025E87
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B9025E87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933913AbeFYQuA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:50:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45905 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754385AbeFYQt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:49:58 -0400
Received: from [IPv6:2607:fb90:8627:d98c:b05d:f9e1:9aff:be3c] ([172.58.75.53])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5PGnFRU1261983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 25 Jun 2018 09:49:16 -0700
Date:   Mon, 25 Jun 2018 09:49:08 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <a68a703f-5d74-a2eb-4b26-0fe3e6e48705@infradead.org>
References: <5B30C32902000078001CD6D5@prv1-mh.provo.novell.com> <a68a703f-5d74-a2eb-4b26-0fe3e6e48705@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86-64: use 32-bit XOR to zero registers
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jan Beulich <JBeulich@suse.com>, mingo@elte.hu,
        tglx@linutronix.de
CC:     linux-kernel@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <F2CF9828-3256-4B70-B2CA-BB85FBA9121A@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 25, 2018 9:33:35 AM PDT, Randy Dunlap <rdunlap@infradead.org> wrote:
>On 06/25/2018 03:25 AM, Jan Beulich wrote:
>> Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms - use
>> 32-bit ones instead.
>
>Hmph.  Is that considered a bug (errata)?
>
>URL/references?
>
>Are these changes really only zeroing the lower 32 bits of the
>register?
>and that's all that the code cares about?
>
>thanks.
>
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> ---
>>  arch/x86/crypto/aegis128-aesni-asm.S     |    2 +-
>>  arch/x86/crypto/aegis128l-aesni-asm.S    |    2 +-
>>  arch/x86/crypto/aegis256-aesni-asm.S     |    2 +-
>>  arch/x86/crypto/aesni-intel_asm.S        |    8 ++++----
>>  arch/x86/crypto/aesni-intel_avx-x86_64.S |    4 ++--
>>  arch/x86/crypto/morus1280-avx2-asm.S     |    2 +-
>>  arch/x86/crypto/morus1280-sse2-asm.S     |    2 +-
>>  arch/x86/crypto/morus640-sse2-asm.S      |    2 +-
>>  arch/x86/crypto/sha1_ssse3_asm.S         |    2 +-
>>  arch/x86/kernel/head_64.S                |    2 +-
>>  arch/x86/kernel/paravirt_patch_64.c      |    2 +-
>>  arch/x86/lib/memcpy_64.S                 |    2 +-
>>  arch/x86/power/hibernate_asm_64.S        |    2 +-
>>  13 files changed, 17 insertions(+), 17 deletions(-)
>> 
>> --- 4.18-rc2/arch/x86/crypto/aegis128-aesni-asm.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/aegis128-aesni-asm.S
>> @@ -75,7 +75,7 @@
>>   *   %r9
>>   */
>>  __load_partial:
>> -	xor %r9, %r9
>> +	xor %r9d, %r9d
>>  	pxor MSG, MSG
>>  
>>  	mov LEN, %r8
>> --- 4.18-rc2/arch/x86/crypto/aegis128l-aesni-asm.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/aegis128l-aesni-asm.S
>> @@ -66,7 +66,7 @@
>>   *   %r9
>>   */
>>  __load_partial:
>> -	xor %r9, %r9
>> +	xor %r9d, %r9d
>>  	pxor MSG0, MSG0
>>  	pxor MSG1, MSG1
>>  
>> --- 4.18-rc2/arch/x86/crypto/aegis256-aesni-asm.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/aegis256-aesni-asm.S
>> @@ -59,7 +59,7 @@
>>   *   %r9
>>   */
>>  __load_partial:
>> -	xor %r9, %r9
>> +	xor %r9d, %r9d
>>  	pxor MSG, MSG
>>  
>>  	mov LEN, %r8
>> --- 4.18-rc2/arch/x86/crypto/aesni-intel_asm.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/aesni-intel_asm.S
>> @@ -258,7 +258,7 @@ ALL_F:      .octa 0xffffffffffffffffffff
>>  .macro GCM_INIT Iv SUBKEY AAD AADLEN
>>  	mov \AADLEN, %r11
>>  	mov %r11, AadLen(%arg2) # ctx_data.aad_length = aad_length
>> -	xor %r11, %r11
>> +	xor %r11d, %r11d
>>  	mov %r11, InLen(%arg2) # ctx_data.in_length = 0
>>  	mov %r11, PBlockLen(%arg2) # ctx_data.partial_block_length = 0
>>  	mov %r11, PBlockEncKey(%arg2) # ctx_data.partial_block_enc_key = 0
>> @@ -286,7 +286,7 @@ ALL_F:      .octa 0xffffffffffffffffffff
>>  	movdqu HashKey(%arg2), %xmm13
>>  	add %arg5, InLen(%arg2)
>>  
>> -	xor %r11, %r11 # initialise the data pointer offset as zero
>> +	xor %r11d, %r11d # initialise the data pointer offset as zero
>>  	PARTIAL_BLOCK %arg3 %arg4 %arg5 %r11 %xmm8 \operation
>>  
>>  	sub %r11, %arg5		# sub partial block data used
>> @@ -702,7 +702,7 @@ _no_extra_mask_1_\@:
>>  
>>  	# GHASH computation for the last <16 Byte block
>>  	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
>> -	xor	%rax,%rax
>> +	xor	%eax, %eax
>>  
>>  	mov	%rax, PBlockLen(%arg2)
>>  	jmp	_dec_done_\@
>> @@ -737,7 +737,7 @@ _no_extra_mask_2_\@:
>>  
>>  	# GHASH computation for the last <16 Byte block
>>  	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
>> -	xor	%rax,%rax
>> +	xor	%eax, %eax
>>  
>>  	mov	%rax, PBlockLen(%arg2)
>>  	jmp	_encode_done_\@
>> --- 4.18-rc2/arch/x86/crypto/aesni-intel_avx-x86_64.S
>> +++
>4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/aesni-intel_avx-x86_64.S
>> @@ -463,7 +463,7 @@ _get_AAD_rest_final\@:
>>  
>>  _get_AAD_done\@:
>>  	# initialize the data pointer offset as zero
>> -	xor     %r11, %r11
>> +	xor     %r11d, %r11d
>>  
>>  	# start AES for num_initial_blocks blocks
>>  	mov     arg5, %rax                     # rax = *Y0
>> @@ -1770,7 +1770,7 @@ _get_AAD_rest_final\@:
>>  
>>  _get_AAD_done\@:
>>  	# initialize the data pointer offset as zero
>> -	xor     %r11, %r11
>> +	xor     %r11d, %r11d
>>  
>>  	# start AES for num_initial_blocks blocks
>>  	mov     arg5, %rax                     # rax = *Y0
>> --- 4.18-rc2/arch/x86/crypto/morus1280-avx2-asm.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/morus1280-avx2-asm.S
>> @@ -113,7 +113,7 @@ ENDPROC(__morus1280_update_zero)
>>   *   %r9
>>   */
>>  __load_partial:
>> -	xor %r9, %r9
>> +	xor %r9d, %r9d
>>  	vpxor MSG, MSG, MSG
>>  
>>  	mov %rcx, %r8
>> --- 4.18-rc2/arch/x86/crypto/morus1280-sse2-asm.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/morus1280-sse2-asm.S
>> @@ -235,7 +235,7 @@ ENDPROC(__morus1280_update_zero)
>>   *   %r9
>>   */
>>  __load_partial:
>> -	xor %r9, %r9
>> +	xor %r9d, %r9d
>>  	pxor MSG_LO, MSG_LO
>>  	pxor MSG_HI, MSG_HI
>>  
>> --- 4.18-rc2/arch/x86/crypto/morus640-sse2-asm.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/morus640-sse2-asm.S
>> @@ -113,7 +113,7 @@ ENDPROC(__morus640_update_zero)
>>   *   %r9
>>   */
>>  __load_partial:
>> -	xor %r9, %r9
>> +	xor %r9d, %r9d
>>  	pxor MSG, MSG
>>  
>>  	mov %rcx, %r8
>> --- 4.18-rc2/arch/x86/crypto/sha1_ssse3_asm.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/crypto/sha1_ssse3_asm.S
>> @@ -96,7 +96,7 @@
>>  	# cleanup workspace
>>  	mov	$8, %ecx
>>  	mov	%rsp, %rdi
>> -	xor	%rax, %rax
>> +	xor	%eax, %eax
>>  	rep stosq
>>  
>>  	mov	%rbp, %rsp		# deallocate workspace
>> --- 4.18-rc2/arch/x86/kernel/head_64.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/kernel/head_64.S
>> @@ -235,7 +235,7 @@ ENTRY(secondary_startup_64)
>>  	 *		address given in m16:64.
>>  	 */
>>  	pushq	$.Lafter_lret	# put return address on stack for unwinder
>> -	xorq	%rbp, %rbp	# clear frame pointer
>> +	xorl	%ebp, %ebp	# clear frame pointer
>>  	movq	initial_code(%rip), %rax
>>  	pushq	$__KERNEL_CS	# set correct cs
>>  	pushq	%rax		# target address in negative space
>> --- 4.18-rc2/arch/x86/kernel/paravirt_patch_64.c
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/kernel/paravirt_patch_64.c
>> @@ -20,7 +20,7 @@ DEF_NATIVE(, mov64, "mov %rdi, %rax");
>>  
>>  #if defined(CONFIG_PARAVIRT_SPINLOCKS)
>>  DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%rdi)");
>> -DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %rax, %rax");
>> +DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %eax, %eax");
>>  #endif
>>  
>>  unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
>> --- 4.18-rc2/arch/x86/lib/memcpy_64.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/lib/memcpy_64.S
>> @@ -256,7 +256,7 @@ ENTRY(__memcpy_mcsafe)
>>  
>>  	/* Copy successful. Return zero */
>>  .L_done_memcpy_trap:
>> -	xorq %rax, %rax
>> +	xorl %eax, %eax
>>  	ret
>>  ENDPROC(__memcpy_mcsafe)
>>  EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
>> --- 4.18-rc2/arch/x86/power/hibernate_asm_64.S
>> +++ 4.18-rc2-x86_64-32bit-XOR/arch/x86/power/hibernate_asm_64.S
>> @@ -137,7 +137,7 @@ ENTRY(restore_registers)
>>  	/* Saved in save_processor_state. */
>>  	lgdt	saved_context_gdt_desc(%rax)
>>  
>> -	xorq	%rax, %rax
>> +	xorl	%eax, %eax
>>  
>>  	/* tell the hibernation core that we've just restored the memory */
>>  	movq	%rax, in_suspend(%rip)
>> 
>> 
>> 

Writing the low 32 bits zero-extends the result to 64 bits anyway.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
