Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D43C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE3720C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE3720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeIYHVl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 03:21:41 -0400
Received: from ozlabs.org ([203.11.71.1]:57341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbeIYHVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 03:21:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42K37Z3vmDz9s7T;
        Tue, 25 Sep 2018 11:16:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to define some additional KBUILD_CFLAGS after building include/generated/asm-offsets.h ?
In-Reply-To: <56227965-464a-d972-1c25-d6a4d190e1a1@c-s.fr>
References: <e1b65467-7497-5db4-aa93-1ad00d12af3f@c-s.fr> <87mus75c5m.fsf@concordia.ellerman.id.au> <56227965-464a-d972-1c25-d6a4d190e1a1@c-s.fr>
Date:   Tue, 25 Sep 2018 11:16:39 +1000
Message-ID: <87bm8m5qbs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 24/09/2018 à 14:10, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> 
>>> I'm trying to implement TLS based stack protector in the Linux Kernel.
>>> For that I need to give to GCC the offset at which it will find the
>>> canary (register r2 is pointing to the current task struct).
>>>
>>> I have been able to do it with the below patch, but it only works when
>>> include/generated/asm-offsets.h already exists from the start of the build.
>>>
>>> Is there a way to evaluate CANARY_OFFSET and add the stack-protector
>>> flags to KBUILD_FLAGS only after include/generated/asm-offsets.h is built ?
>>>
>>> Or another way of add -mstack-protector-guard-offset=offsetof(struct
>>> task_struct, stack_canary) ?
>> 
>> This seems to work, at least I see the value in CFLAGS:
>> 
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 07d9dce..39ee113 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -404,6 +394,11 @@ archclean:
>>   
>>   archprepare: checkbin
>>   
>> +prepare: stack_protector_prepare
>> +
>> +stack_protector_prepare: prepare0
>> +	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' include/generated/asm-offsets.h))
>> +
>
> Great, it works !
> Thanks, I have sent v3 of the patches.

Cool.

It would be good to here from someone who knows Kbuild better than me if
this is acceptable or just a gross hack :)

cheers
