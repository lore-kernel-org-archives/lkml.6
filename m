Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D9CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4F32075D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeLaWUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 17:20:19 -0500
Received: from muru.com ([72.249.23.125]:60000 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeLaWUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 17:20:18 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4825B806C;
        Mon, 31 Dec 2018 22:20:22 +0000 (UTC)
Date:   Mon, 31 Dec 2018 14:20:13 -0800
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
Message-ID: <20181231222013.GH6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
 <20181228204614.GA9431@amd>
 <20181228222805.GC6707@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228222805.GC6707@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Tony Lindgren <tony@atomide.com> [181228 22:28]:
> With droid4-pending-mdm-v4.20 branch in the following state:
> 
> - UARTs idled
> - LCD blanked (well no drivers yet droid4-sms-read.rb)
> - MUSB and EHCI USB modules unloaded
> - OHCI loaded with all the children in autosuspend via sysfs
> - WLAN connected
> - busybox acpid stopped (yup, it keeps polling something???)
> - MDM6600 online with AT+CFUN=1 on /dev/motmdm1
> - MDM6600 notifications disabled with AT+SCRN=0 on /motmdm1
> - droid4-sms-read.rb running

So I tracked down what I thought is a busybox acpid issue, I was
wrong. There's nothing wrong with busybox acpid, sorry for
blaming a wrong culprit.

We have acpid keep the device open for
/dev/input/by-path/platform-48072000.i2c-event open, which
seems to keep atmel_mxt_ts and i2c busy.

Things idle fine after I rmmod atmel_mxt_ts after blanking
the screen.

Regards,

Tony

