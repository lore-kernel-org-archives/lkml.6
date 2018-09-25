Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F2AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EAF20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EAF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeIYMjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:39:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55170 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeIYMjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:39:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KB9B63p1z9ttRd;
        Tue, 25 Sep 2018 08:33:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id numpY-TJepTf; Tue, 25 Sep 2018 08:33:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KB9B5WH7z9ttC6;
        Tue, 25 Sep 2018 08:33:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B2E618B7C4;
        Tue, 25 Sep 2018 08:33:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cqTOrktU5wMB; Tue, 25 Sep 2018 08:33:36 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B651E8B762;
        Tue, 25 Sep 2018 08:33:35 +0200 (CEST)
Subject: Re: [RFC PATCH v1 1/9] timer: fix circular header dependency
From:   Christophe LEROY <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <cover.1537802981.git.christophe.leroy@c-s.fr>
 <72d3e8c38f729dc22cb3235319b72f96190e01ee.1537802981.git.christophe.leroy@c-s.fr>
 <5c9530da-f5c8-e0b2-61ab-294a0da7f3fc@c-s.fr>
Message-ID: <9bff645b-4e00-ab0f-288a-a17f1e45ecdd@c-s.fr>
Date:   Tue, 25 Sep 2018 08:33:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5c9530da-f5c8-e0b2-61ab-294a0da7f3fc@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/09/2018 à 07:34, Christophe LEROY a écrit :
> 
> 
> Le 24/09/2018 à 17:52, Christophe Leroy a écrit :
>> When switching powerpc to CONFIG_THREAD_INFO_IN_TASK, include/sched.h
>> has to be included in asm/smp.h for the following change, in order
>> to avoid uncomplete definition of task_struct:
>>
>> -#define raw_smp_processor_id() (current_thread_info()->cpu)
>> +#define raw_smp_processor_id() (current->cpu)
>>
>> But this generates the following compilation error, due to circular
>> header dependency.
>>
>>    CC      kernel/time/alarmtimer.o
>> In file included from ./arch/powerpc/include/asm/smp.h:31,
>>                   from ./include/linux/smp.h:64,
>>                   from ./include/linux/percpu.h:7,
>>                   from ./include/linux/hrtimer.h:22,
>>                   from kernel/time/alarmtimer.c:19:
>> ./include/linux/sched.h:558:19: error: field 'dl_timer' has incomplete 
>> type
>>    struct hrtimer   dl_timer;
>>                     ^~~~~~~~
>> ./include/linux/sched.h:567:17: error: field 'inactive_timer' has 
>> incomplete type
>>    struct hrtimer inactive_timer;
>>                   ^~~~~~~~~~~~~~
>> make[1]: *** [kernel/time/alarmtimer.o] Error 1
>> make: *** [kernel/time/alarmtimer.o] Error 2
>>
>>    CC      fs/timerfd.o
>> In file included from ./arch/powerpc/include/asm/smp.h:31,
>>                   from ./include/linux/smp.h:64,
>>                   from ./include/linux/percpu.h:7,
>>                   from ./include/linux/hrtimer.h:22,
>>                   from ./include/linux/alarmtimer.h:6,
>>                   from fs/timerfd.c:12:
>> ./include/linux/sched.h:558:19: error: field 'dl_timer' has incomplete 
>> type
>>    struct hrtimer   dl_timer;
>>                     ^~~~~~~~
>> ./include/linux/sched.h:567:17: error: field 'inactive_timer' has 
>> incomplete type
>>    struct hrtimer inactive_timer;
>>                   ^~~~~~~~~~~~~~
>> make[1]: *** [fs/timerfd.o] Error 1
>> make: *** [fs/timerfd.o] Error 2
>>
>> This patch fixes it by including linux/hrtimer.h after linux/sched.h
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   Should it be fixed in powerpc instead ? In that case, how ? Any idea ?
> 
> 
> Looks like there are several other places where the problem occurs, so 
> it has to be fixed in the powerpc headers instead.
> 
> Seems like RISC arch faced the same issue, and fixed it the following way:
> 
> /*
>   * This is particularly ugly: it appears we can't actually get the 
> definition
>   * of task_struct here, but we need access to the CPU this task is 
> running on.
>   * Instead of using C we're using asm-offsets.h to get the current 
> processor
>   * ID.
>   */
> #define raw_smp_processor_id() (*((int*)((char*)get_current() + 
> TASK_TI_CPU)))
> 
> 
> Unless someone has a better idea, I'll fixed it that way.


Not easy. I'm stuck at the moment, because asm-offsets.h redefines a lot 
of things with the same name as in C, so when including asm-offsets.h in 
C it conflicts. Argh !. Need to fix all those duplicates ?

Christophe

> 
> Christophe
> 
> 
>>
>>   fs/timerfd.c             | 2 +-
>>   kernel/time/alarmtimer.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/timerfd.c b/fs/timerfd.c
>> index d69ad801eb80..0fc01b241382 100644
>> --- a/fs/timerfd.c
>> +++ b/fs/timerfd.c
>> @@ -9,12 +9,12 @@
>>    *
>>    */
>> -#include <linux/alarmtimer.h>
>>   #include <linux/file.h>
>>   #include <linux/poll.h>
>>   #include <linux/init.h>
>>   #include <linux/fs.h>
>>   #include <linux/sched.h>
>> +#include <linux/alarmtimer.h>
>>   #include <linux/kernel.h>
>>   #include <linux/slab.h>
>>   #include <linux/list.h>
>> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
>> index fa5de5e8de61..5fb75c9b3f06 100644
>> --- a/kernel/time/alarmtimer.c
>> +++ b/kernel/time/alarmtimer.c
>> @@ -16,11 +16,11 @@
>>    * published by the Free Software Foundation.
>>    */
>>   #include <linux/time.h>
>> -#include <linux/hrtimer.h>
>>   #include <linux/timerqueue.h>
>>   #include <linux/rtc.h>
>>   #include <linux/sched/signal.h>
>>   #include <linux/sched/debug.h>
>> +#include <linux/hrtimer.h>
>>   #include <linux/alarmtimer.h>
>>   #include <linux/mutex.h>
>>   #include <linux/platform_device.h>
>>
