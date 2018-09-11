Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE97C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877EB206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877EB206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIKLWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:22:43 -0400
Received: from foss.arm.com ([217.140.101.70]:38382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeIKLWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:22:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A4E27A9;
        Mon, 10 Sep 2018 23:24:58 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.Emea.Arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C2803F71F;
        Mon, 10 Sep 2018 23:24:52 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@gmail.com>
Cc:     migueldedios@google.com, "Cc: Steve Muckle" <smuckle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <b27b2354-cbfe-7c16-bdc1-d88ed3be90bd@arm.com>
 <20180824065419.GB24860@localhost.localdomain>
 <5fa77995-428e-077e-e236-7cc4a2e82577@arm.com>
 <20180907071602.GA29405@localhost.localdomain>
 <CAKfTPtCpqhQAMeQnUtuePbris0vyjmzfXo40zdprffqh9Pwv=A@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <da0a0480-15dd-1fd3-7da9-6b60955ae729@arm.com>
Date:   Mon, 10 Sep 2018 23:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCpqhQAMeQnUtuePbris0vyjmzfXo40zdprffqh9Pwv=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 12:58 AM, Vincent Guittot wrote:
> On Fri, 7 Sep 2018 at 09:16, Juri Lelli <juri.lelli@gmail.com> wrote:
>>
>> On 06/09/18 16:25, Dietmar Eggemann wrote:
>>> Hi Juri,
>>>
>>> On 08/23/2018 11:54 PM, Juri Lelli wrote:
>>>> On 23/08/18 18:52, Dietmar Eggemann wrote:
>>>>> Hi,
>>>>>
>>>>> On 08/21/2018 01:54 AM, Miguel de Dios wrote:
>>>>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:
>>>>>>> From: John Dias <joaodias@google.com>

[...]

>>> Adding semaphores is possible but rt-app has no easy way to initialize
>>> individual objects, e.g. sem_init(..., value). The only way I see is via the
>>> global section, like "pi_enabled". But then, this is true for all objects of
>>> this kind (in this case mutexes)?
>>
>> Right, global section should work fine. Why do you think this is a
>> problem/limitation?
> 
> keep in mind that rt-app still have "ressources" section. This one is
> optional and almost never used as resources can be created on the fly
> but it's still there and can be used to initialize resources if needed
> like semaphore

I wasn't aware of that but this will do the job AFAICS. I just have to 
re-introduce the direct calls to init_foo_resource() (in this case 
init_sem_resource()) in init_resource_data() and call that instead of 
init_resource_data() for semaphores listed in the global resources section.

Example for a semaphore b_sem with initial value eq. 1:

     "resources" : {
         "b_sem" : { "type" : "sem_wait", "value" : 1 }
     }

[...]
