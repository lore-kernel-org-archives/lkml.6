Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A89C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2898B2170F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTyq6AJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2898B2170F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeHHIQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeHHIQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:16:24 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B3502170F;
        Wed,  8 Aug 2018 05:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533707900;
        bh=kfLzw2JWghE5fbPstZPekgU574y8F1/W+q/0giGeaio=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=KTyq6AJe4l4C0czFtrGrlb+COF4RoDT2J8CN8L9K+Y+MQzvU9j6CTNF7s1e5Nv7Om
         Q235tNq8oUTfgYlz4g/auKFRYn3lurtz16SsvV68cTxCCGLFTqi2tW+r8YSlU+MEiC
         V6TKa75w5ZONaUdFfGlVznyHYZVZ1trGGKHnqD2w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180806150437.GE21283@jcrouse-lnx.qualcomm.com>
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
 <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
 <153111693472.143105.11303543263643845656@swboyd.mtv.corp.google.com>
 <1e6d9fc284c3c118203728867f504ec6@codeaurora.org>
 <153250192252.48062.9210075387954345932@swboyd.mtv.corp.google.com>
 <07e0321116993d27d6585bd1a186328d@codeaurora.org>
 <153324986956.10763.5124619734269160725@swboyd.mtv.corp.google.com>
 <ee2113c9dd6a44e9669e60f760c76409@codeaurora.org>
 <20180806150437.GE21283@jcrouse-lnx.qualcomm.com>
Message-ID: <153370789988.220756.1656616273823792690@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/4] clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
Date:   Tue, 07 Aug 2018 22:58:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jordan Crouse (2018-08-06 08:04:37)
> On Mon, Aug 06, 2018 at 02:37:18PM +0530, Amit Nischal wrote:
> > On 2018-08-03 04:14, Stephen Boyd wrote:
> > >Quoting Amit Nischal (2018-07-30 04:28:56)
> > >>On 2018-07-25 12:28, Stephen Boyd wrote:
> > >>>
> > >>> Ok. Sounds good! Is the rate range call really needed? It can't be
> > >>> determined in the PLL code with some table or avoided by making sure
> > >>> GPU
> > >>> uses OPP table with only approved frequencies?
> > >>>
> > >>
> > >>Currently fabia PLL code does not have any table to check this and
> > >>intention
> > >>was to avoid relying on the client to call set_rate with only approved
> > >>frequencies so we have added the set_rate_range() call in the GPUCC
> > >>driver
> > >>in order to set the rate range.
> > >>
> > >
> > >But GPU will use OPP so it doesn't seem like it really buys us anything
> > >here. And it really doesn't matter when the clk driver implementation
> > >doesn't use the min/max to clamp the values of the round_rate()
> > >call. Is
> > >that being done here? I need to double check. I would be more convinced
> > >if the implementation was looking at min/max to constrain the rate
> > >requested.
> > >
> > =

> > So our understanding is that GPU(client) driver will always call the
> > set_rate with approved frequencies only and we can completely rely
> > on the
> > client. Is our understanding is correct?
> =

> =

> First: on sdm845 the software doesn't set the GPU clocks - we rely on the=
 GMU
> firmware to do that on our behalf but for the GPU at least this is an aca=
demic
> exercise.

So what is this GPU clk driver for then?

> =

> But that said: traditionally we've expected that the clock driver correct=
ly
> clamp the requested rate to the correct values. In the past we have taken
> advantage of this and we may in the future. I don't think it is reasonable
> to require the leaf driver to only pass "approved" frequencies especially
> since we depend on our own OPP table that may or may not be similar to the
> one used by the clock driver.
> =


Ok. Sounds like things can't be kept in sync between the clk driver and
the OPP tables. Why is that hard to do?

Either way, I'd be fine if the code actually used the frequency limits
to round the rate to something within range, but I don't recall seeing
that being done here. So if the min/max limits stay, the clk driver
should round to within that range.

