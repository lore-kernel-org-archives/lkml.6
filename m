Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074F6C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B821A208A4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1zNEncCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B821A208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933612AbeFUMfO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933388AbeFUMfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:35:12 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36CB520883;
        Thu, 21 Jun 2018 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529584512;
        bh=lQah/djH4Cx0KRpFvMkY3SlE9GggRmJ4lwS9+Rx24RA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1zNEncCuDmcb4GE1D609rQ2JwgOTKT0XYd7NVk9YDbEsIjvy673qRwIin8O4pF6g2
         6Y7Hz9h2TJOfcYShtx2BRJeLrrryK0UfvSXnH0vyVK1LVvv2i7U011BbudENUJJKjE
         3sxIPDN6UQBIUAbQKLofXzYNnQoUsiJYXkwo50rk=
Date:   Thu, 21 Jun 2018 18:05:03 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2 2/2] ASoC: qcom: add sdm845 sound card
 support
Message-ID: <20180621123503.GD27187@vkoul-mobl>
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-3-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529578399-3633-3-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohit,

On 21-06-18, 16:23, Rohit kumar wrote:

> +static struct sdm845_snd_data *sdm845_sbc_parse_of(struct snd_soc_card *card)
> +{
> +	struct device *dev = card->dev;
> +	struct snd_soc_dai_link *link;
> +	struct device_node *np, *codec, *platform, *cpu, *node;
> +	int ret, num_links;
> +	struct sdm845_snd_data *data;
> +
> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
> +	if (ret) {
> +		dev_err(dev, "Error parsing card name: %d\n", ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	node = dev->of_node;
> +
> +	/* DAPM routes */
> +	if (of_property_read_bool(node, "qcom,audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(card,
> +					"qcom,audio-routing");
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	/* Populate links */
> +	num_links = of_get_child_count(node);
> +
> +	/* Allocate the private data and the DAI link array */
> +	data = kzalloc(sizeof(*data) + sizeof(*link) * num_links,
> +			GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	card->dai_link = &data->dai_link[0];
> +	card->num_links = num_links;
> +
> +	link = data->dai_link;
> +	data->card = card;
> +
> +	for_each_child_of_node(node, np) {
> +		cpu = of_get_child_by_name(np, "cpu");
> +		if (!cpu) {
> +			dev_err(dev, "Can't find cpu DT node\n");
> +			ret = -EINVAL;
> +			goto fail;
> +		}
> +
> +		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
> +		if (!link->cpu_of_node) {
> +			dev_err(card->dev, "error getting cpu phandle\n");
> +			ret = -EINVAL;
> +			goto fail;
> +		}
> +
> +		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
> +		if (ret) {
> +			dev_err(card->dev, "error getting cpu dai name\n");
> +			goto fail;
> +		}
> +
> +		platform = of_get_child_by_name(np, "platform");
> +		codec = of_get_child_by_name(np, "codec");
> +		if (codec && platform) {
> +			link->platform_of_node = of_parse_phandle(platform,
> +					"sound-dai", 0);
> +			if (!link->platform_of_node) {
> +				dev_err(card->dev, "error getting platform phandle\n");
> +				ret = -EINVAL;
> +				goto fail;
> +			}
> +
> +			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
> +			if (ret < 0) {
> +				dev_err(card->dev, "error getting codec dai name\n");
> +				goto fail;
> +			}
> +			link->no_pcm = 1;
> +			link->ignore_pmdown_time = 1;
> +			link->ops = &sdm845_be_ops;
> +			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
> +		} else {
> +			link->platform_of_node = link->cpu_of_node;
> +			link->codec_dai_name = "snd-soc-dummy-dai";
> +			link->codec_name = "snd-soc-dummy";
> +			link->dynamic = 1;
> +		}
> +
> +		link->ignore_suspend = 1;
> +		ret = of_property_read_string(np, "link-name", &link->name);
> +		if (ret) {
> +			dev_err(card->dev,
> +				"error getting codec dai_link name\n");
> +			goto fail;
> +		}
> +
> +		link->dpcm_playback = 1;
> +		link->dpcm_capture = 1;
> +		link->stream_name = link->name;
> +		link++;
> +	}
> +	dev_set_drvdata(dev, card);
> +	snd_soc_card_set_drvdata(card, data);
> +
> +	return data;
> +fail:
> +	kfree(data);
> +	return ERR_PTR(ret);
> +}

this routine...

> +static int add_audio_components(struct device *dev,
> +				struct component_match **matchptr)
> +{
> +	struct device_node *np, *platform, *cpu, *node, *dai_node;
> +
> +	node = dev->of_node;
> +
> +	for_each_child_of_node(node, np) {
> +		cpu = of_get_child_by_name(np, "cpu");
> +		if (cpu) {
> +			dai_node = of_parse_phandle(cpu, "sound-dai", 0);
> +			of_node_get(dai_node);
> +			component_match_add_release(dev, matchptr,
> +					sdm845_release_of,
> +					sdm845_compare_of,
> +					dai_node);
> +		}
> +
> +		platform = of_get_child_by_name(np, "platform");
> +		if (platform) {
> +			dai_node = of_parse_phandle(platform, "sound-dai", 0);
> +			component_match_add_release(dev, matchptr,
> +					sdm845_release_of,
> +					sdm845_compare_of,
> +					dai_node);
> +		}
> +	}
> +
> +	return 0;
> +}

And this one is generic DT parsing and seems quite similar to one in apq8096.c
Can we move these into a lib and use them instead of duplicating.

-- 
~Vinod
