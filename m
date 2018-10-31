Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF98FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33EE20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QIoQFCI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33EE20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeJaWH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:07:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57766 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeJaWH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:07:56 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 857B411F2;
        Wed, 31 Oct 2018 14:09:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1540991396;
        bh=AJC2ob2MAZ/LXBIJm6bsSMUaaUmuMpxYcyDVBhVBS98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIoQFCI8S50dD80qP29B34a4kw6qqrGOen+fyoC2tFnYSYEFDXGLdspADcc6T0aQ7
         kGd2yYx/P8Fhvfp5LHx6h5j32KgpzqKhFuC6P2StVfGKniYMshU7+ZhNeDq8uGwFmB
         y8fDUel8CQBGOqdBm558LUka+knecsQLu1Mv1MFk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: omap4: support for manually updated display
Date:   Wed, 31 Oct 2018 15:10:00 +0200
Message-ID: <2348762.PvrRPAx0JW@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181020003812.GE43338@atomide.com>
References: <20180830090456.GA17277@amd> <20181019225827.s76wapp3cxrmp5af@earth.universe> <20181020003812.GE43338@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Saturday, 20 October 2018 03:38:12 EET Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [181019 15:58]:
> > I uploaded my current status here. It's not based on the newest
> > -next, but contains the interesting patches from Laurent. Also
> > the last few patches are not yet cleaned up, sorry for the mess.
> 
> Way to go, thanks :) Here's a quick fix for issues with loading
> and unloading modules, seems like this should be fixed somewhere
> else though?

Thanks for the report, I'll have a look at this.

> 8< -----------------------
> Unload of hdmi:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000278
> (hdmi_runtime_resume [omapdss]) from [<c060d944>]
> (__rpm_callback+0x144/0x1d8) (__rpm_callback) from [<c060d9f8>]
> (rpm_callback+0x20/0x80)
> (rpm_callback) from [<c060d580>] (rpm_resume+0x60c/0x828)
> (rpm_resume) from [<c060d7e8>] (__pm_runtime_resume+0x4c/0x64)
> (__pm_runtime_resume) from [<c06027ac>]
> (device_release_driver_internal+0x130/0x234)
> (device_release_driver_internal) from [<c06028f4>]
> (driver_detach+0x38/0x6c) (driver_detach) from [<c0601658>]
> (bus_remove_driver+0x4c/0xa4)
> (bus_remove_driver) from [<c06041fc>]
> (platform_unregister_drivers+0x20/0x2c) (platform_unregister_drivers) from
> [<c01f0ef8>] (sys_delete_module+0x1c0/0x230) (sys_delete_module) from
> [<c0101000>] (ret_fast_syscall+0x0/0x28)
> 
> 
> Unload of dsi:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000278
> (dsi_runtime_resume [omapdss]) from [<c060d944>]
> (__rpm_callback+0x144/0x1d8) (__rpm_callback) from [<c060d9f8>]
> (rpm_callback+0x20/0x80)
> (rpm_callback) from [<c060d580>] (rpm_resume+0x60c/0x828)
> (rpm_resume) from [<c060d7e8>] (__pm_runtime_resume+0x4c/0x64)
> (__pm_runtime_resume) from [<c0602364>] (driver_probe_device+0x38/0x164)
> (driver_probe_device) from [<c0602574>] (__driver_attach+0xe4/0xe8)
> (__driver_attach) from [<c0600418>] (bus_for_each_dev+0x70/0xb4)
> (bus_for_each_dev) from [<c06015a8>] (bus_add_driver+0x198/0x1fc)
> (bus_add_driver) from [<c06032ec>] (driver_register+0x74/0x108)
> (driver_register) from [<c0102fe4>] (do_one_initcall+0x80/0x31c)
> (do_one_initcall) from [<c01f0fc4>] (do_init_module+0x5c/0x1f8)
> (do_init_module) from [<c01f2e0c>] (load_module+0x1360/0x16c0)
> (load_module) from [<c01f33d4>] (sys_finit_module+0xbc/0xdc)
> (sys_finit_module) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c
> b/drivers/gpu/drm/omapdrm/dss/dsi.c --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -5484,6 +5484,9 @@ static int dsi_runtime_resume(struct device *dev)
>  	struct dsi_data *dsi = dev_get_drvdata(dev);
>  	int r;
> 
> +	if (!dsi || !dsi->dss || !dsi->dss->dispc)
> +		return -ENODEV;
> +
>  	r = dispc_runtime_get(dsi->dss->dispc);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> b/drivers/gpu/drm/omapdrm/dss/hdmi4.c ---
> a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> @@ -847,6 +847,9 @@ static int hdmi_runtime_resume(struct device *dev)
>  	struct omap_hdmi *hdmi = dev_get_drvdata(dev);
>  	int r;
> 
> +	if (!hdmi || !hdmi->dss || !hdmi->dss->dispc)
> +		return -ENODEV;
> +
>  	r = dispc_runtime_get(hdmi->dss->dispc);
>  	if (r < 0)
>  		return r;

-- 
Regards,

Laurent Pinchart



