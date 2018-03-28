Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeC1Ulp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:41:45 -0400
Received: from cmta17.telus.net ([209.171.16.90]:49280 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753098AbeC1Uln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:41:43 -0400
X-Authority-Analysis: v=2.2 cv=StJ/0LG0 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=KkEDkbTihyXXKOALizMA:9 a=hSVDg7MSulAM0z_m:21 a=74SgL-Vdwuyptwju:21
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <2249320.0Z4q8AXauv@aspire.rjw.lan> <6462e44a-e207-6b97-22bf-ad4aed69afc2@tu-dresden.de> <4198010.6ArFqS34NK@aspire.rjw.lan> <CAJZ5v0j5mEaQSAiW4ynitM1ee=sqkpc8G_tZ40RYUgyavXXhqQ@mail.gmail.com> <b904266b-b5bb-587d-334a-844a70341f8d@tu-dresden.de> <CAJZ5v0iRjj5DEKU1m2_y96WRBNu6U1w=GSADRxWXfVDN9K+edQ@mail.gmail.com> <CAJZ5v0h40DDZ5da7CS4702Z=D3bY7SsOhbUqPR44qVKU0E4D4A@mail.gmail.com> 1CoHfInOKlebY1CoMfMNTB
In-Reply-To: 1CoHfInOKlebY1CoMfMNTB
Subject: RE: [RFT][PATCH v7 6/8] sched: idle: Select idle state before stopping the tick
Date: Wed, 28 Mar 2018 13:41:35 -0700
Message-ID: <006501d3c6d5$2d03e500$870baf00$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdPGp8AuCNNN9oq0S1KJzh3LS5ugtAAKzJ1Q
X-CMAE-Envelope: MS4wfGEbGNuPaMaUmgUeNtThBuAiMCeO/ILnWcQjN6n5eGCps5UcJ8lUjqHfpmP+7q23erVs31zPkUVhsBEFT03e7AffUXKTlhRQDk5gh7XEWXQEOb7+0G8H
 Ru+lF+J6xr6jiura2uwf3DDC3xQLWJhb7FLTq10RvdHDYcn6V6dgqpHcw4qPdZqgucqrg6+0NZQ/mspmRvIcsOxHuaFxCXYtjGZITHjDdg7TMTabA8IVHm1g
 s3WgyTf85lPjNLhQIzs940uHUr8SppNMcG9PQ18sxVFzRQmJJpGUjXdZfnA9b8Kmq3oYxMNw1Ny7nBtlANUdgB77bJdCmj/Xgqa33NIuMRaXvT+vZjrW5i30
 PPLil2+2aTuRkR1f8CAOcgNHF0fgJ4puBKaqWa/87Z4dE8qmhgK6GuMkJ4q/qJIkbHhY304b5Pp/ecbYVwQdIBHt08dBEFyRNDaQ3C6ZGj0BOYHlLUJOI0hh
 HC5MVA9NDxAz/C/1W56ay8pKTLJcomJJ69mnJChrVzNrbLXH2h6TPesZW1Q=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.28 08:15 Thomas Ilsche wrote:
> On 2018-03-28 12:56, Rafael J. Wysocki wrote:
>> On Wed, Mar 28, 2018 at 12:37 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Wed, Mar 28, 2018 at 10:38 AM, Thomas Ilsche
>>> <thomas.ilsche@tu-dresden.de> wrote:
>>>> On 2018-03-28 10:13, Rafael J. Wysocki wrote:
>>>>>
>> 
>> [cut]
>> 
>>>
>>> So I do
>>>
>>> $ for cpu in 0 1 2 3; do taskset -c $cpu sh -c 'while true; do usleep
>>> 500; done' & done
>>>
>>> which is a shell kind of imitation of the above and I cannot see this
>>> issue at all.
>>>
>>> I count the number of times data->next_timer_us in menu_select() is
>>> greater than TICK_USEC and while this "workload" is running, that
>>> number is exactly 0.
>>>
>>> I'll try with a C program still.
>> 
>> And with a C program I see data->next_timer_us greater than TICK_USEC
>> while it is running, so let me dig deeper.
>> 
>
> I can confirm that a shell-loop behaves differently like you describe.
> Even if it's just a shell-loop calling "main{usleep(500);}" binary.

I normally use the C program method.
The timer there returns with the need_sched() flag set.

I do not seem to have usleep on my system, but when using sleep in a
shell loop, the timer returns without the need_resched() flag set.

Most of my test results involving varying the value of
POLL_IDLE_COUNT are total garbage, because I was using the
C program method, and thus exiting the poll_idle loop based
on the need_resched() flag and not the POLL_IDLE_COUNT
setting. 

I don't know if I can re-do the work, because I
do not have a good way to get my system to use Idle
State 0 with any real workflow, and I seem to get into
side effect issues when I disable other idle states to 
force more use of idle state 0.

... Doug
