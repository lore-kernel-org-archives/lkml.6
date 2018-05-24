Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034725AbeEXWI1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:08:27 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:43870 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966031AbeEXWIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:08:25 -0400
X-Google-Smtp-Source: AB8JxZoDqJaiY50CLt7+86ue9pXJcIJF8PQq7v+8/co67XIBtlsBDMAnBuYRWXCIYhE/r55C30TszESo8bMyx5B+2qI=
MIME-Version: 1.0
In-Reply-To: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
References: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
From: Tomas Hlavacek <tomas.hlavacek@nic.cz>
Date: Fri, 25 May 2018 00:08:23 +0200
X-Google-Sender-Auth: pzUS5RofwgfTg9IgB-vvrHigzRU
Message-ID: <CAEB7QLBcLnv4JYphjxqESqofTbGyVWOd6QYKzfvdEZyDXH9LLQ@mail.gmail.com>
Subject: Re: led: hw-trigger, global brightness and multi-colored leds
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4OM8na2031016

Hi!

On Wed, May 2, 2018 at 5:11 PM, Uwe Kleine-König <uwe@kleine-koenig.org> wrote:
> Hello,
>
> on the Turris Omnia[1] the LEDs are controllable via an i2c device.
...
> Now I wonder how to match these two features to the LED device model. Do
> you have an idea?

That is an interesting question - I was quite clueless about that two
years ago - when I wrote the driver for Omnia LEDs
(https://github.com/tmshlvck/omnia-linux/blob/omnia/drivers/leds/leds-omnia.c).
I didn't even made an attempt to send it to upstream because it
obviously does not fit to the LED device model.

The fundamental problems were:

1) Sending commands over I2C to the MCU that drives LEDs is quite
slow. Therefore the interface is optimized for doing incremental
changes and batch changes. (Btw. the protocol description is here
https://gitlab.labs.nic.cz/hw/omnia_hw_ctrl/blob/master/turris_omnia_i2c_desc.adoc
).

2) "native" or autonomous mode means that MCU that drives LEDs take
independently wired (on/off) input from switch, PHY or PCI cards
without any kernel interaction, but color settings and brightness for
each individual LED are still active, just the on/off/blink trigger is
autonomous.

3) There is a global brightness (autonomous PWM control for cathode of
all LEDs - the best method for LED dimming, running on few MHz).

4) Per-LED brightness works, however PWM is running on just few
hundreds of kHz and when all LEDs are dimmed and you watch carefully,
you can see intermittent flickering.

5) The abstraction in the protocol (mentioned in (1)) is actually
counting 3 LEDs (separate RGB) as one arbitrary-color LED. The reason
was to save bandwidth on I2C I guess, because color is expected to
change less frequently than brightness.

But I also have good news: The FW of the MCU is also OSS (see the repo
in the link (1)). There is a method for flashing the MCU over I2C from
Linux and there is JTAG connector for the MCU, in case un-bricking is
needed. Therefore the LED protocol can be changed to be more sensible
and/or it is even possible to emulate some existing HW LED driver chip
in Omnia MCU and reuse OSS driver for that chip.

Tomas
