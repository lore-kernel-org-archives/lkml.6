Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeD3JDo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:03:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43918 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752484AbeD3JDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:03:41 -0400
Date: Mon, 30 Apr 2018 11:03:39 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/vc4: Skip ULPS latching when we're in that ULPS
 state already.
Message-ID: <20180430110339.29d217e7@bbrezillon>
In-Reply-To: <20171031193258.17373-1-eric@anholt.net>
References: <20171031193258.17373-1-eric@anholt.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2017 12:32:57 -0700
Eric Anholt <eric@anholt.net> wrote:

> It seems that trying to go from unlatched to unlatched will time out
> waiting for STOP, and we can just skip that.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/gpu/drm/vc4/vc4_dsi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 94085f8bcd68..8aa897835118 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -753,6 +753,11 @@ static void vc4_dsi_ulps(struct vc4_dsi *dsi, bool ulps)
>  			 (dsi->lanes > 2 ? DSI1_STAT_PHY_D2_STOP : 0) |
>  			 (dsi->lanes > 3 ? DSI1_STAT_PHY_D3_STOP : 0));
>  	int ret;
> +	bool ulps_currently_enabled = (DSI_PORT_READ(PHY_AFEC0) &
> +				       DSI_PORT_BIT(PHY_AFEC0_LATCH_ULPS));
> +
> +	if (ulps == ulps_currently_enabled)
> +		return;
>  
>  	DSI_PORT_WRITE(STAT, stat_ulps);
>  	DSI_PORT_WRITE(PHYC, DSI_PORT_READ(PHYC) | phyc_ulps);



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
