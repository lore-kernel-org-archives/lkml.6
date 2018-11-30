Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FB8C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247D42146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dteVGgIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247D42146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeK3URl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:17:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbeK3URl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:17:41 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 384BD20868;
        Fri, 30 Nov 2018 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543568942;
        bh=c4z90kPgWBsUx4oXIOj7WmhJSMKbWcc9L+/YrgUV8Aw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=dteVGgIS93aRuEtZ8dwFG6HMPIaYdQhz1BNT7FKtwuJVZA/JLYFnbqR39Fo7k1u8U
         dIOv4VQImvxFn8WCEOoeL2mE6hRkt3njIa6qaXrD0s1/WjP+K2squu0QZVomPvpjNA
         vIEdCHyp0CLpKVOpadFV4OlxtiTAnl9VqLEUHugo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181120141445.21378-1-phil.edworthy@renesas.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Phil Edworthy <phil.edworthy@renesas.com>
References: <20181120141445.21378-1-phil.edworthy@renesas.com>
Message-ID: <154356894146.88331.4169293505438588293@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8] clk: Add (devm_)clk_get_optional() functions
Date:   Fri, 30 Nov 2018 01:09:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Phil Edworthy (2018-11-20 06:14:45)
> This adds clk_get_optional() and devm_clk_get_optional() functions to get
> optional clocks.
> They behave the same as (devm_)clk_get except where there is no clock
> producer. In this case, instead of returning -ENOENT, the function
> returns NULL. This makes error checking simpler and allows
> clk_prepare_enable, etc to be called on the returned reference
> without additional checks.

Ok. I guess that works by virtue of how -ENOENT is returned by various
functions that are called deeper in the clk_get() path? I'm cautiously
optimistic. So cautious, we should probably add a comment to these
optional functions that indicate they rely on the functions they call to
return -ENOENT under the various conditions that make a clk optional.

> =

> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index a7773b5c0b9f..3ea3c78f62dd 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -383,6 +383,17 @@ int __must_check devm_clk_bulk_get_all(struct device=
 *dev,
>   */
>  struct clk *devm_clk_get(struct device *dev, const char *id);
>  =

> +/**
> + * devm_clk_get_optional - lookup and obtain a managed reference to an o=
ptional
> + *                        clock producer.
> + * @dev: device for clock "consumer"
> + * @id: clock consumer ID
> + *
> + * Behaves the same as devm_clk_get except where there is no clock produ=
cer. In

Please add () around devm_clk_get() so we know it's a function.

> + * this case, instead of returning -ENOENT, the function returns NULL.
> + */
> +struct clk *devm_clk_get_optional(struct device *dev, const char *id);
> +
>  /**
>   * devm_get_clk_from_child - lookup and obtain a managed reference to a
>   *                          clock producer from child node.
> @@ -718,6 +729,12 @@ static inline struct clk *devm_clk_get(struct device=
 *dev, const char *id)
>         return NULL;
>  }
>  =

> +static inline struct clk *devm_clk_get_optional(struct device *dev,
> +                                               const char *id)
> +{
> +       return NULL;
> +}
> +
>  static inline int __must_check devm_clk_bulk_get(struct device *dev, int=
 num_clks,
>                                                  struct clk_bulk_data *cl=
ks)
>  {
> @@ -862,6 +879,16 @@ static inline void clk_bulk_disable_unprepare(int nu=
m_clks,
>         clk_bulk_unprepare(num_clks, clks);
>  }
>  =

> +static inline struct clk *clk_get_optional(struct device *dev, const cha=
r *id)

Any kernel doc for this function?

> +{
> +       struct clk *clk =3D clk_get(dev, id);
> +
> +       if (clk =3D=3D ERR_PTR(-ENOENT))
> +               clk =3D NULL;
> +
> +       return clk;
> +}
> +
