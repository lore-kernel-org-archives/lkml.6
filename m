Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E516C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741EA2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741EA2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbeKHCzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:55:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38053 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeKHCzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:55:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 06AAE208CB; Wed,  7 Nov 2018 18:23:40 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id CC4D3208CB;
        Wed,  7 Nov 2018 18:23:39 +0100 (CET)
Date:   Wed, 7 Nov 2018 18:23:40 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sre@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Message-ID: <20181107172340.GF21694@piout.net>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
 <20181106210933.GU24212@piout.net>
 <6719a808-e704-3c63-f592-3b90d44ccbfe@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6719a808-e704-3c63-f592-3b90d44ccbfe@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 14:54:17+0000, Claudiu.Beznea@microchip.com wrote:
> Hi Alexandre,
> 
> On 06.11.2018 23:09, Alexandre Belloni wrote:
> > Hi Claudiu,
> > 
> > On 05/11/2018 11:14:26+0000, Claudiu.Beznea@microchip.com wrote:
> >>  static int __init at91_poweroff_probe(struct platform_device *pdev)
> >> @@ -154,16 +160,22 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
> >>  	u32 ddr_type;
> >>  	int ret;
> >>  
> >> +	at91_shdwc = devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
> >> +	if (!at91_shdwc)
> >> +		return -ENOMEM;
> >> +
> > 
> > Is there any real benefit that will offset the time lost for that
> > allocation at boot time?
> 
> No, I haven't run benchmarks on this. I only wanted to have them grouped in
> one structure. Please let me know if you have some tests in mind.
> 

Well, it is probably not much but small things adds up. Havinf it as a
global structure is probably good enough.

> > 
> > I understand you are then testing at91_shdwc to know whether the driver
> > already probed once. But, the driver will never probe twice as there is
> > only one shutdown controller on the SoC and anyway, If it was to probe
> > twice, it will still work as expected.
> 
> I had in mind the scenario where the driver would be compiled as module. I
> know insmod already does this checking. I'm ok to remove this checking. I
> will do it in next version. With this I will also remove devm_kzalloc() of
> at91_shdwc.
> 

Thanks,

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
