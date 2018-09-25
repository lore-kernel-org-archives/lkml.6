Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902DCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B53A20858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B53A20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeIYKth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 06:49:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15829 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeIYKth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 06:49:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42K7kf482fz9ttRd;
        Tue, 25 Sep 2018 06:43:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vmI95uS8uoXu; Tue, 25 Sep 2018 06:43:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42K7kf3cdMz9ttCD;
        Tue, 25 Sep 2018 06:43:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 48B138B7BD;
        Tue, 25 Sep 2018 06:43:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LS5VntNwuMXi; Tue, 25 Sep 2018 06:43:56 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C5C718B762;
        Tue, 25 Sep 2018 06:43:55 +0200 (CEST)
Subject: Re: [PATCH] powerpc/traps: merge unrecoverable_exception() and
 nonrecoverable_exception()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <f49e2e4ff1eacbad161eb6c1645cca7a281dcf3e.1537765881.git.christophe.leroy@c-s.fr>
 <875zyu5pr6.fsf@concordia.ellerman.id.au>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <af93f6f7-b7e7-64a0-b9df-4f1721a567bd@c-s.fr>
Date:   Tue, 25 Sep 2018 06:43:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <875zyu5pr6.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/09/2018 à 03:29, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index 6ab66a88db14..4567eeb6524e 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -2090,8 +2082,9 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
>>    */
>>   void unrecoverable_exception(struct pt_regs *regs)
>>   {
>> -	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
>> -	       regs->trap, regs->nip);
>> +	pr_emerg("Unrecoverable exception %lx at %lx (msr=%lx)\n",
>> +		 regs->trap, regs->nip, regs->msr);
>> +	debugger(regs);
>>   	die("Unrecoverable exception", regs, SIGABRT);
> 
> die() already calls debugger() if the trap is != 0x100.
> 
> I don't think we want to call it twice?

Oh, good spot. So nonrecoverable_exception() is calling it twice.

I'll fix the patch. Thanks.

Christophe
