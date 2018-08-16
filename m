Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A60C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A172521480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A172521480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403992AbeHPR76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:59:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37550 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbeHPR75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:59:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FB8D7A9;
        Thu, 16 Aug 2018 08:00:56 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 710443F5D0;
        Thu, 16 Aug 2018 08:00:48 -0700 (PDT)
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-4-patrick.bellasi@arm.com>
 <a24def9b-57bb-d072-5064-0421076d2e43@arm.com>
 <20180814164905.GG2605@e110439-lin>
 <7c45c1a8-24cb-6798-5b6f-3b5dfc9b490d@arm.com>
 <20180815105428.GA7388@e110439-lin>
 <ccd9c53f-55f7-a285-39eb-4303888dafcd@arm.com>
 <20180816133249.GA2964@e110439-lin>
 <20180816133737.xfwfoenbhb5wnndi@queper01-lin>
 <dfd21361-1776-16db-c37b-cecc5ebe6db5@arm.com>
 <20180816142115.v7nybc4qfazdiz6n@queper01-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <434c550d-65da-1b41-b949-c91b9cfdd127@arm.com>
Date:   Thu, 16 Aug 2018 17:00:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816142115.v7nybc4qfazdiz6n@queper01-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 04:21 PM, Quentin Perret wrote:
> On Thursday 16 Aug 2018 at 15:45:45 (+0200), Dietmar Eggemann wrote:
>> On 08/16/2018 03:37 PM, Quentin Perret wrote:
>>>>> IMHO, if this is something which should not happen at all, a BUG_ON() is the
>>>>> right thing to do here.
>>>>
>>>> I don't agree on that. I agree it should not happen but since it's a
>>>> recoverable error it think we should not panic.
>>>
>>> FWIW, if this is a recoverable error, I think Linus will agree with
>>> Patrick on this one :-)
>>>
>>> https://lkml.org/lkml/2016/10/4/1
>>
>> Yeah, not really agreeing here that this is a recoverable error.
> 
> A non-recoverable scenario could be, for example, if you corrupt your
> stack and there is absolutely _nothing_ you can do to keep the system up
> and running, because it's just too broken. I don't feel like we're
> talking about such an extreme case here ...

Yeah, that's the extreme. But what about this lovely BUG_ON(busiest == 
env.dst_rq) in fair.c's load_balance()?

We could recover by just bailing out ;-)

I guess we know by now that there are different opinions here.

> 
>> Besides, we
>> only consider under-run here, what about over-run?

Important thing is to also detect the over-run, i.e. add the first task 
and the task counter is already > 0.

>>
>> Currently this warning doesn't hit and if the code will be changed and it
>> hits, I still find a BUG_ON more appealing here ...
>>
>> So this error scenario can happen over and over again and we always recover
>> from ? The important thing is that we find the culprit for this behaviour as
>> fast as possible ...
> 
> Agreed, we want to debug that ASAP, but WARN should let us do that just
> fine, I think.

+1.


