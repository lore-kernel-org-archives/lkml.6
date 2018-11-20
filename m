Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720BBC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E2420671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E2420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeKTUxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:53:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46324 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbeKTUxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:53:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E10EEBD;
        Tue, 20 Nov 2018 02:24:54 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 008A23F575;
        Tue, 20 Nov 2018 02:24:51 -0800 (PST)
Subject: Re: [PATCH v3 05/10] sched/fair: Hoist idle_stamp up from
 idle_balance
To:     Steven Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-6-git-send-email-steven.sistare@oracle.com>
 <9ad62a6f-0269-a5d9-9757-ba5419f9cc1d@arm.com>
 <0d8ceaff-6368-2dff-9e2c-e5928ab39bab@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c177b7dc-b75a-8f0a-e266-b70f2bac780b@arm.com>
Date:   Tue, 20 Nov 2018 10:24:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0d8ceaff-6368-2dff-9e2c-e5928ab39bab@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2018 17:31, Steven Sistare wrote:
[...]
>>> +#define IF_SMP(statement)	statement
>>> +
>>
>> I'm not too hot on those IF_SMP() macros. Since you're not introducing
>> any other user for them, what about an inline function for rq->idle_stamp
>> setting ? When it's mapped to an empty statement (!CONFIG_SMP) GCC is
>> smart enough to remove the rq_clock() that would be passed to it on
>> CONFIG_SMP:
> 
> That may be true now, but I worry that rq_clock or its subroutines may gain
> side effects in the future that prevent the compiler from removing it.  However,
> I could push rq_clock into the inline function:
> 
>   static inline void rq_idle_stamp_set(rq)    { rq->idle_stamp = rq_clock(rq); }
>   static inline void rq_idle_stamp_clear(rq)  { rq->idle_stamp = 0; }
> 
> I like that better, do you?
> 

That works for me, though I can't resist nitpicking on
s/rq_idle_stamp_set/rq_idle_stamp_update/

> - Steve
