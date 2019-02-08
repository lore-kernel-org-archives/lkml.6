Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7875C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67132075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="CzKJG6bY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfBHOp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:45:27 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:16935 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfBHOp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:45:26 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43wydv6YFqz9vBwn;
        Fri,  8 Feb 2019 15:45:23 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=CzKJG6bY; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KD9FMYnZ-oyF; Fri,  8 Feb 2019 15:45:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43wydv5KkKz9vBwh;
        Fri,  8 Feb 2019 15:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1549637123; bh=d5PWnsdPM5wgI4M7ih3NLnPyFXxb9YRXbhgm4kKijSY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=CzKJG6bYOLIRneoA1WKNRJstKVOdaRkHqQI9esKKtQ8nmJRNPYf02s5yqp+C7Pm4l
         XZBmAzn2wRSpa45zPQh1jzk2CUgGNE/qPbW6xmmHyJhvAe0fYRbY7kQF76+dHNal26
         egizO4ojSVj49ACmB4xV9zdDJGKzCb0zqZODhego=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32EED8B8DA;
        Fri,  8 Feb 2019 15:45:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MTrFTS-xsBMo; Fri,  8 Feb 2019 15:45:25 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D8E0E8B756;
        Fri,  8 Feb 2019 15:45:24 +0100 (CET)
Subject: Re: [PATCH] powerpc: fix 32-bit KVM-PR lockup and panic with MacOS
 guest
To:     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
References: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <41b02fb0-cdc6-6de0-d8fc-44d3d0a8ad70@c-s.fr>
Date:   Fri, 8 Feb 2019 15:45:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/02/2019 à 15:33, Mark Cave-Ayland a écrit :
> Commit 8792468da5e1 "powerpc: Add the ability to save FPU without giving it up"

Expected format for the above is:

Commit 123456789abc ("text")

> unexpectedly removed the MSR_FE0 and MSR_FE1 bits from the bitmask used to
> update the MSR of the previous thread in __giveup_fpu() causing a KVM-PR MacOS
> guest to lockup and panic the kernel.
> 
> Reinstate these bits to the MSR bitmask to enable MacOS guests to run under
> 32-bit KVM-PR once again without issue.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Should include a Fixes: and a Cc to stable ?

Fixes: 8792468da5e1 ("powerpc: Add the ability to save FPU without 
giving it up")
Cc: stable@vger.kernel.org

Christophe

> ---
>   arch/powerpc/kernel/process.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index ce393df243aa..71bad4b6f80d 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -176,7 +176,7 @@ static void __giveup_fpu(struct task_struct *tsk)
>   
>   	save_fpu(tsk);
>   	msr = tsk->thread.regs->msr;
> -	msr &= ~MSR_FP;
> +	msr &= ~(MSR_FP|MSR_FE0|MSR_FE1);
>   #ifdef CONFIG_VSX
>   	if (cpu_has_feature(CPU_FTR_VSX))
>   		msr &= ~MSR_VSX;
> 
