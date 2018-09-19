Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCF9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C551E2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C551E2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbeISSCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:02:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49253 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeISSCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:02:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42FfFS5zm4z9ttRg;
        Wed, 19 Sep 2018 14:25:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fZeWn7oN4xNJ; Wed, 19 Sep 2018 14:25:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42FfFS5PsQz9ttRZ;
        Wed, 19 Sep 2018 14:25:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2278A8B834;
        Wed, 19 Sep 2018 14:25:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AYONQQpVPqbs; Wed, 19 Sep 2018 14:25:01 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE4B98B833;
        Wed, 19 Sep 2018 14:25:00 +0200 (CEST)
Subject: Re: [PATCH v2 1/2] sched: move stack_canary field at the top of
 task_struct
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>, segher@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
 <20180919115836.GE24124@hirez.programming.kicks-ass.net>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f6a36d25-ce19-5d56-69d9-198215a7b9e1@c-s.fr>
Date:   Wed, 19 Sep 2018 14:25:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919115836.GE24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/09/2018 à 13:58, Peter Zijlstra a écrit :
> On Wed, Sep 19, 2018 at 11:14:43AM +0000, Christophe Leroy wrote:
>> In order to allow the use of non global stack protector canary,
>> the stack canary needs to be located at a know offset defined
>> in Makefile via -mstack-protector-guard-offset.
>>
>> On powerpc/32, register r2 points to current task_struct at
>> all time, the stack_canary located inside task_struct can be
>> used directly if it is located in a known place.
>>
>> In order to allow that, this patch moves the stack_canary field
>> out of the randomized area of task_struct.
> 
> And you cannot use something like asm-offsets to extract this?

I have not been able to find a way to define the compilation flags AFTER 
building asm-offsets.h, see https://patchwork.ozlabs.org/patch/971521/

If you have a suggestion, it is welcomed.

> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   include/linux/sched.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 977cb57d7bc9..1d977b8a4bac 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -601,6 +601,10 @@ struct task_struct {
>>   	/* -1 unrunnable, 0 runnable, >0 stopped: */
>>   	volatile long			state;
>>   
>> +#ifdef CONFIG_STACKPROTECTOR
>> +	/* Canary value for the -fstack-protector GCC feature: */
>> +	unsigned long			stack_canary;
>> +#endif
>>   	/*
>>   	 * This begins the randomizable portion of task_struct. Only
>>   	 * scheduling-critical items should be added above here.
> 
> Might as well put it before state, right after the task_info thing.
> 

Yes, it doesn't make much difference, don't any arch expect state at 
offset 0 ?

Christophe
