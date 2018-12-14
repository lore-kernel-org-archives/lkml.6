Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F61C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2D62080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2D62080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeLNIBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:01:54 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:47965 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbeLNIBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:01:54 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43GNL74xnwz9vGy9;
        Fri, 14 Dec 2018 09:01:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1YohcOmq4HKZ; Fri, 14 Dec 2018 09:01:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43GNL74CS4z9vGy8;
        Fri, 14 Dec 2018 09:01:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 88AF98B89E;
        Fri, 14 Dec 2018 09:01:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gaXjU-IdF9US; Fri, 14 Dec 2018 09:01:52 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 48D898B89B;
        Fri, 14 Dec 2018 09:01:52 +0100 (CET)
Subject: Re: [PATCH] powerpc/mm: make NULL pointer deferences explicit on bad
 page faults.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <42e7e2e9b74af526523fb5a1451fdb29cfe2687a.1539060806.git.christophe.leroy@c-s.fr>
 <87zht9udqh.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <276439ce-aad9-e72f-7bc9-c57fb4a59339@c-s.fr>
Date:   Fri, 14 Dec 2018 09:01:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <87zht9udqh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Le 14/12/2018 à 01:57, Michael Ellerman a écrit :
> Hi Christophe,
> 
> You know it's the trivial patches that are going to get lots of review
> comments :)

I'm so happy to get comments.

> 
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> As several other arches including x86, this patch makes it explicit
>> that a bad page fault is a NULL pointer dereference when the fault
>> address is lower than PAGE_SIZE
> 
> I'm being pedantic, but it's not necessarily a NULL pointer dereference.
> It might just be a direct access to a low address, eg:
> 
>   char *p = 0x100;
>   *p = 0;
> 
> That's not a NULL pointer dereference.
> 
> But other arches do print this so I guess it's OK to add, and in most
> cases it will be an actual NULL pointer dereference.
> 
> I wonder though if we should use 4096 rather than PAGE_SIZE, given
> that's the actual value other arches are using. We support 256K pages on
> some systems, which is getting quite large.

Those invalid accesses are catched because the first page is marked non 
present or non accessible in the page table, so I thing using PAGE_SIZE 
here is valid regardless of the page size.

Looks like the arches have PAGE_SHIFT ranging from 12 to 16 mainly.

> 
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index d51cf5f4e45e..501a1eadb3e9 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -631,13 +631,16 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>>   	switch (TRAP(regs)) {
>>   	case 0x300:
>>   	case 0x380:
>> -		printk(KERN_ALERT "Unable to handle kernel paging request for "
>> -			"data at address 0x%08lx\n", regs->dar);
>> +		pr_alert("Unable to handle kernel %s for data at address 0x%08lx\n",
>> +			 regs->dar < PAGE_SIZE ? "NULL pointer dereference" :
>> +						 "paging request",
>> +			 regs->dar);
> 
> This is now too long I think, with printk time you get:
> 
> [ 1096.450711] Unable to handle kernel NULL pointer dereference for data at address 0x00000000
> 
> Which is 93 columns. It's true on many systems it doesn't really matter
> any more, but it would still be good if it was shorter.
> 
> I like that on x86 they prefix it with "BUG:", just to avoid any confusion.
> 
> What if we had for the NULL pointer case:
> 
>    BUG: Kernel NULL pointer dereference at 0x00000000
> 
> And for the normal case:
> 
>    BUG: Unable to handle kernel data access at 0x00000000
> 
> Note on the very next line we print:
>    Faulting instruction address: 0xc000000000795cc8
> 
> So there should be no confusion about whether "at" refers to the data
> address or the instruction address.

Agreed

> 
>>   	case 0x400:
>>   	case 0x480:
>> -		printk(KERN_ALERT "Unable to handle kernel paging request for "
>> -			"instruction fetch\n");
>> +		pr_alert("Unable to handle kernel %s for instruction fetch\n",
>> +			 regs->nip < PAGE_SIZE ? "NULL pointer dereference" :
>> +						 "paging request");
> 
> I don't really like using "NULL pointer dereference" here, that
> terminology makes me think of a load/store, I think it confuses things
> rather than making it clearer.
> 
> What about:
> 
>    BUG: Unable to handle kernel instruction fetch at 0x00000000

I think we still need to make it explicit that we jumped there due to a 
NULL function pointer, allthought I don't have a good text idea yet for 
this.

> 
> 
>>   		break;
>>   	case 0x600:
>>   		printk(KERN_ALERT "Unable to handle kernel paging request for "
> 
> It would be good to clean up these other cases as well. They seem to be
> trying to use the "page request for" terminology which leads to them
> being very wordy. I assume that was done to help people grepping kernel
> logs for errors, but I think we should not worry about that if we have
> the "BUG:" prefix.
> 
> So we have:
> 	printk(KERN_ALERT "Unable to handle kernel paging request for "
> 		"unaligned access at address 0x%08lx\n", regs->dar);
> 
> What about:
> 
>    BUG: Unable to handle kernel unaligned access at 0x00000000
> 
> And:
> 	printk(KERN_ALERT "Unable to handle kernel paging request for "
> 		"unknown fault\n");
> 
> What about:
> 
>    BUG: Unable to handle unknown paging fault at 0x00000000
> 
> 
> Thoughts?

Looks like good ideas I'll carry on.

Christophe
