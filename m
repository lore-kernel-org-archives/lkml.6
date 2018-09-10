Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50451C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0287A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sv1wMdV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0287A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeIJTWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:22:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54288 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeIJTWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:22:23 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 928EF57;
        Mon, 10 Sep 2018 16:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536589681;
        bh=wSXNFler1XIm9xK9NCdFNHWXd3+aJKiN5nVgscPQWDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sv1wMdV6Re3JO8Z+o8kXAxi0GGStvtRs+v9QqGsLTLHuxrDBitMgcN2fowtso/u3R
         lQfKW7G+gN/cx5HX3QebmdEkH51oMBq2wwMlvTs6hR7sy04R6JR5zCZj3xbHjPHZNP
         D/C5ixKzkfRNV7Twwy4E7bnD/9AlRb0DUg3ZZOG8=
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
Date:   Mon, 10 Sep 2018 17:28:11 +0300
Message-ID: <3954754.hq6Pmoh9iE@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180910141603.gnwpkmemevaxbi7b@flea>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com> <1923627.Ifno3EcWVN@avalon> <20180910141603.gnwpkmemevaxbi7b@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Monday, 10 September 2018 17:16:03 EEST Maxime Ripard wrote:
> On Fri, Sep 07, 2018 at 05:26:29PM +0300, Laurent Pinchart wrote:
> >>>> + */
> >>>> +int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
> >>>> +				     unsigned int bpp,
> >>>> +				     unsigned int lanes,
> >>>> +				     struct phy_configure_opts_mipi_dphy *cfg)
> >>>> +{
> >>>> +	unsigned long hs_clk_rate;
> >>>> +	unsigned long ui;
> >>>> +
> >>>> +	if (!cfg)
> >>>> +		return -EINVAL;
> >>> 
> >>> Should we really expect cfg to be NULL ?
> >> 
> >> It avoids a kernel panic and it's not in a hot patch, so I'd say yes?
> > 
> > A few line below you divide by the lanes parameter without checking
> > whether it is equal to 0 first, which would also cause issues.
> 
> You say that like it would be a bad thing to test for this.
> 
> > I believe that invalid values in input parameters should only be handled
> > explicitly when considered acceptable for the caller to pass such values.
> > In this case a NULL cfg pointer is a bug in the caller, which would get
> > noticed during development if the kernel panics.
> 
> In the common case, yes. In the case where that pointer is actually
> being lost by the caller somewhere down the line and you have to wait
> for a while before it happens, then having the driver inoperant
> instead of just having a panic seems like the right thing to do.

But why would it happen in the first place ? Why would the pointer be more 
likely here to be NULL than to contain, for instance, an uninitialized value, 
which we don't guard against ?

-- 
Regards,

Laurent Pinchart



