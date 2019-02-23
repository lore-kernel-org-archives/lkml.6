Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E348C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9877206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfBWSXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 13:23:31 -0500
Received: from muru.com ([72.249.23.125]:40616 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfBWSXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 13:23:31 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1984D804F;
        Sat, 23 Feb 2019 18:23:40 +0000 (UTC)
Date:   Sat, 23 Feb 2019 10:23:23 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] mfd: twl-core: disable irq while suspended
Message-ID: <20190223182323.GA39872@atomide.com>
References: <20190223114754.16286-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223114754.16286-1-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190223 11:48]:
> Since commit
> 6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device for suspend")
> on gta04 we have handle_twl4030_pih() called in situations where pm_runtime_get()
> in i2c-omap.c returns -EACCES.
> [   86.474365] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [   86.485473] printk: Suspending console(s) (use no_console_suspend to debug)
> [   86.555572] Disabling non-boot CPUs ...
> [   86.555664] Successfully put all powerdomains to target state
> [   86.563720] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563751] twl4030: I2C error -13 reading PIH ISR
> [   86.563812] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563812] twl4030: I2C error -13 reading PIH ISR
> [   86.563873] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563903] twl4030: I2C error -13 reading PIH ISR
> 
> This happens when we wakeup via something behing twl4030
> (powerbutton or rtc alarm).
> This goes on for minutes until the system is finally resumed.
> Disable the irq on suspend and enable it on resume to avoid
> having i2c access problems when the irq registers are checked.

Thanks for fixing this, still works fine for me for rtcwake:

Tested-by: Tony Lindgren <tony@atomide.com>
