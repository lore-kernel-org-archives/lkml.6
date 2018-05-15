Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeEOIJJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:09:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:28000 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752556AbeEOIJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:09:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="41032299"
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
To: Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
 <20180509145436.GV12217@hirez.programming.kicks-ass.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Message-ID: <eb83a97a-2e62-9c18-b738-a92b2f4dee23@linux.intel.com>
Date: Tue, 15 May 2018 11:08:59 +0300
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


Hi Andy,

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
> 
> The Changelog needs to state that user_regs->bp is in fact valid and
> ideally point to the commits that makes it so. Also this patch should
> update that comment.
> 
> Cc Andy who keeps better track of all that than me.

Are there any thoughts so far? Feedback on the matter above is highly appreciated.

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
