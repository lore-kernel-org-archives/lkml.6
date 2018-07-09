Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935A6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBDB208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TizqiJK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBDB208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbeGIHsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbeGIHso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:48:44 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC329208AF;
        Mon,  9 Jul 2018 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531122523;
        bh=O10bSVgtfWST7gkydT9vbJ6CzKVOtiR1AgxG6fXEMJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TizqiJK/JCuqkNjydxg+9RFR3eCyW+BiQYVpTGk31d3onDKbRta53Fs32qEVXhJoA
         QR7UKIOMNN/BZ0tKy1+2dVbsvUfnjn3e981L6UJDfj/WyRxAUg5EU/gzodXZdTIdva
         m0eWODzNBLeotC71VfXSNmH7qG8GhGZpLLZebHb0=
Date:   Mon, 9 Jul 2018 13:18:35 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card
 support
Message-ID: <20180709074835.GB22377@vkoul-mobl>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-07-18, 15:13, Rohit kumar wrote:

> +static void sdm845_init_supplies(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
> +
> +	data->vdd_supply = regulator_get(dev, "cdc-vdd");
> +	if (IS_ERR(data->vdd_supply)) {
> +		dev_err(dev, "Unable to get regulator supplies\n");
> +		data->vdd_supply = NULL;
> +		return;
> +	}
> +
> +	if (regulator_enable(data->vdd_supply))
> +		dev_err(dev, "Unable to enable vdd supply\n");
> +}
> +
> +static void sdm845_deinit_supplies(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
> +
> +	if (!data->vdd_supply)
> +		return;
> +
> +	regulator_disable(data->vdd_supply);
> +	regulator_put(data->vdd_supply);
> +}

these two can be made generic, cant we make these common when we have
supplies present?

> +static int sdm845_bind(struct device *dev)
> +{
> +	struct snd_soc_card *card;
> +	struct sdm845_snd_data *data;
> +	int ret;
> +
> +	card = kzalloc(sizeof(*card), GFP_KERNEL);
> +	if (!card)
> +		return -ENOMEM;
> +
> +	/* Allocate the private data */
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = component_bind_all(dev, card);
> +	if (ret) {
> +		dev_err(dev, "Audio components bind failed: %d\n", ret);
> +		goto bind_fail;
> +	}
> +
> +	dev_set_drvdata(dev, card);
> +	card->dev = dev;
> +	ret = qcom_snd_parse_of(card);
> +	if (ret) {
> +		dev_err(dev, "Error parsing OF data\n");
> +		goto parse_dt_fail;
> +	}
> +
> +	data->card = card;
> +	snd_soc_card_set_drvdata(card, data);
> +
> +	sdm845_add_be_ops(card);
> +
> +	sdm845_init_supplies(dev);
> +
> +	ret = snd_soc_register_card(card);
> +	if (ret) {
> +		dev_err(dev, "Sound card registration failed\n");
> +		goto register_card_fail;
> +	}
> +	return ret;
> +
> +register_card_fail:
> +	sdm845_deinit_supplies(dev);
> +	kfree(card->dai_link);
> +parse_dt_fail:
> +	component_unbind_all(dev, card);
> +bind_fail:
> +	kfree(data);
> +	kfree(card);
> +	return ret;
> +}

I would make a case for this to be moved into common too :)
-- 
~Vinod
