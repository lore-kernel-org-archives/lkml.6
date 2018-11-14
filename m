Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40395C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FE120868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKqxHBDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FE120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbeKOIdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388801AbeKOIcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:32:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C25920825;
        Wed, 14 Nov 2018 22:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542233950;
        bh=e+1g8ysiEmeAd46GphoqR4QLHNGpE9RlDgMbIMi8VXw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=mKqxHBDyvEODUVWVNH/2H4qAYms0jlvhyFFauW3dtwTdzy+99NQRK0Zr3puRUob4y
         8tEJmCo/LXOApiT8XCjqAL0w3PXTJN7iypzxxLG2i2uUqNUfCY0V/0c6TOcdQq7RJv
         sT2dgajTDb6lQk+UgMbPbE4h0qWPbLAbASOJlbfA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Janek Kotas <jank@cadence.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <D3711617-229C-4FA5-9E73-A7A3C025893B@global.cadence.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <D3711617-229C-4FA5-9E73-A7A3C025893B@global.cadence.com>
Message-ID: <154223394933.88331.14659021245427374668@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: Add Fixed MMIO clock driver
Date:   Wed, 14 Nov 2018 14:19:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janek Kotas (2018-11-14 07:24:39)
> This patch adds a driver for Fixed MMIO clock.
> The driver reads a clock frequency value from a single 32-bit memory
> mapped register and registers it as a fixed rate clock.
> =

> It can be enabled with COMMON_CLK_FIXED_MMIO Kconfig option.
> =

> Signed-off-by: Jan Kotas <jank@cadence.com>

Sounds like a fine idea. Except I can see how it will be abused if there
are a handful of these fixed rate "clks" somewhere in memory that all
get populated. =


Do you really have a fixed rate clk in hardware that exposes a single
register, or do you have a set of them that some firmware is populating
into an I/O memory space that we can read the fixed rates from? If it's
the latter, I wonder why we can't just have the firmware populate the
fixed rate clks into DT itself?

> diff --git a/drivers/clk/clk-fixed-mmio.c b/drivers/clk/clk-fixed-mmio.c
> new file mode 100644
> index 0000000000..bbcadab345
> --- /dev/null
> +++ b/drivers/clk/clk-fixed-mmio.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Memory Mapped IO Fixed Clock driver
> + *
> + * Copyright (C) 2018 Cadence Design Systems, Inc.
> + *
> + * Authors:
> + *     Jan Kotas <jank@cadence.com>
> + */
> +
> +#include <linux/clk.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>

Is this include used?

> +
> +static void __init of_fixed_mmio_clk_setup(struct device_node *node)
> +{
> +       struct clk *clk;
> +       const char *clk_name =3D node->name;
> +       void __iomem *base;
> +       u32 clk_freq;
> +
> +       base =3D of_iomap(node, 0);
> +       if (!base) {
> +               pr_err("%pOFn: failed to map address\n", node);
> +               return;
> +       }
> +
> +       clk_freq =3D readl(base);
> +       iounmap(base);
> +       of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +       clk =3D clk_register_fixed_rate(NULL, clk_name, NULL, 0, clk_freq=
);
> +       if (IS_ERR(clk)) {
> +               pr_err("%pOFn: failed to register fixed rate clock\n", no=
de);
> +               return;
> +       }
> +
> +       if (of_clk_add_provider(node, of_clk_src_simple_get, clk)) {
> +               pr_err("%pOFn: failed to add clock provider\n", node);
> +               return;
> +       }
> +
> +       pr_info("%pOFn: registered fixed-mmio-clock at %u Hz\n",
> +               node, clk_freq);

Please no "I'm alive!" messages.

> +}
> +
> +CLK_OF_DECLARE(fixed_mmio_clk, "fixed-mmio-clock", of_fixed_mmio_clk_set=
up);

Any reason why this can't be a platform driver? It would make this much
less DT specific and usable on other firmwares/platforms if we used a
platform driver here.

