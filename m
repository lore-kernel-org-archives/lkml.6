Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932446AbeCJQHp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 11:07:45 -0500
Received: from cmta19.telus.net ([209.171.16.92]:38605 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932329AbeCJQHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 11:07:44 -0500
X-Authority-Analysis: v=2.2 cv=TI+qcxta c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=SMlCtqHl8cuezqKOnRcA:9 a=rHzEqscNGhXt8Ysn:21 a=Vvrgx22Z1NXd2xuj:21
 a=CjuIK1q_8ugA:10 a=svzTaB3SJmTkU8mK-ULk:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Rik van Riel'" <riel@surriel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <007c01d3b843$3d825e70$b8871b50$@net> uaLheCDiLpApsuaLmer66C
In-Reply-To: uaLheCDiLpApsuaLmer66C
Subject: RE: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Sat, 10 Mar 2018 08:07:36 -0800
Message-ID: <000701d3b889$eadd5340$c097f9c0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdO4Th5ZahZlIECWSn2GzoCuQh+aDgAMoeCA
Content-Language: en-ca
X-CMAE-Envelope: MS4wfD6BOZEhe2dVmHqetlVbTCdaoxVvsPVXDJYymDQ5YVVvjW54Ad/uOxk2zopT7jx2aabtmFkwSxLUJ2LPuQ6mjY5E5nkF6ByN2/lxeWlgFNwsmri94FQd
 IzpYEud+GvKFTVoAFHlwtvoNTSgDrbxQFsErV0b6pln24m+2SqwNEe6ydNkjK4VhLig72QMTK66IlC3epdjzZaed21OeZI5+bIpBWXvVJ9UOfjvBF1tDpGdm
 zXSgfumDnT6Y2GS7UhOcti6as+3+sH0ANOQUNQe+GS8sUyRbg6kttKcdA2yFsqCy5g+k7pn+kjWlkONPREDanXfMfmfPgRX0O7wBC3RxLu25OVNaO66bPXaF
 +LY8cdnu5Vab6+eW31JQpXXiAVSY7nG1+uZZxBOdP1xyiPlRN/0OYGMDpe+Pf6hwJ0ZE6SeVQw9zFUCIluWkrrsSDWq48ADmdRhbIDucAp5mxjrQEWVr9zZz
 1zne4S0Fm8Qh7NjHczSDlVmA8t7PXs4H7YVSROUY0J6HKDv3dZi66Y6MI3c=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.10 01:00 Rafael J. Wysocki wrote:
> On Saturday, March 10, 2018 8:41:39 AM CET Doug Smythies wrote:
>> 
>> With apologies to those that do not like the term "PowerNightmares",
>
> OK, and what exactly do you count as "PowerNightmares"?

I'll snip some below and then explain:

...[snip]...

>> 
>> Kernel 4.16-rc4: Summary: Average processor package power 27.41 watts
>> 
>> Idle State 0: Total Entries: 9096 : PowerNightmares: 6540 : Not PN time (seconds): 0.051532 : PN time: 7886.309553 : Ratio:
153037.133492
>> Idle State 1: Total Entries: 28731 : PowerNightmares: 215 : Not PN time (seconds): 0.211999 : PN time: 77.395467 : Ratio:
365.074679
>> Idle State 2: Total Entries: 4474 : PowerNightmares: 97 : Not PN time (seconds): 1.959059 : PN time: 0.874112 : Ratio: 0.446190
>> Idle State 3: Total Entries: 2319 : PowerNightmares: 0 : Not PN time (seconds): 1.663376 : PN time: 0.000000 : Ratio: 0.000000

O.K. let's go deeper than the summary, and focus on idle state 0, which has been my area of interest in this saga.

Idle State 0:
CPU: 0: Entries: 2093 : PowerNightmares: 1136 : Not PN time (seconds): 0.024840 : PN time: 1874.417840 : Ratio: 75459.655439
CPU: 1: Entries: 1051 : PowerNightmares: 721 : Not PN time (seconds): 0.004668 : PN time: 198.845193 : Ratio: 42597.513425
CPU: 2: Entries: 759 : PowerNightmares: 583 : Not PN time (seconds): 0.003299 : PN time: 1099.069256 : Ratio: 333152.246028
CPU: 3: Entries: 1033 : PowerNightmares: 1008 : Not PN time (seconds): 0.000361 : PN time: 1930.340683 : Ratio: 5347203.995237
CPU: 4: Entries: 1310 : PowerNightmares: 1025 : Not PN time (seconds): 0.006214 : PN time: 1332.497114 : Ratio: 214434.682950
CPU: 5: Entries: 1097 : PowerNightmares: 848 : Not PN time (seconds): 0.005029 : PN time: 785.366864 : Ratio: 156167.601340
CPU: 6: Entries: 1753 : PowerNightmares: 1219 : Not PN time (seconds): 0.007121 : PN time: 665.772603 : Ratio: 93494.256958

Note: CPU 7 is busy and doesn't go into idle at all.

And also look at the histograms of the times spent in idle state 0:
CPU 3 might be the most interesting:

Idle State: 0  CPU: 3:
4 1
5 3
7 2
11 1
12 1
13 2
14 3
15 3
17 4
18 1
19 2
28 2
7563 1
8012 1
9999 1006

Where:
Column 1 is the time in microseconds it was in that idle state
up to 9999 microseconds, which includes anything more.
Column 2 is the number of occurrences of that time.

Notice that 1008 times out of the 1033, it spent an excessive amount
of time in idle state 0, leading to excessive power consumption.
I adopted Thomas Ilsche's "Powernightmare" term for this several
months ago.

This CPU 3 example was pretty clear, but sometimes it is not so
obvious. I admit that my thresholds for is it a "powernigthmare" or
not are somewhat arbitrary, and I'll change them to whatever anybody
wants. Currently:

#define THRESHOLD_0 100       /* Idle state 0 PowerNightmare threshold in microseconds */
#define THRESHOLD_1 1000      /* Idle state 1 PowerNightmare threshold in microseconds */
#define THRESHOLD_2 2000      /* Idle state 2 PowerNightmare threshold in microseconds */
#define THRESHOLD_3 4000      /* Idle state 3 PowerNightmare threshold in microseconds */

Let's have a look at another example from the same test run:

Idle State 1:
CPU: 0: Entries: 3104 : PowerNightmares: 41 : Not PN time (seconds): 0.012196 : PN time: 10.841577 : Ratio: 888.945312
CPU: 1: Entries: 2637 : PowerNightmares: 40 : Not PN time (seconds): 0.013135 : PN time: 11.334686 : Ratio: 862.937649
CPU: 2: Entries: 1618 : PowerNightmares: 41 : Not PN time (seconds): 0.008351 : PN time: 10.193641 : Ratio: 1220.649147
CPU: 3: Entries: 10180 : PowerNightmares: 31 : Not PN time (seconds): 0.087596 : PN time: 14.748787 : Ratio: 168.372836
CPU: 4: Entries: 3878 : PowerNightmares: 22 : Not PN time (seconds): 0.040360 : PN time: 14.207233 : Ratio: 352.012710
CPU: 5: Entries: 3658 : PowerNightmares: 1 : Not PN time (seconds): 0.031188 : PN time: 0.604176 : Ratio: 19.372066
CPU: 6: Entries: 3656 : PowerNightmares: 39 : Not PN time (seconds): 0.019173 : PN time: 15.465367 : Ratio: 806.622179

Idle State: 1  CPU: 2:
0 230
1 566
2 161
3 86
4 61
5 13
6 32
7 37
8 42
9 41
10 4
11 41
12 38
13 24
14 27
15 26
16 5
17 21
18 16
19 17
20 15
21 1
22 12
23 17
24 16
25 11
26 2
27 5
28 5
29 3
35 1
47 1
1733 1
1850 1
2027 1
3929 1
9999 37

The 41 "Powernightmares" out of 1618 seems correct to me.
Even if someone claims that the threshold should have been >3929 uSec,
there are still 37 "powenightmares".

>>> 
>> Graph of package power verses time: http://fast.smythies.com/rjwv3_100.png
>
> The graph actually shows an improvement to my eyes, as the blue line is quite
> consistently above the red one except for a few regions (and I don't really
> understand the drop in the blue line by the end of the test window).

Agreed, it shows improvement, as does the average package power.

The roughly 22 minute drop in the reference test, unmodified kernel 4.16-rc4,
the blue line, is something that has been driving me crazy since the start
of this work and is the reason my tests run for so long (even 4 hours is short).
It all has to do with subtle timing changes of events. Sometimes events lineup
in such a way that there are lots of these "powernightmares" and sometimes
events lineup in such way that there are not. These conditions can persist for
hours at a time. By "events" I mean ones that ask for a resched upon exit and ones
that don't (I think, I am going from memory here and haven't found my notes).
I have the trace data and can look in more detail if you want.

... Doug
