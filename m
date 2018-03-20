Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeCTVD5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:03:57 -0400
Received: from cmta17.telus.net ([209.171.16.90]:39815 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbeCTVDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:03:55 -0400
X-Authority-Analysis: v=2.2 cv=StJ/0LG0 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=FGbulvE0AAAA:8
 a=3FxzIjQZUGz05IYbnM0A:9 a=QEXdDO2ut3YA:10 a=svzTaB3SJmTkU8mK-ULk:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>
Cc: "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <001a01d3be0a$ad3a0ed0$07ae2c70$@net> <2043615.lCdO10SMaB@aspire.rjw.lan> <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com> yE6GempwD1KonyE6LeVquN yINUePngOpApsyKrGeyZxD
In-Reply-To: yINUePngOpApsyKrGeyZxD
Subject: RE: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Date: Tue, 20 Mar 2018 14:03:50 -0700
Message-ID: <002d01d3c08e$f43aa750$dcaff5f0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdPAMpe1b6+HMVjHQca/VUhSciawKgAMka3gAAXS+lA=
X-CMAE-Envelope: MS4wfJMFeqeKM/mAP4/o/R0pm9bfrCBJIMpJ3cYXYW1zytgK7PIodyaYee99ssV9dtNW8HAwCwR/lt/s8Ou+oQJLDErp5L5arU8wWCowSLzileUrjHL+H2WB
 Xh5xgQMcHwJuN3TM1B3s3TZkdU/3OmkeKs/vIWqW0S08Yf3OkXLvLm2l5zX705zJpmEJL2q6KKCw6scN6rgbi4APq0JnujG8TTd5u5YiAZG/aPrVf+mF7sb7
 4YuuXx+IIIVZjpAgpf0YQq+BwAWtb9c+etpcWkraoXs1Vbmmw3MBT7Y6osmNlOC20mQYcD25kNKSKaO3FLwG6qQjnh30GMXsTVATes2FxD7r66dZ7RQVQ+qx
 i2xiEaIPKdXfiUqfKITYdYBMC6HrwpDcY2gjZixCqAYSwiKrovMwxXSl8IuKgB8NuS0x560j7Q2IDCu+kv6249eSx4xMcclZVUy54RNhbe8QAkTgZmm5XOol
 YI6GffXJ0DGvVPgSGNnJN6QG0fdZSuNE2Kh+cajEc5LNRvEaO3xUzeEaUDQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: My results with kernel 4.16-rc6 and V8 of the patch set
are completely different, and now show no clear difference
(a longer test might reveal something). 

On 2018.03.20 10:16 Doug Smythies wrote:
> On 2018.03.20 03:02 Thomas Ilsche wrote:
>
>...[snip]...
>
>> Consider the Skylake server system which has residencies in C1E of
>> 20 us and C6 of 800 us. I use a small while(1) {usleep(300);}
>> unsynchronized pinned to each core. While this is an artificial
>> case, it is a very innocent one - easy to predict and regular. Between
>> vanilla 4.16.0-rc5 and idle-loop/v6, the power consumption increases
>> from 149.7 W to 158.1 W. On 4.16.0-rc5, the cores sleep almost
>> entirely in C1E. With the patches applied, the cores spend ~75% of
>> their sleep time in C6, ~25% in C1E. The average time/usage for C1E is
>> also lower with v6 at ~350 us rather than the ~550 us in C6 (and in
>> C1E with the baseline). Generally the new menu governor seems to chose
>> C1E if the next timer is an enabled sched timer - which occasionally
>> interrupts the sleep-interval into two C1E sleeps rather than one C6.
>>
>> Manually disabling C6, reduces power consumption back to 149.5 W.
>
> ...[snip]...
>
> Note that one of the tests that I normally do is a work/sleep
> frequency sweep from 100 to 2100 Hz, typically at a lowish
> workload. I didn't notice anything odd with this test:
> 
> http://fast.smythies.com/rjw_freq_sweep.png
>
> However, your test is at 3333 Hz (well, minus overheads).
> I did the same as you. And was surprised to confirm
> your power findings. In my case package power goes from
> ~8.6 watts to ~7.3 watts with idle state 4 (C6) disabled.
>
> I am getting different residency times than you though.
> I also observe different overheads between idle state 4
> being disabled or not. i.e. my actual loop frequency
> drops from ~2801 Hz to ~2754 Hz.
>
> Example residencies over the previous minute:
>
> Idle state 4 (C6) disabled (seconds):
>
> Idle state 0: 0.001119
> Idle state 1: 0.056638
> Idle state 2: 13.100550
> Idle state 3: 446.266744
> Idle state 4: 0.000000
>
> Idle state 4 (C6) enabled (seconds):
>
> Idle state 0: 0.034502
> Idle state 1: 1.949595
> Idle state 2: 78.291793
> Idle state 3: 96.467974
> Idle state 4: 286.247524

Now, with kernel 4.16-rc6 and V8 of the patch set and the poll fix
I am unable to measure the processor package power difference
between idle state 0 enabled or disabled (i.e. it is in the noise).
also the loop time changes (overhead changes) are minimal. However,
the overall loop time has dropped to ~2730 Hz, so there seems to be
a little more overhead in general.

I increased my loop frequency to ~3316 Hz. Similar.

I increased my loop frequency to ~15474 Hz. Similar.
Compared to a stock 4.16-rc6 kernel: The loop rate dropped
to 15,209 Hz and it (the stock kernel) used about 0.3 more
watts (out of 10.97, or ~3% more).

... Doug
