Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD5FC6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD512075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIVCUnm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD512075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJLDFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbeJLDFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:05:04 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D3F2075C;
        Thu, 11 Oct 2018 19:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539286583;
        bh=GP+tFrIyEuCoLhh+Z5fA+bVSdtOwKhqXI8jkeVaHuP0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=PIVCUnm00huWNJR9EvnVnnoPvZpo5BR67GM79K0y4ta8VU0VGDN1XfaaXRFbjP9f+
         2YGYxOr2fjkqAwQfkdmCgE/dj4HA7tvUCc0MAOJTtFE2j6qYcvycv0UiJ3jwzIGL3S
         eHoIrS8/bxgd8az/cc6AT+qmjQ28CUdLMH9AMZG4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Brown <broonie@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181011145422.GG25351@sirena.org.uk>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
 <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
 <20181011145422.GG25351@sirena.org.uk>
Message-ID: <153928658292.5275.11321177725702156165@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic Lochnagar
Date:   Thu, 11 Oct 2018 12:36:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2018-10-11 07:54:22)
> On Thu, Oct 11, 2018 at 12:00:46AM -0700, Stephen Boyd wrote:
> > Quoting Charles Keepax (2018-10-08 06:25:40)
> =

> > > +struct lochnagar_regmap_clk {
> > > +       unsigned int cfg_reg;
> > > +       unsigned int ena_mask;
> > > +       unsigned int dir_mask;
> > > +
> > > +       unsigned int src_reg;
> > > +       unsigned int src_mask;
> =

> > Are these 32 bits or 16 bits or 8 bits? Please use a u32/u16/u8 so we
> > know the register width.
> =

> Note that regmap always uses unsigned int to represent registers
> regardless of the underlying physical register width, this can be an
> issue on reads since we pass the destination for the read in by address.
> =

> > > +struct lochnagar_clk_priv {
> > > +       struct device *dev;
> > > +       struct lochnagar *lochnagar;
> =

> > Is this used for anything besides getting the regmap? Can you get the
> > pointer to the parent in probe and use that to get the regmap pointer
> > from dev_get_remap() and also use the of_node of the parent to register
> =

> dev_get_regmap() is pretty expensive, I'd not advise using it in
> anything that might approximate a fast path.  It's kind of debatable
> when I2C gets involved but still feels wrong.

I'm suggesting the regmap is acquired in probe and a pointer is stored
here in this structure. That is not a fastpath as far as I know.

