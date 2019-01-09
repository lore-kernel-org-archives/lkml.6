Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20679C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55F1206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfAINLo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:11:44 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45912 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbfAINLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:11:44 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ghDe0-0005T9-3q; Wed, 09 Jan 2019 14:11:40 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Stefan Mavrodiev <stefan.mavrodiev@gmail.com>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        linux-rockchip@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mfd: rk808: Prepare rk805 for poweroff
Date:   Wed, 09 Jan 2019 14:11:39 +0100
Message-ID: <3397477.pQfoUNday9@diego>
In-Reply-To: <489e70a8-dbe7-e248-972e-c7de4e0f2c1a@gmail.com>
References: <1538465910-27233-1-git-send-email-stefan@olimex.com> <1917869.4NZ4yPfKWV@diego> <489e70a8-dbe7-e248-972e-c7de4e0f2c1a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 14:10:34 CET schrieb Stefan Mavrodiev:
> On 1/9/19 3:07 PM, Heiko Stübner wrote:
> > Hi Stefan, Lee,
> > 
> > Am Dienstag, 2. Oktober 2018, 09:38:29 CET schrieb Stefan Mavrodiev:
> >> RK805 has SLEEP signal, which can put the device into SLEEP or OFF
> >> mode. The default is SLEEP mode.
> >> 
> >> However, when the kernel performs power-off (actually the ATF) the
> >> device will not go fully off and this will result in higher power
> >> consumption and inability to wake the device with RTC alarm.
> >> 
> >> The solution is to enable pm_power_off_prepare function, which will
> >> configure SLEEP pin for OFF function.
> >> 
> >> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> > 
> > just found this while cleaning my inbox and this change looks
> > significant and it seems hasn't been applied yet.
> > 
> > I guess this is still relevant, right?
> 
> Yes, but I guess it's out-of-sync with the latest kernel.

you could rebase and resend it :-)


> >> ---
> >> 
> >>   drivers/mfd/rk808.c | 24 ++++++++++++++++++++++++
> >>   1 file changed, 24 insertions(+)
> >> 
> >> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> >> index 216fbf6..50f3f78 100644
> >> --- a/drivers/mfd/rk808.c
> >> +++ b/drivers/mfd/rk808.c
> >> @@ -387,6 +387,25 @@ static void rk805_device_shutdown(void)
> >> 
> >>   		dev_err(&rk808_i2c_client->dev, "power off error!\n");
> >>   
> >>   }
> >> 
> >> +static void rk805_device_shutdown_prepare(void)
> >> +{
> >> +	int ret;
> >> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> >> +
> >> +	if (!rk808) {
> >> +		dev_warn(&rk808_i2c_client->dev,
> >> +			 "have no rk805, so do nothing here\n");
> >> +
> >> +		return;
> >> +	}
> >> +
> >> +	ret = regmap_update_bits(rk808->regmap,
> >> +				 RK805_GPIO_IO_POL_REG,
> >> +				 SLP_SD_MSK, SHUTDOWN_FUN);
> >> +	if (ret)
> >> +		dev_err(&rk808_i2c_client->dev, "power off error!\n");
> >> +}
> >> +
> >> 
> >>   static void rk808_device_shutdown(void)
> >>   {
> >>   
> >>   	int ret;
> >> 
> >> @@ -549,6 +568,10 @@ static int rk808_probe(struct i2c_client *client,
> >> 
> >>   	if (pm_off && !pm_power_off) {
> >>   	
> >>   		rk808_i2c_client = client;
> >>   		pm_power_off = pm_pwroff_fn;
> >> 
> >> +	} else if (pm_off && !pm_power_off_prepare &&
> >> +		   rk808->variant == RK805_ID) {
> >> +		rk808_i2c_client = client;
> >> +		pm_power_off_prepare = rk805_device_shutdown_prepare;
> >> 
> >>   	}
> >>   	
> >>   	return 0;
> >> 
> >> @@ -564,6 +587,7 @@ static int rk808_remove(struct i2c_client *client)
> >> 
> >>   	regmap_del_irq_chip(client->irq, rk808->irq_data);
> >>   	pm_power_off = NULL;
> >> 
> >> +	pm_power_off_prepare = NULL;
> >> 
> >>   	return 0;
> >>   
> >>   }




