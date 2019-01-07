Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F59C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DD620883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O55nbF8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfAIHkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:40:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35960 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbfAIHkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:40:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so2946505pgm.3;
        Tue, 08 Jan 2019 23:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vuymBGrqpDXNC1v0wNzgDSWFqXUps7cPlzKIN/IyJbA=;
        b=O55nbF8BOx5Ob8vW4JAjs8n20exe36VMUFTUJHaqSJqETrWdMDeMIIiEITFQbg9yHS
         f3cpcckFoB7rf8oURVzy8h8TLJawrP0EWv3E/53UcKR6hLBS/z9pL6CYMb5u4A9lJq4V
         BXyp8z1rMQTsVpmN5iS4ohuMjuHrt7D973HUnt9F3j9OeyQYYtGUrQvJchOgTgbUg+/g
         ivMts4LVCrq7cx3sCYT99HkuYMEOJVm97ZEmHHZhWjkul8fRovAlA39o/OojYhoKMdDw
         IzTsKq11Wo4pButRyFQM4PxJfIpNVqT6HGRMsQvnquDq+ZTlh9GSAB4UlzYzrZZnruW1
         yYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vuymBGrqpDXNC1v0wNzgDSWFqXUps7cPlzKIN/IyJbA=;
        b=CrRj/nrRNeaKkqPQSnwa0DfwK3aHkmqCXT+XELZ4wINsCX6SdHbwXUNWN7AMJYmqQb
         KEt2avxfj3q4/5K0VM9wkdSvpvPMMzUGsSOAetirsF6djspWim/fpA85orcZ940kXeS2
         3zGhptyc/BnS0W55A1Ss8ji4KCqdexkBzQz/iWPnsoytWPGQs62RA2t27jO8qJIjVJ7d
         Z2HPX7PJB/PdyCLZ+lMsFd2zmAU+N36sUD25kJCl0UpoivTMLAI+XxOHfCJMyQ/w1PTV
         sK9sReWoxtIKmDb+8FHQclpwbctLATuE+InrgZ1wEsy1RGr1bO8V9fa8Z/OhlWxT6wfx
         UlJQ==
X-Gm-Message-State: AJcUukddYjapG6D3YThABSXLaqiEsvC8azeliIiucSXplZ0ujuZ4lEH1
        5w9kJJQUdR4qDIY0gleujDE=
X-Google-Smtp-Source: ALg8bN4pORX+NdLsT/ZFxvDTYZ6W3qM57Nr0ka1G14otukMxzOuZ7S+XXZFJ2rDUwdX1mpFLP1JABw==
X-Received: by 2002:a62:de06:: with SMTP id h6mr5075953pfg.158.1547019611355;
        Tue, 08 Jan 2019 23:40:11 -0800 (PST)
Received: from localhost (c-73-158-250-148.hsd1.ca.comcast.net. [73.158.250.148])
        by smtp.gmail.com with ESMTPSA id c72sm125276155pfb.107.2019.01.08.23.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 23:40:10 -0800 (PST)
Date:   Mon, 7 Jan 2019 23:03:30 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org,
        thierry.reding@gmail.com, digetx@gmail.com, lee.jones@linaro.org,
        coquelin.stm32@gmail.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/8] Input: stmpe-ts: preparations for STMPE ADC driver
Message-ID: <20190107230330.fopheslpnwpfg6l4@penguin>
References: <20181221134638.20600-1-dev@pschenker.ch>
 <20181221134638.20600-5-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221134638.20600-5-dev@pschenker.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 02:46:33PM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> This patch removes common ADC settings in favor to use
> stmpe811_adc_common_init that is present in MFD. This is necessary in
> preparation for the stmpe-adc driver, because those two drivers have
> common settings for the ADC.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> ---
> 
> Changes in v5:
>  - Changed author of commit to use correct email.
> 
> Changes in v4:
>  - New patch: Split changes in stmpe-ts.c to a separate commit
>  - Remove common adc settings from init and call the
>    stmpe811_adc_common_init function
> 
> Changes in v3:
>  - Undo ADC-settings related code-deletions in stmpe-ts.c that the code
>    is backwards-compatible to older devicetrees.
> 
> Changes in v2: None
> 
>  drivers/input/touchscreen/stmpe-ts.c | 42 +++++-----------------------
>  1 file changed, 7 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> index c5d9006588a2..cf9c9aa39f6e 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -30,8 +30,6 @@
>   * with touchscreen controller
>   */
>  #define STMPE_REG_INT_STA		0x0B
> -#define STMPE_REG_ADC_CTRL1		0x20
> -#define STMPE_REG_ADC_CTRL2		0x21
>  #define STMPE_REG_TSC_CTRL		0x40
>  #define STMPE_REG_TSC_CFG		0x41
>  #define STMPE_REG_FIFO_TH		0x4A
> @@ -58,15 +56,6 @@
>   * @idev: registered input device
>   * @work: a work item used to scan the device
>   * @dev: a pointer back to the MFD cell struct device*
> - * @sample_time: ADC converstion time in number of clock.
> - * (0 -> 36 clocks, 1 -> 44 clocks, 2 -> 56 clocks, 3 -> 64 clocks,
> - * 4 -> 80 clocks, 5 -> 96 clocks, 6 -> 144 clocks),
> - * recommended is 4.
> - * @mod_12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
> - * @ref_sel: ADC reference source
> - * (0 -> internal reference, 1 -> external reference)
> - * @adc_freq: ADC Clock speed
> - * (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
>   * @ave_ctrl: Sample average control
>   * (0 -> 1 sample, 1 -> 2 samples, 2 -> 4 samples, 3 -> 8 samples)
>   * @touch_det_delay: Touch detect interrupt delay
> @@ -88,10 +77,6 @@ struct stmpe_touch {
>  	struct input_dev *idev;
>  	struct delayed_work work;
>  	struct device *dev;
> -	u8 sample_time;
> -	u8 mod_12b;
> -	u8 ref_sel;
> -	u8 adc_freq;
>  	u8 ave_ctrl;
>  	u8 touch_det_delay;
>  	u8 settling;
> @@ -192,7 +177,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
>  static int stmpe_init_hw(struct stmpe_touch *ts)
>  {
>  	int ret;
> -	u8 adc_ctrl1, adc_ctrl1_mask, tsc_cfg, tsc_cfg_mask;
> +	u8 tsc_cfg, tsc_cfg_mask;
>  	struct stmpe *stmpe = ts->stmpe;
>  	struct device *dev = ts->dev;
>  
> @@ -202,22 +187,9 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
>  		return ret;
>  	}
>  
> -	adc_ctrl1 = STMPE_SAMPLE_TIME(ts->sample_time) |
> -		    STMPE_MOD_12B(ts->mod_12b) | STMPE_REF_SEL(ts->ref_sel);
> -	adc_ctrl1_mask = STMPE_SAMPLE_TIME(0xff) | STMPE_MOD_12B(0xff) |
> -			 STMPE_REF_SEL(0xff);
> -
> -	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL1,
> -			adc_ctrl1_mask, adc_ctrl1);
> -	if (ret) {
> -		dev_err(dev, "Could not setup ADC\n");
> -		return ret;
> -	}
> -
> -	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL2,
> -			STMPE_ADC_FREQ(0xff), STMPE_ADC_FREQ(ts->adc_freq));
> +	ret = stmpe811_adc_common_init(stmpe);
>  	if (ret) {
> -		dev_err(dev, "Could not setup ADC\n");
> +		stmpe_disable(stmpe, STMPE_BLOCK_TOUCHSCREEN | STMPE_BLOCK_ADC);
>  		return ret;
>  	}
>  
> @@ -295,13 +267,13 @@ static void stmpe_ts_get_platform_info(struct platform_device *pdev,
>  
>  	if (np) {
>  		if (!of_property_read_u32(np, "st,sample-time", &val))
> -			ts->sample_time = val;
> +			ts->stmpe->sample_time = val;
>  		if (!of_property_read_u32(np, "st,mod-12b", &val))
> -			ts->mod_12b = val;
> +			ts->stmpe->mod_12b = val;
>  		if (!of_property_read_u32(np, "st,ref-sel", &val))
> -			ts->ref_sel = val;
> +			ts->stmpe->ref_sel = val;
>  		if (!of_property_read_u32(np, "st,adc-freq", &val))
> -			ts->adc_freq = val;
> +			ts->stmpe->adc_freq = val;
>  		if (!of_property_read_u32(np, "st,ave-ctrl", &val))
>  			ts->ave_ctrl = val;
>  		if (!of_property_read_u32(np, "st,touch-det-delay", &val))
> -- 
> 2.19.2
> 

-- 
Dmitry
