Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeD3OKQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:10:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51324 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754107AbeD3OKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:10:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88A7060556
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2] init: Fix false positives in W+X checking
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jan Glauber <jan.glauber@caviumnetworks.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Laura Abbott <labbott@redhat.com>,
        Timur Tabi <timur@codeaurora.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <1524866145-20337-1-git-send-email-jhugo@codeaurora.org>
 <20180428061401.oj4tytn6yy277f7y@gmail.com>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <d81d6d59-ce38-7051-8481-980daa4246d6@codeaurora.org>
Date: Mon, 30 Apr 2018 08:10:05 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180428061401.oj4tytn6yy277f7y@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/2018 12:14 AM, Ingo Molnar wrote:
> 
> * Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> 
>> load_module() creates W+X mappings via __vmalloc_node_range() (from
>> layout_and_allocate()->move_module()->module_alloc()) by using
>> PAGE_KERNEL_EXEC.  These mappings are later cleaned up via
>> "call_rcu_sched(&freeinit->rcu, do_free_init)" from do_init_module().
>>
>> This is a problem because call_rcu_sched() queues work, which can be run
>> after debug_checkwx() is run, resulting in a race condition.  If hit, the
>> race results in a nasty splat about insecure W+X mappings, which results
>> in a poor user experience as these are not the mappings that
>> debug_checkwx() is intended to catch.
>>
>> This issue is observed on multiple arm64 platforms, and has been
>> artificially triggered on an x86 platform.
>>
>> Address the race by flushing the queued work before running the
>> arch-defined mark_rodata_ro() which then calls debug_checkwx().
>>
>> Reported-by: Timur Tabi <timur@codeaurora.org>
>> Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
>> Fixes: e1a58320a38d ("x86/mm: Warn on W^X mappings")
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>
>> v1:
>> -was "arm64: mm: Fix false positives in W+X checking" (see [1])
>> -moved to common code based on review and confirmation of issue on x86
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573776.html
>>
>>   init/main.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/init/main.c b/init/main.c
>> index b795aa3..499d957 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -1034,6 +1034,13 @@ static int __init set_debug_rodata(char *str)
>>   static void mark_readonly(void)
>>   {
>>   	if (rodata_enabled) {
>> +		/*
>> +		 * load_module() results in W+X mappings, which are cleaned up
>> +		 * with call_rcu_sched().  Let's make sure that queued work is
>> +		 * flushed so that we don't hit false positives looking for
>> +		 * insecure pages which are W+X.
>> +		 */
>> +		rcu_barrier_sched();
> 
> I'd suggest adding a matching comment to the module loading portion as well,
> to make sure this connection does not get lost. With that:
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>

Sure.  Will add that in a v3.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
