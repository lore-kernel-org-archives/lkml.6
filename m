Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0071ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF8920871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="GwtGACCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF8920871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeGMKrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:47:43 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41518 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbeGMKrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:47:43 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B6C485C168B;
        Fri, 13 Jul 2018 12:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531478016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIjpAUXv9Q6sxpqXg6aqbfR4dfkvHaqJ7Kwr+UD365I=;
        b=GwtGACCQfXCW7z/GUicFqOH9HPDSIRKkCC2L4pFzl22i/YzbvHYTjlR2nZHqVhE5VMI0K3
        GGNjBXD62oM1Vn8X8bPbT6IdPrEvPjkpwJ90x8ryT9Kiw6nKGI0l8C51no9GO9wCdr08Z/
        5yj+zNQYOOmEsXUHokrlcSQCnhCNcTQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Jul 2018 12:33:36 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Marek Vasut <marex@denx.de>
Cc:     Anson Huang <anson.huang@nxp.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] drm: mxsfb: fix runtime PM handling
In-Reply-To: <90d16681-2a7a-4826-0411-478353d2afe3@denx.de>
References: <1531472085-25174-1-git-send-email-Anson.Huang@nxp.com>
 <ea029b69-f853-4a5f-e798-70a04b02ac1d@denx.de>
 <AM3PR04MB1315E2F345752D0A64A0E2C8F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <90d16681-2a7a-4826-0411-478353d2afe3@denx.de>
Message-ID: <00b5faf737efd1054eb4f0f0e6fc8369@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.2018 11:12, Marek Vasut wrote:
> On 07/13/2018 11:06 AM, Anson Huang wrote:
> [...]
>>>
>>> On 07/13/2018 10:54 AM, Anson Huang wrote:
>>>> As display power domain is combined with lcdif node on some i.MX
>>>> platforms like i.MX6SL, when lcdif driver is enabled, the mxsfb_load
>>>> is called to enable runtime pm, and a pair of pm_runtime_get_sync and
>>>> pm_runtime_put_sync are also called, that will cause generic power
>>>> domain driver to disable lcdif power domain and lcdif is no longer
>>>> working, the lcdif power should ONLY be turned off when display is
>>>> disabled, so move the pm_runtime_put_sync to mxsfb_unload and remove
>>>> the pm_runtime_get_sync in mxsfb_unload as well, in this way, when
>>>> display is enabled, the lcdif power will be always ON until the
>>>> display is disabled.
>>>>
>>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>>
>>> Doesn't this also mean the block will always be on, thus wasting power ?
>>
>> I think drm driver should have somewhere to implement the display
>> disable case, like when fb0 is blank (echo 1 > /sys/class/graphics/fb0/blank),
> 
> Isn't this just the fbdev emulation on top of drm/kms ?
> I think this stuff can be compiled out completely.
> 
>> then lcdif can be powered gated, and
>> when display is back on (unblank), lcdif needs to be re-initialization and display will
>> be on, current implementation is incorrect, with kernel booting up, lcdif
>> is NOT working at all.
> 
> It works fine on MX6SX , so I think this is isolated to MX6SL ?
> I'm CCing Stefan, he might have some valuable feedback here.
> 

Yeah not sure, but putting it in mxsfb_load seems wrong.

MXSFB uses struct drm_simple_display_pipe_funcs which does have
enable/disable callbacks, probably closer to what we want...

--
Stefan

>> The runtime power gating case can be implemented later to save power,
>> need lcdif experts to do it. Thanks.
>>
>> Anson.
>>
>>>
>>>> ---
>>>>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>>>> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>>>> index ffe5137..1ba179b 100644
>>>> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>>>> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
>>>> @@ -235,7 +235,6 @@ static int mxsfb_load(struct drm_device *drm,
>>>> unsigned long flags)
>>>>
>>>>  	pm_runtime_get_sync(drm->dev);
>>>>  	ret = drm_irq_install(drm, platform_get_irq(pdev, 0));
>>>> -	pm_runtime_put_sync(drm->dev);
>>>>
>>>>  	if (ret < 0) {
>>>>  		dev_err(drm->dev, "Failed to install IRQ handler\n"); @@ -264,6
>>>> +263,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned long
>>>> flags)
>>>>  err_irq:
>>>>  	drm_panel_detach(mxsfb->panel);
>>>>  err_vblank:
>>>> +	pm_runtime_put_sync(drm->dev);
>>>>  	pm_runtime_disable(drm->dev);
>>>>
>>>>  	return ret;
>>>> @@ -279,7 +279,6 @@ static void mxsfb_unload(struct drm_device *drm)
>>>>  	drm_kms_helper_poll_fini(drm);
>>>>  	drm_mode_config_cleanup(drm);
>>>>
>>>> -	pm_runtime_get_sync(drm->dev);
>>>>  	drm_irq_uninstall(drm);
>>>>  	pm_runtime_put_sync(drm->dev);
>>>>
>>>>
>>>
>>>
>>> --
>>> Best regards,
>>> Marek Vasut
