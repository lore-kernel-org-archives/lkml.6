Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524554799; cv=none;
        d=google.com; s=arc-20160816;
        b=XeNkmXpJGrdnMf7cbVz/n1KT1ijwv7rLQEN47VXTeZm5rcFg8Gqg6VENfYl29xI7+n
         qlddrL7pm9gWkemPofCSNvlKiD06FHvHUx1GOGfpBWjI09GEipD2xwm5j2Y2wR/mZy5w
         2g3vSA5Yy4qG8CWR0nP/nSKKBCnKekKpqU8wssAx7JvyRySolTw4G11Xsvy+S4DaCYhs
         in4NxyrlTC/8/BC5R7Cl6jaLzw/VNUc0A1aA2QQhAdAA8upUH87vx1ISsUJgIa4SgAmU
         besIt65h3LqsP49SADv7adiulbRpRHP4GFGLhuIrgE7Kg8znrQ5wgTwvsnMGod6HOjmU
         KvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AuhnbuwFHQVKXS/ie/3HnQ7qVGGHq976YJQ4Nv6qN5c=;
        b=DV5nYD6S4ajYvOZIZjmB177o2qlE+KoxsLeyrmF1JMSiP8SJZrFR94eiG7drdvcc5o
         v/PxX4XPxykcJokVw9T7RkjkYPofRReq6qz2Q81fdEL3JUe3vX3f4xKv6KVb5a8GNSa9
         K23oGm0DxCc4Nh2OP0k1wcqOGLFlmH1dtZor5rkkTzTgkW8pEYcDK+VWA80DQkT1K568
         rXZ4LgJ6600L8wfQiDSuxYTIvtDsf1g3n/0RLcchu0Ej+jRe+qbXRwZooUc5m+ELvGe0
         9T18gGMkCGV+4ZqME/cX1SpM2rnpPLlQrnIlE0JhUoHZDPmJrF56FEkvSE75TdJuR8g3
         j5Fg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=gAooYTtp;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=gAooYTtp;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AB8JxZp6HIlw0fOH15ZCN2alvHbZ5zeOW+kxt4xYpMToZ+6tCnzN0NPDItYeMJz7GV/rlZ/xwUXrnaJk8Tz4KP3Q6IU=
MIME-Version: 1.0
In-Reply-To: <b50d1a0d-4585-5c2b-bfc7-4f2ad023b753@lechnology.com>
References: <20180423183814.20615-1-brgl@bgdev.pl> <b50d1a0d-4585-5c2b-bfc7-4f2ad023b753@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 24 Apr 2018 09:26:37 +0200
Message-ID: <CAMRc=Md0vKTtYXOWAHv7mEZUqBWG7U4oF26xMwSL_u_wPZn9rg@mail.gmail.com>
Subject: Re: [RFC work-in-progress 0/7] of: platform: use early platform
 routines instead of OF_DECLARE
To: David Lechner <david@lechnology.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598563237980894406?=
X-GMAIL-MSGID: =?utf-8?q?1598611572702186636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-23 23:38 GMT+02:00 David Lechner <david@lechnology.com>:
> FYI: It looks like the CC for Stephen and Arnd was messed up, so I
> fixed.
>

Thanks!

> On 04/23/2018 01:38 PM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Hi David, Sekhar,
>>
>> since platform devices are generally considered more desirable than
>> CLK_OF_DECLARE, TIMER_OF_DECLARE etc. and we need to figure out how to
>> handle the clocks that need to be initialized early in the boot
>> process on DaVinci, I thought that I could give the early_platform
>> mechanism a try.
>>
>> This API is only used on one architecture (sh) but seems to work just
>> fine on ARM. It allows to register early platform drivers and then
>> probe them early in the boot process. So far only machine code is
>> supported but with a bit of hacking I was able to probe a DT device.
>>
>> This is a very dirty and far-from-upstream proof of concept that allows
>> to probe the (so far dummy) davinci timer platform device during the
>> call to init_time (from machine_desc).
>>
>> The idea is to have a special compatible fallback string: "earlydev"
>> that similarily to "syscon" would be added to device nodes that need
>> early probing. Then we'd call the of_early_platform_populate()
>> function that would find all compatible nodes and populate them
>> long before all the "normal" nodes.
>
>
> FWIW, "earlydev" sounds like a driver implementation detail, so not
> something that should be included in the device tree. We only need
> this because Linux needs a clocksource early on, but that doesn't
> mean that all device tree users need to do the same.
>
> I'm sure it makes things easier for a proof of concept though. :-)
>

We already have "syscon" which too is more an implementation detail
than HW description. I should have probably Cc'ed Rob Herring. I'll do
it with a more polished version I should have today.

>>
>> This would allow us to make the davinci timer a normal platform device
>> and possibly also probe the psc and pll drivers earlier than we do now.
>>
>> The early platform API even allows us to check if we're being probed
>> early in probe() so we can possibly probe the driver twice if needed:
>> only doing the critical stuff first and then completing the process
>> later.
>>
>> If you think this is a good idea, I would like to continue on that
>> and eventually make it an alternative to OF_DECLARE macros.
>>
>> For a quick conversion of the davinci timer to a platform driver
>> I image we'd need to use platform data lookup that would be passed
>> to of_early_platform_populate().
>
>
> On the surface, it certainly sounds like a good idea to me. Do we have
> access to struct device of the platform device when using this early
> platform device? I remember when I was working on the clock drivers, I
> tried registering a platform device in the init_time callback but the
> kernel crashed because kobj stuff was not initialized yet. I'm guessing
> that the early platform device somehow works around this.
>

Yes, it seems we do. I was getting kobj stack dumps too when trying to
register a device using just platform_device_register() and it went
away as soon as I switched to early platform.

Best regards,
Bartosz Golaszewski
