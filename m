Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C49FC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3736208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThJNgXq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3736208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932685AbeGIGQy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:16:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932241AbeGIGQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:16:52 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B97A4208AF;
        Mon,  9 Jul 2018 06:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531117011;
        bh=6Y4Q+RZDle7aO0Lfdh9QSmq/k1xPV6WG8XHCYY9Psdw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ThJNgXq79CmYVzIMx+03KB1nQ23cntQhycAYWm61uYPhvKgJL2gpfR4aevom/l01B
         wepRAd7QrvrsGGFd6KOOEXUEmZESNBJaVSIC38Jfe85dGTCdNPTHZ4EGzRrTSm41t4
         TtzdycNL/61YrzCQwFb493lbHYp55Nb9Rexj6TOM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <10f87216-caa2-d523-e134-6cf3acd268a7@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
 <1529763567-13131-4-git-send-email-tdas@codeaurora.org>
 <153109408562.143105.15954380130353645468@swboyd.mtv.corp.google.com>
 <10f87216-caa2-d523-e134-6cf3acd268a7@codeaurora.org>
Message-ID: <153111701079.143105.13387458941681113476@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] clk: qcom: Add display clock controller driver for SDM845
Date:   Sun, 08 Jul 2018 23:16:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-08 20:38:03)
> Hello Stephen,
> =

> Thanks for your review comments.
> =

> On 7/9/2018 5:24 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-06-23 07:19:27)
> >> diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispc=
c-sdm845.c
> >> new file mode 100644
> >> index 0000000..af437e0
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/dispcc-sdm845.c
> >> @@ -0,0 +1,674 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> > [...]
> >> +static struct clk_alpha_pll disp_cc_pll0 =3D {
> >> +       .offset =3D 0x0,
> >> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> >> +       .clkr =3D {
> >> +               .hw.init =3D &(struct clk_init_data){
> >> +                       .name =3D "disp_cc_pll0",
> >> +                       .parent_names =3D (const char *[]){ "bi_tcxo" =
},
> >> +                       .num_parents =3D 1,
> >> +                       .ops =3D &clk_alpha_pll_fabia_ops,
> >> +               },
> >> +       },
> >> +};
> >> +
> >> +static struct clk_rcg2 disp_cc_mdss_byte0_clk_src =3D {
> >> +       .cmd_rcgr =3D 0x20d0,
> >> +       .mnd_width =3D 0,
> >> +       .hid_width =3D 5,
> >> +       .parent_map =3D disp_cc_parent_map_0,
> >> +       .clkr.hw.init =3D &(struct clk_init_data){
> >> +               .name =3D "disp_cc_mdss_byte0_clk_src",
> >> +               .parent_names =3D disp_cc_parent_names_0,
> >> +               .num_parents =3D 4,
> >> +               .flags =3D CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> > =

> > Why is there the no cache flag? Last time I asked I don't think I got
> > any answer, and there isn't a comment here so please at least add a
> > comment to the code so we don't forget.
> >
> =

> I think you missed my comment from the earlier email. I would add the =

> comment and submit again.

Hmm.. ok.

> =

>  > Why is the nocache flag needed? Applies to all clks in this file.
>  >
> =

> This flag is required for all RCGs whose PLLs are controlled outside the =

> clock controller. The display code would require the recalculated rate =

> always.

Right. Why is the PLL controlled outside of the clock controller? The
rate should propagate upward to the PLL from here, so who's going
outside of that?

