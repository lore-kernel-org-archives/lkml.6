Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDB6ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4455214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="YH/7MZiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4455214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeJQSre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:47:34 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41356 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeJQSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:47:33 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F07045C02D9;
        Wed, 17 Oct 2018 12:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1539773541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4M0RqDD4RKziDvTXJnkE4GPy7LWAwZ0GrPlKiU4G/ik=;
        b=YH/7MZiKm/lpqcejwpE56w1w1+qC4CETjFFJeaAzLDATS6G+My5wntiCrlX/V9G73AzfUk
        ZNkq1Inq/vT6sAUvF4rZuc+kaFgAu12ZR66O2exKHnb7L35wRsGyaBaZ2vvJ8P8IYViWg0
        KoL/s0TwMmrtxQrSS/57P05H4Ptz1Hs=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Wed, 17 Oct 2018 12:52:21 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie,
        rmk+kernel@armlinux.org.uk, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/imx: don't destroy mode objects manually on
 driver unbind"
In-Reply-To: <1539708694.3688.16.camel@pengutronix.de>
References: <20181016160923.2042-1-stefan@agner.ch>
 <1539708694.3688.16.camel@pengutronix.de>
Message-ID: <c7dac6b5bad766d9553be8678f7c0d62@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2018 18:51, Lucas Stach wrote:
> Am Dienstag, den 16.10.2018, 18:09 +0200 schrieb Stefan Agner:
>> This reverts commit 8e3b16e2117409625b89807de3912ff773aea354.
>>
>> Using the component framework requires all components to undo in
>> ->unbind what ->bind does. Unfortunately that particular commit
>> broke this rule. In particular, this is an issue if a single
>> component during probe fails. In that case, component_bind_all()
>> calls unbind on already succussfully bound components, and then
>> frees memory allocated using devm. If one of those components
>> registered e.g. an encoder with the framework then this leads to
>> use after free situations.
>>
>> Revert the commit to ensure that all components properly undo
>> what ->bind does.
> 
> I agree with this patch in general, but I think I remember why I
> changed this in the first place: dw_hdmi_imx_unbind does not destroy
> the encoder that has been registered in dw_hdmi_imx_bind.

Good point, yeah that is missing.

> 
> 8e3b16e21174 was an (apparently wrong) attempt to fix such issues once
> and for all. By reverting this commit we go back to leaking the HDMI
> encoder, so I think this patch should include a fix to destroy the
> encoder on unbind.

Makes sense, will add that to the same commit and send a v2.

--
Stefan

> 
> Regards,
> Lucas
> 
>> Link: https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg233327.html
>> > Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/gpu/drm/imx/imx-drm-core.c     | 4 ++--
>>  drivers/gpu/drm/imx/imx-ldb.c          | 6 ++++++
>>  drivers/gpu/drm/imx/imx-tve.c          | 3 +++
>>  drivers/gpu/drm/imx/parallel-display.c | 3 +++
>>  4 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
>> index 5ea0c82f9957..caa6061a98ba 100644
>> --- a/drivers/gpu/drm/imx/imx-drm-core.c
>> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
>> @@ -305,11 +305,11 @@ static void imx_drm_unbind(struct device *dev)
>>  
>> >  	drm_fb_cma_fbdev_fini(drm);
>>  
>> > -	drm_mode_config_cleanup(drm);
>> -
>> >  	component_unbind_all(drm->dev, drm);
>> >  	dev_set_drvdata(dev, NULL);
>>  
>> > +	drm_mode_config_cleanup(drm);
>> +
>> >  	drm_dev_put(drm);
>>  }
>>  
>> diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
>> index 3bd0f8a18e74..592aabc4a262 100644
>> --- a/drivers/gpu/drm/imx/imx-ldb.c
>> +++ b/drivers/gpu/drm/imx/imx-ldb.c
>> @@ -723,6 +723,12 @@ static void imx_ldb_unbind(struct device *dev, struct device *master,
>> >  		if (channel->panel)
>> >  			drm_panel_detach(channel->panel);
>>  
>> > +		if (!channel->connector.funcs)
>> > +			continue;
>> +
>> > +		channel->connector.funcs->destroy(&channel->connector);
>> > +		channel->encoder.funcs->destroy(&channel->encoder);
>> +
>> >  		kfree(channel->edid);
>> >  		i2c_put_adapter(channel->ddc);
>> >  	}
>> diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
>> index cffd3310240e..8d6e89ce1edb 100644
>> --- a/drivers/gpu/drm/imx/imx-tve.c
>> +++ b/drivers/gpu/drm/imx/imx-tve.c
>> @@ -673,6 +673,9 @@ static void imx_tve_unbind(struct device *dev, struct device *master,
>>  {
>> >  	struct imx_tve *tve = dev_get_drvdata(dev);
>>  
>> > +	tve->connector.funcs->destroy(&tve->connector);
>> > +	tve->encoder.funcs->destroy(&tve->encoder);
>> +
>> >  	if (!IS_ERR(tve->dac_reg))
>> >  		regulator_disable(tve->dac_reg);
>>  }
>> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
>> index aefd04e18f93..6f11bffcde37 100644
>> --- a/drivers/gpu/drm/imx/parallel-display.c
>> +++ b/drivers/gpu/drm/imx/parallel-display.c
>> @@ -258,6 +258,9 @@ static void imx_pd_unbind(struct device *dev, struct device *master,
>> >  	if (imxpd->panel)
>> >  		drm_panel_detach(imxpd->panel);
>>  
>> > +	imxpd->encoder.funcs->destroy(&imxpd->encoder);
>> > +	imxpd->connector.funcs->destroy(&imxpd->connector);
>> +
>> >  	kfree(imxpd->edid);
>>  }
>>  
