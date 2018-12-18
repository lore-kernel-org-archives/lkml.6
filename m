Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5ACC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EAA21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeLRPg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:36:57 -0500
Received: from muru.com ([72.249.23.125]:58666 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeLRPgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:36:55 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4DA43810D;
        Tue, 18 Dec 2018 15:36:57 +0000 (UTC)
Date:   Tue, 18 Dec 2018 07:36:50 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Johan Hovold <johan@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, omerlle@gmail.com,
        Sebastian Reichel <sre@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181218153650.GA6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181218124616.GA10758@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218124616.GA10758@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Pavel Machek <pavel@ucw.cz> [181218 12:46]:
> Dunno, I see that you might want const there, but u8 -> unsigned char
> seems like a step in wrong direction.

Well I was just trying to follow what the serdev core is doing
nowadays.. I'll see if I can just constify.

> # commit	   cd16272060d8100ef0388349cf88f42a1dc667fc (patch)
> # tty: n_gsm: Add support for serdev
> 
> Is it worth putting those in separate file? n_gsm_serdev.c?

Yes that's the plan but that needs some refactoring to be done
and I did not want to get into that until I had things working
to prevent regressions.

> # commit	    0c1bc81ba976bcd480d6e3c3009a28589f8427c0 (patch)
> # mfd: motmdm: Add Motorola TS 27.010 serdev driver for devices like droid4
> 
> Oh, that is a lot of fun. Especially state machine for parsing modem
> responses. I wonder how well it is going to work when modem is
> accessed over USB... 
> 
> motmdm_read_state(... size_t len)

That's a bit of a layering violation yeah :) But we still need to
do that somewhere for notifiers. And the notifications are separate
from the commands and start with a ~ character so from that point of
view it should not be too bad.

In general, motorola-mdm should just deal with the custom packet
numbering layer and pass data to channel specific serdev drivers
or to the channel specific /dev/motmdm* char devices.

> I applied it over my tree (I still need patches for display,
> right?). I'm getting
> 
> /data/fast/l/k/drivers/mfd/motorola-mdm.c:1132:3: error: initializer
> element is not constant
> /data/fast/l/k/drivers/mfd/motorola-mdm.c:1132:3: error: (near
> initialization for 'motmdm_driver.driver.name')
> /data/fast/l/k/scripts/Makefile.build:291: recipe for target
> 'drivers/mfd/motorola-mdm.o' failed

Hmm OK thanks for letting me know. Yes Sebastian has updated
branches for the LCD.

> Oh and that mdelay(3000) is going to hurt... especially because
> console is initialized very late or d4.

It's msleep() not mdelay(). Sorry I have not figured out a better
way so far to get the n_gsm initialized other than spamming the
device with retries for a while on start-up.

> I did a quick test in my config... and it did not break my old setup
> -- voice calls still work when set up over USB and with manual mixer
> setup. That was good surprise.

OK good to hear. Using the n_gsm port instead of USB during idle
has a major PM advantage as the SoC can hit retention during idle
while still connected to the modem and getting notifications.

So looks like during idle we can keep USB in autosuspend mode with
something like the below shell script function.

Regards,

Tony

8< -----------------------
# It's OK to keep to keep ohci device on auto and qmi_wwan and cdc_wd loaded.
# Probably musb and ehci modules need to be currently unloaded for SoC idle.
suspend_usb() {
        ohci=$(find /sys/bus/platform/devices -name \*.ohci)
        if [ "${ohci}" = "" ]; then
                return
        fi

        devices=$(find "${ohci}/" -type f -name control)

        for device in ${devices}; do
                echo -n "${device}: "
                cat ${device}
        done

        for device in ${devices}; do
                echo -n "auto" > ${device}
        done

        for device in ${devices}; do
                echo -n "${device}: "
                cat ${device}
        done
}
