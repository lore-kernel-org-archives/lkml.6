Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeCTRPo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:15:44 -0400
Received: from cmta19.telus.net ([209.171.16.92]:47173 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751712AbeCTRPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:15:35 -0400
X-Authority-Analysis: v=2.2 cv=TI+qcxta c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=FGbulvE0AAAA:8
 a=uj-1fHUxuGTMDH-9HfUA:9 a=QEXdDO2ut3YA:10 a=svzTaB3SJmTkU8mK-ULk:22
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
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <001a01d3be0a$ad3a0ed0$07ae2c70$@net> <2043615.lCdO10SMaB@aspire.rjw.lan> <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com> yE6GempwD1KonyE6LeVquN
In-Reply-To: yE6GempwD1KonyE6LeVquN
Subject: RE: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Date: Tue, 20 Mar 2018 10:15:30 -0700
Message-ID: <002501d3c06f$0e7cf750$2b76e5f0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdPAMpe1b6+HMVjHQca/VUhSciawKgAMka3g
X-CMAE-Envelope: MS4wfBnioFIIO9ayFtzJGFJ5cMUvtewIaA1UaGQPxLZWngAuakH09cpuhEiSlCczu/fL9uxn0B/s5DerAV33Fo1y30LIzvAT8aFeOmCBEX8p6XRW/2RC0Fsv
 agdfw+9keYHTJGlmTEPu54nPH0hJ6DUFwr3g5q4M9kTJYQcQGQNEerOE9dQEPWBkioiQ1ZkyVDDhPOQsRpBWO7jmtp7hpw1+w4l/uCRNhTox7jnHsk4H3kty
 vhBx4/CtfNxP+Fyp+JxKKaE2z86U4t+o/vCWkBFVjbbPtC5tvW5Xu4D62MyWzmTOQLgNij0Di7fMtW6bXUy/kdO4XlkWUcxHAwVv4Cxo9v2vPny4jzh6AI3o
 5/YnHCwTyxNuM3UmDPSFHkVMxPndAMwybYmJQYGYyHmRKOXZx0OMlltiOU1g7ndoXfohnQBG7xqdz2e5dLZzIGE7DSqQUbOt0FweTTtHI1pgR/JYUjerHDen
 cDPFQmYZ5kPH9uIHv9KNHzT3LcXEjpx/SJixwMpK1O0siQNZ7BBcmr3+QzQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.20 03:02 Thomas Ilsche wrote:

...[snip]...

> Consider the Skylake server system which has residencies in C1E of
> 20 us and C6 of 800 us. I use a small while(1) {usleep(300);}
> unsynchronized pinned to each core. While this is an artificial
> case, it is a very innocent one - easy to predict and regular. Between
> vanilla 4.16.0-rc5 and idle-loop/v6, the power consumption increases
> from 149.7 W to 158.1 W. On 4.16.0-rc5, the cores sleep almost
> entirely in C1E. With the patches applied, the cores spend ~75% of
> their sleep time in C6, ~25% in C1E. The average time/usage for C1E is
> also lower with v6 at ~350 us rather than the ~550 us in C6 (and in
> C1E with the baseline). Generally the new menu governor seems to chose
> C1E if the next timer is an enabled sched timer - which occasionally
> interrupts the sleep-interval into two C1E sleeps rather than one C6.
>
> Manually disabling C6, reduces power consumption back to 149.5 W.

...[snip]...

Note that one of the tests that I normally do is a work/sleep
frequency sweep from 100 to 2100 Hz, typically at a lowish
workload. I didn't notice anything odd with this test:

http://fast.smythies.com/rjw_freq_sweep.png

However, your test is at 3333 Hz (well, minus overheads).
I did the same as you. And was surprised to confirm
your power findings. In my case package power goes from
~8.6 watts to ~7.3 watts with idle state 4 (C6) disabled.

I am getting different residency times than you though.
I also observe different overheads between idle state 4
being disabled or not. i.e. my actual loop frequency
drops from ~2801 Hz to ~2754 Hz.

Example residencies over the previous minute:

Idle state 4 (C6) disabled (seconds):

Idle state 0: 0.001119
Idle state 1: 0.056638
Idle state 2: 13.100550
Idle state 3: 446.266744
Idle state 4: 0.000000

Idle state 4 (C6) enabled (seconds):

Idle state 0: 0.034502
Idle state 1: 1.949595
Idle state 2: 78.291793
Idle state 3: 96.467974
Idle state 4: 286.247524

... Doug
