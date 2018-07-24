Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A8B20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A8B20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gliwa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbeGXLEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:04:06 -0400
Received: from s30320.gliwa.com ([148.251.52.238]:37910 "EHLO mail.gliwa.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388302AbeGXLEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:04:05 -0400
Received: by mail.gliwa.com (Postfix, from userid 992)
        id E0642344490; Tue, 24 Jul 2018 11:58:18 +0200 (CEST)
X-Virus-Checker-Version: ClamAV 0.100.0/24777/Tue Jul 24 02:41:32 2018
X-Virus-Status: OK
Received: from [192.168.0.50] (x5ce308b8.dyn.telefonica.de [92.227.8.184])
        by mail.gliwa.com (Postfix) with ESMTPSA id A69EF34447E;
        Tue, 24 Jul 2018 11:58:18 +0200 (CEST)
From:   Claudio <claudio.fontana@gliwa.com>
Subject: ftrace global trace_pipe_raw
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
 <20180709113257.79152dd0@gandalf.local.home>
Message-ID: <7dfce43c-afd3-52ee-4c58-ef6a3b1be5fd@gliwa.com>
Date:   Tue, 24 Jul 2018 11:58:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180709113257.79152dd0@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven,

I am doing correlation of linux sched events, following all tasks between cpus,
and one thing that would be really convenient would be to have a global
trace_pipe_raw, in addition to the per-cpu ones, with already sorted events.

I would imagine the core functionality is already available, since trace_pipe
in the tracing directory already shows all events regardless of CPU, and so
it would be a matter of doing the same for trace_pipe_raw.

But is there a good reason why trace_pipe_raw is available only per-cpu?

Would work in the direction of adding a global trace_pipe_raw be considered
for inclusion?

Thank you,

Claudio

On 07/09/2018 05:32 PM, Steven Rostedt wrote:
> On Fri, 6 Jul 2018 08:22:01 +0200
> Claudio <claudio.fontana@gliwa.com> wrote:
> 
>> Hello all,
>>
>> I have been experimenting with the idea of leaving ftrace enabled, with sched events,
>> on production systems.
>>
>> The main concern that I am having at the moment is about the impact on the system.
>> Enabling the sched events that I currently need for the tracing application
>> seems to slow down context-switches considerably, and make the system less responsive.
>>
>> I have tested with cyclictest on the mainline kernel, and noticed an increase of min, avg latencies of around 25%.
>>
>> Is this expected?
>>
>> Some initial investigation into ftrace seems to point at the reservation and commit of the events into the ring buffer
>> as the highest sources of overhead, while event parameters copying, including COMM, does not seem to have any noticeable effect
>> relative to those costs.
>>
>> I have been running 20 times the following test, and thrown away the first results:
>>
>> $ sudo ./cyclictest --smp -p95 -m -s -N -l 100000 -q
> 
> OK, I just noticed that you are using -N which means all numbers are in
> nanoseconds.
> 
>>
>> $ uname -a
>> Linux claudio-HP-ProBook-470-G5 4.18.0-rc3+ #3 SMP Tue Jul 3 15:50:30 CEST 2018 x86_64 x86_64 x86_64 GNU/Linux
>>
>> For brevity, this is a comparison of one test's results. All other test results show the same ~25% increase.
>>
>> On the left side, the run without ftrace sched events, on the right side with ftrace sched events enabled.
>>
>> CPU    Count      Min       Act        Avg        Max        Count      Min-ftrace Act-ftrace Avg-ftrace Max-ftrace
>> 0     100000      2339       2936       2841     139478     100000       2900       3182       3566      93056
>> 1      66742      2365       3386       2874      93639      66750       2959       3786       3646     154074
>> 2      50080      2376       3058       2910     196221      50097       2997       4209       3655      18707
>> 3      40076      2394       3461       2931      17914      40091       3006       4417       3750      17159
>> 4      33404      2371       3612       2834      15336      33419       2997       3836       3594      23172
>> 5      28635      2387       3313       2885      25863      28649       2995       3795       3647       9956
>> 6      25058      2384       3428       2968      12162      25071       3051       4366       3719      18151
>> 7      22275      2381       2859       2982      10706      22287       3046       5078       3825      10781
>>
>> I would be thankful for any advice or comments on this,
>> especially with the goal in mind to lower as much as possible the runtime impact on the system.
> 
> Thus, the tracing is causing the wakeup time to be an average of 0.8us
> longer.
> 
> Yes that is expected.
> 
> -- Steve
> 
