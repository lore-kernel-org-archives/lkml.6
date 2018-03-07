Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933894AbeCGRE3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:04:29 -0500
Received: from cmta20.telus.net ([209.171.16.93]:38706 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933468AbeCGREZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:04:25 -0500
X-Authority-Analysis: v=2.2 cv=Pr98V0E3 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=fkRjtHzjblDVjxR6nZEA:9 a=CjuIK1q_8ugA:10 a=svzTaB3SJmTkU8mK-ULk:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>
References: t8eAehXAKpApst8eFeMNAX
In-Reply-To: t8eAehXAKpApst8eFeMNAX
Subject: RE: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
Date: Wed, 7 Mar 2018 09:04:18 -0800
Message-ID: <000a01d3b636$57b75c00$07261400$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdO1K0iXKNFWMfj8Q+e+d9deNSt/gwBAll/w
X-CMAE-Envelope: MS4wfBrpLiIfiCrqXaNEGNxx+EGKqxOW4Tj7kd3bN5GPHA7UP6ByevFp8OGjVN32D3yJZCtCdLAJrbuQKjY/UdBXtQApTB+UQx9QLDdDSNhbozGUXYcDuszX
 QdKrh9PIcP6A5hwpwP4BcE2gh5rXTSc/Og4D85SbRLBCsBWObAGgzD/8TAZtzwNgtgA62i0NrzFFrTcTtqhYviDM7U0MO7SyDeedLpCicczBBbfdOggS9DVS
 ydv5dnk846zBn4J9Rr1iDoAeCXop4uAUmf74rq0tFlz0SkWn3Am4cZNsw1PVBNlwMApH7H5hBR3uvziysmh0NQymH24fwhAFAFrpEcjtg3RiQextEPYsJaVH
 fd1RR8j+gjg/LR5JqLTuTpN6tt9/qCmctI4LhZUnyopXvQAqDoGz8k/t7zIsDtCYSSE+q8/RVYkHBMVadDnS1aVR+NIbrMJjlbyLwwlbM8FiG2o7sSIpQNoq
 3E8A+bPbOTYZmlcJM0Xv4irXexiD10PM+JRbWQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.06 12:57 Rafael J. Wysocki wrote:

...[snip]...

> And the two paragraphs below still apply:

>> I have tested these patches on a couple of machines, including the very laptop
>> I'm sending them from, without any obvious issues, but please give them a go
>> if you can, especially if you have an easy way to reproduce the problem they
>> are targeting.  The patches are on top of 4.16-rc3 (if you need a git branch
>> with them for easier testing, please let me know).

Hi,

I am still having some boot troubles with V2. However, and because my system
did eventually boot, seemingly O.K., I didn't re-boot a bunch of times for
further testing.

I ran my 100% load on one CPU test, which is for idle state 0 issues, on
my otherwise extremely idle test server. I never did have very good ways
to test issues with the other idle states (Thomas Ilsche's specialty).

During the test I got some messages (I also got some with the V1 patch set):

[16246.655148] rcu_preempt kthread starved for 60005 jiffies! g10557 c10556
			f0x0 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=5
[19556.565007] rcu_preempt kthread starved for 60003 jiffies! g12126 c12125
			f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=5
[20223.066251] clocksource: timekeeping watchdog on CPU4: Marking clocksource
			'tsc' as unstable because the skew is too large:
[20223.066260] clocksource:                       'hpet' wd_now: 6b02e6a0
			wd_last: c70685ef mask: ffffffff
[20223.066262] clocksource:                       'tsc' cs_now: 3ed0d6f109f5
			cs_last: 3e383b5c058d mask: ffffffffffffffff
[20223.066264] tsc: Marking TSC unstable due to clocksource watchdog
[26720.509156] rcu_preempt kthread starved for 60003 jiffies! g16640
			c16639 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=5
[29058.215330] rcu_preempt kthread starved for 60004 jiffies! g17522
			c17521 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=4
...

The other observation is sometimes the number of irqs (turbostat) jumps
a lot. This did not occur with the V1 patch set. An increase in irqs is
expected, but I don't think that much.
Note: I am unable to show a correlation between the above log entries
and the jumps in irqs.

Test results (some previous restated):
Observe 24.44 average processor package watts. 100% load on CPU 7.
Test Duration 10 hours and 9 minutes. Peak power 26.88 Watts
Reference: K4.16-rc3 + rjw V1 patchset: 24.77 Watts. Peak power 32.8 watts
Reference: K4.16-rc3: 26.41 Watts (short test, 3.53 hours)
Reference: K4.15-rc1: 27.34 Watts
Reference: K4.15-rc1, idle states 0-3 disabled: 23.92 Watts
Reference: K4.16-rc3 + rjw v1 patch set, idle states 0-3 disabled: ~23.65 Watts

References (Graphs):
http://fast.smythies.com/rjw416rc3v2_irq.png
http://fast.smythies.com/rjw416rc3v2_pwr.png

... Doug
