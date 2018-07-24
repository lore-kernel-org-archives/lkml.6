Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78870ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DAC2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DAC2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gliwa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbeGXQhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:37:08 -0400
Received: from s30320.gliwa.com ([148.251.52.238]:54724 "EHLO mail.gliwa.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388289AbeGXQhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:37:08 -0400
Received: by mail.gliwa.com (Postfix, from userid 992)
        id EE9DC3444B1; Tue, 24 Jul 2018 17:30:05 +0200 (CEST)
X-Virus-Checker-Version: ClamAV 0.100.0/24778/Tue Jul 24 10:44:49 2018
X-Virus-Status: OK
Received: from [192.168.0.50] (x5ce308b8.dyn.telefonica.de [92.227.8.184])
        by mail.gliwa.com (Postfix) with ESMTPSA id A54103444AC;
        Tue, 24 Jul 2018 17:30:05 +0200 (CEST)
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
 <20180724102506.42114a68@gandalf.local.home>
From:   Claudio <claudio.fontana@gliwa.com>
Message-ID: <bb14f513-cc1c-ba2f-59b4-d926e5c49d6c@gliwa.com>
Date:   Tue, 24 Jul 2018 17:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724102506.42114a68@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steve,

thank you for your answer,

On 07/24/2018 04:25 PM, Steven Rostedt wrote:
> On Tue, 24 Jul 2018 10:23:16 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>>
>>> Would work in the direction of adding a global trace_pipe_raw be considered
>>> for inclusion?  
>>
>> The design of the lockless ring buffer requires not to be preempted,
>> and that the data cannot be written to from more than one location. To
>> do so, we make a per CPU buffer, and disable preemption when writing.
>> This means that we have only one writer at a time. It can handle
>> interrupts and NMIs, because they will finish before they return and
>> this doesn't break the algorithm. But having writers from multiple CPUs
>> would require locking or other heaving synchronization operations that
>> will greatly reduce the speed of writing to the buffers (not to mention
>> the cache thrashing).
> 

I understand, it is not a simple matter then.

> And why would you need a single buffer? 

I am interested in all events that have to do with a specific task,
regardless of the CPU they appear on.
Having an already post-processed stream of binary data would be awesome I think.

> Note, we are working on making
> libtracecmd.so that will allow applications to read the buffers and the
> library will take care of the interleaving of the raw data. This should
> hopefully be ready in about three months or so.
> 
> -- Steve

That would be great! So the library could handle this kind of preprocessing,
and create a single stream of sorted timestamps/events with the binary data?

Thanks a lot,

Claudio
