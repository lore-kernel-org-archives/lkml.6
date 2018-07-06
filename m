Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE77C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A482089D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj74CBiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A482089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbeGFSVV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933921AbeGFSVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:21:20 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FFE02089D;
        Fri,  6 Jul 2018 18:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530901279;
        bh=HHKH6xxyPZA5jknDbX9CrYxZFkR88Fqh94F/v2Bz/ew=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Jj74CBiZUUhrxZncB25HLt57IVHAn0AQF5uf/XagjKiDBBjDAbxm8OQPSDV8nS76J
         KR6Stsz+gOBJGCHf9uPo5zCUZcnfX42fI3jCPrBrnmeNyq9mdVRaWgQy41DakDoJzH
         GLDgBpDCDjY8HfhPtcjv1w20aLPqljJE8Jey9zEI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1530699455-27654-1-git-send-email-avienamo@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
References: <1530699455-27654-1-git-send-email-avienamo@nvidia.com>
Message-ID: <153090127889.143105.9965550219605167700@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/3] clk: tegra: refactor 7.1 div calculation
Date:   Fri, 06 Jul 2018 11:21:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aapo Vienamo (2018-07-04 03:17:33)
> diff --git a/drivers/clk/tegra/div71.c b/drivers/clk/tegra/div71.c
> new file mode 100644
> index 0000000..1a5e04c
> --- /dev/null
> +++ b/drivers/clk/tegra/div71.c
> @@ -0,0 +1,54 @@
> +/*
> + * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/kernel.h>

You can include <asm/div64.h> instead.

> +
> +#include "clk.h"
> +
> +#define div_mask(w) ((1 << (w)) - 1)
> +
> +int div71_get(unsigned long rate, unsigned parent_rate, u8 width,
> +             u8 frac_width, u8 flags)
> +{
> +       u64 divider_ux1 =3D parent_rate;

Hmm ok, now it's unsigned. That's works too.

> +       int mul;
> +
> +       if (!rate)
> +               return 0;
> +
> +       mul =3D 1 << frac_width;
> +
> +       if (!(flags & TEGRA_DIVIDER_INT))
> +               divider_ux1 *=3D mul;
> +
> +       if (flags & TEGRA_DIVIDER_ROUND_UP)
> +               divider_ux1 +=3D rate - 1;
> +
> +       do_div(divider_ux1, rate);
> +
> +       if (flags & TEGRA_DIVIDER_INT)
> +               divider_ux1 *=3D mul;
> +
> +       if (divider_ux1 < mul)
> +               return 0;
> +
> +       divider_ux1 -=3D mul;
> +
> +       if (divider_ux1 > div_mask(width))
> +               return div_mask(width);
> +
> +       return divider_ux1;
> +}
