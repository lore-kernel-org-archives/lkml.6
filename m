Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD22C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A32F20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh7F0v1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A32F20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeG3Fpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 01:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeG3Fpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 01:45:33 -0400
Received: from localhost (unknown [171.76.121.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A32620873;
        Mon, 30 Jul 2018 04:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532923952;
        bh=Vet0cQPbZ4Ylyrs9pn/Y3a/6N6sMsWBO3c2sFNAplU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lh7F0v1APWSkrR5pi8yTYHRfGtTwOSYeStQRwOjKzwgRR8amF5G8Ld0MwDQ3HTeY8
         ewaYAM2qInO9c9TV4XHpv/uOuM42ttuvINbzCxvOlxMo8kOHUuiO7Z85a69vp00nEQ
         NJjZ/5oARP1bMA1SsbiodaiDQ64Srawkx8R7q+8w=
Date:   Mon, 30 Jul 2018 09:42:23 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core
Message-ID: <20180730041223.GD3661@vkoul-mobl>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727121806.18209-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-07-18, 13:17, Srinivas Kandagatla wrote:
> +obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
> +wcd9335-objs			:= wcd9335-core.o
> +

no slimbus objs?

> +static int wcd9335_bring_up(struct wcd9335 *wcd)
> +{
> +	struct regmap *rm = wcd->regmap;
> +	int val, byte0;
> +	int ret = 0;
> +
> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_EFUSE_VAL_OUT0, &val);
> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_CHIP_ID_BYTE0, &byte0);
> +
> +	if ((val < 0) || (byte0 < 0)) {
> +		dev_err(wcd->dev, "wcd9335 codec version detection fail!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (byte0 == 0x1) {
> +		dev_info(wcd->dev, "wcd9335 codec version is v2.0\n");
> +		wcd->version = WCD9335_VERSION_2_0;
> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x01);
> +		regmap_write(rm, WCD9335_SIDO_SIDO_TEST_2, 0x00);
> +		regmap_write(rm, WCD9335_SIDO_SIDO_CCL_8, 0x6F);
> +		regmap_write(rm, WCD9335_BIAS_VBG_FINE_ADJ, 0x65);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x5);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x7);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x3);
> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x3);
> +	} else {
> +		dev_err(wcd->dev, "wcd9335 codec version not supported\n");
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;

we can do return 0 and remove the variable as it is not used anywhere
else.

> +static int wcd9335_slim_probe(struct slim_device *slim)
> +{
> +	struct device *dev = &slim->dev;
> +	struct wcd9335 *wcd;
> +	int ret = 0;
> +
> +	/* Interface device */
> +	if (slim->e_addr.dev_index == 0)
> +		return 0;
> +
> +	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
> +	if (!wcd)
> +		return	-ENOMEM;
                      ^^
double space

-- 
~Vinod
