Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F97A20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfAPVLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:11:50 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46261 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfAPVLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:11:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 758D7207B0; Wed, 16 Jan 2019 22:11:47 +0100 (CET)
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4BAEE207AC;
        Wed, 16 Jan 2019 22:11:47 +0100 (CET)
Date:   Wed, 16 Jan 2019 22:11:47 +0100
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
        Urs =?iso-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rtc: pcf85063: set xtal load capacitance from DT
Message-ID: <20190116211147.GF2627@piout.net>
References: <20190108185414.26922-1-sam@ravnborg.org>
 <20190108185414.26922-6-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108185414.26922-6-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2019 19:54:14+0100, Sam Ravnborg wrote:
> Add support for specifying the xtal load capacitance in the DT node.
> The pcf85063 supports xtal load capacitance of 7pF or 12.5pF.
> If the rtc has the wrong configuration the time will
> drift several hours/week.
> 
> The driver use the default value 7pF.
> 
> The DT may specify either 7000fF or 12500fF.
> (The DT uses femto Farad to avoid decimal numbers).
> Other values are warned and the driver uses the default value.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Urs Fässler <urs.fassler@bbv.ch>
> ---
>  drivers/rtc/rtc-pcf85063.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
> index 283c2335b01b..0c0b6030627e 100644
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
> @@ -180,6 +181,39 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
>  	.set_time	= pcf85063_rtc_set_time
>  };
>  
> +static int pcf85063_load_capacitance(struct i2c_client *client)
> +{
> +	u32 load;
> +	int rc;
> +	u8 reg;
> +
> +	rc = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
> +	if (rc < 0)
> +		return rc;
> +
> +	reg = rc;
> +	load = 7000;
> +	of_property_read_u32(client->dev.of_node, "quartz-load-femtofarads",
> +			     &load);
> +
> +	switch (load) {
> +	default:
> +		dev_warn(&client->dev, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
> +			load);

Alignment is not correct

> +		/* fall through */
> +	case 7000:
> +		reg &= ~PCF85063_REG_CTRL1_CAP_SEL;
> +		break;
> +	case 12500:
> +		reg |= PCF85063_REG_CTRL1_CAP_SEL;
> +		break;
> +	}
> +
> +	rc = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, reg);
> +
> +	return rc;
> +}
> +
>  static int pcf85063_probe(struct i2c_client *client,
>  				const struct i2c_device_id *id)
>  {
> @@ -197,6 +231,11 @@ static int pcf85063_probe(struct i2c_client *client,
>  		return err;
>  	}
>  
> +	err = pcf85063_load_capacitance(client);
> +	if (err < 0)
> +		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
> +		         err);

This should be using more tabs.

As you can see, I don't have much to add and I'm quite pleased with the
series.

As Rob pointed out, quartz-load-femtofarads should be added in rtc.txt

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
