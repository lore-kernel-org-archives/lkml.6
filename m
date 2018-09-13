Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0776AC63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF64E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF64E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeINAka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:40:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53082 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbeINAk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:40:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B6E21208AA; Thu, 13 Sep 2018 21:29:33 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 805E5206FF;
        Thu, 13 Sep 2018 21:29:23 +0200 (CEST)
Date:   Thu, 13 Sep 2018 21:29:24 +0200
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
Subject: Re: [PATCH v1 5/5] rtc: pcf85063: external capacitor configuration
Message-ID: <20180913192924.GK14988@piout.net>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-6-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907193508.24974-6-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 21:35:08+0200, Sam Ravnborg wrote:
> From: Søren Andersen <san@skov.dk>
> 
> Add support for specifying the quartz load in the DT node.
> The pcf85063 may use either a 7 pF or an 12.5 pF xtal.
> If the rtc has the wrong configuration the time will
> drift several hours/week.
> 
> If nothing is specified in DT then the factory default of 7 pF is used.
> 
> Signed-off-by: Søren Andersen <san@skov.dk>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index 283c2335b01b..38163446664f 100644
> --- a/drivers/rtc/rtc-pcf85063.c
> +++ b/drivers/rtc/rtc-pcf85063.c
> @@ -27,6 +27,7 @@
>  */
>  
>  #define PCF85063_REG_CTRL1		0x00 /* status */
> +#define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
>  #define PCF85063_REG_CTRL1_STOP		BIT(5)
>  #define PCF85063_REG_CTRL2		0x01
>  
> @@ -180,6 +181,31 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
>  	.set_time	= pcf85063_rtc_set_time
>  };
>  
> +static int pcf85063_select_capacitance(struct i2c_client *client)
> +{
> +	int rc;
> +	u8 reg;
> +
> +	rc = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
> +	if (rc < 0) {
> +		dev_err(&client->dev, "Failing to read Control1 reg\n");
> +		return -EIO;
> +	}
> +
> +	if (device_property_present(&client->dev, "nxp,quartz_load_12.5pf"))
> +		reg = rc |= PCF85063_REG_CTRL1_CAP_SEL;
> +	else
> +		reg = rc &= ~PCF85063_REG_CTRL1_CAP_SEL;

That one is more straight forward, set it to the value from DT or leave
it alone.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
