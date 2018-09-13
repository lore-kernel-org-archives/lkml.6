Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A803C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BE22086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BE22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeINAiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:38:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52976 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbeINAiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:38:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4EE9720877; Thu, 13 Sep 2018 21:27:23 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 06E882075C;
        Thu, 13 Sep 2018 21:27:13 +0200 (CEST)
Date:   Thu, 13 Sep 2018 21:27:13 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 4/5] rtc: pcf8523: external capacitor configuration
Message-ID: <20180913192713.GJ14988@piout.net>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-5-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907193508.24974-5-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 21:35:07+0200, Sam Ravnborg wrote:
> From: Søren Andersen <san@skov.dk>
> 
> Add support for specifying the quartz load in the DT node.
> The pcf8523 may use either a 7 pF or an 12.5 pF xtal.
> If the rtc has the wrong configuration the time will
> drift several hours/week.
> 
> If nothing is specified in DT then the factory default of 7 pF is used.
> This is a change compared to before where the driver assumed 12.5 pF.
> 
> Note: all kernel dts trees are updated with the new property.
> 
> Signed-off-by: Søren Andersen <san@skov.dk>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-pcf8523.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
> index 453615f8ac9a..3c19b4d21a2d 100644
> --- a/drivers/rtc/rtc-pcf8523.c
> +++ b/drivers/rtc/rtc-pcf8523.c
> @@ -85,7 +85,7 @@ static int pcf8523_write(struct i2c_client *client, u8 reg, u8 value)
>  	return 0;
>  }
>  
> -static int pcf8523_select_capacitance(struct i2c_client *client, bool high)
> +static int pcf8523_select_capacitance(struct i2c_client *client)
>  {
>  	u8 value;
>  	int err;
> @@ -94,7 +94,7 @@ static int pcf8523_select_capacitance(struct i2c_client *client, bool high)
>  	if (err < 0)
>  		return err;
>  
> -	if (!high)
> +	if (!device_property_present(&client->dev, "nxp,quartz_load_12.5pf"))

OK, this is super annoying we unfortunately can't change what was done
previously without breaking the DT ABI. Honestly, I suspect the 12.5pF
value is wrong for most boards anyway.

What I would do is use the value from DT (so either 7000fF or 12500fF)
and set it if present.
If not present, set 12.5pF and print a warning that this differs from
the RTC default.

Hopefully, at some point, we could leave it as it is as the value should
persist across reboot.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
