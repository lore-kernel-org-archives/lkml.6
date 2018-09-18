Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7FAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225622146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225622146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeISD2x convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbeISD2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:28:52 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D387307C94F;
        Tue, 18 Sep 2018 21:54:17 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-167.rdu2.redhat.com [10.10.122.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC0AD308BDA1;
        Tue, 18 Sep 2018 21:54:16 +0000 (UTC)
Subject: Re: [PATCH] clocksource: Warn if too many missing ticks are detected
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <1537295774-17975-1-git-send-email-longman@redhat.com>
 <alpine.DEB.2.21.1809182259110.1468@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5afd698b-2337-71ef-f118-7395c7991922@redhat.com>
Date:   Tue, 18 Sep 2018 17:54:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809182259110.1468@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 18 Sep 2018 21:54:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 05:07 PM, Thomas Gleixner wrote:
> Waiman,
>
> On Tue, 18 Sep 2018, Waiman Long wrote:
>
>> The clocksource watchdog, when running, is scheduled on all the CPUs in
>> the system sequentially on a round-robin fashion with a period of 0.5s.
>> A bug in the 4.18 kernel is causing missing ticks when nohz_full
>> is specified. Under some circumstances, this causes the watchdog to
>> incorrectly state that the TSC is unstable because of counter overflow
>> in the hpet watchdog clock source after a few minutes delay.
>>
>> That particular bug is fixed by the 4.19 commit 7059b36636beab ("sched:
>> idle: Avoid retaining the tick when it has been stopped"). To make it
>> easier to catch this kind of bug in the future, a check is added to see
>> if there is too much delay in the watchdog invocation and print a
>> warning once if it happens.
> I like the idea.
>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/time/clocksource.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>> index 0e6e97a..2ea5db0 100644
>> --- a/kernel/time/clocksource.c
>> +++ b/kernel/time/clocksource.c
>> @@ -140,6 +140,7 @@ static void inline clocksource_watchdog_unlock(unsigned long *flags)
>>   * Interval: 0.5sec Threshold: 0.0625s
>>   */
>>  #define WATCHDOG_INTERVAL (HZ >> 1)
>> +#define WATCHDOG_INTERNVAL_NS (NSEC_PER_SEC >> 1)
>>  #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
>>  
>>  static void clocksource_watchdog_work(struct work_struct *work)
>> @@ -242,6 +243,18 @@ static void clocksource_watchdog(struct timer_list *unused)
>>  		wd_nsec = clocksource_cyc2ns(delta, watchdog->mult,
>>  					     watchdog->shift);
>>  
>> +		/*
>> +		 * When the timer tick is incorrectly stopped on a CPU with
>> +		 * pending events, for example, it is possible that the
>> +		 * clocksource watchdog will stop running for a sufficiently
>> +		 * long enough time to cause overflow in the delta
>> +		 * computation leading to incorrect report of unstable clock
>> +		 * source. So print a warning if there is unusually large
>> +		 * delay (> 0.5s) in the invocation of the watchdog. That
>> +		 * can indicate a hidden bug in the timer tick code.
>> +		 */
>> +		WARN_ON_ONCE(!wd_nsec || wd_nsec > 2*WATCHDOG_INTERNVAL_NS);
> But this is using the watchdog delta to check. If that wrapped the
> detection is broken.
>
> I'd rather use watchdog_timer.expires and check against jiffies. That tells
> you how late the timer callback actually is and does not suffer any
> wraparound issues.

The clocksource_delta() function will deal with wrap-around in the
counter value. It is only when the counter advances more than 0x80000000
for 32-bit hpet counter mask that a value of 0 will be returned. That is
why I have a !wd_nsec check there. There is a small chance when the
warparound is just within the 1 second window that the test fails. In
this case, the following kind of warning will certainly be triggered:

[  578.890937] clocksource: timekeeping watchdog on CPU21: Marking
clocksource 'tsc' as unstable because the skew is too large:
[  578.890938] clocksource:                       'hpet' wd_now:
ee332105 wd_last: 544f80e7 mask: ffffffff
[  578.890939] clocksource:                       'tsc' cs_now:
4b6e6ccb5d609 cs_last: 4b679a469d09e mask: ffffffffffffffff
[  578.890954] tsc: Marking TSC unstable due to clocksource watchdog
[  578.890963] TSC found unstable after boot, most likely due to broken
BIOS. Use 'tsc=unstable'.
[  578.890965] sched_clock: Marking unstable (578920214163,
-28725675)<-(579047174801, -156217937)
[  578.891056] clocksource: Switched to clocksource hpet

Another reason that I used wd_nsec is because the data has already been
computed.

I am perfectly fine to use the watchdog_timer.expires as suggested, though.

Cheers,
Longman

watchdog_timer.expires


