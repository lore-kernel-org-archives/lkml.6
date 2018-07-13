Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CDCECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F73A20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F73A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeGMJ0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:26:39 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57130 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeGMJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:26:39 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41RnC66rNQz1qxDD;
        Fri, 13 Jul 2018 11:12:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41RnC65xqTz1wj80;
        Fri, 13 Jul 2018 11:12:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id nNigbCoDp03G; Fri, 13 Jul 2018 11:12:49 +0200 (CEST)
X-Auth-Info: sbtMl29f1Tj+haHQNqtX68tcR5nsmbUH9gm86/TBdI8=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 13 Jul 2018 11:12:49 +0200 (CEST)
Subject: Re: [PATCH] drm: mxsfb: fix runtime PM handling
To:     Anson Huang <anson.huang@nxp.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>, Stefan Agner <stefan@agner.ch>
References: <1531472085-25174-1-git-send-email-Anson.Huang@nxp.com>
 <ea029b69-f853-4a5f-e798-70a04b02ac1d@denx.de>
 <AM3PR04MB1315E2F345752D0A64A0E2C8F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <90d16681-2a7a-4826-0411-478353d2afe3@denx.de>
Date:   Fri, 13 Jul 2018 11:12:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB1315E2F345752D0A64A0E2C8F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 11:06 AM, Anson Huang wrote:
[...]
>>
>> On 07/13/2018 10:54 AM, Anson Huang wrote:
>>> As display power domain is combined with lcdif node on some i.MX
>>> platforms like i.MX6SL, when lcdif driver is enabled, the mxsfb_load
>>> is called to enable runtime pm, and a pair of pm_runtime_get_sync and
>>> pm_runtime_put_sync are also called, that will cause generic power
>>> domain driver to disable lcdif power domain and lcdif is no longer
>>> working, the lcdif power should ONLY be turned off when display is
>>> disabled, so move the pm_runtime_put_sync to mxsfb_unload and remove
>>> the pm_runtime_get_sync in mxsfb_unload as well, in this way, when
>>> display is enabled, the lcdif power will be always ON until the
>>> display is disabled.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>
>> Doesn't this also mean the block will always be on, thus wasting power ?
>  
> I think drm driver should have somewhere to implement the display
> disable case, like when fb0 is blank (echo 1 > /sys/class/graphics/fb0/blank),

Isn't this just the fbdev emulation on top of drm/kms ?
I think this stuff can be compiled out completely.

> then lcdif can be powered gated, and
> when display is back on (unblank), lcdif needs to be re-initialization and display will
> be on, current implementation is incorrect, with kernel booting up, lcdif
> is NOT working at all.

It works fine on MX6SX , so I think this is isolated to MX6SL ?
I'm CCing Stefan, he might have some valuable feedback here.

> The runtime power gating case can be implemented later to save power,
> need lcdif experts to do it. Thanks.
> 
> Anson.
> 
>>
>>> ---
>>>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>>> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>>> index ffe5137..1ba179b 100644
>>> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>>> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>>> @@ -235,7 +235,6 @@ static int mxsfb_load(struct drm_device *drm,
>>> unsigned long flags)
>>>
>>>  	pm_runtime_get_sync(drm->dev);
>>>  	ret = drm_irq_install(drm, platform_get_irq(pdev, 0));
>>> -	pm_runtime_put_sync(drm->dev);
>>>
>>>  	if (ret < 0) {
>>>  		dev_err(drm->dev, "Failed to install IRQ handler\n"); @@ -264,6
>>> +263,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned long
>>> flags)
>>>  err_irq:
>>>  	drm_panel_detach(mxsfb->panel);
>>>  err_vblank:
>>> +	pm_runtime_put_sync(drm->dev);
>>>  	pm_runtime_disable(drm->dev);
>>>
>>>  	return ret;
>>> @@ -279,7 +279,6 @@ static void mxsfb_unload(struct drm_device *drm)
>>>  	drm_kms_helper_poll_fini(drm);
>>>  	drm_mode_config_cleanup(drm);
>>>
>>> -	pm_runtime_get_sync(drm->dev);
>>>  	drm_irq_uninstall(drm);
>>>  	pm_runtime_put_sync(drm->dev);
>>>
>>>
>>
>>
>> --
>> Best regards,
>> Marek Vasut


-- 
Best regards,
Marek Vasut
