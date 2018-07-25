Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D8FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A2220893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+jiYl3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A2220893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeGYNPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbeGYNPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:15:39 -0400
Received: from localhost (unknown [122.178.229.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7931E20844;
        Wed, 25 Jul 2018 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532520256;
        bh=rJgl7cNWV8SVzuBFVpFu6/dWEswJPbOgXZQgce8Itaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+jiYl3nTeMGHTLWrz7MNo6PTctg0tChH5ClnWEdPlTe1jl2D1Ss+FphtuKTS0T0S
         hXt+HH5hQp5wXlOSUynfdy5FIHjBRlQ0SFWF1iOpHgdOqh/LoKjMhf4u2St7QF7BlO
         v1TCcCuHxC3pshFNNdi5geNa3vx7RtUM/XKqxxv0=
Date:   Wed, 25 Jul 2018 17:34:07 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 08/12] ASoC: wcd9335: add basic controls
Message-ID: <20180725120407.GO3661@vkoul-mobl>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-9-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723155410.9494-9-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-18, 16:54, Srinivas Kandagatla wrote:

> +static int wcd9335_set_compander(struct snd_kcontrol *kc,
> +				 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
> +	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
> +	int comp = ((struct soc_mixer_control *) kc->private_value)->shift;
> +	int value = ucontrol->value.integer.value[0];
> +	int sel;
> +
> +	wcd->comp_enabled[comp] = value;
> +	sel = value ? WCD9335_HPH_GAIN_SRC_SEL_COMPANDER :
> +		WCD9335_HPH_GAIN_SRC_SEL_REGISTER;
> +
> +	/* Any specific register configuration for compander */
> +	switch (comp) {
> +	case COMPANDER_1:
> +		/* Set Gain Source Select based on compander enable/disable */
> +		snd_soc_component_update_bits(component, WCD9335_HPH_L_EN,
> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
> +		break;
> +	case COMPANDER_2:
> +		snd_soc_component_update_bits(component, WCD9335_HPH_R_EN,
> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
> +		break;
> +	case COMPANDER_3:
> +		break;
> +	case COMPANDER_4:
> +		break;
> +	case COMPANDER_5:
> +		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO3_GAIN,
> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
> +		break;
> +	case COMPANDER_6:
> +		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO4_GAIN,
> +				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
> +		break;
> +	case COMPANDER_7:
> +		break;
> +	case COMPANDER_8:
> +		break;

why not do:

        case COMPANDER_3:
        case COMPANDER_4:
        case COMPANDER_7:
        case COMPANDER_8:
                break;

thereby clubbing all the ones not handled together..

> +static int wcd9335_rx_hph_mode_get(struct snd_kcontrol *kc,
> +				 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
> +	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
> +
> +	ucontrol->value.integer.value[0] = wcd->hph_mode;

i think this is an enum so shouldn't value.enumerated.item[0] be used?

> +
> +	return 0;
> +}
> +
> +static int wcd9335_rx_hph_mode_put(struct snd_kcontrol *kc,
> +				 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
> +	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
> +	u32 mode_val;
> +
> +	mode_val = ucontrol->value.enumerated.item[0];

yaaay
-- 
~Vinod
