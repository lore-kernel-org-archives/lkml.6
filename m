Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9F3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3074520869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbeL1TbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:31:11 -0500
Received: from muru.com ([72.249.23.125]:59584 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbeL1TbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:31:10 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AD68280BF;
        Fri, 28 Dec 2018 19:31:13 +0000 (UTC)
Date:   Fri, 28 Dec 2018 11:31:05 -0800
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
Message-ID: <20181228193105.GW6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227101647.GA32260@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Pavel Machek <pavel@ucw.cz> [181227 10:17]:
> Ok, I really need SMS messages, too.
> 
> Fortunately, they are on /dev/motmdm9, in PDU format. Quite
> logical. And you probably need to acknowledge them, using PDU,
> too... (because otherwise you'll just get the same SMS over and over
> and over). Which is also logical, but hard to do from shell/python.

Yeah so I found that Ruby pdu_tools module allows decoding PDUs
properly while I did not have much luck with other tools.

So I wrote a hasty script to read SMS, copy it to a Maildir and
then ack it:

https://github.com/tmlind/droid4-sms-tools

> Proper solution involves special support for ofonod...

Yeah at least we're dealing with standard PDU format now for
incoming SMS.

Also looks like there is no status on the modem for these incoming
messages as checked with mmcli. I guess the idea with raw PDU
access is that the message is delivered directly to the client
and then acked instead of being queued in the modem?

> Fortunately ttyUSB4 still works, so I can still use my old code... and
> I started logging motmdm1 and 9 to a file as a backup... that should
> be better than my existing solution. (But I don't get power benefits
> etc.)

So what are you using to ack the received SMS over ttyUSB4?

My logs show that Android uses two different commands for ack.
Either AT+GCNMA=1 or AT+CNMA=0,0 gets used depending on something
that I have no idea of.. Maybe the network connected?

Sending SMS via /dev/motmdm3 needs move investigation, but at
least ModemManager mmcli can be used to create and send SMS.

Hmm or what are you using to send SMS over ttyUSB4?
I think you already replied with some of that info earlier
but I can't find it..

Oh one more thing, I noticed that on /dev/motmdm1, typing
AT+SCRN=0 supresses notifications except for WAKEUP, and then
1 is used to enable them again. That allows the UART to idle
instead of getting network status messages every few seconds :)

Regards,

Tony
