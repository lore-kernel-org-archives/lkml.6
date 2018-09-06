Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374122075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RyYonKEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374122075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeIFV1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:27:21 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45354 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeIFV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:27:21 -0400
Received: from avalon.localnet (unknown [91.180.122.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9AFF71A45;
        Thu,  6 Sep 2018 18:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536252658;
        bh=c7hrOS39ox0zEIrAUjtVLkaMhnvfelIW4qjVYDP9Hr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyYonKEq0l92kFf4xdMb7rbhD+yFg8XOk7ctsC2tRqos2eLFqX2kDzSiKcByy4v+y
         5fylDrDyp2HL7KgmDhwgvPHHSrcxeB7Rf3U2n/GvrxnkspLrenztIVfhOtIdpbvilv
         xxJpZSJXquWX+HuJv75VCsv5ppOaNJ4afMwFE2ek=
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
Subject: Re: [PATCH 02/10] phy: Add configuration interface
Date:   Thu, 06 Sep 2018 19:51:05 +0300
Message-ID: <2403687.Gdit31W5bd@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180906144807.pn753tgfyovvheil@flea>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com> <8397722.XVQDA25ZU6@avalon> <20180906144807.pn753tgfyovvheil@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thursday, 6 September 2018 17:48:07 EEST Maxime Ripard wrote:
> On Wed, Sep 05, 2018 at 04:39:46PM +0300, Laurent Pinchart wrote:
> > On Wednesday, 5 September 2018 12:16:33 EEST Maxime Ripard wrote:
> >> The phy framework is only allowing to configure the power state of the
> >> PHY using the init and power_on hooks, and their power_off and exit
> >> counterparts.
> >> 
> >> While it works for most, simple, PHYs supported so far, some more
> >> advanced PHYs need some configuration depending on runtime parameters.
> >> These PHYs have been supported by a number of means already, often by
> >> using ad-hoc drivers in their consumer drivers.
> >> 
> >> That doesn't work too well however, when a consumer device needs to deal
> > 
> > s/deal/deal with/
> > 
> >> multiple PHYs, or when multiple consumers need to deal with the same PHY
> >> (a DSI driver and a CSI driver for example).
> >> 
> >> So we'll add a new interface, through two funtions, phy_validate and
> >> phy_configure. The first one will allow to check that a current
> >> configuration, for a given mode, is applicable. It will also allow the
> >> PHY driver to tune the settings given as parameters as it sees fit.
> >> 
> >> phy_configure will actually apply that configuration in the phy itself.
> >> 
> >> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >> ---
> >> 
> >>  drivers/phy/phy-core.c  | 62 +++++++++++++++++++++++++++++++++++++++++-
> >>  include/linux/phy/phy.h | 42 ++++++++++++++++++++++++++++-
> >>  2 files changed, 104 insertions(+)
> >> 
> >> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> >> index 35fd38c5a4a1..6eaf655e370f 100644
> >> --- a/drivers/phy/phy-core.c
> >> +++ b/drivers/phy/phy-core.c
> >> @@ -408,6 +408,68 @@ int phy_calibrate(struct phy *phy)
> >>  EXPORT_SYMBOL_GPL(phy_calibrate);
> >>  
> >>  /**
> >> + * phy_configure() - Changes the phy parameters
> >> + * @phy: the phy returned by phy_get()
> >> + * @mode: phy_mode the configuration is applicable to.
> >> + * @opts: New configuration to apply
> >> + *
> >> + * Used to change the PHY parameters. phy_init() must have
> >> + * been called on the phy.
> >> + *
> >> + * Returns: 0 if successful, an negative error code otherwise
> >> + */
> >> +int phy_configure(struct phy *phy, enum phy_mode mode,
> >> +		  union phy_configure_opts *opts)
> >> +{
> >> +	int ret;
> >> +
> >> +	if (!phy)
> >> +		return -EINVAL;
> >> +
> >> +	if (!phy->ops->configure)
> >> +		return 0;
> > 
> > Shouldn't you report an error to the caller ? If a caller expects the PHY
> > to be configurable, I would assume that silently ignoring the requested
> > configuration won't work great.
> 
> I'm not sure. I also expect a device having to interact with multiple
> PHYs, some of them needing some configuration while some other do
> not. In that scenario, returning 0 seems to be the right thing to do.

It could be up to the caller to decide whether to ignore the error or not when 
the operation isn't implemented. I expect that a call requiring specific 
configuration parameters for a given PHY might want to bail out if the 
configuration can't be applied. On the other hand that should never happen 
when the system is designed correctly, as vendors are not supposed to ship 
kernels that would be broken by design (as in requiring a configure operation 
but not providing it).

> >> +	mutex_lock(&phy->mutex);
> >> +	ret = phy->ops->configure(phy, mode, opts);
> >> +	mutex_unlock(&phy->mutex);
> >> +
> >> +	return ret;
> >> +}

[snip]

> >> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> >> index 9cba7fe16c23..3cc315dcfcd0 100644
> >> --- a/include/linux/phy/phy.h
> >> +++ b/include/linux/phy/phy.h

[snip]

> >> @@ -60,6 +66,38 @@ struct phy_ops {
> >>  	int	(*power_on)(struct phy *phy);
> >>  	int	(*power_off)(struct phy *phy);
> >>  	int	(*set_mode)(struct phy *phy, enum phy_mode mode);
> >> +
> >> +	/**
> >> +	 * @configure:
> >> +	 *
> >> +	 * Optional.
> >> +	 *
> >> +	 * Used to change the PHY parameters. phy_init() must have
> >> +	 * been called on the phy.
> >> +	 *
> >> +	 * Returns: 0 if successful, an negative error code otherwise
> >> +	 */
> >> +	int	(*configure)(struct phy *phy, enum phy_mode mode,
> >> +			     union phy_configure_opts *opts);
> > 
> > Is this function allowed to modify opts ? If so, to what extent ? If not,
> > the pointer should be made const.
> 
> That's a pretty good question. I guess it could modify it to the same
> extent than validate could. Would that make sense?

It would, or we could say that PHY users are required to call the validate 
function first, and the the configure function will return an error if the 
passed configuration isn't valid. That would avoid double-validation when the 
PHY user uses .validate().

> >> +	/**
> >> +	 * @validate:
> >> +	 *
> >> +	 * Optional.
> >> +	 *
> >> +	 * Used to check that the current set of parameters can be
> >> +	 * handled by the phy. Implementations are free to tune the
> >> +	 * parameters passed as arguments if needed by some
> >> +	 * implementation detail or constraints. It must not change
> >> +	 * any actual configuration of the PHY, so calling it as many
> >> +	 * times as deemed fit by the consumer must have no side
> >> +	 * effect.
> >> +	 *
> >> +	 * Returns: 0 if the configuration can be applied, an negative
> >> +	 * error code otherwise
> > 
> > When should this operation modify the passed parameters, and when should
> > it return an error ? I understand that your goal is to implement a
> > negotiation mechanism for the PHY parameters, and to be really useful I
> > think we need to document it more precisely.
> 
> My initial idea was to reject a configuration that wouldn't be
> achievable by the PHY, ie you're asking something that is outside of
> the operating boundaries, while you would be able to change settings
> that would be operational, but sub-optimal.

I'm fine with that, let's document it explicitly.

-- 
Regards,

Laurent Pinchart



