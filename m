Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C9AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E31217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu7ckwkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E31217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeHUSvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeHUSvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:51:36 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0262177A;
        Tue, 21 Aug 2018 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534865458;
        bh=mfxL//xvS546tfWYVYpflRfN/YZieTfjXTQPBKDGi2g=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Bu7ckwkmeFmPCOhVpdNjH3HOn+SCNtkkA3wBAx1on9r7eszYuKGvwF6rlCOwaldsT
         fXe6+UnISnRsSTOZy112u5Ex5NftKYa1GYfdYogxP3QAIJ1HiLtvYiuam6gel+hEYF
         DEZXnxEjYp0YFH1pvUAR2DsIUN3knCrROGUiHa58=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <2db97037-b5f1-9234-862c-fa483b8aeb62@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533952436-17221-1-git-send-email-tdas@codeaurora.org>
 <153455835372.28926.7641705907931269497@swboyd.mtv.corp.google.com>
 <693d9cf4-4a6f-feb5-0c3f-ded842bbdf0a@codeaurora.org>
 <2db97037-b5f1-9234-862c-fa483b8aeb62@codeaurora.org>
Message-ID: <153486545785.28926.5289007760649251969@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 0/2] clk: qcom: Add support for RCG to register for DFS
Date:   Tue, 21 Aug 2018 08:30:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-08-21 04:36:20)
> On 8/18/2018 11:31 PM, Taniya Das wrote:
> > Hello Stephen,
> > =

> > I will test these changes and get back.
> > =

> > On 8/18/2018 7:42 AM, Stephen Boyd wrote:
> >> Quoting Taniya Das (2018-08-10 18:53:54)
> >>> =C2=A0 [v4]
> >>> =C2=A0=C2=A0 * Add recalc_clk_ops to calculate the clock frequency re=
ading the =

> >>> current
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 perf state, also add CLK_GET_RATE_NOCACHE fl=
ag.
> >>> =C2=A0=C2=A0 * Cleanup 'goto' during mode check in 'clk_rcg2_calculat=
e_freq'.
> >>> =C2=A0=C2=A0 * cleanup return from function 'com_cc_register_rcg_dfs'.
> >>
> >> I want to squash this in. I have only compile tested it. Let me know
> >> what you think.
> >>
> >> ----8<---
> >> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> >> index e6300e05d5df..e5eca8a1abe4 100644
> >> --- a/drivers/clk/qcom/clk-rcg.h
> >> +++ b/drivers/clk/qcom/clk-rcg.h
> >> @@ -163,6 +163,15 @@ extern const struct clk_ops clk_pixel_ops;
> >> =C2=A0 extern const struct clk_ops clk_gfx3d_ops;
> >> =C2=A0 extern const struct clk_ops clk_rcg2_shared_ops;
> >> +struct clk_rcg_dfs_data {
> >> +=C2=A0=C2=A0=C2=A0 struct clk_rcg2 *rcg;
> >> +=C2=A0=C2=A0=C2=A0 struct clk_init_data *init;
> >> +};
> >> +
> >> +#define DEFINE_RCG_DFS(r) \
> >> +=C2=A0=C2=A0=C2=A0 { .rcg =3D &r##_src, .init =3D &r##_init }
> >> +
> >> =C2=A0 extern int qcom_cc_register_rcg_dfs(struct regmap *regmap,
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct clk_rcg2 **rcgs, int num_clks);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct clk_rcg_dfs_data=
 *rcgs,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t len);
> >> =C2=A0 #endif
> >> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> >> index 55a5b58cbb15..bbe2a1916296 100644
> >> --- a/drivers/clk/qcom/clk-rcg2.c
> >> +++ b/drivers/clk/qcom/clk-rcg2.c
> >> @@ -1051,48 +1051,24 @@ static unsigned long
> >> =C2=A0 clk_rcg2_dfs_recalc_rate(struct clk_hw *hw, unsigned long paren=
t_rate)
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct clk_rcg2 *rcg =3D to_clk_rcg2(hw=
);
> >> -=C2=A0=C2=A0=C2=A0 u32 cfg, hid_div, m =3D 0, n =3D 0, mode =3D 0, ma=
sk, level;
> >> -=C2=A0=C2=A0=C2=A0 int num_parents, i;
> >> -=C2=A0=C2=A0=C2=A0 unsigned long prate;
> >> -
> >> -=C2=A0=C2=A0=C2=A0 regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr +
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SE_CMD_DFSR_OFFSET, &cfg);
> >> -=C2=A0=C2=A0=C2=A0 level =3D (GENMASK(4, 1) & cfg) >> 1;
> >> -
> >> -=C2=A0=C2=A0=C2=A0 regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr +
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SE_PERF_DFSR(level), &cfg);
> >> -=C2=A0=C2=A0=C2=A0 if (rcg->mnd_width) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D BIT(rcg->mnd_widt=
h) - 1;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_read(rcg->clkr.regm=
ap, rcg->cmd_rcgr +
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SE_PERF_M_DFSR(level), &m);
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m &=3D mask;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_read(rcg->clkr.regm=
ap, rcg->cmd_rcgr +
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SE_PERF_N_DFSR(level), &n);
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n =3D=C2=A0 ~n;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n &=3D mask;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n +=3D m;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D cfg & CFG_MODE_MA=
SK;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode >>=3D CFG_MODE_SHIFT;
> >> -=C2=A0=C2=A0=C2=A0 }
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> +=C2=A0=C2=A0=C2=A0 u32 level;
> >> -=C2=A0=C2=A0=C2=A0 mask =3D BIT(rcg->hid_width) - 1;
> >> -=C2=A0=C2=A0=C2=A0 hid_div =3D cfg >> CFG_SRC_DIV_SHIFT;
> >> -=C2=A0=C2=A0=C2=A0 hid_div &=3D mask;
> >> -=C2=A0=C2=A0=C2=A0 cfg &=3D CFG_SRC_SEL_MASK;
> >> -=C2=A0=C2=A0=C2=A0 cfg >>=3D CFG_SRC_SEL_SHIFT;
> >> +=C2=A0=C2=A0=C2=A0 regmap_read(rcg->clkr.regmap,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc=
g->cmd_rcgr + SE_CMD_DFSR_OFFSET, &level);
> >> +=C2=A0=C2=A0=C2=A0 level &=3D GENMASK(4, 1);
> >> +=C2=A0=C2=A0=C2=A0 level >>=3D 1;
> >> -=C2=A0=C2=A0=C2=A0 num_parents =3D clk_hw_get_num_parents(hw);
> >> -=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_parents; i++) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cfg =3D=3D rcg->parent=
_map[i].cfg) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
ate =3D clk_hw_get_rate(
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 clk_hw_get_parent_by_index(&rcg->clkr.hw, i));
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (parent_rate !=3D prate)
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 parent_rate =3D prate;
> >> +=C2=A0=C2=A0=C2=A0 if (!rcg->freq_tbl) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clk_rcg2_dfs_popul=
ate_freq_table(rcg);
> =

> This function would retrieve the parent_rate and if the parent_rate is =

> not ready then it would fail to boot up.
> =

> So we have to make sure the parents are registered before these RCGs. =

> That also was one reason for me to not populate the frequency table at =

> recalc.
> =

> We would need this patch to make this work.

Hmmmm. Ok. That won't work then. recalc_rate() better not try to
populate the frequency table then or it will not work. So I suppose it
needs to fallback to reading the registers and assuming the parent_rate
coming in is the actual frequency of it's parent until the frequency
table pointer is non-NULL. Would that work?

BTW, does DFS switch parents without software knowing about it? What
happens in that case? Does the QUP driver make sure that the new parent
of this RCG is properly enabled so that it can switch to it when needed?
I'm still trying to understand this whole design. Who takes care of the
voltage requirements in this case? The QUP driver as well?

