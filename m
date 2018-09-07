Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8281EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372F12077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OL0m6OUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372F12077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeIGTHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:07:34 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39512 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbeIGTHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:07:34 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:4407:cd00:1953:677d:5909:a7be])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F6DB84;
        Fri,  7 Sep 2018 16:26:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536330381;
        bh=l5Y260kPSGpMFPHqfDr9s2sEQc0YXoxs/exOQaPQdT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OL0m6OUt7sWnOgHL0htxg2Z4LEn0TSS2VRSweDsGryj1Qv5pHRvwQNwHgALB+yPNb
         iVXbDNAtS44GjXax7VQS3OknANJGNrTWsxPAmyTcRw218TjXODi8HlSyN4AU7OMWPK
         urqQgRdiU6wz6OAbt7b7eFCjvMpL2p3ZBEdP8rdo=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: Re: [PATCH 04/10] phy: dphy: Add configuration helpers
Date:   Fri, 07 Sep 2018 17:26:29 +0300
Message-ID: <1923627.Ifno3EcWVN@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180907133739.6lvlw7wsdk4ffeua@flea>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com> <3617916.Vq2Smf1hnZ@avalon> <20180907133739.6lvlw7wsdk4ffeua@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Friday, 7 September 2018 16:37:39 EEST Maxime Ripard wrote:
> On Wed, Sep 05, 2018 at 04:46:05PM +0300, Laurent Pinchart wrote:
> > On Wednesday, 5 September 2018 12:16:35 EEST Maxime Ripard wrote:
> >> The MIPI D-PHY spec defines default values and boundaries for most of
> >> the parameters it defines. Introduce helpers to help drivers get
> >> meaningful values based on their current parameters, and validate the
> >> boundaries of these parameters if needed.
> >> 
> >> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >> ---
> >> 
> >>  drivers/phy/Kconfig               |   8 ++-
> >>  drivers/phy/Makefile              |   1 +-
> >>  drivers/phy/phy-core-mipi-dphy.c  | 160 ++++++++++++++++++++++++++++++-
> >>  include/linux/phy/phy-mipi-dphy.h |   6 +-
> >>  4 files changed, 175 insertions(+)
> >>  create mode 100644 drivers/phy/phy-core-mipi-dphy.c

[snip]

> >> diff --git a/drivers/phy/phy-core-mipi-dphy.c
> >> b/drivers/phy/phy-core-mipi-dphy.c new file mode 100644
> >> index 000000000000..6c1ddc7734a2
> >> --- /dev/null
> >> +++ b/drivers/phy/phy-core-mipi-dphy.c
> >> @@ -0,0 +1,160 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (C) 2013 NVIDIA Corporation
> >> + * Copyright (C) 2018 Cadence Design Systems Inc.
> >> + */
> >> +
> >> +#include <linux/errno.h>
> >> +#include <linux/export.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/time64.h>
> >> +
> >> +#include <linux/phy/phy.h>
> >> +#include <linux/phy/phy-mipi-dphy.h>
> >> +
> >> +/*
> >> + * Default D-PHY timings based on MIPI D-PHY specification. Derived
> >> from the
> >> + * valid ranges specified in Section 6.9, Table 14, Page 40 of the
> >> D-PHY
> >> + * specification (v1.2) with minor adjustments.
> > 
> > Could you list those adjustments ?
> 
> I will. This was taken from the Tegra DSI driver, so I'm not sure what
> these are exactly, but that should be addressed.
> 
> >> + */
> >> +int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
> >> +				     unsigned int bpp,
> >> +				     unsigned int lanes,
> >> +				     struct phy_configure_opts_mipi_dphy *cfg)
> >> +{
> >> +	unsigned long hs_clk_rate;
> >> +	unsigned long ui;
> >> +
> >> +	if (!cfg)
> >> +		return -EINVAL;
> > 
> > Should we really expect cfg to be NULL ?
> 
> It avoids a kernel panic and it's not in a hot patch, so I'd say yes?

A few line below you divide by the lanes parameter without checking whether it 
is equal to 0 first, which would also cause issues.

I believe that invalid values in input parameters should only be handled 
explicitly when considered acceptable for the caller to pass such values. In 
this case a NULL cfg pointer is a bug in the caller, which would get noticed 
during development if the kernel panics.

-- 
Regards,

Laurent Pinchart



