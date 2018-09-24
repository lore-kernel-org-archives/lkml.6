Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A002C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA802086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA802086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeIXV3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:29:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35751 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbeIXV3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:29:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42Jp2L73r7z9ttFK;
        Mon, 24 Sep 2018 17:26:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8AcFpZkQvBz5; Mon, 24 Sep 2018 17:26:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42Jp2L6T6xz9ttCT;
        Mon, 24 Sep 2018 17:26:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B29278B7B6;
        Mon, 24 Sep 2018 17:26:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TI8r2am50Z6R; Mon, 24 Sep 2018 17:26:19 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 796D48B7B2;
        Mon, 24 Sep 2018 17:26:19 +0200 (CEST)
Subject: Re: How to define some additional KBUILD_CFLAGS after building
 include/generated/asm-offsets.h ?
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <e1b65467-7497-5db4-aa93-1ad00d12af3f@c-s.fr>
 <87mus75c5m.fsf@concordia.ellerman.id.au>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <56227965-464a-d972-1c25-d6a4d190e1a1@c-s.fr>
Date:   Mon, 24 Sep 2018 17:26:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87mus75c5m.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/09/2018 à 14:10, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> I'm trying to implement TLS based stack protector in the Linux Kernel.
>> For that I need to give to GCC the offset at which it will find the
>> canary (register r2 is pointing to the current task struct).
>>
>> I have been able to do it with the below patch, but it only works when
>> include/generated/asm-offsets.h already exists from the start of the build.
>>
>> Is there a way to evaluate CANARY_OFFSET and add the stack-protector
>> flags to KBUILD_FLAGS only after include/generated/asm-offsets.h is built ?
>>
>> Or another way of add -mstack-protector-guard-offset=offsetof(struct
>> task_struct, stack_canary) ?
> 
> This seems to work, at least I see the value in CFLAGS:
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 07d9dce..39ee113 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -404,6 +394,11 @@ archclean:
>   
>   archprepare: checkbin
>   
> +prepare: stack_protector_prepare
> +
> +stack_protector_prepare: prepare0
> +	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' include/generated/asm-offsets.h))
> +

Great, it works !
Thanks, I have sent v3 of the patches.

Christophe

>   # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
>   # to stdout and these checks are run even on install targets.
>   TOUT	:= .tmp_gas_check
> 
> 
> cheers
> 
