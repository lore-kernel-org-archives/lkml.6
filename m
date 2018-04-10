Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeDJOlP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:41:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:10647 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753124AbeDJOlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:41:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,432,1517904000";
   d="scan'208";a="190333314"
Subject: Re: [PATCH v1]: perf/x86: store user space frame-pointer value on a
 sample
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <086d45fb-a099-4ae9-2854-943447e86010@linux.intel.com>
 <20180406153144.GA9010@tassilo.jf.intel.com>
 <df5f38d8-9b35-0309-527a-c7b7b35c635b@linux.intel.com>
 <20180406195310.GB9010@tassilo.jf.intel.com>
 <ddb220da-eb32-a9bb-f742-8fe5d5588974@linux.intel.com>
 <2a42b621-e7b2-b761-beb8-dfef11b2afb3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3f6238cd-7bb7-4baf-b371-e428d489495b@linux.intel.com>
Date: Tue, 10 Apr 2018 17:41:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2a42b621-e7b2-b761-beb8-dfef11b2afb3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.2018 8:23, Alexey Budankov wrote:
> On 07.04.2018 9:18, Alexey Budankov wrote:
>> On 06.04.2018 22:53, Andi Kleen wrote:
>>> On Fri, Apr 06, 2018 at 10:06:26PM +0300, Alexey Budankov wrote:
>>>> On 06.04.2018 18:31, Andi Kleen wrote:
>>>>>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>>>>>> index e47b2dbbdef3..9284048cf5b0 100644
>>>>>> --- a/arch/x86/kernel/perf_regs.c
>>>>>> +++ b/arch/x86/kernel/perf_regs.c
>>>>>> @@ -157,6 +157,15 @@ void perf_get_regs_user(struct perf_regs *regs_user,
>>>>>>  	 */
>>>>>>  	regs_user_copy->bx = -1;
>>>>>>  	regs_user_copy->bp = -1;
>>>>>> +	if (user_64bit_mode(user_regs)) {
>>>>>
>>>>> Why is it 64bit only? Should work on 32bit too.
>>>>
>>>> bp register is a part of i386 syscall ABI 
>>>> (http://man7.org/linux/man-pages/man2/syscall.2.html) 
>>>> so not sure if it will make any sense for 32bit processes. 
>>>
>>> Both 32bit and 64bit use the same frame pointer, if they
>>> use frame pointer.
>>
>> Well let me check the same scenario for 32bit binary.
> 
> Here is what I have when profiling 32bit process on the patched 64bit 
> kernel w/o 32bit frame-pointer exposure:
> 
> vmlinux ! try_to_wake_up - [unknown source file]
> vmlinux ! wake_up_q + 0x3e - [unknown source file]
> vmlinux ! futex_wake + 0x141 - [unknown source file]
> vmlinux ! do_futex + 0x49b - [unknown source file]
> vmlinux ! compat_SyS_futex + 0x123 - [unknown source file]
> vmlinux ! do_fast_syscall_32 + 0xb9 - [unknown source file]
> vmlinux ! entry_SYSENTER_compat + 0x7e - [unknown source file]
> ==> [vdso] ! __kernel_vsyscall + 0x8 - [unknown source file]
> ==> libc-2.26.so ! syscall + 0x26 - [unknown source file]
> ==> futex32-fp ! main + 0xba - [unknown source file]
> ==> libc-2.26.so ! __libc_start_main + 0xf2 - [unknown source file]
> 
> so stack is unwound till the top. However if I enable 32bit exposure 
> then the stack looks like this:
> 
> vmlinux ! try_to_wake_up - [unknown source file]
> vmlinux ! wake_up_q + 0x3e - [unknown source file]
> vmlinux ! futex_wake + 0x141 - [unknown source file]
> vmlinux ! do_futex + 0x49b - [unknown source file]
> vmlinux ! compat_SyS_futex + 0x123 - [unknown source file]
> vmlinux ! do_fast_syscall_32 + 0xb9 - [unknown source file]
> vmlinux ! entry_SYSENTER_compat + 0x7e - [unknown source file]
> ==> [vdso] ! [vdso] + 0x1058 - [unknown source file]
> ==> vmlinux ! [Skipped stack frame(s)] + 0x1 - [unknown source file]

Investigated more on that unwind failure case above and it turns out that
in case of system wide monitoring there may be several modules named equally 
but of different architecture, e.g. vdso like in that case above, so unwinding 
code needs to be smart enough to distinguish between the modules to choose 
proper one when walking stack on a sample. Well, lifting the restriction 
on the frame-pointer architecture looks reasonable.

In order to enable unwinding code for that mixed mode case above 
it is required to expose module architecture to unwinding code.

Thanks,
Alexey

> 
> and x86_64 perf report --stdio shows this:
> 
> ...
> unwind: target platform=x86 is not supported
> ...
> # Samples: 140K of event 'cycles'
> # Event count (approx.): 93688193797
> #
> # Children      Self  Command     Shared Object     Symbol                                        
> # ........  ........  ..........  ................  .........................
> #
>     86.00%    14.40%  futex32-fp  [kernel.vmlinux]  [k] entry_SYSENTER_compat
>             |
>             ---entry_SYSENTER_compat
>                |          
>                 --71.60%--do_fast_syscall_32
>                           |          
>                           |--54.62%--compat_sys_futex
>                           |          |          
>                           |           --53.67%--do_futex
> 
> I am not sure it is worth exposing frame pointer for 32bit too.
> 
> -Alexey
> 
>> If the issue exists for it too and is fixed by the exposing bp
>> then it is obviously worth this improvement.
>>
>> -Alexey
>>
>>>
>>> -Andi
>>>
>>
>>
> 
