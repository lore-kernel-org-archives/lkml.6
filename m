Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1CDC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399EB2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQB5QuA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399EB2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967018AbeFSQWk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966582AbeFSQWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:22:39 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668282083A;
        Tue, 19 Jun 2018 16:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529425359;
        bh=fCb0GIme5KEgePbGf3R7XZjAeep8amgvBeoowIHzzIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQB5QuA+Y8LC7Ktv7/dBiOVBX2ASoywRCoYP0efSzbshrreMeHtN2EnCI3i49qCGU
         AC12TCDw+xmlSJmCHPShOBs5U4eHDZCbP1FDzOudUMsk0XETHblNVEpudY7StBkLA5
         h04tCR7BDKiNlVUFE2gDYxFTMCreJeoWjjl1zvdc=
Date:   Tue, 19 Jun 2018 21:52:30 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rohit Kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: qcom: add sdm845 sound card support
Message-ID: <20180619162230.GF13316@vkoul-mobl>
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <20180619050527.GR25852@vkoul-mobl>
 <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohit,

On 19-06-18, 19:20, Rohit Kumar wrote:
> On 6/19/2018 10:35 AM, Vinod wrote:
> > On 18-06-18, 16:46, Rohit kumar wrote:
> > 
> > > +struct sdm845_snd_data {
> > > +	struct snd_soc_card *card;
> > > +	struct regulator *vdd_supply;
> > > +	struct snd_soc_dai_link dai_link[];
> > > +};
> > > +
> > > +static struct mutex pri_mi2s_res_lock;
> > > +static struct mutex quat_tdm_res_lock;
> > any reason why the locks can't be part of sdm845_snd_data?
> > Also why do we need two locks ?
> No specific reason, I will move it to sdm845_snd_data.
> These locks are used to protect enable/disable of bit clocks. We have
> Primary MI2S RX/TX
> and Quaternary TDM RX/TX interfaces. For primary mi2s rx/tx, we have single
> clock which is
> synchronized with pri_mi2s_res_lock. For Quat TDM RX/TX, we are using
> quat_tdm_res_lock.
> We need two locks as we are protecting two different resources.

I think bigger question is why do you need any locks? What is the race
scenario you envision which needs protection

-- 
~Vinod
