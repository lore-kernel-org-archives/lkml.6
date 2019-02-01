Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE2C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE05D2080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Vsoa1d71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfBALv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:51:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:50103 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfBALv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:51:58 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43rb6z3401z9vBmk;
        Fri,  1 Feb 2019 12:51:55 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Vsoa1d71; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hknQnW1A91Aj; Fri,  1 Feb 2019 12:51:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43rb6z1xM6z9vBmj;
        Fri,  1 Feb 2019 12:51:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1549021915; bh=AQdm0SAN8POWrrhA7gzanUbOnIfWVD05TOtjD1Agyiw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vsoa1d714TzPITzTkx4Fu2zTG3OeciFSuZOT5dIZEqTakVfBDcwR0xz42XNvQVlO5
         ExVLqBEDcXk1ke40HtgBC8lrsKGUzDMVi3xFS5/Woo5yhsGxPETdBpPWm52eIFRpGf
         ep7NM4Hd38++6oGNzHqRardYw62BZGt6Nf5nW+nA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C1F58B84E;
        Fri,  1 Feb 2019 12:51:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7XAj5VH-DjPq; Fri,  1 Feb 2019 12:51:56 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4527C8B75B;
        Fri,  1 Feb 2019 12:51:56 +0100 (CET)
Subject: Re: [RFC PATCH] powerpc/6xx: Don't set back MSR_RI before reenabling
 MMU
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <9f9dd859d571e324c7412ed9db9da8cfba678257.1548956511.git.christophe.leroy@c-s.fr>
 <87lg2zojbt.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <17b00097-a807-e9b9-3dce-198df4a3153f@c-s.fr>
Date:   Fri, 1 Feb 2019 12:51:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87lg2zojbt.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/02/2019 à 12:10, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> By delaying the setting of MSR_RI, a 1% improvment is optained on
>> null_syscall selftest on an mpc8321.
>>
>> Without this patch:
>>
>> root@vgoippro:~# ./null_syscall
>>     1134.33 ns     378.11 cycles
>>
>> With this patch:
>>
>> root@vgoippro:~# ./null_syscall
>>     1121.85 ns     373.95 cycles
>>
>> The drawback is that a machine check during that period
>> would be unrecoverable, but as only main memory is accessed
>> during that period, it shouldn't be a concern.
> 
> On 64-bit server CPUs accessing main memory can cause a UE
> (Uncorrectable Error) which can trigger a machine check.
> 
> So it may still be a concern, it depends how paranoid you are.
> 
>> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
>> index 146385b1c2da..ea28a6ab56ec 100644
>> --- a/arch/powerpc/kernel/head_32.S
>> +++ b/arch/powerpc/kernel/head_32.S
>> @@ -282,8 +282,6 @@ __secondary_hold_acknowledge:
>>   	stw	r1,GPR1(r11);	\
>>   	stw	r1,0(r11);	\
>>   	tovirt(r1,r11);			/* set new kernel sp */	\
>> -	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
>> -	MTMSRD(r10);			/* (except for mach check in rtas) */ \
>>   	stw	r0,GPR0(r11);	\
>>   	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
>>   	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \
> 
> Where does RI get enabled? I don't see it anywhere obvious.

MSR_RI is part of MSR_KERNEL, it gets then enabled when reenabling MMU 
when calling the exception handler.

#define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
	li	r10,trap;					\
	stw	r10,_TRAP(r11);					\
	li	r10,MSR_KERNEL;					\
	copyee(r10, r9);					\
	bl	tfer;						\
i##n:								\
	.long	hdlr;						\
	.long	ret

where tfer = transfer_to_handler.

In transfer_to_handler (kernel/entry_32.S) you have:

transfer_to_handler_cont:
3:
	mflr	r9
	lwz	r11,0(r9)		/* virtual address of handler */
	lwz	r9,4(r9)		/* where to go when done */
[...]
	mtspr	SPRN_SRR0,r11
	mtspr	SPRN_SRR1,r10
	mtlr	r9
	SYNC
	RFI				/* jump to handler, enable MMU */

So MSR_RI is restored above as r10 contains MSR_KERNEL [ | MSR_EE ]

Christophe



> 
> cheers
> 
