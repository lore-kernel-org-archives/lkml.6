Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeAaPPh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:15:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:7443 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeAaPPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:15:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,440,1511856000";
   d="scan'208";a="14856906"
Subject: Re: [PATCH V3 0/5] bugs fix for large PEBS mmap read and rdpmc read
To: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180130133917.GC29098@krava>
 <6d708c09-52a7-a906-b651-b133a7b4f189@linux.intel.com>
 <20180130150454.GE29098@krava>
 <35090c62-466a-aec8-b1a3-69def959c1c6@linux.intel.com>
 <CABPqkBRWtSsKEM7ycPs0HYSKLsYDmZhr4ztUmMMqsytYamPGsw@mail.gmail.com>
 <24210bcb-0e4b-58fe-bcda-da30019f6e7e@linux.intel.com>
 <20180130185212.GA16806@krava>
 <CABPqkBRp9bDmGECStbAHA5Ja0SjJmDQ2SOceat=qXno707MuAA@mail.gmail.com>
 <20180131035941.GW26209@tassilo.jf.intel.com> <20180131091539.GA3313@krava>
 <20180131131505.GB31614@krava>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b16cfe20-53e0-088b-f833-131e0e9e2210@linux.intel.com>
Date: Wed, 31 Jan 2018 10:15:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180131131505.GB31614@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2018 8:15 AM, Jiri Olsa wrote:
> On Wed, Jan 31, 2018 at 10:15:39AM +0100, Jiri Olsa wrote:
>> On Tue, Jan 30, 2018 at 07:59:41PM -0800, Andi Kleen wrote:
>>>> Still, the part I am missing here, is why asking for
>>>> PERF_SAMPLE_PERIOD voids large PEBS.
>>>
>>> I think it was disabled together with frequency mode
>>> (which we could support too, but it's a bit more work)
>>>
>>> But yes PERIOD could probably be allowed.
>>
>> looks like it's just a matter of adding PERF_SAMPLE_PERIOD
>> into PEBS_FREERUNNING_FLAGS, we already populate period
>> in setup_pebs_sample_data
>>
>> jirka
>>
>>
>> ---
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index 8e4ea143ed96..78f91ec1056e 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -93,7 +93,8 @@ struct amd_nb {
>>   	PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_STREAM_ID | \
>>   	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
>>   	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
>> -	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)
>> +	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
>> +	PERF_SAMPLE_PERIOD)
> 
> seems to work, getting large PEBS event for following command line:
> 
>    perf record -e cycles:P -c 100 --no-timestamp -C 0 --period
> 
> 

Yes, I tried the patch. The large PEBS can be enabled with the PERIOD 
flag. Everything looks good.

Jirka, could you please post the patch as well?

Thanks,
Kan
