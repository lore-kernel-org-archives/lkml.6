Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48740C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EAA21987
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DjDvSETg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EAA21987
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeHEW4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:56:47 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46820 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeHEW4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:56:47 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC42757;
        Sun,  5 Aug 2018 22:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533502254;
        bh=C6HIXkrv8Ez5p0cxXQS6irpYB2qA4opRSLE9lflm1u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjDvSETg8mPsZbLpiQPD9OL5la5K0M4x98GTYcX9VAtBgDeLFnrhKDrnkGGAp7qfA
         JlAPEdXOHp2+d5gOJt6yFcKUerdnGvcNXZbCiWGHUrA87r6UPzuZzHDX5+4QuWW+JT
         C+8vOJ1hU3BTFBPSbl6Pnogd/NfGAb8Jfqh/j7SM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: analogix_dp: Downgrade "Link Training" messages to dev_dbg
Date:   Sun, 05 Aug 2018 23:51:36 +0300
Message-ID: <1962378.MsuH5vNa41@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180805172857.2517-1-marc.zyngier@arm.com>
References: <20180805172857.2517-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thank you for the patch.

On Sunday, 5 August 2018 20:28:57 EEST Marc Zyngier wrote:
> The Analogix DP bridge driver is pretty verbose, and outputs
> things like
> 
> [  619.414067] rockchip-dp ff970000.edp: Link Training Clock Recovery
> success [  619.429233] rockchip-dp ff970000.edp: Link Training success!
> 
> each time the display gets unblanked. While it is good to know
> that the device is behaving correctly, users already know that
> because they can see some video output.
> 
> Let's keep these messages for cases where we need to actually
> debug the driver (we have dynamic debug to enable them at runtime
> if need be), and let's keep the kernel quiet otherwise.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c index
> 2bcbfadb6ac5..0d715a375ff9 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -554,7 +554,7 @@ static int analogix_dp_process_clock_recovery(struct
> analogix_dp_device *dp)
>  		if (retval < 0)
>  			return retval;
> 
> -		dev_info(dp->dev, "Link Training Clock Recovery success\n");
> +		dev_dbg(dp->dev, "Link Training Clock Recovery success\n");
>  		dp->link_train.lt_state = EQUALIZER_TRAINING;
>  	} else {
>  		for (lane = 0; lane < lane_count; lane++) {
> @@ -634,7 +634,7 @@ static int analogix_dp_process_equalizer_training(struct
> analogix_dp_device *dp)
>  		if (retval < 0)
>  			return retval;
> 
> -		dev_info(dp->dev, "Link Training success!\n");
> +		dev_dbg(dp->dev, "Link Training success!\n");
>  		analogix_dp_get_link_bandwidth(dp, &reg);
>  		dp->link_train.link_rate = reg;
>  		dev_dbg(dp->dev, "final bandwidth = %.2x\n",

-- 
Regards,

Laurent Pinchart



