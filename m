Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9D2C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310E82089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+n7X4Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310E82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeGIOpo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932508AbeGIOpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:45:42 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5748D20878;
        Mon,  9 Jul 2018 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531147542;
        bh=6krZ9cWHssJEe46VxLFEX8woVMKrF8w9zqm/TT2ceHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+n7X4QahvsYGHoeCX2Y6YZnNKaVrLJJYrSxfEB92pQgI+c+3mZIaQgLzwTVXxIMt
         K4F54d3aae4xZ/tqu2fgpLPsR1+rTXCBb/kTunmyzVWm5PrWCfwnYCXPfY9Mmlpwef
         L5CluL8HzDFVmJ9C+ZKcK6QrRbvjHWa7lu6XH/y8=
Date:   Mon, 9 Jul 2018 20:15:33 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rohit Kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card
 support
Message-ID: <20180709144533.GE22377@vkoul-mobl>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709074835.GB22377@vkoul-mobl>
 <c1766ce9-060f-32d8-46fa-b0a6ac42538b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1766ce9-060f-32d8-46fa-b0a6ac42538b@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-18, 16:16, Rohit Kumar wrote:

> > > +static int sdm845_bind(struct device *dev)
> > > +{
> > > +	struct snd_soc_card *card;
> > > +	struct sdm845_snd_data *data;
> > > +	int ret;
> > > +
> > > +	card = kzalloc(sizeof(*card), GFP_KERNEL);
> > > +	if (!card)
> > > +		return -ENOMEM;
> > > +
> > > +	/* Allocate the private data */
> > > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > > +	if (!data)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = component_bind_all(dev, card);
> > > +	if (ret) {
> > > +		dev_err(dev, "Audio components bind failed: %d\n", ret);
> > > +		goto bind_fail;
> > > +	}
> > > +
> > > +	dev_set_drvdata(dev, card);
> > > +	card->dev = dev;
> > > +	ret = qcom_snd_parse_of(card);
> > > +	if (ret) {
> > > +		dev_err(dev, "Error parsing OF data\n");
> > > +		goto parse_dt_fail;
> > > +	}
> > > +
> > > +	data->card = card;
> > > +	snd_soc_card_set_drvdata(card, data);
> > > +
> > > +	sdm845_add_be_ops(card);
> > > +
> > > +	sdm845_init_supplies(dev);
> > > +
> > > +	ret = snd_soc_register_card(card);
> > > +	if (ret) {
> > > +		dev_err(dev, "Sound card registration failed\n");
> > > +		goto register_card_fail;
> > > +	}
> > > +	return ret;
> > > +
> > > +register_card_fail:
> > > +	sdm845_deinit_supplies(dev);
> > > +	kfree(card->dai_link);
> > > +parse_dt_fail:
> > > +	component_unbind_all(dev, card);
> > > +bind_fail:
> > > +	kfree(data);
> > > +	kfree(card);
> > > +	return ret;
> > > +}
> > I would make a case for this to be moved into common too :)
> 
> There are few platform specific APIs and structs here like struct
> sdm845_snd_data,
> sdm845_add_be_ops() which needs to be initialized and assigned before
> soundcard
> registration. Moving this complete API to common will restrict it. Please
> suggest.

Yes indeed, they can be split and done outside while the common stuff
use a 'core' object and use that to initialize. If you need to do some
driver step, you can invoke a callback.

-- 
~Vinod
