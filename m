Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9573C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3920657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTtoY308"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF3920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbeJ3DdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeJ3DdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:33:08 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4971820657;
        Mon, 29 Oct 2018 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540838593;
        bh=m/B0WyK8bYFkRNISlkWReG0unzpCQN2iR4pXsKVifk8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=QTtoY308njuHGgEwulUeDLI8bbW7Mtp9Spu+ZeUwHReQSkioX59qUrp1gvtwY5d/y
         fhfQj0VqxHxPfPuDHWw2ACml63y9pTI1usqT9wjpgO792843CYL1fo0NTojY/ff9T5
         Wu7GfPSGDpYwZRPwwytMDEr8+pS8TOAyhad1h4f8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <9c359e26-3708-14b6-f22a-fb529446d325@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandanu@codeaurora.org, linux-arm-msm-owner@vger.kernel.org
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
 <1539093467-12123-3-git-send-email-tdas@codeaurora.org>
 <153911726378.119890.5522594539667887860@swboyd.mtv.corp.google.com>
 <3c4cccca-2c5c-927f-f471-2bbbd71b4155@codeaurora.org>
 <9c359e26-3708-14b6-f22a-fb529446d325@codeaurora.org>
Message-ID: <154083859263.98144.15690571729193618604@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 2/2] clk: qcom : dispcc: Add support for display port clocks
Date:   Mon, 29 Oct 2018 11:43:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-28 03:34:55)
> Hello Stephen,
> =

> On 2018-10-19 16:04, Taniya Das wrote:
> > Hello Stephen,
> > =

> > On 10/10/2018 2:04 AM, Stephen Boyd wrote:
> >> Quoting Taniya Das (2018-10-09 06:57:47)
> >>> diff --git a/drivers/clk/qcom/dispcc-sdm845.c =

> >>> b/drivers/clk/qcom/dispcc-sdm845.c
> >>> index 0cc4909..6d3136a 100644
> >>> --- a/drivers/clk/qcom/dispcc-sdm845.c
> >>> +++ b/drivers/clk/qcom/dispcc-sdm845.c
> >>> @@ -128,6 +144,100 @@ enum {
> >>>          },
> >>>   };
> >>> =

> >>> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_aux_clk_src[] =3D {
> >>> +       F(19200000, P_BI_TCXO, 1, 0, 0),
> >>> +       { }
> >>> +};
> >>> +
> >>> +static struct clk_rcg2 disp_cc_mdss_dp_aux_clk_src =3D {
> >>> +       .cmd_rcgr =3D 0x219c,
> >>> +       .mnd_width =3D 0,
> >>> +       .hid_width =3D 5,
> >>> +       .parent_map =3D disp_cc_parent_map_2,
> >>> +       .freq_tbl =3D ftbl_disp_cc_mdss_dp_aux_clk_src,
> >>> +       .clkr.hw.init =3D &(struct clk_init_data){
> >>> +               .name =3D "disp_cc_mdss_dp_aux_clk_src",
> >>> +               .parent_names =3D disp_cc_parent_names_2,
> >>> +               .num_parents =3D 2,
> >>> +               .flags =3D CLK_SET_RATE_PARENT,
> >>> +               .ops =3D &clk_rcg2_ops,
> >>> +       },
> >>> +};
> >>> +
> >>> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_crypto_clk_src[] =
=3D =

> >>> {
> >>> +       F(108000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
> >>> +       F(180000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
> >>> +       F(360000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
> >>> +       F(540000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
> >>> +       { }
> >>> +};
> >>> +
> >>> +static struct clk_rcg2 disp_cc_mdss_dp_crypto_clk_src =3D {
> >>> +       .cmd_rcgr =3D 0x2154,
> >>> +       .mnd_width =3D 0,
> >>> +       .hid_width =3D 5,
> >>> +       .parent_map =3D disp_cc_parent_map_1,
> >>> +       .freq_tbl =3D ftbl_disp_cc_mdss_dp_crypto_clk_src,
> >>> +       .clkr.hw.init =3D &(struct clk_init_data){
> >>> +               .name =3D "disp_cc_mdss_dp_crypto_clk_src",
> >>> +               .parent_names =3D disp_cc_parent_names_1,
> >>> +               .num_parents =3D 4,
> >>> +               .flags =3D CLK_GET_RATE_NOCACHE,
> >> =

> >> Why?
> >> =

> >>> +               .ops =3D &clk_rcg2_ops,
> >>> +       },
> >>> +};
> >>> +
> >>> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_link_clk_src[] =3D=
 {
> >>> +       F(162000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> >>> +       F(270000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> >>> +       F(540000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> >>> +       F(810000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> >> =

> >> Are these in kHz? They really look like it and that's bad. Why do we
> >> need them at all? Just to make sure the display driver picks these =

> >> exact
> >> frequencies? It seems like we could just pass whatever number comes in
> >> up to the parent and see what it can do.
> >> =

> > =

> > Let me check back the reason we had to make this change.
> =

> We will need this flag since we reset/power-down the PLL every time we =

> disconnect/connect the DP cable or during suspend/resume. Only with this =

> flag, the calls to the PLL driver are properly called.

What does this mean? I wanted to know about the weird frequencies listed
above, and why it can't be done without a frequency table and direct
rates passed up to the parent.

> =

> > =

> >>> +       { }
> >>> +};
> >>> +
> >>> +static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src =3D {
> >>> +       .cmd_rcgr =3D 0x2138,
> >>> +       .mnd_width =3D 0,
> >>> +       .hid_width =3D 5,
> >>> +       .parent_map =3D disp_cc_parent_map_1,
> >>> +       .freq_tbl =3D ftbl_disp_cc_mdss_dp_link_clk_src,
> >>> +       .clkr.hw.init =3D &(struct clk_init_data){
> >>> +               .name =3D "disp_cc_mdss_dp_link_clk_src",
> >>> +               .parent_names =3D disp_cc_parent_names_1,
> >>> +               .num_parents =3D 4,
> >>> +               .flags =3D CLK_SET_RATE_PARENT,
> >>> +               .ops =3D &clk_rcg2_ops,
> >>> +       },
> >>> +};
> >>> +
> >>> +static struct clk_rcg2 disp_cc_mdss_dp_pixel1_clk_src =3D {
> >>> +       .cmd_rcgr =3D 0x2184,
> >>> +       .mnd_width =3D 16,
> >>> +       .hid_width =3D 5,
> >>> +       .parent_map =3D disp_cc_parent_map_1,
> >>> +       .clkr.hw.init =3D &(struct clk_init_data){
> >>> +               .name =3D "disp_cc_mdss_dp_pixel1_clk_src",
> >>> +               .parent_names =3D disp_cc_parent_names_1,
> >>> +               .num_parents =3D 4,
> >>> +               .flags =3D CLK_SET_RATE_PARENT,
> >>> +               .ops =3D &clk_dp_ops,
> >>> +       },
> >>> +};
> >>> +
> >>> +static struct clk_rcg2 disp_cc_mdss_dp_pixel_clk_src =3D {
> >>> +       .cmd_rcgr =3D 0x216c,
> >>> +       .mnd_width =3D 16,
> >>> +       .hid_width =3D 5,
> >>> +       .parent_map =3D disp_cc_parent_map_1,
> >>> +       .clkr.hw.init =3D &(struct clk_init_data){
> >>> +               .name =3D "disp_cc_mdss_dp_pixel_clk_src",
> >>> +               .parent_names =3D disp_cc_parent_names_1,
> >>> +               .num_parents =3D 4,
> >>> +               .flags =3D CLK_SET_RATE_PARENT,
> >>> +               .ops =3D &clk_dp_ops,
> >>> +       },
> >>> +};
> >>> +
> >>>   static const struct freq_tbl ftbl_disp_cc_mdss_esc0_clk_src[] =3D {
> >>>          F(19200000, P_BI_TCXO, 1, 0, 0),
> >>>          { }
> >>> @@ -391,6 +501,115 @@ enum {
> >>>          },
> >>>   };
> >>> =

> >>> +static struct clk_branch disp_cc_mdss_dp_aux_clk =3D {
> >>> +       .halt_reg =3D 0x2054,
> >>> +       .halt_check =3D BRANCH_HALT,
> >>> +       .clkr =3D {
> >>> +               .enable_reg =3D 0x2054,
> >>> +               .enable_mask =3D BIT(0),
> >>> +               .hw.init =3D &(struct clk_init_data){
> >>> +                       .name =3D "disp_cc_mdss_dp_aux_clk",
> >>> +                       .parent_names =3D (const char *[]){
> >>> +                               "disp_cc_mdss_dp_aux_clk_src",
> >>> +                       },
> >>> +                       .num_parents =3D 1,
> >>> +                       .flags =3D CLK_SET_RATE_PARENT,
> >>> +                       .ops =3D &clk_branch2_ops,
> >>> +               },
> >>> +       },
> >>> +};
> >>> +
> >>> +static struct clk_branch disp_cc_mdss_dp_crypto_clk =3D {
> >>> +       .halt_reg =3D 0x2048,
> >>> +       .halt_check =3D BRANCH_HALT,
> >>> +       .clkr =3D {
> >>> +               .enable_reg =3D 0x2048,
> >>> +               .enable_mask =3D BIT(0),
> >>> +               .hw.init =3D &(struct clk_init_data){
> >>> +                       .name =3D "disp_cc_mdss_dp_crypto_clk",
> >>> +                       .parent_names =3D (const char *[]){
> >>> +                               "disp_cc_mdss_dp_crypto_clk_src",
> >>> +                       },
> >>> +                       .num_parents =3D 1,
> >>> +                       .flags =3D CLK_SET_RATE_PARENT,
> >>> +                       .ops =3D &clk_branch2_ops,
> >>> +               },
> >>> +       },
> >>> +};
> >>> +
> >>> +static struct clk_branch disp_cc_mdss_dp_link_clk =3D {
> >>> +       .halt_reg =3D 0x2040,
> >>> +       .halt_check =3D BRANCH_HALT,
> >>> +       .clkr =3D {
> >>> +               .enable_reg =3D 0x2040,
> >>> +               .enable_mask =3D BIT(0),
> >>> +               .hw.init =3D &(struct clk_init_data){
> >>> +                       .name =3D "disp_cc_mdss_dp_link_clk",
> >>> +                       .parent_names =3D (const char *[]){
> >>> +                               "disp_cc_mdss_dp_link_clk_src",
> >>> +                       },
> >>> +                       .num_parents =3D 1,
> >>> +                       .flags =3D CLK_SET_RATE_PARENT,
> >>> +                       .ops =3D &clk_branch2_ops,
> >>> +               },
> >>> +       },
> >>> +};
> >>> +
> >>> +/* reset state of disp_cc_mdss_dp_link_div_clk_src divider is 0x3 =

> >>> (div 4) */
> >> =

> >> Not sure what this comment is for. But it's interesting nonetheless.
> >> =

> >>> +static struct clk_branch disp_cc_mdss_dp_link_intf_clk =3D {
> >>> +       .halt_reg =3D 0x2044,
> >>> +       .halt_check =3D BRANCH_HALT,
> >>> +       .clkr =3D {
> >>> +               .enable_reg =3D 0x2044,
> >>> +               .enable_mask =3D BIT(0),
> >>> +               .hw.init =3D &(struct clk_init_data){
> >>> +                       .name =3D "disp_cc_mdss_dp_link_intf_clk",
> >>> +                       .parent_names =3D (const char *[]){
> >>> +                               "disp_cc_mdss_dp_link_clk_src",
> >>> +                       },
> >>> +                       .num_parents =3D 1,
> >>> +                       .flags =3D CLK_GET_RATE_NOCACHE,
> >> =

> >> Why?
> >> =

> > =

> > It was a requirement, but let me get back on this too.
> > =

> I had a discussion with the Display Port teams and below is the requireme=
nt,
> =

> This flag is required since we reset/power-down the PLL every time they
> disconnect/connect the DP cable or during suspend/resume.
> Only with this flag, the calls to the PLL driver properly.

Ok. So that explains the get rate nocache flag. Can you please add a
comment that explains that these clk registers here are lost across
suspend/resume of the display device? It really sounds like these
display clks are inside of the display power domain and thus they lose
their state across the display power domain power down. It would be
better if we could properly implement suspend/restore for these clk
registers across suspend/resume of the display device so that we don't
need this nocache flag and the display code can work together with the
clk code here to restore the frequency to the clk.

Is it really the case that the rcg here is always selecting a particular
PLL and doing a div-1? Because that is very simple then to just write
that setting again on genpd restore.

