Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EFEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC55320872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1wccQZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC55320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754942AbeFTJbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754908AbeFTJbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:31:14 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E8120693;
        Wed, 20 Jun 2018 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529487074;
        bh=gYcvbnmZM0k3vdWZQWFVZAXF18q5B0efzAUneau6qb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1wccQZSm7U64nktTi5wEdkwXOMvuX9jwfNG/n6HO8wjMDh7AjXNQGnYGK1KPl8SQ
         xBmyobSTtElhTmPXodQTK6FA9GJqxdn7eN+2MeSUrphMvngP+9DQauF1MObktydeCT
         PQz8lw9yDT6uIUit2Aq88bQ06sRBJr7S1o0ayclY=
Date:   Wed, 20 Jun 2018 15:01:06 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rohit Kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: qcom: add sdm845 sound card support
Message-ID: <20180620093106.GI13316@vkoul-mobl>
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <20180619050527.GR25852@vkoul-mobl>
 <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
 <20180619162230.GF13316@vkoul-mobl>
 <f7891675-4c98-7fc6-b80f-840ada9a1c5b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7891675-4c98-7fc6-b80f-840ada9a1c5b@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohit,

On 20-06-18, 13:07, Rohit Kumar wrote:
> > On 19-06-18, 19:20, Rohit Kumar wrote:
> > > On 6/19/2018 10:35 AM, Vinod wrote:
> > > > On 18-06-18, 16:46, Rohit kumar wrote:
> > > > 
> > > > > +struct sdm845_snd_data {
> > > > > +	struct snd_soc_card *card;
> > > > > +	struct regulator *vdd_supply;
> > > > > +	struct snd_soc_dai_link dai_link[];
> > > > > +};
> > > > > +
> > > > > +static struct mutex pri_mi2s_res_lock;
> > > > > +static struct mutex quat_tdm_res_lock;
> > > > any reason why the locks can't be part of sdm845_snd_data?
> > > > Also why do we need two locks ?
> > > No specific reason, I will move it to sdm845_snd_data.
> > > These locks are used to protect enable/disable of bit clocks. We have
> > > Primary MI2S RX/TX
> > > and Quaternary TDM RX/TX interfaces. For primary mi2s rx/tx, we have single
> > > clock which is
> > > synchronized with pri_mi2s_res_lock. For Quat TDM RX/TX, we are using
> > > quat_tdm_res_lock.
> > > We need two locks as we are protecting two different resources.
> > I think bigger question is why do you need any locks? What is the race
> > scenario you envision which needs protection
> > 
> 
> Below is one of the race condition:
> 
> Thread1                          |         Thread2
> ----------------------------------------------------------
> startup()                         |
> count++;                         |    startup()
> read count (count = 1) |
> enable_clock()               |    count++;   //count = 2
> shutdown()                    |
> count--;// count = 1      |
>                                          | read count (count = 1)
>                                          | enable_clock()
> 
> Here clock will be enabled twice but disable will be called only once when
> count = 0.
> 
> This will make the clock always enabled. So, I think we should keep either
> mutex lock or atomic variable to synchronize this.

we are using DPCM here right?

-- 
~Vinod
