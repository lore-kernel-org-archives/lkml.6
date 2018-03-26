Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeCZGAB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:00:01 -0400
Received: from cmta19.telus.net ([209.171.16.92]:56626 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbeCZF77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 01:59:59 -0400
X-Authority-Analysis: v=2.2 cv=TI+qcxta c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=SW-Vs-0diS-S-B4UQtYA:9
 a=QEXdDO2ut3YA:10
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rik van Riel'" <riel@surriel.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan>  <4731938.EeADOapqQb@aspire.rjw.lan> <1522008952.6308.46.camel@surriel.com>      <5810003.D8QGLjubHr@aspire.rjw.lan> 0DSBfDrt1Ffdw0DSCfOhiN
In-Reply-To: 0DSBfDrt1Ffdw0DSCfOhiN
Subject: RE: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Sun, 25 Mar 2018 22:59:52 -0700
Message-ID: <003401d3c4c7$ab9f82d0$02de8870$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdPEgplD7c2lkbTKRWyh+F8uoNxgVAADYERg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfFVElWcX3WS5CjB0aFGeoNQfhNuCKfjQ4V5EsvSRsv3/j4DRHzGQvKSzpRgiPIU+uABmLmmEhpqD4+EvgyHbTqfx8u4UPNTbtvJkHerayn7Nmcba55fr
 xNdAeIeujsGcOCo5D/BmcE9292i1pAUuLE2D365LWZhjxwR9cBs4QrcjLotVMn5hqwHwtp54TK1VDikQtaEi5mKR61YCOsi8x/Vof5LlpNZ+Xd/624Y3AHTt
 n5xg7GgcxLNn1RE+cQ1yKxpcFTEswR0tFd1Xk4hIC4nVbL1T3sjsGM3YvmsD5xBVfqqbJsCFIohNo1IcbUDumfCz5cUzKUVYkjS6tOWE5fG/Z8W3EZCJdOM4
 h/WlerYStZ/BpRUy4W/262jvT24Yj2DxSsCSLY4Q2l8o1sOefdeyroLb7511PbKoSilspN/QUv5shJ2XiNFFoVfoB2On784EL2ESmCPpBdENvOsSu/X0f85q
 xKmmInzibiTf31P2456FmtM/XPT0u2Bpza7IjXSeFTE1xDAdSDzXzcThnYk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.25 14:25 Rik van Riel wrote:
> On Sun, 2018-03-25 at 23:34 +0200, Rafael J. Wysocki wrote:
>> On Sunday, March 25, 2018 10:15:52 PM CEST Rik van Riel wrote:
>>> 
>>> --=-e8yLbs0aoH4SrxOskwwl
>>> Content-Type: text/plain; charset="UTF-8"
>>> Content-Transfer-Encoding: quoted-printable
>>> 
>>> On Thu, 2018-03-22 at 18:09 +0100, Rafael J. Wysocki wrote:
>>>> =20
>>>> +++ linux-pm/drivers/cpuidle/poll_state.c
>>>> @@ -10,6 +10,7 @@
>>>>  #include <linux/sched/idle.h>
>>>> =20
>>>>  #define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
>>>> +#define POLL_IDLE_COUNT		1000
>>>> =20
>>>>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>>>>  			       struct cpuidle_driver *drv, int
>>>> index)
>>>> @@ -18,9 +19,14 @@ static int __cpuidle poll_idle(struct cp
>>>>
>>>>  	local_irq_enable();
>>>>  	if (!current_set_polling_and_test()) {
>>>> +		unsigned int loop_count =3D 0;
>>>> +
>>>>  		while (!need_resched()) {
>>>>  			cpu_relax();
>>>> +			if (loop_count++ < POLL_IDLE_COUNT)
>>>> +				continue;
>>>>
>>>> +			loop_count =3D 0;
>>>>  			if (local_clock() - time_start >
>>>> POLL_IDLE_TIME_LIMIT)
>>>>  				break;
>>>>  		}
>>> 
>>> OK, I am still seeing a performance
>>> degradation with the above, though
>>> not throughout the entire workload.
>>> 
>>> It appears that making the idle loop
>>> do anything besides cpu_relax() for
>>> a significant amount of time slows
>>> things down.
>> 
>> I see.
>> 

I have no proof, but I do not see that as
the problem.

I think the issue is the overall exiting
and then re-entering idle state 0 much
more often, and the related overheads, where
interrupts are disabled for short periods.

My jury rigged way of trying to create similar
conditions seems to always have the ISR return with
the need_resched() flag set, so there is no difference
in idle state 0 entries per unit time between kernel
4.16-rc6 and one with the poll fixes added.

i.e. the difference between these numbers over some time:

cat /sys/devices/system/cpu/cpu*/cpuidle/state0/usage

Rik, I wonder if you see a difference with your real
workflow?

... Doug
