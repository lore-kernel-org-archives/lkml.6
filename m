Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933944AbeEIIFS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:05:18 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:41262 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbeEIIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:05:10 -0400
X-Google-Smtp-Source: AB8JxZo0XXl6pg1Zg0uL6IJbAzFycl86Y38a1ri8tb4jNx8tXWAfRo+pqO/uVt2XKL9E+XEB8EurWIgJ3/r/An6fr1o=
MIME-Version: 1.0
In-Reply-To: <20180509070113.GB52784@joelaf.mtv.corp.google.com>
References: <1525704215-8683-1-git-send-email-claudio@evidence.eu.com>
 <20180508065435.bcht6dyb3rpp6gk5@vireshk-i7> <20180509045425.GA158882@joelaf.mtv.corp.google.com>
 <20180509064530.GA1681@localhost.localdomain> <20180509065449.c5zotxqmuyatjgfd@vireshk-i7>
 <20180509070113.GB52784@joelaf.mtv.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 May 2018 10:05:09 +0200
X-Google-Sender-Auth: mldvmnP5vG1BsKAeM-Kj_2cs1oc
Message-ID: <CAJZ5v0hNgvd=0dKstXRsbHhtrc6m+ugS5kjPOq2B8k55ioX0MA@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/cpufreq/schedutil: handling urgent frequency requests
To: Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 9:01 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Wed, May 09, 2018 at 12:24:49PM +0530, Viresh Kumar wrote:
>> On 09-05-18, 08:45, Juri Lelli wrote:
>> > On 08/05/18 21:54, Joel Fernandes wrote:
>> > Isn't this potentially introducing unneeded irq pressure (and doing the
>> > whole wakeup the kthread thing), while the already active kthread could
>> > simply handle multiple back-to-back requests before going to sleep?
>>
>> And then we may need more instances of the work item and need to store
>> a different value of next_freq with each work item, as we can't use
>> the common one anymore as there would be races around accessing it ?
>
> Exactly. I think it also doesn't make sense to over write an already
> committed request either so better to store them separate (?). After the
> "commit", that previous request is done..

Why is it?

In the non-fast-switch case the "commit" only means queuing up an
irq_work.  Which BTW is one of the reasons for having work_in_progress
even if your kthread can handle multiple work items in one go.

You may try to clear work_in_progress in sugov_irq_work() instead of
in sugov_work(), though.

BTW, I'm not sure if the comment in sugov_irq_work() still applies.  Juri?
