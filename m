Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D7EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626F421900
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfBALKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:10:37 -0500
Received: from ozlabs.org ([203.11.71.1]:36517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfBALKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:10:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rZCG05wgz9s4Z;
        Fri,  1 Feb 2019 22:10:33 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/6xx: Don't set back MSR_RI before reenabling MMU
In-Reply-To: <9f9dd859d571e324c7412ed9db9da8cfba678257.1548956511.git.christophe.leroy@c-s.fr>
References: <9f9dd859d571e324c7412ed9db9da8cfba678257.1548956511.git.christophe.leroy@c-s.fr>
Date:   Fri, 01 Feb 2019 22:10:30 +1100
Message-ID: <87lg2zojbt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> By delaying the setting of MSR_RI, a 1% improvment is optained on
> null_syscall selftest on an mpc8321.
>
> Without this patch:
>
> root@vgoippro:~# ./null_syscall
>    1134.33 ns     378.11 cycles
>
> With this patch:
>
> root@vgoippro:~# ./null_syscall
>    1121.85 ns     373.95 cycles
>
> The drawback is that a machine check during that period
> would be unrecoverable, but as only main memory is accessed
> during that period, it shouldn't be a concern.

On 64-bit server CPUs accessing main memory can cause a UE
(Uncorrectable Error) which can trigger a machine check.

So it may still be a concern, it depends how paranoid you are.

> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index 146385b1c2da..ea28a6ab56ec 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -282,8 +282,6 @@ __secondary_hold_acknowledge:
>  	stw	r1,GPR1(r11);	\
>  	stw	r1,0(r11);	\
>  	tovirt(r1,r11);			/* set new kernel sp */	\
> -	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
> -	MTMSRD(r10);			/* (except for mach check in rtas) */ \
>  	stw	r0,GPR0(r11);	\
>  	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
>  	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \

Where does RI get enabled? I don't see it anywhere obvious.

cheers
