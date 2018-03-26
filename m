Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbeCZGBp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:01:45 -0400
Received: from cmta16.telus.net ([209.171.16.89]:37638 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeCZGBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:01:43 -0400
X-Authority-Analysis: v=2.2 cv=EJrp6xRC c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8
 a=3oCXvdm__O8CtFXvTRQA:9 a=aqfI2Y7znZ4Iv96F:21 a=boWLWCHAhw08seaY:21
 a=QEXdDO2ut3YA:10 a=7715FyvI7WU-l6oqrZBK:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
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
References: <001401d3c3d0$2a4623d0$7ed26b70$@net> 04DXfkAmXQdbp04DYfFszC
In-Reply-To: 04DXfkAmXQdbp04DYfFszC
Subject: RE: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Sun, 25 Mar 2018 23:01:37 -0700
Message-ID: <003501d3c4c7$e9a188d0$bce49a70$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdPEL+1xLGkwpwoURkmUq8fkINp7oAAFqLGg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfBkxfIKNYxg7wIoNN1OSUaMkTZgSieP6U3tKE/LtxXnHgg6sicRZNRO27tvvMb4md0gihYdYB5G6UG/OI/3Qvp+32+BjtgJ4qNnNuu7LJqW1ngtcznpu
 G5A6EAgATKk+rzFia/fXWpnCKPFDyWYnOmDhSSOEj1AjQpX1pr/mvvxS8pzFfa2af+KrIo+Ruqxd+TLq/HGQ5xoEYBRL6RCX1A4NV6abkh6XR/WFsRRcEL+7
 49KB4sgi5MNSnLM3ZlJz9NS7A0bULqo85Rntrb/TFUBHXdc5lvXuKP7+KM7BOTowp406+D1vIUDQoTYQx8pRl2uSLSVCglFvrFZUTq2Bziq+V5Q1NLRiaXBw
 TcCDue9LV9UbHh3PALYiPokPpGUIMZJHSr7eK3uCUQdSJrqEHtpHr6hqZacrGd/PsDY3P6FmuH2lHBZUIBww4kAQIjg1t9C38hx/Z9EVbiWqd/ExOKPPBK1j
 d2Z6ljpC+aXq6pFnvWqie0jKqwPIWUebz86Ujx92VzkkiNyVUufMIIjoeA98pQM3Q5XWwymiuQvvi+t65MdVMGd6QmIwaJPaTuUyEg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.25 04:54 Rafael J. Wysocki wrote:
> On Sun, Mar 25, 2018 at 1:28 AM, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2018.03.14 07:04 Rafael J. Wysocki wrote:
>>
>>> If poll_idle() is allowed to spin until need_resched() returns 'true',
>>> it may actually spin for a much longer time than expected by the idle
>>> governor, since set_tsk_need_resched() is not always called by the
>>> timer interrupt handler.  If that happens, the CPU may spend much
>>> more time than anticipated in the "polling" state.
>>>
>>> To prevent that from happening, limit the time of the spinning loop
>>> in poll_idle().
>>
>> ...[snip]...
>>
>>> +#define POLL_IDLE_TIME_LIMIT (TICK_NSEC / 16)
>>
>> The other ongoing threads on this aside, potentially, there might
>> be another issue.
>>
>> What if the next available idle state, after 0, has a residency
>> that is greater than TICK_NSEC / 16? Meaning these numbers, for example:
>>
>> /sys/devices/system/cpu/cpu0/cpuidle/state*/residency
>>
>> The suggestion is that upon a timeout exit from idle state 0,
>> the measured_us should maybe be rejected, because the statistics
>> are being biased and it doesn't seem to correct itself.
>
> OK
>
>> Up to 1300% (<- not a typo) extra power consumption has been observed.
>>
>> Supporting experimental data:
>>
>> My processor:
>> /sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
>> /sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
>> /sys/devices/system/cpu/cpu0/cpuidle/state2/residency:20
>> /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:211 <<< Important
>> /sys/devices/system/cpu/cpu0/cpuidle/state4/residency:345
>>
>> A 1000 Hz kernel (TICK_NSEC/16) = 62.5 nsec; idle system:
>
> nsec or usec?

Right, uSeconds.

>> Idle state 0 time: Typically 0 uSec.
>> Processor package power: 3.7 watts (steady)
>>
>> Now, disable idle states 1 and 2:
>>
>> Idle state 0 time (all 8 CPUs): ~~ 430 Seconds / minute
>> Processor package power: ~52 watts (1300% more power, 14X)
>
> But that's because you have disabled states 1 and 2, isn't it?

Yes, and perhaps the conclusion here is that we don't care if
the user has disabled intermediate idle states, forcing these
conditions.

>> A 250 Hz kernel (TICK_NSEC/16) = 250 nSec; idle system:
250 uSec.
>>
>> Idle state 0 time: Typically < 1 mSec / minute
>> Processor package power: 3.7 to 3.8 watts
>>
>> Now, disable idle states 1 and 2:
>>
>> Idle state 0 time (all 8 CPUs): Typically 0 to 70 mSecs / minute
>> Processor package power: 3.7 to 3.8 watts
>>
>> A 1000 Hz kernel with:
>>
>> +#define POLL_IDLE_TIME_LIMIT   (TICK_NSEC / 4)
>>
>> Note: Just for a test. I am not suggesting this should change.
>>
>> instead. i.e. (TICK_NSEC/4) = 250 nSec.
250 uSec.
>>
>> Idle state 0 time: Typically 0 uSec.
>> Processor package power: 3.7 watts (steady)
>>
>> Now, disable idle states 1 and 2:
>>
>> Idle state 0 time (all 8 CPUs): Typically 0 to 70 mSecs / minute
>> Processor package power: ~3.8 watts
>>
>> Note 1: My example is contrived via disabling idle states, so
>> I don't know if it actually needs to be worried about.
>>
>> Note 2: I do not know if there is some processor where
>> cpuidle/state1/residency is > 62.5 nSec.
62.5 uSec.
> If that's usec, I would be quite surprised if there were any. :-)

O.K.

>> Note 3: I am trying to figure out a way to test rejecting
>> measured_us upon timeout exit, but haven't made much progress.
>
> Rejecting it has side effects too, because it basically means lost information.
>
> Reaching the time limit means that the CPU could have been idle much
> longer, even though we can't say how much.  That needs to be recorded
> in the data used for the next-time prediction or that is going to be
> inaccurate too.
>
> Of course, what number to record is a good question. :-)

Maybe it would be O.K. to be aware of this and simply move on.

By the way, I forgot to mention that the above work was done
with kernels based on 4.16-rc6 and only these poll_idle patches.
If I then add the V7.3 idle loop rework patch set, the issue
becomes partially mitigated (151 minute averages):
Idle state 0 time (all 8 CPUs): ~~ 304 Seconds / minute
Processor package power: ~47.7 watts

It'll be tomorrow before I can try the suggestion from the other e-mail.

... Doug
