Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeCYA2U (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 20:28:20 -0400
Received: from cmta16.telus.net ([209.171.16.89]:51524 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752596AbeCYA2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 20:28:18 -0400
X-Authority-Analysis: v=2.2 cv=EJrp6xRC c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=hKllpQOUrfQXysdyzWgA:9
 a=CjuIK1q_8ugA:10
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: w74pegSSBpApsw74ueHlNx
In-Reply-To: w74pegSSBpApsw74ueHlNx
Subject: RE: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Sat, 24 Mar 2018 17:28:10 -0700
Message-ID: <001401d3c3d0$2a4623d0$7ed26b70$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdO7ne+4zbK4uNEUQPizGgVG9Sn9lwIHFyDA
Content-Language: en-ca
X-CMAE-Envelope: MS4wfNS/WqVqbh1MjUTsIYLCWndSKyth4D8ALJvctaKIXajqsJNEfFiyPJaFwxjg9J5BRZa5NxMQjd2gzvDnOpIKNG/zuzj6IykHJqBoGIz3/DFqQ5cJrj3y
 lu6y/Wd82wUun8Oy5/itNkYOWikBCEpt6d1WoMY9m/Aa0Ahhihd/Szxc1bKgPbYiDWeNS+Mq5VxnJwLZJ2pTUU1QvssCNiJ4jfWbLWITyhbs75IsCtI1HWbL
 kwAxhHlpCYZ+ou3q92sCn70W5slMl4lBJzyC4FP0pn/qjAiNcn7/YeUo30eFm/3kIBBvT0SXxWdBBUhGD0mMX9qm5gupLAI6C9LF42/8vV6ScWQV077UDe7g
 76inkhBirHV4VUoV3wP14WgwWPi1rTg0slROsc0/+dN84ChAY8XLLo6HdATH6FRXwTA0Ypxhkj0BJkCGLkdOYfnVB17tiY2mnnMV/WYs2G/AYFbxFRZOdAQ5
 HiSUq5kPr9Gu7y04ZjZMiuy1iTls3SpvTw9cE6ZXsjgtm3ysJD1Vv60rfEY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.14 07:04 Rafael J. Wysocki wrote:

> If poll_idle() is allowed to spin until need_resched() returns 'true',
> it may actually spin for a much longer time than expected by the idle
> governor, since set_tsk_need_resched() is not always called by the
> timer interrupt handler.  If that happens, the CPU may spend much
> more time than anticipated in the "polling" state.
>
> To prevent that from happening, limit the time of the spinning loop
> in poll_idle().

...[snip]...

> +#define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)

The other ongoing threads on this aside, potentially, there might
be another issue.

What if the next available idle state, after 0, has a residency
that is greater than TICK_NSEC / 16? Meaning these numbers, for example:

/sys/devices/system/cpu/cpu0/cpuidle/state*/residency

The suggestion is that upon a timeout exit from idle state 0,
the measured_us should maybe be rejected, because the statistics
are being biased and it doesn't seem to correct itself.

Up to 1300% (<- not a typo) extra power consumption has been observed.

Supporting experimental data:

My processor: 
/sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
/sys/devices/system/cpu/cpu0/cpuidle/state2/residency:20
/sys/devices/system/cpu/cpu0/cpuidle/state3/residency:211 <<< Important
/sys/devices/system/cpu/cpu0/cpuidle/state4/residency:345

A 1000 Hz kernel (TICK_NSEC/16) = 62.5 nsec; idle system:

Idle state 0 time: Typically 0 uSec.
Processor package power: 3.7 watts (steady)

Now, disable idle states 1 and 2:

Idle state 0 time (all 8 CPUs): ~~ 430 Seconds / minute
Processor package power: ~52 watts (1300% more power, 14X)

A 250 Hz kernel (TICK_NSEC/16) = 250 nSec; idle system:

Idle state 0 time: Typically < 1 mSec / minute
Processor package power: 3.7 to 3.8 watts

Now, disable idle states 1 and 2:

Idle state 0 time (all 8 CPUs): Typically 0 to 70 mSecs / minute
Processor package power: 3.7 to 3.8 watts

A 1000 Hz kernel with:

+#define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 4)

Note: Just for a test. I am not suggesting this should change.

instead. i.e. (TICK_NSEC/4) = 250 nSec.

Idle state 0 time: Typically 0 uSec.
Processor package power: 3.7 watts (steady)

Now, disable idle states 1 and 2:

Idle state 0 time (all 8 CPUs): Typically 0 to 70 mSecs / minute
Processor package power: ~3.8 watts

Note 1: My example is contrived via disabling idle states, so
I don't know if it actually needs to be worried about.

Note 2: I do not know if there is some processor where
cpuidle/state1/residency is > 62.5 nSec.

Note 3: I am trying to figure out a way to test rejecting
measured_us upon timeout exit, but haven't made much progress.

... Doug
