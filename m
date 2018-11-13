Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC7C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6430B22360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LzzPLtDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6430B22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbeKNCRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:17:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34220 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeKNCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:17:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so5654488pgg.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkcA76kiBVDSNlarx+wWtzK/pLcw9lf11p7HWYIi3cc=;
        b=LzzPLtDih4Wbnvq5bgFynkK6HCCP8QI2m4/kG/xcZoSewbxHZ7VwK6l68/Y2tP0sQC
         uKaor9+wO3wlgx95aY0T35kfThmfxSlZ0TjvKgAAL+0Oz7oyyIiXigiZun9cbmI/nobv
         avp4BB8JiD3MIualVG8JG76BJcMq3ZWUWabIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkcA76kiBVDSNlarx+wWtzK/pLcw9lf11p7HWYIi3cc=;
        b=j59en2hVZJMd9DBq02N8UPacfGAmqk4hoUiD1IlOqL0uElC10ktXSLK4Q2gEphsn5p
         pf9+lbC1/E5sVyOgRrS2XZXP1SoPEl103INbG4K/HdA3ZC/RE10RnkhVDiaFkxxVDVr7
         RrIBS89vjE52HO77ZnDZEO8uXtMPRTiNUAgwDmrvuL+zamQv5huwoGCTsD6x5YIZrZ5F
         5mlpl1qEtJAJFHDe3dvf5m3t5ByER+IfTNHOsoZaezAuYsfkGvyQfYrDZyD5DnG9mc5l
         vUscSUIPjW2VY2TyeZCHvYX1Oxu7bLCWdZFdMXOUBEpBDyLtLa8mLSGj1RsimK52qtpk
         RAzA==
X-Gm-Message-State: AGRZ1gI4+L46OH8w5F201d1GdUNV4G/2rmPS9dkEuc3rfrx6rcTN/rx2
        LKwF4QVabrxDvX+06xWswkrQDiq+KIiM3Gm/31lF2g==
X-Google-Smtp-Source: AJdET5f3iVp8+DSEeAzwwq+nENOf58xxMyQylRXyKXk3h68EEK3vX77YepQJAYCNHeYU9WDIXUWqOYmOXNkaOGgGyPo=
X-Received: by 2002:a62:cac4:: with SMTP id y65-v6mr5743033pfk.27.1542125944467;
 Tue, 13 Nov 2018 08:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20181106064206.17535-1-weiyi.lu@mediatek.com> <20181106064206.17535-4-weiyi.lu@mediatek.com>
In-Reply-To: <20181106064206.17535-4-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 13 Nov 2018 08:18:52 -0800
Message-ID: <CANMq1KBjtyQFyJ-mZBndPDSfSDnD0K8izy39jp9zKE4xfiCiog@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] clk: mediatek: add new member to mtk_pll_data
To:     weiyi.lu@mediatek.com
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, sboyd@codeaurora.org,
        Rob Herring <robh@kernel.org>, jamesjj.liao@mediatek.com,
        fan.chen@mediatek.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, owen.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 10:43 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> From: Owen Chen <owen.chen@mediatek.com>
>
> 1. pcwibits: The integer bits of pcw for plls is extend to 8 bits,
>    add a variable to indicate this change and
>    backward-compatible.
> 2. fmin: The pll freqency lower-bound is vary from 1GMhz to
>    1.5Ghz, add a variable to indicate platform-dependent.
>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.h |  2 ++
>  drivers/clk/mediatek/clk-pll.c | 10 +++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index f83c2bbb677e..1882221fe994 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -215,7 +215,9 @@ struct mtk_pll_data {
>         const struct clk_ops *ops;
>         u32 rst_bar_mask;
>         unsigned long fmax;
> +       unsigned long fmin;

Minor nit: I'd put fmin before fmax in the structure.

>         int pcwbits;
> +       int pcwibits;
>         uint32_t pcw_reg;
>         int pcw_shift;
>         const struct mtk_pll_div_table *div_table;
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index f54e4015b0b1..0ec2c62d9383 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c

I'd add a note next to:
#define INTEGER_BITS            7
to say that this is the default, and can be overridden with pcwibits.

> @@ -69,11 +69,13 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
>  {
>         int pcwbits = pll->data->pcwbits;
>         int pcwfbits;
> +       int ibits;
>         u64 vco;
>         u8 c = 0;
>
>         /* The fractional part of the PLL divider. */
> -       pcwfbits = pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
> +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> +       pcwfbits = pcwbits > ibits ? pcwbits - ibits : 0;
>
>         vco = (u64)fin * pcw;
>
> @@ -138,9 +140,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>                 u32 freq, u32 fin)
>  {
> -       unsigned long fmin = 1000 * MHZ;
> +       unsigned long fmin = pll->data->fmin ? pll->data->fmin : 1000 * MHZ;

I'd put parentheses around (1000 * MHZ), to avoid the need to think
about precedence...

>         const struct mtk_pll_div_table *div_table = pll->data->div_table;
>         u64 _pcw;
> +       int ibits;
>         u32 val;
>
>         if (freq > pll->data->fmax)
> @@ -164,7 +167,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>         }
>
>         /* _pcw = freq * postdiv / fin * 2^pcwfbits */
> -       _pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
> +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> +       _pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);
>         do_div(_pcw, fin);
>
>         *pcw = (u32)_pcw;
> --
> 2.18.0
>
