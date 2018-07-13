Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A87CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B68208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B68208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbeGMLAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:00:04 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39530 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeGMLAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:00:04 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41RqGW6xNKz1qxWD;
        Fri, 13 Jul 2018 12:45:55 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41RqGW6R5bz20bYL;
        Fri, 13 Jul 2018 12:45:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 7HEb9_M-wLwA; Fri, 13 Jul 2018 12:45:54 +0200 (CEST)
X-Auth-Info: 5jzH0wpOxNGsxGVu8I4AFFBbEdcfLhMHJoLp7DDI/4g=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 13 Jul 2018 12:45:54 +0200 (CEST)
Subject: Re: [PATCH] drm: mxsfb: fix runtime PM handling
To:     Stefan Agner <stefan@agner.ch>
Cc:     Anson Huang <anson.huang@nxp.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dl-linux-imx <linux-imx@nxp.com>
References: <1531472085-25174-1-git-send-email-Anson.Huang@nxp.com>
 <ea029b69-f853-4a5f-e798-70a04b02ac1d@denx.de>
 <AM3PR04MB1315E2F345752D0A64A0E2C8F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <90d16681-2a7a-4826-0411-478353d2afe3@denx.de>
 <00b5faf737efd1054eb4f0f0e6fc8369@agner.ch>
 <52c0153c-1810-2919-70b7-d57280c83c90@denx.de>
 <ac14d93449ac802854b29216967c9d98@agner.ch>
From:   Marek Vasut <marex@denx.de>
Message-ID: <122d65ad-8840-f991-4c73-c28d5c06c3b0@denx.de>
Date:   Fri, 13 Jul 2018 12:45:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ac14d93449ac802854b29216967c9d98@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 12:39 PM, Stefan Agner wrote:
> On 13.07.2018 12:36, Marek Vasut wrote:
>> On 07/13/2018 12:33 PM, Stefan Agner wrote:
>>> On 13.07.2018 11:12, Marek Vasut wrote:
>>>> On 07/13/2018 11:06 AM, Anson Huang wrote:
>>>> [...]
>>>>>>
>>>>>> On 07/13/2018 10:54 AM, Anson Huang wrote:
>>>>>>> As display power domain is combined with lcdif node on some i.MX
>>>>>>> platforms like i.MX6SL, when lcdif driver is enabled, the mxsfb_load
>>>>>>> is called to enable runtime pm, and a pair of pm_runtime_get_sync and
>>>>>>> pm_runtime_put_sync are also called, that will cause generic power
>>>>>>> domain driver to disable lcdif power domain and lcdif is no longer
>>>>>>> working, the lcdif power should ONLY be turned off when display is
>>>>>>> disabled, so move the pm_runtime_put_sync to mxsfb_unload and remove
>>>>>>> the pm_runtime_get_sync in mxsfb_unload as well, in this way, when
>>>>>>> display is enabled, the lcdif power will be always ON until the
>>>>>>> display is disabled.
>>>>>>>
>>>>>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>>>>>
>>>>>> Doesn't this also mean the block will always be on, thus wasting power ?
>>>>>
>>>>> I think drm driver should have somewhere to implement the display
>>>>> disable case, like when fb0 is blank (echo 1 > /sys/class/graphics/fb0/blank),
>>>>
>>>> Isn't this just the fbdev emulation on top of drm/kms ?
>>>> I think this stuff can be compiled out completely.
>>>>
>>>>> then lcdif can be powered gated, and
>>>>> when display is back on (unblank), lcdif needs to be re-initialization and display will
>>>>> be on, current implementation is incorrect, with kernel booting up, lcdif
>>>>> is NOT working at all.
>>>>
>>>> It works fine on MX6SX , so I think this is isolated to MX6SL ?
>>>> I'm CCing Stefan, he might have some valuable feedback here.
>>>>
>>>
>>> Yeah not sure, but putting it in mxsfb_load seems wrong.
>>>
>>> MXSFB uses struct drm_simple_display_pipe_funcs which does have
>>> enable/disable callbacks, probably closer to what we want...
>>
>> Seems to me like this is not something that should be hacked around in
>> the mxsfb driver in the first place, but somewhere else.
> 
> By somewhere else you mean in the DRM stack?

Rather the clock driver or somesuch. Maybe the power domains need to be
modeled in the DT properly, but I didn't dig in deep enough.

> Yeah not sure, currently pm seems to be handled on driver level only,
> see
> grep -r -e pm_runtime_get_sync drivers/gpu/drm
> 
> --
> Stefan
> 


-- 
Best regards,
Marek Vasut
