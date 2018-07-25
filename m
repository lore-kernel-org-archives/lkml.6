Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B380C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AB120671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="piseT2gJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AB120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeGYICf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbeGYICf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:02:35 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC9420671;
        Wed, 25 Jul 2018 06:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532501540;
        bh=TPobVrYpZ0Fd+3wNgRCoUWlHROgZlVzCdgwEPRvkCvI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=piseT2gJq9RjynCP5yIwCVM9pJuvhnLLyvKr2L9OklhecDdoJeVgy9FuRYPKeMayd
         sJvaLtlmYQ8cgysx55dOt+dQ5SI4d8vHfW0sVRRhWKLEBZyXQY+zX4Gt5xZsuWbzz4
         E864BUqK+5eLdfu7YwZb2ooY45Xv71rR5GUFo4is=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <6e53b7934af72e40e99a3d6afe54174f@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-2-git-send-email-anischal@codeaurora.org>
 <153111447519.143105.17241493270191899078@swboyd.mtv.corp.google.com>
 <6e53b7934af72e40e99a3d6afe54174f@codeaurora.org>
Message-ID: <153250153971.48062.18053635476867512394@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/4] clk: qcom: gdsc: Add support to enable/disable the clocks
 with GDSC
Date:   Tue, 24 Jul 2018 23:52:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-07-12 05:23:48)
> On 2018-07-09 11:04, Stephen Boyd wrote:
> > Quoting Amit Nischal (2018-06-06 04:41:45)
> >> For some of the GDSCs, there is a requirement to enable/disable the
> >> few clocks before turning on/off the gdsc power domain. Add support
> > =

> > Why is there a requirement? Do the clks need to be in hw control mode =

> > or
> > they can't be turned off when the GDSC is off? It's hard for me to
> > understand with these vague statements.
> > =

> =

> This requirement is primarily to turn on the GPU GX GDSC and these =

> clocks
> do not need to be in HW control mode and clock disable is not related
> with the GDSC.

Ok that's good to know.

> =

> To turn on the GX GDSC, root clock (GFX3D RCG) needs to be enabled first
> before writing to SW_COLLAPSE bit of the GDSC. The CLK_ON signal from =

> RCG
> would power up the GPU GX GDSC.

Can you please put this specific information in the commit text instead
of making a vague statement about GDSC hardware configurations?

Does anything go wrong if the GDSC is enabled from genpd but doesn't
actually turn on until the GFX3D RCG root bit is enabled or disabled by
the clk enable call? I suppose we won't know if the GDSC is enabled or
not until the clk is enabled? Maybe we should make the clk enable of the
RCG for GPU go check the GDSC status bit as well to make sure it's
toggling on or off?

Also, does the RCG turn on when the GX GDSC is off? I think we may be
able to rely on the GPU driver to "do the right thing" and enable the
GPU CX GDSC first, then the RCG and branch for the GFX3D clk, and then
the GPU GX GDSC for the core GPU logic. Then we don't need to do
anything special in the GDSC code for this.

