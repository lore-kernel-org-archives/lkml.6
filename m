Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9261C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8B720840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ0NfrpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8B720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeKIUsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbeKIUsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:48:20 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E13720827;
        Fri,  9 Nov 2018 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541761692;
        bh=m/dcEOoSbDFjfbhmO+reaN2RhRFb45FXTf5L398Kyd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJ0NfrpI7Uhh+YzmMSj8OyEkGprtpZ0RJvHFkcdTJ+l1W4cRBazzDWJOAwGet9Ydp
         f34tzz11iKcB+mqAZiAFB/qEz6SAqC8mvkgVCNPlbDCR9Es7eN+CHeZgeQ1/eXAljZ
         4xmZts6HpNcv2FFt4Qw18CukMSksmGb09Q4WZZUQ=
Date:   Fri, 9 Nov 2018 16:38:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY driver
Message-ID: <20181109110809.GT12092@vkoul-mobl>
References: <20181108070449.23572-1-shawn.guo@linaro.org>
 <20181108070449.23572-3-shawn.guo@linaro.org>
 <20181109052217.GL12092@vkoul-mobl>
 <20181109065226.GB20049@tiger>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109065226.GB20049@tiger>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-11-18, 14:52, Shawn Guo wrote:
> On Fri, Nov 09, 2018 at 10:52:17AM +0530, Vinod Koul wrote:
> > On 08-11-18, 15:04, Shawn Guo wrote:
> > > +static int qcom_snps_hsphy_config_regulators(struct hsphy_priv *priv, int high)
> > > +{
> > > +	int min, ret, i;
> > > +
> > > +	min = high ? 1 : 0; /* low or none? */
> > > +
> > > +	for (i = 0; i < VREG_NUM; i++) {
> > > +		ret = regulator_set_voltage(priv->vregs[i].consumer,
> > > +					    priv->voltages[i][min],
> > > +					    priv->voltages[i][VOL_MAX]);
> > > +		if (ret)
> > > +			return ret;
> > 
> > should we not roll back the set voltages on error?
> 
> Yes.  I will get that handled in v2.  Thanks.
> 
> > 
> > > +static int qcom_snps_hsphy_por_reset(struct hsphy_priv *priv)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = reset_control_assert(priv->por_reset);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/*
> > > +	 * The Femto PHY is POR reset in the following scenarios.
> > 
> > POR?
> 
> Hmm, I do not understand this comment.  The POR is commonly used as the
> abbrev of power-on-reset.  What do you meat exactly?

I wasnt aware that POR refers to power-on-reset :) I dont know if it is
a very generic term :D
-- 
~Vinod
