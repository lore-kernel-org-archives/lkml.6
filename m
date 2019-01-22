Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA4C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22A72084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rwuwppvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfAVVKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:10:31 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:56308 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAVVKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:10:30 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 887D7575;
        Tue, 22 Jan 2019 22:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548191428;
        bh=vKY129i8aRtbfAXk03mqMUCEEbXct5Bsh+1dVXPIr6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwuwppvEvnWVQFJu+vupQTIbHuwBT/KiywJ7LQGsoRQIMCJDlysJNPoQxgAp0TUKH
         hJjTVV4cL+DFNPe8yG1sJOoXScEVIwYF8EegL89BYDHfnZu2kdeTlmiS55xni2NbqL
         OnlpD992OGVxstbcovw2AhV+P0ivWGWy8ff8UMR8=
Date:   Tue, 22 Jan 2019 23:10:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ronald =?utf-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sil_sii8620: depend on INPUT instead of
 selecting it.
Message-ID: <20190122211028.GK3264@pendragon.ideasonboard.com>
References: <20190122141311.10445-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122141311.10445-1-ronald@innovation.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ronald,

Thank you for the patch.

On Tue, Jan 22, 2019 at 06:13:11AM -0800, Ronald Tschalär wrote:
> commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:

Commits are usually quoted using the short 12 digits version of their
SHA-1.

> sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
> INPUT. However, this causes problems with other drivers, in particular
> an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
> future commit):
> 
>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> 
> According to the docs, select should only be used for non-visible
> symbols. Furthermore almost all other references to INPUT throughout the
> kernel config are depends, not selects. Hence this change.
> 
> CC: Inki Dae <inki.dae@samsung.com>
> CC: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 2fee47b0d50b..eabedc83f25c 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
>  config DRM_SIL_SII8620
>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>  	depends on OF
> +	depends on INPUT
>  	select DRM_KMS_HELPER
>  	imply EXTCON
> -	select INPUT
>  	select RC_CORE

RC_CORE is always a user-visible symbol (which by the way depends on
INPUT). I think reverting commit d6abe6df706c would be a better
solution.

>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.

-- 
Regards,

Laurent Pinchart
