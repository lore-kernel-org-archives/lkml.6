Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeECVPs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:15:48 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38836 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeECVPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:15:47 -0400
X-Google-Smtp-Source: AB8JxZrY1tRtVZKOoK1xHp1rm1bbVCSEpUc8utHVcVAh9kkvLZjLOMnUwUAGoEbbRRKXM128RQSgvQ==
Subject: Re: led: hw-trigger, global brightness and multi-colored leds
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Tomas Hlavacek <tomas.hlavacek@nic.cz>
References: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
 <20180502212105.GA9869@amd>
 <69651d45-7566-95ad-2a83-53dd76e5680e@kleine-koenig.org>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <4b8da1c0-60a6-e19c-379d-9649036c9ba4@gmail.com>
Date: Thu, 3 May 2018 23:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <69651d45-7566-95ad-2a83-53dd76e5680e@kleine-koenig.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe and Pavel,

On 05/03/2018 08:49 PM, Uwe Kleine-König wrote:
> Hello Pavel,
> 
> On 05/02/2018 11:21 PM, Pavel Machek wrote:
>>> on the Turris Omnia[1] the LEDs are controllable via an i2c device. Each
>>> LED can be either in "manual mode" or in a mode I'd call "native mode"
>>> which is the default. In this native mode the LED being on or off
>>> depends on an input line that is controlled by another hardware. So a
>>> LED signals for example activity on the WAN ethernet port without any
>>> software intervention, but can be used as a normal LED, too, when in
>>> "manual mode" where it can be switched on and off by a register
>>> write.
>>
>> "Native mode" is quite common. We have it for example on Nokia N900
>> here (charger has hw option to automatically control the LED).
> 
> git grep -i n900 -- drivers/leds doesn't yield any output. Do I miss
> anything?
> 
>> I believe reasonable solution would be to have "hardware" trigger, and
>> have it selected by default. When active, LED would be controlled by
>> hardware.

The question is whether there is a way for a driver to tell whether
the device is in the manual or in the native mode. If yes,
then we could just return -EBUSY on any attempt of brightness setting
when in the native mode.

Also, if it is possible to detect brightness changes originating
from hardware, then we have an optional brightness_hw_changed sysfs
file supporting POLLPRI events
(compare drivers/platform/x86/thinkpad_acpi.c).

If we can't tell whether the LED is in native or manual mode,
but it is possible to read the current brightness from a register, then
implementing brightness_get op will allow to detect it indirectly (to
some extent since we cannot guarantee that brightness is not changed
by another process).

In each case I'd rather not use trigger mechanism here, which is
defined as __kernel__ based source of LED events.

> There is no prior art for that available as source code, right?
> 
>>> Another feature of the LED device is that there is a global brightness
>>> register that influences all LED's brightness (if on) independent of the
>>> operating mode.
>>
>> We can't describe that easily.
> 
> Given that I can give an RGB value (i.e. 3x 8 bit) for the LED, I can
> change brightness per LED. Have to play around a bit.
> 
>>> Further the color of each LED can be set to an RGB triplet.
>>
>> We normally handle RGB LED as three independend LEDs, like
>> notify::red, notify::green, notify::blue. Again, example is Nokia N900
>> or Motorola Droid 4.
> 
> I cannot find source code for LEDs on the Droid 4 either.
> 
> An ugly property here is that the hardware trigger only operates on all
> three colors at once. Hmm, will think a bit about the way to go.
> 
> Best regards and thanks for your input,
> Uwe
> 

-- 
Best regards,
Jacek Anaszewski
