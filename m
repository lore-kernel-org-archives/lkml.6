Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeCTR21 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:28:27 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:37256 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCTR2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:28:22 -0400
X-Google-Smtp-Source: AG47ELvw2HKdlXPx98XVD9NQ3nqg3Gig4tO/rIybQ9DCEMylQpIJy1Rh1hF3kojN2dGrglCQ9lu1NZrteA71PlP1OcA=
MIME-Version: 1.0
In-Reply-To: <002401d3c06e$fed035b0$fc70a110$@net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <2148754.TY7qXgFyZy@aspire.rjw.lan>
 <002401d3c06e$fed035b0$fc70a110$@net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Mar 2018 18:28:21 +0100
X-Google-Sender-Auth: 5IKYuoBreazpXjwvFYV3Ldf1NPU
Message-ID: <CAJZ5v0hbW-v+392v2+Or4x0Azht7bKQaXy_8SAciMHBv9jX_pQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v5 7/7] cpuidle: menu: Avoid selecting shallow states
 with stopped tick
To: Doug Smythies <dsmythies@telus.net>
Cc: Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>, Peter Zijlstra <peterz@infradead.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 6:15 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2018.03.20 11:22 Doug Smythies wrote:
>> On 2018.03.19 05:47 Thomas Ilsche wrote:
>>> On 2018-03-15 23:19, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> If the scheduler tick has been stopped already and the governor
>>>> selects a shallow idle state, the CPU can spend a long time in that
>>>> state if the selection is based on an inaccurate prediction of idle
>>>> time.  That effect turns out to be noticeable, so it needs to be
>>>> mitigated.
>>>
>>> What are some common causes for that situation?
>>> How could I trigger this for testing?
>>
>> It appeared quite readily with my simple 100% load
>> on one CPU test. Back then (V3) there only 6 patches in the set,
>> and before the re-spin there ended up being a patch 7 of 6, which
>> made a significant difference in both package power and the
>> histograms of times in each idle state.
>>
>> Reference:
>> https://marc.info/?l=linux-pm&m=152075419526696&w=2
>
> I made a kernel (4.16-rc5) with only patches 1 to 6 of 7 (V6)
> and also with the poll fix.
>
> I took an old graph:
> http://fast.smythies.com/rjwv3pp_100.png
>
> and removed an obsolete line and added a line from this
> kernel:
>
> http://fast.smythies.com/rjwv6m_100.png
>
> I also acquired a trace during the test and observe:
>
> Report: Summary:
>
> Idle State 0: Total Entries: 699 : PowerNightmares: 0 : Not PN time (seconds): 0.031169 : PN time: 0.000000 : Ratio: 0.000000
> Idle State 1: Total Entries: 3855 : PowerNightmares: 106 : Not PN time (seconds): 0.123759 : PN time: 43.511914 : Ratio: 351.585856
> Idle State 2: Total Entries: 3688 : PowerNightmares: 181 : Not PN time (seconds): 1.303237 : PN time: 63.241424 : Ratio: 48.526418
> Idle State 3: Total Entries: 528 : PowerNightmares: 115 : Not PN time (seconds): 0.276290 : PN time: 44.764111 : Ratio: 162.018571
>
> Where "PowerNightmare" is defined as spending excessive time in an idle state,
> and arbitrarily defined for my processor as:
>
> #define THRESHOLD_0 100       /* Idle state 0 PowerNightmare threshold in microseconds */
> #define THRESHOLD_1 1000      /* Idle state 1 PowerNightmare threshold in microseconds */
> #define THRESHOLD_2 2000      /* Idle state 2 PowerNightmare threshold in microseconds */
> #define THRESHOLD_3 4000      /* Idle state 3 PowerNightmare threshold in microseconds */
>
> While this trace file was only about 15 megabytes, I have several 10s of gigabytes of trace data for
> V4 + poll fix and never see any excessive time spent in any idle state.

Thanks for this work!

I prefer it with patch [7/7]. :-)
