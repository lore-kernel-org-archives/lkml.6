Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbeC1XLP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 19:11:15 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41540 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeC1XLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 19:11:13 -0400
X-Google-Smtp-Source: AIpwx4/fJgPP/Yq0DTeMXdB/UfBUVnYuOZ7Y7DnxYkoDjftOualLKtPvpGX68MN27nxSXmrw7was9Mz0H6MOjP3KvWY=
MIME-Version: 1.0
In-Reply-To: <006501d3c6d5$2d03e500$870baf00$@net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <2249320.0Z4q8AXauv@aspire.rjw.lan>
 <6462e44a-e207-6b97-22bf-ad4aed69afc2@tu-dresden.de> <4198010.6ArFqS34NK@aspire.rjw.lan>
 <CAJZ5v0j5mEaQSAiW4ynitM1ee=sqkpc8G_tZ40RYUgyavXXhqQ@mail.gmail.com>
 <b904266b-b5bb-587d-334a-844a70341f8d@tu-dresden.de> <CAJZ5v0iRjj5DEKU1m2_y96WRBNu6U1w=GSADRxWXfVDN9K+edQ@mail.gmail.com>
 <CAJZ5v0h40DDZ5da7CS4702Z=D3bY7SsOhbUqPR44qVKU0E4D4A@mail.gmail.com> <006501d3c6d5$2d03e500$870baf00$@net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Mar 2018 01:11:11 +0200
X-Google-Sender-Auth: dvINSnvF0KPY9L2G0q3CP4iYbpE
Message-ID: <CAJZ5v0g6=f60Owy2NLSeXZs7hL4tGECseqhwgy7h0imLOTvt5w@mail.gmail.com>
Subject: Re: [RFT][PATCH v7 6/8] sched: idle: Select idle state before
 stopping the tick
To: Doug Smythies <dsmythies@telus.net>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 10:41 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2018.03.28 08:15 Thomas Ilsche wrote:
>> On 2018-03-28 12:56, Rafael J. Wysocki wrote:
>>> On Wed, Mar 28, 2018 at 12:37 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> On Wed, Mar 28, 2018 at 10:38 AM, Thomas Ilsche
>>>> <thomas.ilsche@tu-dresden.de> wrote:
>>>>> On 2018-03-28 10:13, Rafael J. Wysocki wrote:
>>>>>>
>>>
>>> [cut]
>>>
>>>>
>>>> So I do
>>>>
>>>> $ for cpu in 0 1 2 3; do taskset -c $cpu sh -c 'while true; do usleep
>>>> 500; done' & done
>>>>
>>>> which is a shell kind of imitation of the above and I cannot see this
>>>> issue at all.
>>>>
>>>> I count the number of times data->next_timer_us in menu_select() is
>>>> greater than TICK_USEC and while this "workload" is running, that
>>>> number is exactly 0.
>>>>
>>>> I'll try with a C program still.
>>>
>>> And with a C program I see data->next_timer_us greater than TICK_USEC
>>> while it is running, so let me dig deeper.
>>>
>>
>> I can confirm that a shell-loop behaves differently like you describe.
>> Even if it's just a shell-loop calling "main{usleep(500);}" binary.
>
> I normally use the C program method.
> The timer there returns with the need_sched() flag set.

I found the problem, but addressing it will not be straightforward,
which is kind of unfortunate.

Namely, get_next_timer_interrupt() doesn't take high resolution timers
into account if they are enabled (which I overlooked), but they
obviously need to be taken into account in
tick_nohz_get_sleep_length(), so calling tick_nohz_next_event() in
there is not sufficient.

Moreover, it needs to know the next highres timer not including the
tick and that's not so easy to get.  It is doable, though, AFAICS.
