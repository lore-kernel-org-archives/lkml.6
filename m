Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934473AbeCHB2m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:28:42 -0500
Received: from cmta16.telus.net ([209.171.16.89]:43984 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754965AbeCHB2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:28:40 -0500
X-Authority-Analysis: v=2.2 cv=EJrp6xRC c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8
 a=D0lIOFjFgzSWJjfY7dMA:9 a=QEXdDO2ut3YA:10 a=7715FyvI7WU-l6oqrZBK:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <000a01d3b636$57b75c00$07261400$@net> thHZenCOVQdbpthHaeaJ1a
In-Reply-To: thHZenCOVQdbpthHaeaJ1a
Subject: RE: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
Date: Wed, 7 Mar 2018 17:28:34 -0800
Message-ID: <001101d3b67c$c8eb2550$5ac16ff0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdO2YUFyoX23OKWuSDqB3IDDCEMKzwAFca6Q
X-CMAE-Envelope: MS4wfMzttp+0hKYg+a18bwuTn7H17Poe+KssfDJkN7wOVbA4nMhzWJCDMvsck8Rj7BQzRrGtkdh6DO98ccHvlmhBetXR/zL/eNy3i0cMyArQXD84UWYWc7nZ
 t4bqJgkS0XGK0m52Rww2kyLuPSpV9VJ0TMakwPBNOIDr2cRQtW5mQ3DqOmG5XYBWPOgXqWbc6gi4xmCGkWBIEtcXt1xbkLNEVqQWt8Hzi0hqw1+7N2i7vMq1
 VrQwPNkUz48+vyK+OS+q4NFOrnor5m3D4kuk3NVzo8pxV+ZNPPLjO+YtGxUwL6gTq01vCfmQTyrgyH6Cj17Ky4kazeTJSkhMiBunqvisTOCeaEnHm0PSz/+K
 fsIWtx355rb7TrKZeC5ft8RXm1tjQo8PdfqUK+029XpNMAGdQQU+oWJsytwju9qYepdSKbJMz8+s5Zhm63C5Jm51tK2RNInK7gyVZmMLf4mfPPPUxQJIdNX2
 M1CCTfgIuS2Ur+S2MbkdCgpoy7XNQed7ILJ2XPKOtAZtsLRG6egwIC76ZL2UI4niRvx32FPBrjntqCs+1FD50F6S6GFbLMmlAJJwlw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.07 14:12 Rafael J. Wysocki wrote:
> On Wed, Mar 7, 2018 at 6:04 PM, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2018.03.06 12:57 Rafael J. Wysocki wrote:
>
>> During the test I got some messages (I also got some with the V1 patch set):

> Can you please check if that's reporoducible with just the first three
> patches in the series applied?

I will.

>> The other observation is sometimes the number of irqs (turbostat) jumps
>> a lot. This did not occur with the V1 patch set. An increase in irqs is
>> expected, but I don't think that much.

> Right.

I did a trace for 1 hour, and got about 12 occurrence of very high IRQs.
I was able to correlate trace results with high IRQs per turbostat sampling
time (1 minute).

The extreme jumps in IRQs is due to CPUs wanting to be in idle state 4
(the deepest for my older i7 processor, C6), but the tick is not stopping,
(or so I am guessing) thus they exit idle state 4 every millisecond
(I am using a 1000 Hz kernel), and then pretty much immediately to go
back into idle state 4.
When this occurs, it seems to occur for a very long time, but it does
seem to eventually sort itself out. 

Example:
       5   2.0 [006] d..1   780.447005: cpu_idle: state=4 cpu_id=6
     993   2.0 [006] d..1   780.447999: cpu_idle: state=4294967295 cpu_id=6
       6   2.0 [006] d..1   780.448006: cpu_idle: state=4 cpu_id=6
     992   2.0 [006] d..1   780.448999: cpu_idle: state=4294967295 cpu_id=6
       6   2.0 [006] d..1   780.449005: cpu_idle: state=4 cpu_id=6

Where:
column 1 is the time difference in microseconds from the previous sample.
column 2 is the elapsed time of the test in minutes (for ease of correlating
	with the other once per minute data.
Other columns are unmodified from the raw trace data, but this file is
only CPU 6 and only idle entry/exit.

And the same area from the raw trace file:

<idle>-0     [006] d..1   780.447005: cpu_idle: state=4 cpu_id=6
 test1-2664  [007] d.h.   780.447999: local_timer_entry: vector=237
<idle>-0     [006] d..1   780.447999: cpu_idle: state=4294967295 cpu_id=6
 test1-2664  [007] d.h.   780.447999: hrtimer_expire_entry: hrtimer=00000000ea612c0e function=tick_sched_timer now=780435000915
<idle>-0     [006] d.h1   780.448000: local_timer_entry: vector=237
<idle>-0     [006] d.h1   780.448001: hrtimer_expire_entry: hrtimer=000000004b84020f function=tick_sched_timer now=780435002540
<idle>-0     [006] d.h1   780.448002: hrtimer_expire_exit: hrtimer=000000004b84020f
 test1-2664  [007] d.h.   780.448003: hrtimer_expire_exit: hrtimer=00000000ea612c0e
<idle>-0     [006] d.h1   780.448003: local_timer_exit: vector=237
 test1-2664  [007] d.h.   780.448003: local_timer_exit: vector=237
<idle>-0     [006] d..1   780.448006: cpu_idle: state=4 cpu_id=6

... Doug
