Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38241C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD24208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIvxyGcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD24208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754736AbeGIFen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754713AbeGIFeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:34:36 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7BFB208DB;
        Mon,  9 Jul 2018 05:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531114476;
        bh=xtublNqMN+HxLY6eO56FPltOB0NEWfJL4bOiLZr8Pjc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=QIvxyGcH2pR6d72K4Bg8ZbnBe1A2aWx7WX8eHICWqqYFjSJ70aod2bhLQcGZyMp3n
         IWLopwSE/dOOnjLufPiW+ulbTKVUQvQNdc8tU5OG0MLCT/xnnG7dXl4ZF1Ab55P0eU
         q1XZhy2OtGSjn1T3+2atLzJkygZhkqIgSfdWfM68=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528285308-25477-2-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-2-git-send-email-anischal@codeaurora.org>
Message-ID: <153111447519.143105.17241493270191899078@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/4] clk: qcom: gdsc: Add support to enable/disable the clocks
 with GDSC
Date:   Sun, 08 Jul 2018 22:34:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-06-06 04:41:45)
> For some of the GDSCs, there is a requirement to enable/disable the
> few clocks before turning on/off the gdsc power domain. Add support

Why is there a requirement? Do the clks need to be in hw control mode or
they can't be turned off when the GDSC is off? It's hard for me to
understand with these vague statements.

> for the same by specifying a list of clk_hw pointers per gdsc and
> enable/disable them along with power domain on/off callbacks.
> =

> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---
>  drivers/clk/qcom/gdsc.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h |  5 +++++
>  2 files changed, 49 insertions(+)
> =

> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index a077133..b6adca1 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -12,6 +12,8 @@
>   */
> =

>  #include <linux/bitops.h>
> +#include <linux/clk.h>

Ugh.

> +#include <linux/clk-provider.h>

Both, really?

>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/jiffies.h>
> @@ -208,11 +210,41 @@ static inline void gdsc_assert_reset_aon(struct gds=
c *sc)
>         regmap_update_bits(sc->regmap, sc->clamp_io_ctrl,
>                            GMEM_RESET_MASK, 0);
>  }
> +
> +static int gdsc_clk_prepare_enable(struct gdsc *sc)
> +{
> +       int i, ret;
> +
> +       for (i =3D 0; i < sc->clk_count; i++) {
> +               ret =3D clk_prepare_enable(sc->clk_hws[i]->clk);
> +               if (ret) {
> +                       for (i--; i >=3D 0; i--)
> +                               clk_disable_unprepare(sc->clk_hws[i]->clk=
);
> +                       return ret;
> +               }
> +       }
> +       return 0;
> +}
> +

Looks an awful lot like bulk_enable clk API.
