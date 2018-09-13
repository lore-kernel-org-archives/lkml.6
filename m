Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE9FA3741
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21F321764
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="c+iC1A15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21F321764
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeIMWN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:13:29 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:39242 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeIMWN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:13:29 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id DE1CA5C08FA;
        Thu, 13 Sep 2018 19:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536858185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qs6EwoQxE4uEtaTssWazrM/iPyDz2Vd2ED8zUwOJyt0=;
        b=c+iC1A15QxroK+WY/C3KshQQcIdlYeLcMRu94rMl2jEh1R1LvOxTJWTMJZbvJ6qftp794v
        nzv7ywwZJkoAtOyN/uC8Pjwem/rkFaywkQHFxY6QkFxIoDDIvy0eIXo2IaH5h0TvGjcNBH
        lO6RHcFrBfWb6iWFn7evC9h7y8BAk5I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Sep 2018 10:03:05 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linus.walleij@linaro.org, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, architt@codeaurora.org,
        a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] drm/imx: support handling bridge timings bus flags
In-Reply-To: <1536827930.3452.4.camel@pengutronix.de>
References: <20180912183222.25414-1-stefan@agner.ch>
 <20180912183222.25414-7-stefan@agner.ch>
 <1536827930.3452.4.camel@pengutronix.de>
Message-ID: <c0814f7187159956c4a495986bdba01c@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2018 01:38, Philipp Zabel wrote:
> On Wed, 2018-09-12 at 11:32 -0700, Stefan Agner wrote:
>> A bridge might require specific settings for the pixel data on
>> the bus.
> 
> On which bus? The bridge has input and output.
> 
>> Copy the bus flags from the bridge timings if a bridge
>> is in use.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/gpu/drm/imx/parallel-display.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
>> index aefd04e18f93..7798a0621df7 100644
>> --- a/drivers/gpu/drm/imx/parallel-display.c
>> +++ b/drivers/gpu/drm/imx/parallel-display.c
>> @@ -239,6 +239,9 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
>>  	if (ret && ret != -ENODEV)
>>  		return ret;
>>
>> +	if (imxpd->bridge && imxpd->bridge->timings)
>> +		imxpd->bus_flags = imxpd->bridge->timings->input_bus_flags;
> 
> Oh, ok. I'd also specify input bus in the commit message.
> 

Good point, will change in v3 to:

"A bridge might require specific settings for the pixel data on
its input bus. Those are specified through optional bus timings.
Copy the bridges input bus flags as to the imxpd bus flags."

--
Stefan

>> +
>>  	imxpd->dev = dev;
>>
>>  	ret = imx_pd_register(drm, imxpd);
> 
> regards
> Philipp
