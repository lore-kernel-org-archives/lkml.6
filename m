Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C48C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E4920840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbfAPIBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:01:06 -0500
Received: from s30320.gliwa.com ([148.251.52.238]:44334 "EHLO mail.gliwa.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731328AbfAPIBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:01:06 -0500
Received: by mail.gliwa.com (Postfix, from userid 992)
        id ED8B93459F1; Wed, 16 Jan 2019 09:01:03 +0100 (CET)
X-Virus-Checker-Version: ClamAV 0.100.2/25302/Wed Jan 16 03:34:53 2019
X-Virus-Status: OK
Received: from [192.168.2.165] (p4FE0DB24.dip0.t-ipconnect.de [79.224.219.36])
        by mail.gliwa.com (Postfix) with ESMTPSA id 106DF344FEF;
        Wed, 16 Jan 2019 09:00:03 +0100 (CET)
Subject: Re: ftrace global trace_pipe_raw
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
 <20180709113257.79152dd0@gandalf.local.home>
 <7dfce43c-afd3-52ee-4c58-ef6a3b1be5fd@gliwa.com>
 <20180724102316.41cdb8a1@gandalf.local.home>
 <732bd9ce-c0dd-79ea-de17-462ba662a10a@gliwa.com>
 <20181219113734.56b57f93@gandalf.local.home>
From:   Claudio <claudio.fontana@gliwa.com>
Message-ID: <5af4b871-41dd-219b-f78e-3a60ea570160@gliwa.com>
Date:   Wed, 16 Jan 2019 09:00:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181219113734.56b57f93@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven, happy new year,

On 12/19/2018 05:37 PM, Steven Rostedt wrote:
> On Wed, 19 Dec 2018 12:32:41 +0100
> Claudio <claudio.fontana@gliwa.com> wrote:
> 
>>>>
>>>> I would imagine the core functionality is already available, since trace_pipe
>>>> in the tracing directory already shows all events regardless of CPU, and so
>>>> it would be a matter of doing the same for trace_pipe_raw.  
>>>
>>> The difference between trace_pipe and trace_pipe_raw is that trace_pipe
>>> is post processed, and reads the per CPU buffers and interleaves them
>>> one event at a time. The trace_pipe_raw just sends you the raw
>>> unprocessed data directly from the buffers, which are grouped per CPU.  
>>
>> I think that what I am looking for, to improve the performance of our system,
>> is a post processed stream of binary entry data, already merged from all CPUs
>> and sorted per timestamp, in the same way that it is done for textual output
>> in __find_next_entry:
>>
>>        for_each_tracing_cpu(cpu) {
>>
>>                 if (ring_buffer_empty_cpu(buffer, cpu))
>>                         continue;
>>
>>                 ent = peek_next_entry(iter, cpu, &ts, &lost_events);
>>
>>                 /*                                                                
>>                  * Pick the entry with the smallest timestamp:                    
>>                  */
>>                 if (ent && (!next || ts < next_ts)) {
>>                         next = ent;
>>                         next_cpu = cpu;
>>                         next_ts = ts;
>>                         next_lost = lost_events;
>>                         next_size = iter->ent_size;
>>                 }
>>         }
>>
>> We first tried to use the textual output directly, but this lead to
>> unacceptable overheads in parsing the text.
>>
>> Please correct me if I do not understand, however it seems to me that it
>> would be possible do the same kind of post processing including generating
>> a sorted stream of entries, just avoiding the text output formatting,
>> and outputting the binary data of the entry directly, which would be way
>> more efficient to consume directly from user space correlators.
>>
>> But maybe this is not a general enough requirement to be acceptable for
>> implementing directly into the kernel?
>>
>> We have the requirement of using the OS tracing events, including
>> scheduling events, to react from software immediately
>> (vs doing after-the-fact analysis).
> 
> Have you looked at using the perf event interface? I believe it uses a
> single buffer for all events. At least for tracing a single process.
> 
> -- Steve
> 

Indeed the perf event interface would be awesome, if only it would support tracing all processes.

Unfortunately for my use case, it can only trace one process on any cpus, or all processes on one (1) cpu.

I guess for some kind of security concerns..

I'll take a look at how much work it would be to extend the interface for the any process/any cpu use case.

Ciao and thank you,

Claudio



