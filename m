Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34415C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D663218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfAYTwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:52:11 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:39813 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYTwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:52:11 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id AE19C80392;
        Fri, 25 Jan 2019 20:52:06 +0100 (CET)
Date:   Fri, 25 Jan 2019 20:52:05 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v5 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
Message-ID: <20190125195205.GA31938@ravnborg.org>
References: <20190125192233.10019-1-jagan@amarulasolutions.com>
 <20190125192233.10019-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125192233.10019-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=3fyaaF4VAAAA:8 a=iP-xVBlJAAAA:8 a=7gkXJVJtAAAA:8
        a=4HpgsN6KaROfE_mb8mQA:9 a=CjuIK1q_8ugA:10 a=jOuFdahVONy5WApiBME_:22
        a=lHLH-nfn2y1bM_0xSXwp:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

Looks good, only very few nits left.

On Sat, Jan 26, 2019 at 12:52:33AM +0530, Jagan Teki wrote:
> Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> 
> Add panel driver for it.
> 
> Tested-by: Bhushan Shah <bshah@kde.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

If you consider my inputs (I know you will) then you can add my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>


> +	msleep(20);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +	/* T5 + T6 (avdd rise + video & logic signal rise)
> +	 * T5 >= 10ms, 0 < T6 <= 10ms
> +	 */
> +	msleep(20);

Please use kernel coding style comment, and maybe an empty
line between gpiod...() and the comment:

	gpiod_set_value(ctx->reset, 0);
	/*
	 * T5 + T6 (avdd rise + video & logic signal rise)
	 * T5 >= 10ms, 0 < T6 <= 10ms
	 */
	msleep(20);


> +static int feiyang_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_connector *connector = panel->connector;
> +	struct feiyang *ctx = panel_to_feiyang(panel);
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(panel->drm, &feiyang_default_mode);
> +	if (!mode) {
> +		DRM_DEV_ERROR(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> +			      feiyang_default_mode.hdisplay,
> +			      feiyang_default_mode.vdisplay,
> +			      feiyang_default_mode.vrefresh);
Please consider to use DRM_MODE_FMT and DRM_MODE_ARG for printing.


> +static const struct of_device_id feiyang_of_match[] = {
> +	{ .compatible = "feiyang,fy07024di26a30d", },
> +	{ }
Maybe use { /* sentinel */ },
?
