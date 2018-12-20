Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D831620811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbeLTQMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:12:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59262 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730955AbeLTQMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:12:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D2E8EBD;
        Thu, 20 Dec 2018 08:12:21 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504D83F5C0;
        Thu, 20 Dec 2018 08:12:20 -0800 (PST)
Subject: Re: [PATCH 2/3] sched/fair: trigger asym_packing during idle load
 balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
 <1545292547-18770-3-git-send-email-vincent.guittot@linaro.org>
 <edd9f36f-7826-11db-94ff-1604a4be11d0@arm.com>
 <CAKfTPtCxCpHJwsfJQht4ux-Fqm9u27vZQM4ExkLFLdWGS=JvAQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <640959d1-34eb-0a53-c05a-86b81bbf6f63@arm.com>
Date:   Thu, 20 Dec 2018 16:12:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCxCpHJwsfJQht4ux-Fqm9u27vZQM4ExkLFLdWGS=JvAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 14:33, Vincent Guittot wrote:
[...]
>> As in the previous thread, I'll still argue that if you want to *reliably*
>> exploit newidle balances to do asym packing active balancing, you should
>> add some logic to raise rq->rd->overload when we notice some asym packing
>> could be done, so that it can be leveraged by a higher-priority CPU doing
>> a newidle balance.
> 
> The source cpu with the task is never overloaded.
> We need to start the load balance to know that it's worth migrating the task.
> 

Yep, that's my point exactly:  if you ever want to active balance a task
on a rq with nr_running == 1 when a higher priority CPU goes newidle, you'd
need an asym-packing version of:

  757ffdd705ee ("sched/fair: Set rq->rd->overload when misfit")

It's somewhat orthogonal to this patch, but the reason I'm bringing this up
is that the commit log says

  "newly idle load balance is not always triggered when a cpu becomes idle"

And not having root_domain->overload raised is a reason for that issue.

>>
>> Otherwise the few newidle asym-packing active balances you'll get will be
>> due to somewhat random luck because we happened to set that overload flag
>> at some point.
