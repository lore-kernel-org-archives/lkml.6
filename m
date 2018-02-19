Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeBSKhk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:37:40 -0500
Received: from mail01.prevas.se ([62.95.78.3]:1867 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752322AbeBSKhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:37:39 -0500
X-IronPort-AV: E=Sophos;i="5.46,534,1511823600";
   d="scan'208";a="3264749"
Subject: Re: 500 ms delay in time saved into RTC
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Igor Plyatov <plyatov@gmail.com>
CC: <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>,
        <util-linux@vger.kernel.org>
References: <30ae185f-28c9-54f1-2884-4ee7801b130e@gmail.com>
 <34f50661-85f5-eb46-3ff7-45f0c2bb5960@prevas.dk>
 <c91e0079-c31f-715d-bb2e-648af34565d7@gmail.com>
 <20180219100754.GL14177@piout.net>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <33e30f44-c774-1130-0461-4b48a58f9c4a@prevas.dk>
Date: Mon, 19 Feb 2018 11:37:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219100754.GL14177@piout.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.8.31]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-19 11:07, Alexandre Belloni wrote:
> On 19/02/2018 at 12:16:04 +0300, Igor Plyatov wrote:
>> Dear Rasmus,
>>
>> thank you very much for explanation!
>>
>> I have set "RTC_SET_DELAY_SECS = 0.0" in hwclock.c and got acceptable
>> result.
>>
>> It wonder why such critical function does not implemented on kernel level in
>> RTC driver?
>> It is very strange to rely on specific HW in user space SW.
>>
> 
> Because of the way the API is designed, handling the MC146818A oddity is
> not possible in the driver (i.e. 50% of the time, it will be too late
> to handle it).

Well, I suppose one could implement an ioctl that would not actually
take a struct rtctime from userspace but simply use the current value of
clock_realtime (which is what 99% of rtc_set_times are using anyway),
and doing it as accurately as possible (which requires implementations
in each driver) - i.e., have the kernel do the appropriate sleeping
which is currently done in userspace: a generic implementation of that
ioctl would sleep until clock_realtime is a whole second, while the x86
driver could sleep until a .5 second. Sure, clock_realtime can jump or
get adjusted while we sleep, and we can oversleep for all kinds of
reasons, but the kernel is in a much better position to do the sleeping
and knowing when to attempt the rtc setting than userspace.

Said ioctl could also take an integer offset to apply to the
clock_realtime value to support setting the rtc to some non-UTC timezone.

> You can use busybox hwclock which has the x86 insanity commented out:
> https://git.busybox.net/busybox/tree/util-linux/hwclock.c 

No, the code that is commented out is code that would actually try to do
the rtc setting at a whole (system clock) second, which is what one
wants on non-x86. It is apparently commented out because aiming for a
whole second is not the right thing to do on some platforms (i.e., x86).
So the current busybox code, on rtcs which set the fractional part to 0,
end up discarding (losing) some uniformly distributed number from [0,1]
instead of consistently .5 seconds.

Also, AFAIR, the busybox code which implements the --hctosys doesn't do
anything to do it right after the rtc has incremented, losing another
[0, 1] uniformly.

Rasmus
