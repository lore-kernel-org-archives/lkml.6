Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B38C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C96B20858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C96B20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeIYX5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:57:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30617 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeIYX5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:57:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KT8D5g13z9ttCY;
        Tue, 25 Sep 2018 19:48:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id irY6Hb3lUZIm; Tue, 25 Sep 2018 19:48:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KT8D4sD1z9ttCN;
        Tue, 25 Sep 2018 19:48:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB9558B7E5;
        Tue, 25 Sep 2018 19:48:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id smCj-dtNUMhJ; Tue, 25 Sep 2018 19:48:44 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E46A8B7C8;
        Tue, 25 Sep 2018 19:48:44 +0200 (CEST)
Subject: Re: [RFC PATCH v1 1/9] timer: fix circular header dependency
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, Paul Mackerras <paulus@samba.org>,
        aneesh.kumar@linux.vnet.ibm.com, linux-fsdevel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1537802981.git.christophe.leroy@c-s.fr>
 <72d3e8c38f729dc22cb3235319b72f96190e01ee.1537802981.git.christophe.leroy@c-s.fr>
 <5c9530da-f5c8-e0b2-61ab-294a0da7f3fc@c-s.fr>
 <20180925121104.zrz4m45sbnt5h2ht@lakrids.cambridge.arm.com>
 <d22dc0e6-13ff-2abe-6536-a7b14bb285db@c-s.fr>
Message-ID: <136be8d9-54e5-d609-41ea-f27ef87c8f3b@c-s.fr>
Date:   Tue, 25 Sep 2018 17:48:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d22dc0e6-13ff-2abe-6536-a7b14bb285db@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/25/2018 12:15 PM, Christophe LEROY wrote:
> 
> 
> Le 25/09/2018 à 14:11, Mark Rutland a écrit :
>> On Tue, Sep 25, 2018 at 07:34:15AM +0200, Christophe LEROY wrote:
>>>
>>>
>>> Le 24/09/2018 à 17:52, Christophe Leroy a écrit :
>>>> When switching powerpc to CONFIG_THREAD_INFO_IN_TASK, include/sched.h
>>>> has to be included in asm/smp.h for the following change, in order
>>>> to avoid uncomplete definition of task_struct:
>>>>
>>>> -#define raw_smp_processor_id() (current_thread_info()->cpu)
>>>> +#define raw_smp_processor_id() (current->cpu)
>>>>
>>>> But this generates the following compilation error, due to circular
>>>> header dependency.
>>>>
>>>>     CC      kernel/time/alarmtimer.o
>>>> In file included from ./arch/powerpc/include/asm/smp.h:31,
>>>>                    from ./include/linux/smp.h:64,
>>>>                    from ./include/linux/percpu.h:7,
>>>>                    from ./include/linux/hrtimer.h:22,
>>>>                    from kernel/time/alarmtimer.c:19:
>>>> ./include/linux/sched.h:558:19: error: field 'dl_timer' has 
>>>> incomplete type
>>>>     struct hrtimer   dl_timer;
>>>>                      ^~~~~~~~
>>>> ./include/linux/sched.h:567:17: error: field 'inactive_timer' has 
>>>> incomplete type
>>>>     struct hrtimer inactive_timer;
>>>>                    ^~~~~~~~~~~~~~
>>>> make[1]: *** [kernel/time/alarmtimer.o] Error 1
>>>> make: *** [kernel/time/alarmtimer.o] Error 2
>>>>
>>>>     CC      fs/timerfd.o
>>>> In file included from ./arch/powerpc/include/asm/smp.h:31,
>>>>                    from ./include/linux/smp.h:64,
>>>>                    from ./include/linux/percpu.h:7,
>>>>                    from ./include/linux/hrtimer.h:22,
>>>>                    from ./include/linux/alarmtimer.h:6,
>>>>                    from fs/timerfd.c:12:
>>>> ./include/linux/sched.h:558:19: error: field 'dl_timer' has 
>>>> incomplete type
>>>>     struct hrtimer   dl_timer;
>>>>                      ^~~~~~~~
>>>> ./include/linux/sched.h:567:17: error: field 'inactive_timer' has 
>>>> incomplete type
>>>>     struct hrtimer inactive_timer;
>>>>                    ^~~~~~~~~~~~~~
>>>> make[1]: *** [fs/timerfd.o] Error 1
>>>> make: *** [fs/timerfd.o] Error 2
>>>>
>>>> This patch fixes it by including linux/hrtimer.h after linux/sched.h
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> ---
>>>>    Should it be fixed in powerpc instead ? In that case, how ? Any 
>>>> idea ?
>>>
>>>
>>> Looks like there are several other places where the problem occurs, 
>>> so it
>>> has to be fixed in the powerpc headers instead.
>>>
>>> Seems like RISC arch faced the same issue, and fixed it the following 
>>> way:
>>>
>>> /*
>>>   * This is particularly ugly: it appears we can't actually get the
>>> definition
>>>   * of task_struct here, but we need access to the CPU this task is 
>>> running
>>> on.
>>>   * Instead of using C we're using asm-offsets.h to get the current 
>>> processor
>>>   * ID.
>>>   */
>>> #define raw_smp_processor_id() (*((int*)((char*)get_current() +
>>> TASK_TI_CPU)))
>>>
>>>
>>> Unless someone has a better idea, I'll fixed it that way.
>>
>> To solve this on arm64 we made the cpu number a percpu variable; see
>> commit:
>>
>>    57c82954e77fa12c ("arm64: make cpu number a percpu variable")
> 
> Thanks, I'll have a look
> 
>> IIUC, you could do that by placing it in paca_struct.
> 
> By the way, it is already in PACA struct for PPC64.
> The issue is with PPC32, up to now it was in current_thread_info:
> 
> #ifdef CONFIG_PPC64
> #define raw_smp_processor_id()    (local_paca->paca_index)
> #define hard_smp_processor_id() (get_paca()->hw_cpu_id)
> #else
> /* 32-bit */
> extern int smp_hw_index[];
> 
> #define raw_smp_processor_id()    (current_thread_info()->cpu)
> #define hard_smp_processor_id()     (smp_hw_index[smp_processor_id()])
> 
> [..]
> 
> #endif
> 

It seems not that easy. Adding the following leads to the below failure. 
I'm having a hard time identifying and fixing the issue. Looks again 
like a circular thing, because linux/percpu-defs.h is where 
raw_cpu_ptr() is defined.

--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -83,7 +83,14 @@ int is_cpu_dead(unsigned int cpu);
  /* 32-bit */
  extern int smp_hw_index[];

-#define raw_smp_processor_id() (current_thread_info()->cpu)
+DECLARE_PER_CPU_READ_MOSTLY(unsigned int, cpu_number);
+
+/*
+ * We don't use this_cpu_read(cpu_number) as that has implicit writes to
+ * preempt_count, and associated (compiler) barriers, that we'd like to 
avoid
+ * the expense of. If we're preemptible, the value can be stale at use 
anyway.
+ */
+#define raw_smp_processor_id()         (*this_cpu_ptr(&cpu_number))
  #define hard_smp_processor_id()        (smp_hw_index[smp_processor_id()])

  static inline int get_hard_smp_processor_id(int cpu)


   CC      arch/powerpc/kernel/asm-offsets.s
In file included from ././include/linux/compiler_types.h:64:0,
                  from <command-line>:0:
./include/linux/percpu-rwsem.h: In function 
'percpu_down_read_preempt_disable':
./include/linux/percpu-defs.h:254:27: error: implicit declaration of 
function 'raw_cpu_ptr' [-Werror=implicit-function-declaration]
  #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
                            ^
./include/linux/compiler-gcc.h:58:26: note: in definition of macro 
'RELOC_HIDE'
   (typeof(ptr)) (__ptr + (off));     \
                           ^
./include/asm-generic/percpu.h:44:31: note: in expansion of macro 
'SHIFT_PERCPU_PTR'
  #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
                                ^
./include/asm-generic/percpu.h:31:25: note: in expansion of macro 
'per_cpu_offset'
  #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
                          ^
./arch/powerpc/include/asm/smp.h:93:35: note: in expansion of macro 
'this_cpu_ptr'
  #define raw_smp_processor_id()  (*this_cpu_ptr(&cpu_number))
                                    ^
./include/asm-generic/percpu.h:31:40: note: in expansion of macro 
'raw_smp_processor_id'
  #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
                                         ^
./include/asm-generic/percpu.h:44:53: note: in expansion of macro 
'__my_cpu_offset'
  #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
                                                      ^
./include/linux/percpu-defs.h:244:2: note: in expansion of macro 
'arch_raw_cpu_ptr'
   arch_raw_cpu_ptr(ptr);      \
   ^
./include/asm-generic/percpu.h:76:3: note: in expansion of macro 
'raw_cpu_ptr'
   *raw_cpu_ptr(&(pcp)) op val;     \
    ^
./include/asm-generic/percpu.h:225:34: note: in expansion of macro 
'raw_cpu_generic_to_op'
  #define raw_cpu_add_1(pcp, val)  raw_cpu_generic_to_op(pcp, val, +=)
                                   ^
./include/linux/percpu-defs.h:379:11: note: in expansion of macro 
'raw_cpu_add_1'
    case 1: stem##1(variable, __VA_ARGS__);break;  \
            ^
./include/linux/percpu-defs.h:424:32: note: in expansion of macro 
'__pcpu_size_call'
  #define raw_cpu_add(pcp, val)  __pcpu_size_call(raw_cpu_add_, pcp, val)
                                 ^
./include/linux/percpu-defs.h:460:2: note: in expansion of macro 
'raw_cpu_add'
   raw_cpu_add(pcp, val);      \
   ^
./include/linux/percpu-defs.h:499:30: note: in expansion of macro 
'__this_cpu_add'
  #define __this_cpu_inc(pcp)  __this_cpu_add(pcp, 1)
                               ^
./include/linux/percpu-rwsem.h:47:2: note: in expansion of macro 
'__this_cpu_inc'
   __this_cpu_inc(*sem->read_count);
   ^
./arch/powerpc/include/asm/smp.h:93:34: error: invalid type argument of 
unary '*' (have 'int')
  #define raw_smp_processor_id()  (*this_cpu_ptr(&cpu_number))
                                   ^


[...]
