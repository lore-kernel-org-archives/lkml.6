Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A25C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FC920880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfBTOPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:15:03 -0500
Received: from foss.arm.com ([217.140.101.70]:58456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfBTOPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:15:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84AF1EBD;
        Wed, 20 Feb 2019 06:15:02 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74E5F3F690;
        Wed, 20 Feb 2019 06:15:01 -0800 (PST)
Subject: Re: xen/evtchn and forced threaded irq
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave P Martin <dave.martin@arm.com>
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
 <20190220000209.GA4091@localhost.localdomain>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
Date:   Wed, 20 Feb 2019 14:15:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190220000209.GA4091@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thank you for your answer.

On 20/02/2019 00:02, Boris Ostrovsky wrote:
> On Tue, Feb 19, 2019 at 05:31:10PM +0000, Julien Grall wrote:
>> Hi all,
>>
>> I have been looking at using Linux RT in Dom0. Once the guest is started,
>> the console is ending to have a lot of warning (see trace below).
>>
>> After some investigation, this is because the irq handler will now be threaded.
>> I can reproduce the same error with the vanilla Linux when passing the option
>> 'threadirqs' on the command line (the trace below is from 5.0.0-rc7 that has
>> not RT support).
>>
>> FWIW, the interrupt for port 6 is used to for the guest to communicate with
>> xenstore.
>>
>>  From my understanding, this is happening because the interrupt handler is now
>> run in a thread. So we can have the following happening.
>>
>>     Interrupt context            |     Interrupt thread
>>                                  |
>>     receive interrupt port 6     |
>>     clear the evtchn port        |
>>     set IRQF_RUNTHREAD	        |
>>     kick interrupt thread        |
>>                                  |    clear IRQF_RUNTHREAD
>>                                  |    call evtchn_interrupt
>>     receive interrupt port 6     |
>>     clear the evtchn port        |
>>     set IRQF_RUNTHREAD           |
>>     kick interrupt thread        |
>>                                  |    disable interrupt port 6
>>                                  |    evtchn->enabled = false
>>                                  |    [....]
>>                                  |
>>                                  |    *** Handling the second interrupt ***
>>                                  |    clear IRQF_RUNTHREAD
>>                                  |    call evtchn_interrupt
>>                                  |    WARN(...)
>>
>> I am not entirely sure how to fix this. I have two solutions in mind:
>>
>> 1) Prevent the interrupt handler to be threaded. We would also need to
>> switch from spin_lock to raw_spin_lock as the former may sleep on RT-Linux.
>>
>> 2) Remove the warning
> 
> I think access to evtchn->enabled is racy so (with or without the warning) we can't use it reliably.

Thinking about it, it would not be the only issue. The ring is sized to contain 
only one instance of the same event. So if you receive twice the event, you may 
overflow the ring.

> 
> Another alternative could be to queue the irq if !evtchn->enabled and handle it in evtchn_write() (which is where irq is supposed to be re-enabled).
What do you mean by queue? Is it queueing in the ring? If so, wouldn't it be 
racy as described above?

Cheers,

-- 
Julien Grall
