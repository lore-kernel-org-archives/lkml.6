Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46E0C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7641B208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwcYYkvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7641B208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbeG0SNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732122AbeG0SNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:13:01 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E9C9208B0;
        Fri, 27 Jul 2018 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532710218;
        bh=oMYkbw1zBmsk4vP901i/XTt5S8CDCkAgwdFs7/OG4dA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=OwcYYkvHRukhrkDl9m+/ZwTZwvfvk3pW7rP2NKtUHSZX9tUWrs5UWDfIigOCuQM3y
         B2s4tZpa0CFPTB9vxOe6+KlB5KTbdrk+PWxEsKepnkIDiW3bY9OCsKsuTa3t4BEJoR
         BLUccupS0VWib26iBYyRW0oiOUanGrDEtqbOMC/E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <TY1PR01MB1769925385A6FB44A431AA07F52A0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
 <20180718130228.GG17271@n2100.armlinux.org.uk>
 <CAMuHMdUjzVBXn-goAwbTBULfo=HrJEY6eBae4w7Z6qA-gScUUw@mail.gmail.com>
 <OSBPR01MB1766E6AFE37986B2E2B5E35DF5530@OSBPR01MB1766.jpnprd01.prod.outlook.com>
 <153255822286.48062.3193076486782567960@swboyd.mtv.corp.google.com>
 <TY1PR01MB1769925385A6FB44A431AA07F52A0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Message-ID: <153271021758.48062.12757198387330928176@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH] clk: Add functions to get optional clocks
Date:   Fri, 27 Jul 2018 09:50:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Phil Edworthy (2018-07-27 08:38:12)
> On 25 July 2018 23:37, Stephen Boyd wrote:
> > Short answer is they don't. I'd still prefer we have this API though.
> > =

> > Can you rework this patch to be a little more invasive into the
> > clk_get() path, perhaps by reworking __of_clk_get_by_name() a little to
> > take an 'optional' argument, so that it only returns NULL when the clk =
is
> > looked up from DT? The fallback path in clkdev where we have a DT based
> > system looking up a clk through clkdev lookups doesn't seem to be a real
> > scenario that we should worry about here. I think sometimes people use
> > clkdev lookups when they're migrating to DT systems and things aren't w=
ired
> > up properly in DT, but that isn't the norm.
> Do you mean something like this:
> =

[...]
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 907202b..830209a 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -771,6 +771,7 @@ static inline void clk_bulk_disable_unprepare(int num=
_clks,
>  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>  struct clk *of_clk_get(struct device_node *np, int index);
>  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
> +struct clk *of_clk_get_by_name_optional(struct device_node *np, const ch=
ar *name);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
>  #else
>  static inline struct clk *of_clk_get(struct device_node *np, int index)
> =

> ---
> A lot of drivers use devm_clk_get() so I think a devm_clk_get_optional()
> version would be useful. That would probably need an additional
> clk_get_optional() function.
> =


Yes, this would be the first patch, and then the second patch would add
clk_get_optional() and devm_clk_get_optional(). We shouldn't encourage
consumers to move from device based to DT node based clk_get() for the
optional clk API.

