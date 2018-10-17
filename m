Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9881BECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551822150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="jyQEkfYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551822150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeJQT4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:56:07 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:42586 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQT4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:56:07 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 3212B5C02D9;
        Wed, 17 Oct 2018 14:00:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1539777641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5ksCOEh0djQz+iDwXNCex/lLzXC+lFDjwNyKXU/mzw=;
        b=jyQEkfYGeoVTgLb5MtNusjnfwrelri3G04viyeWtRu8hpeo0UbiarqDHcSmLq37SiKCUau
        QOd7Z5XLZwzr+Oc22odKKYmA/y871m7ZMhIkn6DqPMP2WrYEwh7FUQ2oKk6gNJfptoQv+X
        nCwuA57ZsS6dq7U/1WuQ6wUFNVK60Aw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Oct 2018 14:00:41 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     p.zabel@pengutronix.de
Cc:     airlied@linux.ie, rmk+kernel@armlinux.org.uk,
        l.stach@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/imx: don't destroy mode objects manually on
 driver unbind"
In-Reply-To: <d55ebfae98b0ccf30895700be0881264@agner.ch>
References: <20181016160923.2042-1-stefan@agner.ch>
 <d55ebfae98b0ccf30895700be0881264@agner.ch>
Message-ID: <66518fd4ba1fe77344d849a0b3949342@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.2018 13:25, Stefan Agner wrote:
> On 16.10.2018 18:09, Stefan Agner wrote:
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
> After Lucas comment mentioning HDMI unbind is not proper I looked
> through all the unbind again. The other unbind functions need some
> fixing too. I did not bother checking whether those were always broken
> or just because things changed (the commit this is reverting was in
> 2016).... Here is what I found:
> 
>>
>> Link:
>> https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg233327.html
>> Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/gpu/drm/imx/imx-drm-core.c     | 4 ++--
>>  drivers/gpu/drm/imx/imx-ldb.c          | 6 ++++++
>>  drivers/gpu/drm/imx/imx-tve.c          | 3 +++
>>  drivers/gpu/drm/imx/parallel-display.c | 3 +++
>>  4 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c
>> b/drivers/gpu/drm/imx/imx-drm-core.c
>> index 5ea0c82f9957..caa6061a98ba 100644
>> --- a/drivers/gpu/drm/imx/imx-drm-core.c
>> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
>> @@ -305,11 +305,11 @@ static void imx_drm_unbind(struct device *dev)
>>
>>  	drm_fb_cma_fbdev_fini(drm);
>>
>> -	drm_mode_config_cleanup(drm);
>> -
>>  	component_unbind_all(drm->dev, drm);
>>  	dev_set_drvdata(dev, NULL);
>>
>> +	drm_mode_config_cleanup(drm);
>> +
>>  	drm_dev_put(drm);
>>  }
>>
>> diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
>> index 3bd0f8a18e74..592aabc4a262 100644
>> --- a/drivers/gpu/drm/imx/imx-ldb.c
>> +++ b/drivers/gpu/drm/imx/imx-ldb.c
>> @@ -723,6 +723,12 @@ static void imx_ldb_unbind(struct device *dev,
>> struct device *master,
>>  		if (channel->panel)
>>  			drm_panel_detach(channel->panel);
>>
>> +		if (!channel->connector.funcs)
>> +			continue;
>> +
>> +		channel->connector.funcs->destroy(&channel->connector);
>> +		channel->encoder.funcs->destroy(&channel->encoder);
> 
> There can be an encoder and bridge, or an encoder and connector. All of
> them should be properly cleaned up.
> 
> So I guess this should look like this:
> 
>   		if (channel->panel)
>   			drm_panel_detach(channel->panel);
> 
>   		if (channel->bridge)
>   			drm_bridge_detach(channel->bridge);

Actually, when a bridge is attached to an encoder, which is the case
when unbind is getting called, then encoder cleanup takes care of
drm_bridge_detach.

> 
> 		if (channel->connector.funcs)
> 			channel->connector.funcs->destroy(&channel->connector);
> 
> 		if (channel->encoder.funcs)
> 			channel->encoder.funcs->destroy(&channel->encoder);
> 
> 		kfree(channel->edid);
> 		i2c_put_adapter(channel->ddc);
> 
> The last two functions following are only strictly necessary when
> connector is initialized. But its safe to call them with null, so I
> would just call them always.
> 
> 
>> +
>>  		kfree(channel->edid);
>>  		i2c_put_adapter(channel->ddc);
>>  	}
>> diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
>> index cffd3310240e..8d6e89ce1edb 100644
>> --- a/drivers/gpu/drm/imx/imx-tve.c
>> +++ b/drivers/gpu/drm/imx/imx-tve.c
>> @@ -673,6 +673,9 @@ static void imx_tve_unbind(struct device *dev,
>> struct device *master,
>>  {
>>  	struct imx_tve *tve = dev_get_drvdata(dev);
>>
>> +	tve->connector.funcs->destroy(&tve->connector);
>> +	tve->encoder.funcs->destroy(&tve->encoder);
>> +
> 
> Cleanup of tve->ddc missing.
> 
>>  	if (!IS_ERR(tve->dac_reg))
>>  		regulator_disable(tve->dac_reg);
>>  }
>> diff --git a/drivers/gpu/drm/imx/parallel-display.c
>> b/drivers/gpu/drm/imx/parallel-display.c
>> index aefd04e18f93..6f11bffcde37 100644
>> --- a/drivers/gpu/drm/imx/parallel-display.c
>> +++ b/drivers/gpu/drm/imx/parallel-display.c
>> @@ -258,6 +258,9 @@ static void imx_pd_unbind(struct device *dev,
>> struct device *master,
>>  	if (imxpd->panel)
>>  		drm_panel_detach(imxpd->panel);
>>
> 
> And in this case a bridge detach is missing.

Same here.

> 
> Will send a v2 with that addressed.

Still valid.

--
Stefan

> 
> --
> Stefan
> 
>> +	imxpd->encoder.funcs->destroy(&imxpd->encoder);
>> +	imxpd->connector.funcs->destroy(&imxpd->connector);
>> +
>>  	kfree(imxpd->edid);
>>  }
