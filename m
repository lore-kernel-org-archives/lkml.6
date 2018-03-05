Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeCEQMX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:12:23 -0500
Received: from mailout6.zih.tu-dresden.de ([141.30.67.75]:51106 "EHLO
        mailout6.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751395AbeCEQMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:12:21 -0500
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Doug Smythies" <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <2048240.1dZKXsSxFh@aspire.rjw.lan>
From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Message-ID: <3c051023-312b-d2bc-34b5-40e8c13ca796@tu-dresden.de>
Date: Mon, 5 Mar 2018 16:36:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2048240.1dZKXsSxFh@aspire.rjw.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MSX-L104.msx.ad.zih.tu-dresden.de (172.26.34.104) To
 MSX-L104.msx.ad.zih.tu-dresden.de (172.26.34.104)
X-PMWin-Version: 4.0.3, Antivirus-Engine: 3.70.2, Antivirus-Data: 5.48
X-TUD-Virus-Scanned: mailout6.zih.tu-dresden.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-04 23:28, Rafael J. Wysocki wrote:
> use the expected idle period
> duration returned by cpuidle_select() to tell tick_nohz_idle_go_idle()
> whether or not to stop the tick.

I assume that at the point of going idle, the actual next scheduling
tick may happen anywhere between now and 1/HZ. If there is a mechanism
that somehow ensures that the next scheduling tick always happens 1/HZ
after going idle, then some of my arguments are invalid.

Ideally, the decision whether to disable the sched tick should
primarily depend on the order of tree upcoming events: the the sched
tick, the next non-sched timer, and the heuristic prediction:

   https://marc.info/?l=linux-pm&m=151384941425947&w=2

If I read the code correctly, there is already logic deep within
__tick_nohz_idle_enter that prevents disabling the sched tick when
it is scheduled to happen after another timer, which is a good primary
condition for not stopping the sched tick. However the newly added
condition prevents stopping the sched tick in more cases where it is
undesirable.
Assume duration_us is slightly less than USEC_PER_SEC / HZ.
and next sched tick will happen in 0.1 * USEC_PER_SEC / HZ
If the prediction was accurate, the cpu will be woken up way too soon
by the not-disabled sched tick.

I fear that might even create positive feedback loops on the
heuristic, which will take into account the sleep durations for
sched tick wakeups in sort of a self fulfilling prophecy:
1) The heuristic predicts to wake up in less than a full sched period,
2) The sched tick is kept enabled
3) The sched tick wakes up the system in less than a full sched period
4) Repeat

Even when sleeping for longer than target_residency of the deepest
sleep state, you can still improve energy consumption by sleeping
longer whenever possible.

On the opposite side - undesirable shallow sleeps - the proposed patch
will basically always keep the tick enabled if there is a higher sleep
state with a target_residency <= 1/HZ. On systems with relatively low
target_residencies, such as the ones that I am primarily
investigating, this should effectively prevent long shallow sleeps.
However, on mobile systems with C10 states > 5 ms the sched tick is
not a suitable fallback timer for preventing these issues. Well, maybe
the timer itself could be used, but with a larger expiry.

So IMHO
- the precise timer and vague heuristic should not be mixed
- decisions should preferably use actual time points rather than the
   generic tick duration and residency time.
- for some cases the sched tick as is may not be sufficient as fallback

Question: Does disabling a timer on a cpu guarantee that this cpu will
wake-up or is there a scenario where a timer is deleted or moved
externally without the cpu having a chance to change it's idle state?
