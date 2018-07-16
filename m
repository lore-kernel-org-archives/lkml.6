Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006C7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EA12084C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EA12084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeGPWCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:02:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47067 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbeGPWCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:02:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C744B207AC; Mon, 16 Jul 2018 23:33:02 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 98954206F3;
        Mon, 16 Jul 2018 23:33:02 +0200 (CEST)
Date:   Mon, 16 Jul 2018 23:33:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v6 3/4] rtc: ds1307: add offset sysfs for mt41txx chips.
Message-ID: <20180716213302.GA2751@piout.net>
References: <20180516210842.5874-1-giulio.benetti@micronovasrl.com>
 <20180516210842.5874-3-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516210842.5874-3-giulio.benetti@micronovasrl.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/05/2018 23:08:41+0200, Giulio Benetti wrote:
> m41txx chips can hold a calibration value to get correct clock bias.
> 
> Add offset handling (ranging between -63ppm and 126ppm) via sysfs.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 81 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 0ab0c166da83..2797d01bfa1d 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -114,6 +114,20 @@ enum ds_type {
>  #	define RX8025_BIT_VDET		0x40
>  #	define RX8025_BIT_XST		0x20
>  
> +#define M41TXX_REG_CONTROL	0x07
> +#	define M41TXX_BIT_OUT		0x80
> +#	define M41TXX_BIT_FT		0x40
> +#	define M41TXX_BIT_CALIB_SIGN	0x20

Please use BIT()

> +#	define M41TXX_M_CALIBRATION	0x1f
> +
> +/* negative offset step is -2.034ppm */
> +#define M41TXX_NEG_OFFSET_STEP_PPM	2034

This should be named M41TXX_NEG_OFFSET_STEP_PPB

> +/* positive offset step is +4.068ppm */
> +#define M41TXX_POS_OFFSET_STEP_PPM	4068

and M41TXX_POS_OFFSET_STEP_PPB

> +/* Min and max values supported with 'offset' interface by M41TXX */
> +#define M41TXX_MIN_OFFSET	(((-31) * M41TXX_NEG_OFFSET_STEP_PPM) / 1000)
> +#define M41TXX_MAX_OFFSET	(((31) * M41TXX_POS_OFFSET_STEP_PPM) / 1000)
> +

I don't see the point of dividing by 1000 here, it is definitively
better to keep everything in PPB.

>  struct ds1307 {
>  	enum ds_type		type;
>  	unsigned long		flags;
> @@ -146,6 +160,9 @@ struct chip_desc {
>  
>  static int ds1307_get_time(struct device *dev, struct rtc_time *t);
>  static int ds1307_set_time(struct device *dev, struct rtc_time *t);
> +static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t);
> +static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t);
> +static int ds1307_alarm_irq_enable(struct device *dev, unsigned int enabled);
>  static u8 do_trickle_setup_ds1339(struct ds1307 *, u32 ohms, bool diode);
>  static irqreturn_t rx8130_irq(int irq, void *dev_id);
>  static int rx8130_read_alarm(struct device *dev, struct rtc_wkalrm *t);
> @@ -155,6 +172,8 @@ static irqreturn_t mcp794xx_irq(int irq, void *dev_id);
>  static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t);
>  static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t);
>  static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled);
> +static int m41txx_rtc_read_offset(struct device *dev, long *offset);
> +static int m41txx_rtc_set_offset(struct device *dev, long offset);
>  
>  static const struct rtc_class_ops rx8130_rtc_ops = {
>  	.read_time      = ds1307_get_time,
> @@ -172,6 +191,16 @@ static const struct rtc_class_ops mcp794xx_rtc_ops = {
>  	.alarm_irq_enable = mcp794xx_alarm_irq_enable,
>  };
>  
> +static const struct rtc_class_ops m41txx_rtc_ops = {
> +	.read_time      = ds1307_get_time,
> +	.set_time       = ds1307_set_time,
> +	.read_alarm	= ds1337_read_alarm,
> +	.set_alarm	= ds1337_set_alarm,
> +	.alarm_irq_enable = ds1307_alarm_irq_enable,
> +	.read_offset	= m41txx_rtc_read_offset,
> +	.set_offset	= m41txx_rtc_set_offset,
> +};
> +
>  static const struct chip_desc chips[last_ds_type] = {
>  	[ds_1307] = {
>  		.nvram_offset	= 8,
> @@ -227,10 +256,17 @@ static const struct chip_desc chips[last_ds_type] = {
>  		.irq_handler = rx8130_irq,
>  		.rtc_ops = &rx8130_rtc_ops,
>  	},
> +	[m41t0] = {
> +		.rtc_ops	= &m41txx_rtc_ops,
> +	},
> +	[m41t00] = {
> +		.rtc_ops	= &m41txx_rtc_ops,
> +	},
>  	[m41t11] = {
>  		/* this is battery backed SRAM */
>  		.nvram_offset	= 8,
>  		.nvram_size	= 56,
> +		.rtc_ops	= &m41txx_rtc_ops,
>  	},
>  	[mcp794xx] = {
>  		.alarm		= 1,
> @@ -972,6 +1008,51 @@ static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
>  				  enabled ? MCP794XX_BIT_ALM0_EN : 0);
>  }
>  
> +static int m41txx_rtc_read_offset(struct device *dev, long *offset)
> +{
> +	struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +	unsigned int ctrl_reg;
> +	u8 val;
> +
> +	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
> +
> +	val = ctrl_reg & M41TXX_M_CALIBRATION;
> +
> +	/* check if positive */
> +	if (ctrl_reg & M41TXX_BIT_CALIB_SIGN)
> +		*offset = (val * M41TXX_POS_OFFSET_STEP_PPM);
> +	else
> +		*offset = -(val * M41TXX_NEG_OFFSET_STEP_PPM);
> +
> +	*offset = DIV_ROUND_CLOSEST(*offset, 1000);
> +

This is definitively not necessary, the whole subsystem handles PPB, not
PPM.

> +	return 0;
> +}
> +
> +static int m41txx_rtc_set_offset(struct device *dev, long offset)
> +{
> +	struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +	unsigned int ctrl_reg;
> +
> +	if ((offset < M41TXX_MIN_OFFSET) || (offset > M41TXX_MAX_OFFSET))
> +		return -ERANGE;
> +
> +	offset *= 1000;
> +

ditto

> +	if (offset >= 0) {
> +		ctrl_reg = DIV_ROUND_CLOSEST(offset,
> +					     M41TXX_POS_OFFSET_STEP_PPM);
> +		ctrl_reg |= M41TXX_BIT_CALIB_SIGN;
> +	} else {
> +		ctrl_reg = DIV_ROUND_CLOSEST(abs(offset),
> +					     M41TXX_NEG_OFFSET_STEP_PPM);
> +	}
> +
> +	return regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL,
> +				  M41TXX_M_CALIBRATION | M41TXX_BIT_CALIB_SIGN,
> +				  ctrl_reg);
> +}
> +
>  /*----------------------------------------------------------------------*/
>  
>  static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
> -- 
> 2.17.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
