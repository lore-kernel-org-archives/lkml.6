Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9183DC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5583021CBD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5583021CBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbeHIKqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:46:16 -0400
Received: from muru.com ([72.249.23.125]:53150 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbeHIKqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:46:15 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E525B80B7;
        Thu,  9 Aug 2018 08:26:04 +0000 (UTC)
Date:   Thu, 9 Aug 2018 01:22:29 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: Droid 4: suspend to RAM?
Message-ID: <20180809082229.GU99251@atomide.com>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
 <20180725212853.GA1965@amd>
 <20180727113214.GA32069@amd>
 <20180808090512.GQ99251@atomide.com>
 <20180808213204.GD15831@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808213204.GD15831@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180808 21:35]:
> On Wed 2018-08-08 02:05:12, Tony Lindgren wrote:
> > Then for deeper idle modes, you need to also idle UARTs, and unbind or
> > unload USB related modules. You should get to something like 160mW
> > power consumption with mdm6600 enabled and SoC suspended that way.
> 
> That's slightly interesting. echo mem > /sys/power/state should do all
> the work, right? Disable UARTs etc. Plus, is 160mW still a bit high?

Yes suspend will do it, you still need to configure wake-up events
though at least for the UARTs. I think I got enabled mdm6600 to low-power
state after connecting over UART ts27010 and then suspending OHCI:

        ohci=$(find /sys/bus/platform/devices -name \*.ohci)
        devices=$(find ${ohci}/ -type d -name control)
        for device in ${devices}; do
                echo -n "auto" > ${device}/level
                echo -n "control" > ${device}/level
        done

        echo "usb-phy@1" > /sys/bus/platform/drivers/phy-mapphone-mdm6600/unbind

For power consumption, 160mW is high yeah. We currently cannot hit core
retention on omap4 until some GPIO issues are fixed. I've been trying to
think for a good fix for that, but need to debug it more when I get a chance.

From few months ago, I recall I got droid4 to run at around 65mW idle
with WLAN connected and modem off with my test hacks. With modem on
and USB suspended I think I got to around 100mW.

Then I recall measuring droid4 with stock android in flight mode
measuring at around 15 - 30mW. But that requires off mode to work on
omap4, maybe we'll get to that too at some point after core retention.

Regards,

Tony
