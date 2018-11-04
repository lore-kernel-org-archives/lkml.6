Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB877C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC7520843
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTX6wGuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC7520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeKDMQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 07:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbeKDMQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 07:16:02 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B6C32082E;
        Sun,  4 Nov 2018 03:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541300564;
        bh=LWiaBqbaUBB9hsXksYdoTynqgK8e123bd8/IBy+dSZg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=oTX6wGuQ0f1Qnct/8WENr8/l2ESYmrlrIeukooc4S0mLty/7pQQB8KdsdQ/WqsPVi
         O8zqjkLZHhC2GdHNUPff6aYkEKmgiixhnoTnqe2B7hTNFCZgyVRnjjYpK5vzWcUEpc
         d9y4nVQoHgMGGlYwAht6tn6kwb06WX8axCNzjJJ8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1541089855-19356-2-git-send-email-jianxin.pan@amlogic.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com>
 <1541089855-19356-2-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <154130056376.88331.17004780065573288593@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 1/3] clk: meson: add emmc sub clock phase delay driver
Date:   Sat, 03 Nov 2018 20:02:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jianxin Pan (2018-11-01 09:30:53)
> diff --git a/drivers/clk/meson/clk-phase-delay.c b/drivers/clk/meson/clk-=
phase-delay.c
> new file mode 100644
> index 0000000..83e74ed
> --- /dev/null
> +++ b/drivers/clk/meson/clk-phase-delay.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include "clkc.h"
> +
> +static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
> +{
> +       struct clk_regmap *clk =3D to_clk_regmap(hw);
> +       struct meson_clk_phase_delay_data *ph =3D
> +               meson_clk_get_phase_delay_data(clk);

Nitpick: Do this after declaring variables because it splits a line.

> +       unsigned long period_ps, p, d;
> +       int degrees;
> +
> +       p =3D meson_parm_read(clk->map, &ph->phase);
> +       degrees =3D p * 360 / (1 << (ph->phase.width));

Nitpick: Remove useless parenthesis.

> +
> +       period_ps =3D DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,

Is the cast necessary?

> +                                clk_hw_get_rate(hw));
> +
> +       d =3D meson_parm_read(clk->map, &ph->delay);
> +       degrees +=3D d * ph->delay_step_ps * 360 / period_ps;
> +       degrees %=3D 360;
> +
> +       return degrees;
> +}
> +
> +static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degree=
s)
> +{
> +       struct clk_regmap *clk =3D to_clk_regmap(hw);
> +       struct meson_clk_phase_delay_data *ph =3D
> +               meson_clk_get_phase_delay_data(clk);
> +       unsigned long period_ps, d =3D 0, r;
> +       u64 p;
> +
> +       p =3D degrees % 360;

We don't allow phase to be larger than 360 so this isn't needed.

> +       period_ps =3D DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,

Drop the cast?

> +                                clk_hw_get_rate(hw));
> +
> +       /* First compute the phase index (p), the remainder (r) is the

Nitpick: Please leave /* on it's own line.

> +        * part we'll try to acheive using the delays (d).
> +        */
> +       r =3D do_div(p, 360 / (1 << (ph->phase.width)));

Drop useless parenthesis please.

> +       d =3D DIV_ROUND_CLOSEST(r * period_ps,
> +                             360 * ph->delay_step_ps);
> +       d =3D min(d, PMASK(ph->delay.width));
> +
> +       meson_parm_write(clk->map, &ph->phase, p);
> +       meson_parm_write(clk->map, &ph->delay, d);
> +       return 0;
> +}
