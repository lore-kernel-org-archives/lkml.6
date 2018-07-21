Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A666620856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jZ3REOht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A666620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeGUVKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:10:23 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37314 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeGUVKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:10:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so27013161oib.4;
        Sat, 21 Jul 2018 13:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xk+q+Sm1U45bNaecj3Zjs0gurYZvhD1H5ZOhL7z02qU=;
        b=jZ3REOhthubfgWIXJxKrAgVyjMpt+ABi3IanWZQLIwnXn14Qihvlb3F6FFRIG/UaEn
         eiBBQ3vE0IdDXBA8ZSbTXgWaehQpivfpB/xHPf081vhHhQy0gsIGAZmk98FLis/PN1Gw
         M8gB3ChCWNZWduPkc6sVrmYgFo5uoG9NmD0sI3HJtlbEJeX2RQBTiuKMLLcSKiiCqcTG
         yv+kUahsBwoGT7n8A5Xl/Ur/7rIClcn9MW+wQrpx2EEkNNs7RfDcP2Kug+FMf8HOuDFY
         Er3dkpoqYTrX2LF82q9uQC5CKhLe9ADbXZwhSvR2JrlO37jlrZP2wJhbTVl4tyS/tR65
         8XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xk+q+Sm1U45bNaecj3Zjs0gurYZvhD1H5ZOhL7z02qU=;
        b=bxbxktZ0xbvPYDvCFRB2ri94QblvkR4mxBdGcXNQvBIyDMpsWWLRHTOUMSjVLwCTMu
         fO7MefHcjmnxWkJk7rvzHmrHyKNGg58fjtlw400zaiE1Nl70OBLnSpDVF5rL60P/dbt7
         DgQbpqNa2PNpCHIXCvG73I68sXIe3QKmPbn1Z+1XiG67geXu30QmIf7L68AUOl1tWTYr
         vBOAoA4bi8egKEWc5WB1lr/rtBTuZ+deUx5hMuJdoAfztGaQwDdKG0Ky3wS1C9W8su0k
         9MSujg71HDHip6lsCXH3zlw5mBCD/jTlbCdKHfo6e+NFxF43KYNYKPGPkvHp1TPR/E+Y
         9V3Q==
X-Gm-Message-State: AOUpUlGI2vJjBTzAsmfiy5wuk7sEV9jt9vtdiA6iajHvHjOYnsQ4M0Ck
        VrdUmhwU3x8TpViulZKY/hFyeS47AwuZ0dt9DKI=
X-Google-Smtp-Source: AAOMgpcGQy2I/f5msqGU88dolS34e4kVem1RcX+kHFPpYzMfhvd+L3WsWemTHVE79CkWWQFzBqq23Dw8z4z9Sp7PdhQ=
X-Received: by 2002:aca:3092:: with SMTP id w140-v6mr3166832oiw.213.1532204184221;
 Sat, 21 Jul 2018 13:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180717095617.12240-1-jbrunet@baylibre.com> <20180717095617.12240-4-jbrunet@baylibre.com>
 <d4e5e35a-39e0-fe27-8d27-387c5312ca32@baylibre.com>
In-Reply-To: <d4e5e35a-39e0-fe27-8d27-387c5312ca32@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 21 Jul 2018 22:16:13 +0200
Message-ID: <CAFBinCBc_cFD2ACiSHVuRrXaqSyDnkJb2rem1_k2jwved=QXVw@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: meson: clk-pll: drop hard-coded rates from pll tables
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:44 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 17/07/2018 11:56, Jerome Brunet wrote:
> > Putting hard-coded rates inside the parameter tables assumes that
> > the parent is known and will never change. That's a big assumption
> > we should not make.
> >
> > We have everything we need to recalculate the output rate using
> > the parent rate and the rest of the parameters. Let's do so and
> > drop the rates from the tables.
> >
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/clk/meson/axg.c     |  73 +++++++++++++--------------
> >  drivers/clk/meson/clk-pll.c |  69 ++++++++++++++++---------
> >  drivers/clk/meson/clkc.h    |   8 ++-
> >  drivers/clk/meson/gxbb.c    | 120 ++++++++++++++++++++++----------------------
> >  drivers/clk/meson/meson8b.c |  34 ++++++-------
> >  5 files changed, 162 insertions(+), 142 deletions(-)
> >
> > diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> > index 572358062459..d34954bd8c5e 100644
> > --- a/drivers/clk/meson/axg.c
> > +++ b/drivers/clk/meson/axg.c
> > @@ -130,36 +130,36 @@ static struct clk_regmap axg_sys_pll = {
> >       },
> >  };
> >
> > -static const struct pll_rate_table axg_gp0_pll_rate_table[] = {
> > -     PLL_RATE(960000000, 40, 1),
> > -     PLL_RATE(984000000, 41, 1),
> > -     PLL_RATE(1008000000, 42, 1),
> > -     PLL_RATE(1032000000, 43, 1),
> > -     PLL_RATE(1056000000, 44, 1),
> > -     PLL_RATE(1080000000, 45, 1),
> > -     PLL_RATE(1104000000, 46, 1),
> > -     PLL_RATE(1128000000, 47, 1),
> > -     PLL_RATE(1152000000, 48, 1),
> > -     PLL_RATE(1176000000, 49, 1),
> > -     PLL_RATE(1200000000, 50, 1),
> > -     PLL_RATE(1224000000, 51, 1),
> > -     PLL_RATE(1248000000, 52, 1),
> > -     PLL_RATE(1272000000, 53, 1),
> > -     PLL_RATE(1296000000, 54, 1),
> > -     PLL_RATE(1320000000, 55, 1),
> > -     PLL_RATE(1344000000, 56, 1),
> > -     PLL_RATE(1368000000, 57, 1),
> > -     PLL_RATE(1392000000, 58, 1),
> > -     PLL_RATE(1416000000, 59, 1),
> > -     PLL_RATE(1440000000, 60, 1),
> > -     PLL_RATE(1464000000, 61, 1),
> > -     PLL_RATE(1488000000, 62, 1),
> > -     PLL_RATE(1512000000, 63, 1),
> > -     PLL_RATE(1536000000, 64, 1),
> > -     PLL_RATE(1560000000, 65, 1),
> > -     PLL_RATE(1584000000, 66, 1),
> > -     PLL_RATE(1608000000, 67, 1),
> > -     PLL_RATE(1632000000, 68, 1),
> > +static const struct pll_params_table axg_gp0_pll_params_table[] = {
> > +     PLL_PARAMS(40, 1),
> > +     PLL_PARAMS(41, 1),
> > +     PLL_PARAMS(42, 1),
> > +     PLL_PARAMS(43, 1),
> > +     PLL_PARAMS(44, 1),
> > +     PLL_PARAMS(45, 1),
> > +     PLL_PARAMS(46, 1),
> > +     PLL_PARAMS(47, 1),
> > +     PLL_PARAMS(48, 1),
> > +     PLL_PARAMS(49, 1),
> > +     PLL_PARAMS(50, 1),
> > +     PLL_PARAMS(51, 1),
> > +     PLL_PARAMS(52, 1),
> > +     PLL_PARAMS(53, 1),
> > +     PLL_PARAMS(54, 1),
> > +     PLL_PARAMS(55, 1),
> > +     PLL_PARAMS(56, 1),
> > +     PLL_PARAMS(57, 1),
> > +     PLL_PARAMS(58, 1),
> > +     PLL_PARAMS(59, 1),
> > +     PLL_PARAMS(60, 1),
> > +     PLL_PARAMS(61, 1),
> > +     PLL_PARAMS(62, 1),
> > +     PLL_PARAMS(63, 1),
> > +     PLL_PARAMS(64, 1),
> > +     PLL_PARAMS(65, 1),
> > +     PLL_PARAMS(66, 1),
> > +     PLL_PARAMS(67, 1),
> > +     PLL_PARAMS(68, 1),
> >       { /* sentinel */ },
> >  };
> >
> > @@ -203,7 +203,7 @@ static struct clk_regmap axg_gp0_pll_dco = {
> >                       .shift   = 29,
> >                       .width   = 1,
> >               },
> > -             .table = axg_gp0_pll_rate_table,
> > +             .table = axg_gp0_pll_params_table,
> >               .init_regs = axg_gp0_init_regs,
> >               .init_count = ARRAY_SIZE(axg_gp0_init_regs),
> >       },
> > @@ -271,7 +271,7 @@ static struct clk_regmap axg_hifi_pll_dco = {
> >                       .shift   = 29,
> >                       .width   = 1,
> >               },
> > -             .table = axg_gp0_pll_rate_table,
> > +             .table = axg_gp0_pll_params_table,
> >               .init_regs = axg_hifi_init_regs,
> >               .init_count = ARRAY_SIZE(axg_hifi_init_regs),
> >               .flags = CLK_MESON_PLL_ROUND_CLOSEST,
> > @@ -627,11 +627,10 @@ static struct clk_regmap axg_mpll3 = {
> >       },
> >  };
> >
> > -static const struct pll_rate_table axg_pcie_pll_rate_table[] = {
> > +static const struct pll_params_table axg_pcie_pll_params_table[] = {
> >       {
> > -             .rate   = 1600000000,
> > -             .m      = 200,
> > -             .n      = 3,
> > +             .m = 200,
> > +             .n = 3,
> >       },
> >       { /* sentinel */ },
> >  };
> > @@ -678,7 +677,7 @@ static struct clk_regmap axg_pcie_pll_dco = {
> >                       .shift   = 29,
> >                       .width   = 1,
> >               },
> > -             .table = axg_pcie_pll_rate_table,
> > +             .table = axg_pcie_pll_params_table,
> >               .init_regs = axg_pcie_init_regs,
> >               .init_count = ARRAY_SIZE(axg_pcie_init_regs),
> >       },
> > diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> > index 348a866f09eb..f5b5b3fabe3c 100644
> > --- a/drivers/clk/meson/clk-pll.c
> > +++ b/drivers/clk/meson/clk-pll.c
> > @@ -45,7 +45,7 @@ meson_clk_pll_data(struct clk_regmap *clk)
> >  }
> >
> >  static unsigned long __pll_params_to_rate(unsigned long parent_rate,
> > -                                       const struct pll_rate_table *pllt,
> > +                                       const struct pll_params_table *pllt,
> >                                         u16 frac,
> >                                         struct meson_clk_pll_data *pll)
> >  {
> > @@ -66,7 +66,7 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
> >  {
> >       struct clk_regmap *clk = to_clk_regmap(hw);
> >       struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> > -     struct pll_rate_table pllt;
> > +     struct pll_params_table pllt;
> >       u16 frac;
> >
> >       pllt.n = meson_parm_read(clk->map, &pll->n);
> > @@ -81,7 +81,7 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
> >
> >  static u16 __pll_params_with_frac(unsigned long rate,
> >                                 unsigned long parent_rate,
> > -                               const struct pll_rate_table *pllt,
> > +                               const struct pll_params_table *pllt,
> >                                 struct meson_clk_pll_data *pll)
> >  {
> >       u16 frac_max = (1 << pll->frac.width);
> > @@ -97,29 +97,50 @@ static u16 __pll_params_with_frac(unsigned long rate,
> >       return min((u16)val, (u16)(frac_max - 1));
> >  }
> >
> > -static const struct pll_rate_table *
> > +static bool meson_clk_pll_is_better(unsigned long rate,
> > +                                 unsigned long best,
> > +                                 unsigned long now,
> > +                                 struct meson_clk_pll_data *pll)
> > +{
> > +     if (!(pll->flags & CLK_MESON_PLL_ROUND_CLOSEST) ||
> > +         MESON_PARM_APPLICABLE(&pll->frac)) {
> > +             /* Round down */
> > +             if (now < rate && best < now)
> > +                     return true;
> > +     } else {
> > +             /* Round Closest */
> > +             if (abs(now - rate) < abs(best - rate))
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static const struct pll_params_table *
> >  meson_clk_get_pll_settings(unsigned long rate,
> > +                        unsigned long parent_rate,
> >                          struct meson_clk_pll_data *pll)
> >  {
> > -     const struct pll_rate_table *table = pll->table;
> > -     unsigned int i = 0;
> > +     const struct pll_params_table *table = pll->table;
> > +     unsigned long best = 0, now = 0;
> > +     unsigned int i, best_i = 0;
> >
> >       if (!table)
> >               return NULL;
> >
> > -     /* Find the first table element exceeding rate */
> > -     while (table[i].rate && table[i].rate <= rate)
> > -             i++;
> > +     for (i = 0; table[i].n; i++) {
> > +             now = __pll_params_to_rate(parent_rate, &table[i], 0, pll);
> >
> > -     if (i != 0) {
> > -             if (MESON_PARM_APPLICABLE(&pll->frac) ||
> > -                 !(pll->flags & CLK_MESON_PLL_ROUND_CLOSEST) ||
> > -                 (abs(rate - table[i - 1].rate) <
> > -                  abs(rate - table[i].rate)))
> > -                     i--;
> > +             /* If we get an exact match, don't bother any further */
> > +             if (now == rate) {
> > +                     return &table[i];
> > +             } else if (meson_clk_pll_is_better(rate, best, now, pll)) {
> > +                     best = now;
> > +                     best_i = i;
> > +             }
> >       }
> >
> > -     return (struct pll_rate_table *)&table[i];
> > +     return (struct pll_params_table *)&table[best_i];
> >  }
> >
> >  static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> > @@ -127,16 +148,18 @@ static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> >  {
> >       struct clk_regmap *clk = to_clk_regmap(hw);
> >       struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> > -     const struct pll_rate_table *pllt =
> > -             meson_clk_get_pll_settings(rate, pll);
> > +     const struct pll_params_table *pllt =
> > +             meson_clk_get_pll_settings(rate, *parent_rate, pll);
> > +     unsigned long round;
> >       u16 frac;
> >
> >       if (!pllt)
> >               return meson_clk_pll_recalc_rate(hw, *parent_rate);
> >
> > -     if (!MESON_PARM_APPLICABLE(&pll->frac)
> > -         || rate == pllt->rate)
> > -             return pllt->rate;
> > +     round = __pll_params_to_rate(*parent_rate, pllt, 0, pll);
> > +
> > +     if (!MESON_PARM_APPLICABLE(&pll->frac) || rate == round)
> > +             return round;
> >
> >       /*
> >        * The rate provided by the setting is not an exact match, let's
> > @@ -214,7 +237,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> >  {
> >       struct clk_regmap *clk = to_clk_regmap(hw);
> >       struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> > -     const struct pll_rate_table *pllt;
> > +     const struct pll_params_table *pllt;
> >       unsigned int enabled;
> >       unsigned long old_rate;
> >       u16 frac = 0;
> > @@ -224,7 +247,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> >
> >       old_rate = rate;
> >
> > -     pllt = meson_clk_get_pll_settings(rate, pll);
> > +     pllt = meson_clk_get_pll_settings(rate, parent_rate, pll);
> >       if (!pllt)
> >               return -EINVAL;
> >
> > diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> > index a2245e857f70..6b96d55c047d 100644
> > --- a/drivers/clk/meson/clkc.h
> > +++ b/drivers/clk/meson/clkc.h
> > @@ -43,15 +43,13 @@ static inline void meson_parm_write(struct regmap *map, struct parm *p,
> >  }
> >
> >
> > -struct pll_rate_table {
> > -     unsigned long   rate;
> > +struct pll_params_table {
> >       u16             m;
> >       u16             n;
> >  };
> >
> > -#define PLL_RATE(_r, _m, _n)                                         \
> > +#define PLL_PARAMS(_m, _n)                                           \
> >       {                                                               \
> > -             .rate           = (_r),                                 \
> >               .m              = (_m),                                 \
> >               .n              = (_n),                                 \
> >       }
> > @@ -67,7 +65,7 @@ struct meson_clk_pll_data {
> >       struct parm rst;
> >       const struct reg_sequence *init_regs;
> >       unsigned int init_count;
> > -     const struct pll_rate_table *table;
> > +     const struct pll_params_table *table;
> >       u8 flags;
> >  };
> >
> > diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> > index e2d94498f098..9ac03c7bfbaa 100644
> > --- a/drivers/clk/meson/gxbb.c
> > +++ b/drivers/clk/meson/gxbb.c
> > @@ -18,67 +18,67 @@
> >
> >  static DEFINE_SPINLOCK(meson_clk_lock);
> >
> > -static const struct pll_rate_table gxbb_gp0_pll_rate_table[] = {
> > -     PLL_RATE(768000000, 32, 1),
> > -     PLL_RATE(792000000, 33, 1),
> > -     PLL_RATE(816000000, 34, 1),
> > -     PLL_RATE(840000000, 35, 1),
> > -     PLL_RATE(864000000, 36, 1),
> > -     PLL_RATE(888000000, 37, 1),
> > -     PLL_RATE(912000000, 38, 1),
> > -     PLL_RATE(936000000, 39, 1),
> > -     PLL_RATE(960000000, 40, 1),
> > -     PLL_RATE(984000000, 41, 1),
> > -     PLL_RATE(1008000000, 42, 1),
> > -     PLL_RATE(1032000000, 43, 1),
> > -     PLL_RATE(1056000000, 44, 1),
> > -     PLL_RATE(1080000000, 45, 1),
> > -     PLL_RATE(1104000000, 46, 1),
> > -     PLL_RATE(1128000000, 47, 1),
> > -     PLL_RATE(1152000000, 48, 1),
> > -     PLL_RATE(1176000000, 49, 1),
> > -     PLL_RATE(1200000000, 50, 1),
> > -     PLL_RATE(1224000000, 51, 1),
> > -     PLL_RATE(1248000000, 52, 1),
> > -     PLL_RATE(1272000000, 53, 1),
> > -     PLL_RATE(1296000000, 54, 1),
> > -     PLL_RATE(1320000000, 55, 1),
> > -     PLL_RATE(1344000000, 56, 1),
> > -     PLL_RATE(1368000000, 57, 1),
> > -     PLL_RATE(1392000000, 58, 1),
> > -     PLL_RATE(1416000000, 59, 1),
> > -     PLL_RATE(1440000000, 60, 1),
> > -     PLL_RATE(1464000000, 61, 1),
> > -     PLL_RATE(1488000000, 62, 1),
> > +static const struct pll_params_table gxbb_gp0_pll_params_table[] = {
> > +     PLL_PARAMS(32, 1),
> > +     PLL_PARAMS(33, 1),
> > +     PLL_PARAMS(34, 1),
> > +     PLL_PARAMS(35, 1),
> > +     PLL_PARAMS(36, 1),
> > +     PLL_PARAMS(37, 1),
> > +     PLL_PARAMS(38, 1),
> > +     PLL_PARAMS(39, 1),
> > +     PLL_PARAMS(40, 1),
> > +     PLL_PARAMS(41, 1),
> > +     PLL_PARAMS(42, 1),
> > +     PLL_PARAMS(43, 1),
> > +     PLL_PARAMS(44, 1),
> > +     PLL_PARAMS(45, 1),
> > +     PLL_PARAMS(46, 1),
> > +     PLL_PARAMS(47, 1),
> > +     PLL_PARAMS(48, 1),
> > +     PLL_PARAMS(49, 1),
> > +     PLL_PARAMS(50, 1),
> > +     PLL_PARAMS(51, 1),
> > +     PLL_PARAMS(52, 1),
> > +     PLL_PARAMS(53, 1),
> > +     PLL_PARAMS(54, 1),
> > +     PLL_PARAMS(55, 1),
> > +     PLL_PARAMS(56, 1),
> > +     PLL_PARAMS(57, 1),
> > +     PLL_PARAMS(58, 1),
> > +     PLL_PARAMS(59, 1),
> > +     PLL_PARAMS(60, 1),
> > +     PLL_PARAMS(61, 1),
> > +     PLL_PARAMS(62, 1),
> >       { /* sentinel */ },
> >  };
> >
> > -static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
> > -     PLL_RATE(1008000000, 42, 1),
> > -     PLL_RATE(1032000000, 43, 1),
> > -     PLL_RATE(1056000000, 44, 1),
> > -     PLL_RATE(1080000000, 45, 1),
> > -     PLL_RATE(1104000000, 46, 1),
> > -     PLL_RATE(1128000000, 47, 1),
> > -     PLL_RATE(1152000000, 48, 1),
> > -     PLL_RATE(1176000000, 49, 1),
> > -     PLL_RATE(1200000000, 50, 1),
> > -     PLL_RATE(1224000000, 51, 1),
> > -     PLL_RATE(1248000000, 52, 1),
> > -     PLL_RATE(1272000000, 53, 1),
> > -     PLL_RATE(1296000000, 54, 1),
> > -     PLL_RATE(1320000000, 55, 1),
> > -     PLL_RATE(1344000000, 56, 1),
> > -     PLL_RATE(1368000000, 57, 1),
> > -     PLL_RATE(1392000000, 58, 1),
> > -     PLL_RATE(1416000000, 59, 1),
> > -     PLL_RATE(1440000000, 60, 1),
> > -     PLL_RATE(1464000000, 61, 1),
> > -     PLL_RATE(1488000000, 62, 1),
> > -     PLL_RATE(1512000000, 63, 1),
> > -     PLL_RATE(1536000000, 64, 1),
> > -     PLL_RATE(1560000000, 65, 1),
> > -     PLL_RATE(1584000000, 66, 1),
> > +static const struct pll_params_table gxl_gp0_pll_params_table[] = {
> > +     PLL_PARAMS(42, 1),
> > +     PLL_PARAMS(43, 1),
> > +     PLL_PARAMS(44, 1),
> > +     PLL_PARAMS(45, 1),
> > +     PLL_PARAMS(46, 1),
> > +     PLL_PARAMS(47, 1),
> > +     PLL_PARAMS(48, 1),
> > +     PLL_PARAMS(49, 1),
> > +     PLL_PARAMS(50, 1),
> > +     PLL_PARAMS(51, 1),
> > +     PLL_PARAMS(52, 1),
> > +     PLL_PARAMS(53, 1),
> > +     PLL_PARAMS(54, 1),
> > +     PLL_PARAMS(55, 1),
> > +     PLL_PARAMS(56, 1),
> > +     PLL_PARAMS(57, 1),
> > +     PLL_PARAMS(58, 1),
> > +     PLL_PARAMS(59, 1),
> > +     PLL_PARAMS(60, 1),
> > +     PLL_PARAMS(61, 1),
> > +     PLL_PARAMS(62, 1),
> > +     PLL_PARAMS(63, 1),
> > +     PLL_PARAMS(64, 1),
> > +     PLL_PARAMS(65, 1),
> > +     PLL_PARAMS(66, 1),
> >       { /* sentinel */ },
> >  };
> >
> > @@ -374,7 +374,7 @@ static struct clk_regmap gxbb_gp0_pll_dco = {
> >                       .shift   = 29,
> >                       .width   = 1,
> >               },
> > -             .table = gxbb_gp0_pll_rate_table,
> > +             .table = gxbb_gp0_pll_params_table,
> >               .init_regs = gxbb_gp0_init_regs,
> >               .init_count = ARRAY_SIZE(gxbb_gp0_init_regs),
> >       },
> > @@ -427,7 +427,7 @@ static struct clk_regmap gxl_gp0_pll_dco = {
> >                       .shift   = 29,
> >                       .width   = 1,
> >               },
> > -             .table = gxl_gp0_pll_rate_table,
> > +             .table = gxl_gp0_pll_params_table,
> >               .init_regs = gxl_gp0_init_regs,
> >               .init_count = ARRAY_SIZE(gxl_gp0_init_regs),
> >       },
> > diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> > index 17bcf0be56ba..30ae849ff53f 100644
> > --- a/drivers/clk/meson/meson8b.c
> > +++ b/drivers/clk/meson/meson8b.c
> > @@ -29,22 +29,22 @@ struct meson8b_clk_reset {
> >       void __iomem *base;
> >  };
> >
> > -static const struct pll_rate_table sys_pll_rate_table[] = {
> > -     PLL_RATE(1200000000, 50, 1),
> > -     PLL_RATE(1224000000, 51, 1),
> > -     PLL_RATE(1248000000, 52, 1),
> > -     PLL_RATE(1272000000, 53, 1),
> > -     PLL_RATE(1296000000, 54, 1),
> > -     PLL_RATE(1320000000, 55, 1),
> > -     PLL_RATE(1344000000, 56, 1),
> > -     PLL_RATE(1368000000, 57, 1),
> > -     PLL_RATE(1392000000, 58, 1),
> > -     PLL_RATE(1416000000, 59, 1),
> > -     PLL_RATE(1440000000, 60, 1),
> > -     PLL_RATE(1464000000, 61, 1),
> > -     PLL_RATE(1488000000, 62, 1),
> > -     PLL_RATE(1512000000, 63, 1),
> > -     PLL_RATE(1536000000, 64, 1),
> > +static const struct pll_params_table sys_pll_params_table[] = {
> > +     PLL_PARAMS(50, 1),
> > +     PLL_PARAMS(51, 1),
> > +     PLL_PARAMS(52, 1),
> > +     PLL_PARAMS(53, 1),
> > +     PLL_PARAMS(54, 1),
> > +     PLL_PARAMS(55, 1),
> > +     PLL_PARAMS(56, 1),
> > +     PLL_PARAMS(57, 1),
> > +     PLL_PARAMS(58, 1),
> > +     PLL_PARAMS(59, 1),
> > +     PLL_PARAMS(60, 1),
> > +     PLL_PARAMS(61, 1),
> > +     PLL_PARAMS(62, 1),
> > +     PLL_PARAMS(63, 1),
> > +     PLL_PARAMS(64, 1),
> >       { /* sentinel */ },
> >  };
> >
> > @@ -195,7 +195,7 @@ static struct clk_regmap meson8b_sys_pll_dco = {
> >                       .shift   = 29,
> >                       .width   = 1,
> >               },
> > -             .table = sys_pll_rate_table,
> > +             .table = sys_pll_params_table,
> >       },
> >       .hw.init = &(struct clk_init_data){
> >               .name = "sys_pll_dco",
> >
>
> We could even add ranges instead of table when we know the PLL supports a well-known continuous dividers range.
I had a look at the sys_pll settings on Meson8b, here's what
Meson8/Meson8b/Meson8m2 support for sys_pll:
- 50..74
- 76
- 78
- 80
- 82
- 84
- 86
- 88
- 90
- 92
- 94
- 96
- 98

(I'm providing this info because it may help finding a decision
whether ranges are good or not. I have no preference)


Regards
Martin


[0] https://github.com/endlessm/linux-meson/blob/master/arch/arm/mach-meson8/clock.c#L140
