Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6546CECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAE02150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAE02150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbeISUBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:01:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2379 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbeISUBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:01:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42FhsS3XB8z9ttmK;
        Wed, 19 Sep 2018 16:22:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id f0996QYE8DBI; Wed, 19 Sep 2018 16:22:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42FhsS2pKYz9ttmG;
        Wed, 19 Sep 2018 16:22:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CFF788B83E;
        Wed, 19 Sep 2018 16:22:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6FvprEiBv-hB; Wed, 19 Sep 2018 16:22:52 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 956E28B83B;
        Wed, 19 Sep 2018 16:22:52 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] powerpc/32: add stack protector support
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
 <ef8fcc7933d56db6f5f7251cb982ca7131f7408d.1537355312.git.christophe.leroy@c-s.fr>
 <20180919132618.GX23155@gate.crashing.org>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3f5d1937-393c-1105-30a0-72d568a1c190@c-s.fr>
Date:   Wed, 19 Sep 2018 16:22:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919132618.GX23155@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/09/2018 à 15:26, Segher Boessenkool a écrit :
> On Wed, Sep 19, 2018 at 11:14:45AM +0000, Christophe Leroy wrote:
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -112,6 +112,10 @@ KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
>>   KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
>>   endif
>>   
>> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
>> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
>> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-offset=4
> 
> This last line is only correct if !CONFIG_THREAD_INFO_IN_TASK; is that
> always true?  Add an assert somewhere maybe?

At the time being powerpc doesn't select CONFIG_THREAD_INFO_IN_TASK.

A BUILD_BUG_ON() is added in stackprotector.h

> 
>> +	/*
>> +	 * The stack_canary must be located at the offset given to
>> +	 * -mstack-protector-guard-offset in the Makefile
>> +	 */
>> +	BUILD_BUG_ON(offsetof(struct task_struct, stack_canary) != sizeof(long));
> 
> Well this will help :-)
> 
> It looks like it will be easy to enable on 64 bit as well.

Will it ? It seems that PPC64 doesn't have r2 pointing to current task 
struct, but instead it has r13 pointing to the paca struct. Which means 
we should add a canary in the paca struct, and populate it at task 
switch from current->stack_canary. Or am I missing something ?

> 
>> +	/* Try to get a semi random initial value. */
>> +	get_random_bytes(&canary, sizeof(canary));
>> +	canary ^= mftb();
>> +	canary ^= LINUX_VERSION_CODE;
> 
> These last two lines are useless (or worse, they may give people the idea
> that they are not!)

Well, the last line is in all arches except x86
The mftb() was suggested by Michael to add some entropy.
x86 does the same sort of thing with their rdtsc()

> 
> You should use wait_for_random_bytes I think.

On the 8xx, it takes several minutes before crnd_is_ready(), while 
boot_init_stack_canary() is called quite early in start_kernel()

Christophe
