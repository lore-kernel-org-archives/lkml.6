Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E94ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7B5208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7B5208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeGOKse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:48:34 -0400
Received: from www381.your-server.de ([78.46.137.84]:43979 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeGOKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:48:33 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1feeDx-0006Fw-Mg; Sun, 15 Jul 2018 12:25:53 +0200
Received: from [188.174.116.68] (helo=[192.168.178.33])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1feeDx-0005l9-DP; Sun, 15 Jul 2018 12:25:53 +0200
Subject: Re: [PATCH] [v2] Documentation: document ktime_get_*() APIs
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, david@fromorbit.com,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, willy@infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180710144737.1136856-1-arnd@arndb.de>
 <CACRpkdY5oMG0WknSEnG1khTTm_UKwWwdAbAthA54geGhqgyXpQ@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2d5fd2ac-6f82-557a-326b-d8ce0f293ef2@metafoo.de>
Date:   Sun, 15 Jul 2018 12:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdY5oMG0WknSEnG1khTTm_UKwWwdAbAthA54geGhqgyXpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24754/Sun Jul 15 06:52:15 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 09:24 AM, Linus Walleij wrote:
> On Tue, Jul 10, 2018 at 4:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> As Dave Chinner points out, we don't have a proper documentation for the
>> ktime_get() family of interfaces, making it rather unclear which of the
>> over 30 (!) interfaces one should actually use in a driver or elsewhere
>> in the kernel.
>>
>> I wrote up an explanation from how I personally see the interfaces,
>> documenting what each of the functions do and hopefully making it a bit
>> clearer which should be used where.
>>
>> This is the first time I tried writing .rst format documentation, so
>> in addition to any mistakes in the content, I probably also introduce
>> nonstandard formatting ;-)
>>
>> I first tried to add an extra section to
>> Documentation/timers/timekeeping.txt, but this is currently not included
>> in the generated API, and it seems useful to have the API docs as part
>> of what gets generated in
>> https://www.kernel.org/doc/html/latest/core-api/index.html#core-utilities
>> instead, so I started a new file there.
>>
>> I also considered adding the documentation inline in the
>> include/linux/timekeeping.h header, but couldn't figure out how to do
>> that in a way that would result both in helpful inline comments as
>> well as readable html output, so I settled for the latter, with
>> a small note pointing to it from the header.
>>
>> Cc: Dave Chinner <david@fromorbit.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> v2: minor changes suggested by Randy
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> This brings into question commit bc2b7dab629a5
> "iio:core: timestamping clock selection support"
> that has bothered me for some time. Now that is ABI, but
> we might be able to do some recommendations based on the
> time base and have a sensible default moving forward.
> 
> As I want to make that clock base parsing similar for GPIO
> I first thought it was a good idea to support the same clocks,
> but now it seems like a bad idea.
> 
> IIRC you told me to simply hammer down the clock that
> makes the most sense.
> 
> At the same time userspace libraries (such as GNU radio) will
> be confused if they can't match the timestamping clocks,
> as correlating GPIO and IIO events is something they will
> want to do. And I guess these clocks are there for a reason.
> 
> So asking Lars-Peter and Gregor: from a userspace point
> of view, what makes most sense for the usecases you
> have seen? Having one consistent time base or all of these
> as we currently have? Different clocks under different
> circumstances?

It is a question of correlation. What other events do you want to correlate
your events to.

If you only want to correlate events to other events from the same source
(i.e. know the amount of time that has elapsed between two events) the best
in my opinion is a monotonic clock. You can't account for changes to the
realtime clock and it will screw up your measurements when it changes in
between two events.

Now for monotonic clocks there are two variants available MONOTONIC and
BOOTTIME. BOOTTIME will account for time that the device has been in
suspend, MONOTONIC will not. Most applications will not care for either. But
those which care about it and want to measure the duration between two
events will most likely prefer BOOTTIME, especially if the wakeup event was
caused by the device itself.

So in my opinion BOOTTIME is the most sensible default.

REALTIME should probably also be an option in case you want to correlate
your events to other events for which only a REALTIME timestamp is available
or when the absolute time matters rather than the relative time. This could
for example be rare events and you want to log time and date when they happened.

Right now I can't think of a usecase where soembody would prefer MONOTONIC
over BOOTTIME, but I'm sure there are some.

TAI and MONOTONIC_RAW are kind of the same thing. They are more immune to
changes of the exact duration of what is reported as a second. I'm sure
there are special applications that would prefer this over REALTIME and
MONOTONIC.

The only thing that is probably not really needed are the coarse variants.
But even there I could see people arguing that it serves their performance
and precision requirements better.

And to make this a lot more complicated many applications, especially in the
high-speed area, don't really care about the system time as reported by the
CPU (or a on-SoC timer) at all. They care about the time as reported by a
clock that is synchronous to the signal processing itself.

Different oscillators in a system will run at slightly different
frequencies, even if they are nominal the same frequency. So if you have 1
counter that says 1 second has elapsed another might say that 1.0001 seconds
have elapsed. If you do timestamping using a clock that is not synchronous
to your signal processing clock your results will be imprecise.

So that is something to keep in mind. Beyond just the system clock we might
want to have the ability to assign other timestamp sources in a way that is
consistent across subsystems. So that we can for example as you said
correlate events between IIO and GPIO.
