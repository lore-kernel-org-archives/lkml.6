Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161060AbeBPQqj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:46:39 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:56273 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755487AbeBPQqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:46:23 -0500
X-Google-Smtp-Source: AH8x227dagXojDzBziIPGdX3iqhNsqewcDk1hvqj20GPg07yYxxaBhJlS0ok2g+zeHXOvK47jsFHUxkgtshE6+B8T74=
MIME-Version: 1.0
In-Reply-To: <20180206012027.GF46524@dtor-ws>
References: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
 <CAH9NwWeom2H89D5hUixxSL28YgDna_WS26boayzUBAPyVFUvTA@mail.gmail.com> <20180206012027.GF46524@dtor-ws>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 16 Feb 2018 17:46:01 +0100
Message-ID: <CAH9NwWdLqQCrsFtmYC5wHy2hZ38MZfPexF4QuJ0z56dyXYf7ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] input: touchscreen: ar1021_i2c: enable touch mode
 during open
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-06 2:20 GMT+01:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Mon, Feb 05, 2018 at 11:07:08AM +0100, Christian Gmeiner wrote:
>> Hi all.
>>
>> 2017-04-27 14:22 GMT+02:00 Martin Kepplinger <martin.kepplinger@ginzinger.com>:
>> > The device could as well be in command mode, in which this driver cannot
>> > handle the device. When opening the device, let's make sure the device
>> > will be in the mode we expect it to be for this driver.
>> >
>>
>> I run into issues caused by this change. It turns out that the device
>> is non-functional
>> after some warm-reboots and as a result I am not able to use xorg's
>> evdev driver.
>> So I have some questions about this change:
>>
>> * Should we enable irq before calling i2c_master_send(..) as the chip raises an
>>   irq if the command was processed?
>
> Well, we do not care about the response... However, what is your
> interrupt trigger settings? Are you using edge by chance? If so, please
> try switching to level.
>

We may should take care of the response. I have seen strange responses
after the third open of the device.

&i2c2 {
       ar1021@4d {
               compatible = "microchip,ar1021-i2c";
               reg = <0x4d>;
               interrupt-parent = <&gpio3>;
               interrupts = <26 IRQ_TYPE_EDGE_RISING>;
       };
};

I am not sure if this is really the cause of the problem! As without this commit
my device survives one week of a automated touch-press-test done with some
mechanical gear and with the help of an SPS.

>>
>> * Would it be enough to send this command only once during driver
>> lifetime? I can
>>   see that on my system open gets called 3 times during boot-up.
>>
>> * What are the circumstances the touch device would be in an other state? In the
>>   official kernel driver the userspace can send commands via sysfs.
>> Also the driver
>>   does set the touch enable mode as this patch does.
>
> What is "the official kernel driver"?
>

http://ww1.microchip.com/downloads/en/DeviceDoc/AR1020-AR1021-LINUX-SPI-I2C-V102.tar.gz

As it is release time at my company I had to stop finding the root
cause but will look into the issue
again in 2-3 weeks.


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info
