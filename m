Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFE1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F1C20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfBKGz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:55:59 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:53617 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKGz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:55:59 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8EC1620030;
        Mon, 11 Feb 2019 07:55:53 +0100 (CET)
Date:   Mon, 11 Feb 2019 07:55:52 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Hean-Loong, Ong" <hean.loong.ong@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Rienk de Jong <rienk.dejong@quest-innovations.com>,
        devicetree@vger.kernel.org, yves.vandervennet@intel.com,
        chin.liang.see@intel.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Ong@freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv12 3/3] ARM:drm ivip Intel FPGA Video and Image
 Processing Suite
Message-ID: <20190211065552.GA7010@ravnborg.org>
References: <20190211060926.3433-1-hean.loong.ong@intel.com>
 <20190211060926.3433-4-hean.loong.ong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211060926.3433-4-hean.loong.ong@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=yBYpec10AAAA:8 a=fjobobjgAAAA:8 a=QyXUC8HyAAAA:8
        a=jbnKnBcKNtAAbXgpOMQA:9 a=aegFic2g-LuQCSZJ:21 a=er5hxFpQ-oadSlK4:21
        a=CjuIK1q_8ugA:10 a=zbxmTX4fiVD2UiCe4Dha:22 a=PlEKnuvBpV2Z9KzPMKMm:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hean-Loong, Ong

Patch looks good to me, but there is a few trivial
things I spotted while browsing the code.
See below.

	Sam

> +++ b/drivers/gpu/drm/ivip/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for the drm device driver.  This driver provides support for the
> +# Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> +
> +obj-$(CONFIG_DRM_IVIP) += ivip.o
> +ivip-objs := intel_vip_of.o intel_vip_core.o \
> +	intel_vip_conn.o

You could use:
ivip-y := intel_vip_of.o intel_vip_core.o
ivip-y += intel_vip_conn.o


Using "ivip-y" is the recommend syntax today.
And using "+=" you get rid of the ugly "\" to continue a line.
(Some people prefer "\" in makefiles, but there are not needed)

> +++ b/drivers/gpu/drm/ivip/intel_vip_core.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + *
> + * intel_vip_core.c -- Intel Video and Image Processing(VIP)
> + * Frame Buffer II driver
> + *
> + * This driver supports the Intel VIP Frame Reader component.
> + * More info on the hardware can be found in the Intel Video
> + * and Image Processing Suite User Guide at this address
> + * http://www.altera.com/literature/ug/ug_vip.pdf.
> + *
> + * Authors:
> + * Walter Goossens <waltergoossens@home.nl>
> + * Thomas Chou <thomas@wytron.com.tw>
> + * Chris Rauer <crauer@altera.com>
> + * Ong, Hean-Loong <hean.loong.ong@intel.com>
> + *
> + */
> +
> +#include <drm/drmP.h>
Please do not use drmP.h in new drivers, we try to get rid of this file.

> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_plane_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
Sort the list of include files.
(Looks like this was properly done before, and only one file is out of palce)


> +static void intelvipfb_enable(struct drm_simple_display_pipe *pipe,
> +	       struct drm_crtc_state *crtc_state, struct drm_plane_state *
> +	       plane_state)
Fix indent. The parameters on second line and following should be aligned
below the opening paranthesis.
Use tab(s) + spaces to align properly.

> +void intelvipfb_display_pipe_update(struct drm_simple_display_pipe *pipe,
> +				 struct drm_plane_state *old_state)
Align parameter

> +}
> +EXPORT_SYMBOL(intelvipfb_display_pipe_update);
> +
> +static struct drm_simple_display_pipe_funcs fbpriv_funcs = {
> +	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
> +	.update = intelvipfb_display_pipe_update,
> +	.enable = intelvipfb_enable,
> +	.disable = intelvipfb_disable,
> +};
> +
> +
> +int intelvipfb_probe(struct device *dev)
> +{
> +	int retval;
> +	struct drm_device *drm;
> +	struct intelvipfb_priv *fbpriv = dev_get_drvdata(dev);
> +
> +	struct drm_connector *connector;
> +	u32 formats[] = {DRM_FORMAT_XRGB8888};
> +
> +	drm = fbpriv->drm;
> +
> +	drm->dev_private = fbpriv;

It would be simpler to just pass fbpriv as a parameter.
There is only one user of intelvipfb_probe() so no need
to avoid it.

Also it would be more logical to set drm = fbpriv->drm; where memory are allocated.

> +
> +	intelvipfb_setup_mode_config(drm);
> +
> +	connector = intelvipfb_conn_setup(drm);
> +	if (!connector) {
> +		dev_err(drm->dev, "Connector setup failed\n");
> +		goto err_mode_config;
> +	}
> +
> +	retval = drm_simple_display_pipe_init(drm,
> +			&fbpriv->pipe,
> +			&fbpriv_funcs,
> +			formats,
> +			ARRAY_SIZE(formats),
> +			NULL, connector);
Consider indent, where subsequent parameters are aligned right after the
opening '('.

> +
> +	if (retval < 0) {
> +		dev_err(drm->dev, "Cannot setup simple display pipe\n");
> +		goto err_mode_config;
> +	}
> +
> +	drm_mode_config_reset(drm);
> +
> +	drm_dev_register(drm, 0);
> +
> +	drm_fbdev_generic_setup(drm, 32);
> +
> +	dev_info(drm->dev, "ivip: Successfully created fb\n");
> +
> +	return retval;
> +
> +err_mode_config:
> +
> +	drm_mode_config_cleanup(drm);
> +	return -ENODEV;
> +}
> +

> diff --git a/drivers/gpu/drm/ivip/intel_vip_of.c b/drivers/gpu/drm/ivip/intel_vip_of.c
> new file mode 100644
> index 0000000..c899e30
> --- /dev/null
> +++ b/drivers/gpu/drm/ivip/intel_vip_of.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + *
> + * intel_vip_of.c -- Intel Video and Image Processing(VIP)
> + * Frame Buffer II driver

The need for this file confuses me.
It does not include only "of" related stuff, but also generic device driver stuff.

Maybe merge with intel_vip_core.c?
And rename that file to intel_vip_drv.c?

> + *
> + * This driver supports the Intel VIP Frame Reader component.
> + * More info on the hardware can be found in the Intel Video
> + * and Image Processing Suite User Guide at this address
> + * http://www.altera.com/literature/ug/ug_vip.pdf.
> + *
> + * Authors:
> + * Ong, Hean-Loong <hean.loong.ong@intel.com>
> + *
> + */
> +#include <drm/drmP.h>
Drop use of drmP.h

> +static int intelvipfb_of_probe(struct platform_device *pdev)
> +{
> +	int retval;
> +	struct resource *reg_res;
> +	struct intelvipfb_priv *fbpriv;
> +	struct device *dev = &pdev->dev;
> +	struct drm_device *drm;
> +
> +	fbpriv = devm_kzalloc(dev, sizeof(*fbpriv), GFP_KERNEL);
> +	if (!fbpriv)
> +		return -ENOMEM;
> +
> +	/*setup DRM */
Space before "setup"

> +
> +static const struct of_device_id intelvipfb_of_match[] = {
> +	{ .compatible = "altr,vip-frame-buffer-2.0" },
> +	{},
Maybe add "/* sentinel */" comment?

