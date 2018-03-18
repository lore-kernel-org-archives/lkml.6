Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbeCRO2g (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 10:28:36 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:37858 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754197AbeCRO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 10:28:34 -0400
X-Google-Smtp-Source: AG47ELtBfPyadxnI4UFdTjN2vfH0Nba0YP7JHV4wqJJ2l/dCcCRM1YlsXrMwSzkpb//650blIWD5fw==
Date: Sun, 18 Mar 2018 15:24:57 +0100 (CET)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
X-X-Sender: elektroman@T420s
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Alan Mizrahi <alan@mizrahi.com.ve>, Richard Purdie <rpurdie@rpsys.net>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] leds: fix wrong dmi_match on PC Engines APU LEDs
In-Reply-To: <b51f1f41-e06e-25e6-30f8-a2b9f7e8ffb8@gmail.com>
Message-ID: <alpine.LNX.2.00.1803181509330.7595@T420s>
References: <20180305170910.8905-1-ulli.kroll@googlemail.com> <b51f1f41-e06e-25e6-30f8-a2b9f7e8ffb8@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek

On Sat, 10 Mar 2018, Jacek Anaszewski wrote:

> Hi Hans,
> 
> Thank you for the patch.
> 
> On 03/05/2018 06:09 PM, Hans Ulli Kroll wrote:
> > APU has compared to APU2 no DMI_BOARD_NAME.
> > Use DMI_PRODUCT_NAME instead.
> 
> Could we have the commit message more expressive?
> 
> Is it that now this driver doesn't work for APU board?

Yes it doesn't work for my APU board.
I've already checked the updated driver in -next

As you can see here
# grep . /sys/class/dmi/id/*
/sys/class/dmi/id/bios_date:04/05/2014
/sys/class/dmi/id/bios_vendor:coreboot
/sys/class/dmi/id/bios_version:SageBios_PCEngines_APU-45
/sys/class/dmi/id/chassis_type:3
/sys/class/dmi/id/chassis_vendor:PC Engines
/sys/class/dmi/id/modalias:dmi:bvncoreboot:bvrSageBios_PCEngines_APU-45:bd04/05/2014:svnPCEngines:pnAPU:pvr1.0:cvnPCEngines:ct3:cvr:
/sys/class/dmi/id/product_family:None Provided
/sys/class/dmi/id/product_name:APU
/sys/class/dmi/id/product_serial:XXXXXXX
/sys/class/dmi/id/product_version:1.0
/sys/class/dmi/id/sys_vendor:PC Engines
/sys/class/dmi/id/uevent:MODALIAS=dmi:bvncoreboot:bvrSageBios_PCEngines_APU-45:bd04/05/2014:svnPCEngines:pnAPU:pvr1.0:cvnPCEngines:ct3:cvr:

there is no board name on APU.

here is the output from my APU2 board
# grep . /sys/class/dmi/id/*
/sys/class/dmi/id/bios_date:02/28/2017
/sys/class/dmi/id/bios_vendor:coreboot
/sys/class/dmi/id/bios_version:4.0.7
/sys/class/dmi/id/board_name:APU2
/sys/class/dmi/id/board_serial:XXXXXXX
/sys/class/dmi/id/board_vendor:PC Engines
/sys/class/dmi/id/board_version:1.0
/sys/class/dmi/id/chassis_type:3
/sys/class/dmi/id/chassis_vendor:PC Engines
/sys/class/dmi/id/modalias:dmi:bvncoreboot:bvr4.0.7:bd02/28/2017:svnPCEngines:pnAPU2:pvr1.0:rvnPCEngines:rnAPU2:rvr1.0:cvnPCEngines:ct3:cvr:
/sys/class/dmi/id/product_name:APU2
/sys/class/dmi/id/product_serial:XXXXXX
/sys/class/dmi/id/product_version:1.0
/sys/class/dmi/id/sys_vendor:PC Engines
/sys/class/dmi/id/uevent:MODALIAS=dmi:bvncoreboot:bvr4.0.7:bd02/28/2017:svnPCEngines:pnAPU2:pvr1.0:rvnPCEngines:rnAPU2:rvr1.0:cvnPCEngines:ct3:cvr:

As you can see here for APU2 the board_name is set.

> 
> If it fails here, then how it is possible that it succeeds
> in the apu_led_init() ?
> 

in apu_led_init() is a check for product_name for both both boards.
Ans this succeeds

Thus the fix here
> -     if (dmi_match(DMI_BOARD_NAME, "APU")) {
> +     if (dmi_match(DMI_PRODUCT_NAME, "APU")) {

I can rewrite the patch to catch both board_name and product_name for the 
APU board, and add a better commit log.

They are more recent bios updates for this board, but the are specified as 
"beta" so I'm afraid of an update. I have no hardware to recover a 
"damaged" SPI flash chip.

Greetings
Hans Ulli Kroll
