Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D284FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD07521874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeL1W2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:28:11 -0500
Received: from muru.com ([72.249.23.125]:59688 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeL1W2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:28:10 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EC79380BF;
        Fri, 28 Dec 2018 22:28:13 +0000 (UTC)
Date:   Fri, 28 Dec 2018 14:28:05 -0800
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
Message-ID: <20181228222805.GC6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
 <20181228204614.GA9431@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228204614.GA9431@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Pavel Machek <pavel@ucw.cz> [181228 20:46]:
> I have ofone with direct AT access --
> https://github.com/pavelmachek/unicsy_demo/blob/master/ofone/at.py .

OK thanks, that shows some of the commands I was wondering about.

> Now, ttyUSB4 provides quite a rich interface, and you can actually
> select what if you want messages in text and PDU format, and if you
> want modem to auto-acknowledge messages for you.

So which AT command configures auto-ack of SMS? I don't need it,
just wondering what all these commands do.

> What kind of battery life do you get with all the optimalizations?
> IIRC I was getting 7h with ttyUSB4 in use...

With droid4-pending-mdm-v4.20 branch in the following state:

- UARTs idled
- LCD blanked (well no drivers yet droid4-sms-read.rb)
- MUSB and EHCI USB modules unloaded
- OHCI loaded with all the children in autosuspend via sysfs
- WLAN connected
- busybox acpid stopped (yup, it keeps polling something???)
- MDM6600 online with AT+CFUN=1 on /dev/motmdm1
- MDM6600 notifications disabled with AT+SCRN=0 on /motmdm1
- droid4-sms-read.rb running

I'm seeing droid 4 idle at 119mW according to my power supply.
So I guess theoretical battery life would currently be
(1785mWh * 3.8V) / 119mW = 57h. But in practise things are not
completely idle and monitoring sysfs POWER_SUPPLY_POWER_AVG
every 10 seconds I'm seeing something along these 10 samples:

POWER_SUPPLY_POWER_AVG=138938
POWER_SUPPLY_POWER_AVG=134571
POWER_SUPPLY_POWER_AVG=505802
POWER_SUPPLY_POWER_AVG=240412
POWER_SUPPLY_POWER_AVG=134252
POWER_SUPPLY_POWER_AVG=132694
POWER_SUPPLY_POWER_AVG=571569
POWER_SUPPLY_POWER_AVG=132694
POWER_SUPPLY_POWER_AVG=190456
POWER_SUPPLY_POWER_AVG=518288

So the average based on that sampling is about 270mW and the idle
time should be about 1785 * 3.8 / 270 = 25h, which is quite usable
already :)

Regards,

Tony
