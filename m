Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A188C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2185920837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2185920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeFUIm4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:42:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46762 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932636AbeFUImx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:42:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C9B33277A40
Subject: Re: [PATCH v2 2/2] cros_ec: Move cros_ec_dev module to drivers/mfd
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        lkml <linux-kernel@vger.kernel.org>, thierry.escande@linaro.org,
        Gwendal Grignou <gwendal@chromium.org>
References: <1511194526-3729-1-git-send-email-thierry.escande@collabora.com>
 <1511194526-3729-3-git-send-email-thierry.escande@collabora.com>
 <CAKdAkRRtv41c-s7vunaBde9Oj8L5b5YdfHcOFEueGYenHV=byg@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <bb1bc51a-3ff9-a885-7037-55306d1af564@collabora.com>
Date:   Thu, 21 Jun 2018 10:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKdAkRRtv41c-s7vunaBde9Oj8L5b5YdfHcOFEueGYenHV=byg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

I think I can answer some of your questions (not all).

cc'ing the new Thierry's address and Gwendal.

On 21/06/18 01:05, Dmitry Torokhov wrote:
> On Mon, Nov 20, 2017 at 8:18 AM Thierry Escande
> <thierry.escande@collabora.com> wrote:
>>
>> The cros_ec_dev module is responsible for registering the MFD devices
>> attached to the ChromeOS EC. This patch moves this module to drivers/mfd
>> so calls to mfd_add_devices() are not done from outside the MFD subtree
>> anymore.
> 
> I am quite a bit late to the party, but what's the rationale for not
> using mfd_add_devices() from outside of MFD tree? We do allow
> registering i2c clients from outside of i2c core, and spi from outside
> of spi core, etc, etc.
> 

What I can say here is that when I tried to use mfd_add_devices outside the mfd
Lee has the preference to not to do this. That's the main reason why we moved
cros_ec_dev to mfd subsystem. The origin of this discussion started here [1] and
iirc after talk with Lee via irc he was not agree to use mfd_add_devices outside
the mfd subsystem (Lee correct me if I am wrong). So, is Lee who can add the
reasoning here.

[1] https://www.spinics.net/lists/kernel/msg2465099.html

> Right now I see cros_ec being split, quite haphazardly, between
> drivers/platform/chrome and drivers/mfd, with some transport drivers
> (i2C, SPI) and some interfaces living in MFD, while LPC transport and
> host of other stuff living in drivers/platform. On top of that we have
> cros_ec_keyb in input, RTC drivers, CEC, and god knows what else
> spread across various subsystems:
> 

Move the transport driver to platform/chrome is on my TODO, I didn't send the
patches to upstream yet, sorry about that.

About having the driver spread across various subsystem I don't have a hard
opinion. I suppose that this is because is the common way for mfd cells,
although, in this case, it is true that the drivers are very ChromeOS specific,
so maybe has sense have all in platform/chrome. On the other side, if you put
all in platform/chrome you will probably lost the advantage of have the
maintainer of the subsytem reviewing the patches (just because he filters the
drivers that doesn't go their subsystem).

> dtor@dtor-ws:~/kernel/linus $ find -name 'cros_ec*.c'
> ./drivers/iio/light/cros_ec_light_prox.c
> ./drivers/iio/accel/cros_ec_accel_legacy.c
> ./drivers/iio/pressure/cros_ec_baro.c
> ./drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> ./drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> ./drivers/mfd/cros_ec_spi.c
> ./drivers/mfd/cros_ec.c
> ./drivers/mfd/cros_ec_i2c.c
> ./drivers/mfd/cros_ec_dev.c
> ./drivers/input/keyboard/cros_ec_keyb.c
> ./drivers/platform/chrome/cros_ec_vbc.c
> ./drivers/platform/chrome/cros_ec_debugfs.c
> ./drivers/platform/chrome/cros_ec_lpc.c
> ./drivers/platform/chrome/cros_ec_lightbar.c
> ./drivers/platform/chrome/cros_ec_lpc_reg.c
> ./drivers/platform/chrome/cros_ec_proto.c
> ./drivers/platform/chrome/cros_ec_lpc_mec.c
> ./drivers/platform/chrome/cros_ec_sysfs.c
> 
> The fact that sysfs/debugfs code is in platform but we instantiate it
> from MFD is pure madness (it's driver private data, there is no reason
> why it should be exported to nclude/linux/mfd/cros_ec.h). This all
> creates unnecessary friction and I would love to move most of the code
> into drivers/platform/chrome.
> 

Ack.

> I see the wisdom of having code that could potentially be used in
> several systems in respective subsystems code (pretty much majority of
> drivers/mfd/ drivers are for chips/IP blocks that are used and reused
> by different systems and boards), but I think cros ec is quite
> different in that regard as it is only used by ChromeOS devices and
> has little to no chance to be useful anywhere else.
> 
> Thanks.
> 

Cheers,
 Enric
