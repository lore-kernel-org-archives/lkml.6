Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1AAC6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C622086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieKzkGCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C622086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeJHJzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 05:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbeJHJzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 05:55:16 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02FC92084D;
        Mon,  8 Oct 2018 02:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538966752;
        bh=uly+y61DsSOoA3/xVHk/hGOpSBy7C3WpsZO1k7j7Kio=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ieKzkGCpgA5+y+ycdvvclQb6Vv7IPBbmaoy+o0DiepLWjIh508DOu/qxM2/jAoOz1
         k/UzIXJWXx/7FIfAZ02ACRoiYDIVvwFT3sYJJvlip8pO8si/rMcZtcMif1lzgZUewJ
         d7f/mnd9bclqI21G0WOtVtvbGAyx83ZfWdQLIpnI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <66fc65d8-92ec-f32c-6edb-ad4952695395@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
References: <1537266338-18661-1-git-send-email-tdas@codeaurora.org>
 <1537266338-18661-3-git-send-email-tdas@codeaurora.org>
 <153816066933.119890.2976485722156069351@swboyd.mtv.corp.google.com>
 <66fc65d8-92ec-f32c-6edb-ad4952695395@codeaurora.org>
Message-ID: <153896675144.119890.3991549600874849177@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 2/2] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Sun, 07 Oct 2018 19:45:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-04 05:01:27)
> =

> On 9/29/2018 12:21 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-09-18 03:25:38)
> >> @@ -3469,6 +3495,8 @@ enum {
> >>          [GCC_QSPI_CORE_CLK_SRC] =3D &gcc_qspi_core_clk_src.clkr,
> >>          [GCC_QSPI_CORE_CLK] =3D &gcc_qspi_core_clk.clkr,
> >>          [GCC_QSPI_CNOC_PERIPH_AHB_CLK] =3D &gcc_qspi_cnoc_periph_ahb_=
clk.clkr,
> >> +       [GCC_LPASS_Q6_AXI_CLK] =3D NULL,
> >> +       [GCC_LPASS_SWAY_CLK] =3D NULL,
> >>   };
> >>   =

> >>   static const struct qcom_reset_map gcc_sdm845_resets[] =3D {
> >> @@ -3583,6 +3611,13 @@ static int gcc_sdm845_probe(struct platform_dev=
ice *pdev)
> >>          if (ret)
> >>                  return ret;
> >>   =

> >> +       if (of_property_read_bool(pdev->dev.of_node, "qcom,lpass-prote=
cted")) {
> > =

> > Shouldn't this be negated? So that we only add the clks when lpass isn't
> > protected?
> >
> =

> I was of the opinion to add the flag only when LPASS clocks are =

> required. But I am fine negating it too.

It's stating that lpass clks are protected, so presumably we wouldn't
add the property on devices without the XPU configured. This means that
most configurations would have it protected and then this flag is needed
almost all the time. O well!

