Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934637AbeEJJmr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:42:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:26898 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934363AbeEJJmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:42:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,384,1520924400";
   d="scan'208";a="40131990"
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
 <20180509145436.GV12217@hirez.programming.kicks-ass.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Message-ID: <3ecedd91-1c01-6fc5-4648-89eaf5ff0930@linux.intel.com>
Date: Thu, 10 May 2018 12:42:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509145436.GV12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09.05.2018 17:54, Peter Zijlstra wrote:
> On Tue, May 08, 2018 at 06:21:36PM +0300, Alexey Budankov wrote:
>>
>> Store user space frame-pointer value (BP register) into Perf trace 
>> on a sample for a process so the value becomes available when 
>> unwinding call stacks for functions gaining event samples.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  arch/x86/kernel/perf_regs.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>> index e47b2dbbdef3..8d68658eff7f 100644
>> --- a/arch/x86/kernel/perf_regs.c
>> +++ b/arch/x86/kernel/perf_regs.c
>> @@ -156,7 +156,13 @@ void perf_get_regs_user(struct perf_regs *regs_user,
> 
> 
>>  	 * Most system calls don't save these registers, don't report them.
> 
> ^^^ that worries me and is the reason for the '-1's below. However I
> think with all the PTI rework this might no longer be true.

Well ok, at the moment I don't see the rationale behind exposure the other 
registers so they still may be reported as -1.

However BP may contain valid frame address not only on syscalls but also 
for samples landing into user space. 

> 
> The Changelog needs to state that user_regs->bp is in fact valid and

That actually was tested on binaries compiled without and with BP exposed 
and in the latter case proved the value of that change.

Test executable for the example below was compiled with frame pointer 
support enabled:

g++ -o futex-fp -fpermissive --no-omit-frame-pointer futex.c

and profiled using:

tools/perf/perf record --user-regs=IP,SP,BP \
	-g --call-graph=dwarf,1024 -e cycles -- ./futex-fp

Output of

tools/perf/perf report -i perf.data --stdio 

demonstrates the effect of the patch change so before saving BP 
value on a sample we have several frames missing above main 
function frame:

# Samples: 138K of event 'cpu-cycles'
# Event count (approx.): 92713835335
#
# Children      Self  Command   Shared Object     Symbol                                        
# ........  ........  ........  ................  ..........................
#
    96.15%     0.72%  futex-fp  futex-fp          [.] main
            |          
            |--95.43%--main
            |          |          
            |          |--71.56%--syscall
            |          |          |          
            |          |          |--57.28%--entry_SYSCALL_64_after_hwframe
            |          |          |          |          
            |          |          |           --56.95%--do_syscall_64
            |          |          |                     |          
            |          |          |                      --55.77%--sys_futex

and after saving BP value on a sample we have expected 

	_start
	__libc_start_main 

frames unwound:

# Samples: 128K of event 'cpu-cycles'
# Event count (approx.): 85349981034
#
# Children      Self  Command   Shared Object     Symbol                                        
# ........  ........  ........  ................  ..................
#
    95.83%     0.00%  futex-fp  futex-fp          [.] _start
            |
==>         ---_start
==>            __libc_start_main
               main
               |          
               |--71.28%--syscall
               |          |          
               |          |--55.67%--entry_SYSCALL_64
               |          |          |          
               |          |           --55.40%--do_syscall_64
               |          |                     |          
               |          |                      --54.21%--sys_futex


> ideally point to the commits that makes it so. Also this patch should
> update that comment.

Accepted.

> 
> Cc Andy who keeps better track of all that than me.

Yes, any comments and feedback would be very welcome.

Thanks,
Alexey

> 
>>  	 */
>>  	regs_user_copy->bx = -1;
>> -	regs_user_copy->bp = -1;
>> +	/*
>> +	 * Store user space frame-pointer value on sample
>> +	 * to facilitate stack unwinding for cases when
>> +	 * user space executable code has such support
>> +	 * enabled at compile time;
>> +	 */
>> +	regs_user_copy->bp = user_regs->bp;
>>  	regs_user_copy->r12 = -1;
>>  	regs_user_copy->r13 = -1;
>>  	regs_user_copy->r14 = -1;
> 
