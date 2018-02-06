Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeBFVrA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:47:00 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43716 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbeBFVq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:46:59 -0500
X-Google-Smtp-Source: AH8x224NBPTJdtrBKU7Vk+ZtBb0ZEtS87MD3UW5RKZzahIKDxjgraGD8oKny6iUpmwOVqBpIoTYycnCS3G36P1Z96os=
MIME-Version: 1.0
In-Reply-To: <20180206212507.GO2249@hirez.programming.kicks-ass.net>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org> <20180206212507.GO2249@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 6 Feb 2018 22:46:37 +0100
Message-ID: <CAKfTPtD_+UA7zM7xG43D5Aa+8E7-=0qxqPnRErE9U7_rv=uEoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Update blocked load
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 February 2018 at 22:25, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Feb 06, 2018 at 08:23:04PM +0100, Vincent Guittot wrote:
>> This patchset applies on top of Peter's sched/esting branch minus the last 2 commit:
>> 56eb46798b33 ("sched: Clean up nohz enter/exit")
>
> So what will update the blocked load after we wake from a total idle?
>
> I don't see anything here that would do that (yet?).

The fast wake up path uses only idle state and runnable load average.
The later is normally up to date and null ( thanks to the propagation
of runnable) because of the fact that we were totally idle.
For the other "slow" path, we need to update the utilization of the
CPUs when we use them (and the load as well even if we don't use it).
This will be part of another patch as the overhead need to be
evaluated

That should be enough to take the right decision at wake up from a
long total idle state

Then for a complete update of the load metric, we can either wait for
the next tick or kick an ilb at wake up (what you don't like).
