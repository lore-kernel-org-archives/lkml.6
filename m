Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24836C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D081F20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D081F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeG2Tjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:39:31 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37254 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeG2Tjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:39:31 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23993024AbeG2SINQQSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 2 others);
        Sun, 29 Jul 2018 20:08:13 +0200
Date:   Sun, 29 Jul 2018 20:08:04 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        David Rivshin <drivshin@allworx.com>,
        linux-pwm@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by returning
 EPROBE_DEFER
Message-ID: <20180729180804.GA18468@lenoch>
References: <20180728165914.15871-1-andreas@kemnade.info>
 <20180728203501.GA16194@lenoch>
 <BE83C4E8-55B0-4EA7-8FF6-756460464264@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE83C4E8-55B0-4EA7-8FF6-756460464264@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 08:32:41AM +0200, H. Nikolaus Schaller wrote:
> Hi,
> 
> > Am 28.07.2018 um 22:35 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > 
> > Hi Andreas,
> > 
> > On Sat, Jul 28, 2018 at 06:59:14PM +0200, Andreas Kemnade wrote:
> >> I got this in the kernel log:
> >> [    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
> >> [    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22
> >> 
> >> the probe function has to wait until omap_dm_timer_probe() in
> >> clocksource/timer-ti-dm.c has initialized pdata, so defer probing
> > 
> > There already is a patch by David Rivshin addressing the same issue...
> 
> Here it is:
> 
> https://patchwork.ozlabs.org/patch/943148/
> 
> but hasn't arrived in linux-next.

That's because there'll be v3.

> But it is questionable if a driver should dev_info() about doing deferred probing.
> IMHO, it should just do it which is how Andreas' patch works.

See here: https://patchwork.ozlabs.org/patch/949659/

> >> Fixes: b7290cf6ff78 (pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops)
> >> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >> ---
> >> drivers/pwm/pwm-omap-dmtimer.c | 3 +--
> >> 1 file changed, 1 insertion(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> >> index 665da3c8fbce..808835179c2e 100644
> >> --- a/drivers/pwm/pwm-omap-dmtimer.c
> >> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> >> @@ -264,8 +264,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> >> 
> >> 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
> >> 	if (!timer_pdata) {
> >> -		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
> >> -		ret = -EINVAL;
> >> +		ret = -EPROBE_DEFER;
> >> 		goto put;
> >> 	}
> >> 
> >> -- 
> >> 2.11.0
> >> 
> 
> BR,
> Nikolaus
> 
