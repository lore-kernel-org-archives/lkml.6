Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C69FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A7B2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rdnwOlwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A7B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeIGTcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:32:03 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39620 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeIGTcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:32:03 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:4407:cd00:1953:677d:5909:a7be])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F0C8A84;
        Fri,  7 Sep 2018 16:50:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536331845;
        bh=uSUzkQTqVxW9DWhO4EZPDAlLqJV7+iNL578KYRShi+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdnwOlwIu5rKyDVxRepEwyE/PCYd3z4FOY/ryu+1K4TGP0fjJSx3US7HVntZeJHiU
         HoVkKUmO0qwscY+AyQjRPs0qXO8LGtoZIuRffTCkBLjuURdeH1x1JHtn+LcD9+gxBy
         cg/0SakoPD2bqTrlWTIh/jgYpkIUQAds/kxdG7w4=
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
Subject: Re: [PATCH 03/10] phy: Add MIPI D-PHY configuration options
Date:   Fri, 07 Sep 2018 17:50:52 +0300
Message-ID: <4247225.jW0mJSbZmP@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180907085623.ltzybsftrw3zmmev@flea>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com> <11216244.YyI1EIWKhC@avalon> <20180907085623.ltzybsftrw3zmmev@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Friday, 7 September 2018 11:56:23 EEST Maxime Ripard wrote:
> On Wed, Sep 05, 2018 at 04:43:57PM +0300, Laurent Pinchart wrote:
> >> The current set of parameters should cover all the potential users.
> >> 
> >> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >> ---
> >> 
> >>  include/linux/phy/phy-mipi-dphy.h | 241 ++++++++++++++++++++++++++++++-
> >>  include/linux/phy/phy.h           |   6 +-
> >>  2 files changed, 247 insertions(+)
> >>  create mode 100644 include/linux/phy/phy-mipi-dphy.h
> >> 
> >> diff --git a/include/linux/phy/phy-mipi-dphy.h
> >> b/include/linux/phy/phy-mipi-dphy.h new file mode 100644
> >> index 000000000000..792724145290
> >> --- /dev/null
> >> +++ b/include/linux/phy/phy-mipi-dphy.h
> >> @@ -0,0 +1,241 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (C) 2018 Cadence Design Systems Inc.
> >> + */
> >> +
> >> +#ifndef __PHY_MIPI_DPHY_H_
> >> +#define __PHY_MIPI_DPHY_H_
> >> +
> >> +#include <video/videomode.h>
> >> +
> >> +/**
> >> + * struct phy_configure_opts_mipi_dphy - MIPI D-PHY configuration set
> >> + *
> >> + * This structure is used to represent the configuration state of a
> >> + * MIPI D-PHY phy.
> > 
> > Shouldn't we split the RX and TX parameters in two structures ?
> 
> Are they different? As far as I understood it, both were having the
> same parameters.

clk_miss, for instance, is a receiver parameter, while clk_post is a 
transmitter parameter. There are relationships between the transmitter and 
receiver parameters in the sense that they have to be compatible, and we may 
want to compute one set of parameters based on the other one, but I think they 
target RX and TX separately.

> >> +	/**
> >> +	 * @modes:
> >> +	 *
> >> +	 * transmission operation mode flags
> >> +	 */
> >> +	u32			modes;
> > 
> > Where are those flags defined ?
> 
> goto label;
> 
> >> +	/**
> >> +	 * @timings:
> >> +	 *
> >> +	 * Video timings associated with the transmission.
> > 
> > That's a pretty vague description...
> 
> I'll try to improve it then
> 
> >> +	 */
> >> +	struct videomode	timings;
> >> +};
> >> +
> 
> label:
> > > +/* TODO: Add other modes (burst, commands, etc) */
> > > +#define MIPI_DPHY_MODE_VIDEO_SYNC_PULSE		BIT(0)
> 
> But maybe I should reorganize it to make it more obvious.

-- 
Regards,

Laurent Pinchart



