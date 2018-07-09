Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EE520852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9hVSBfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EE520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeGIGdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754214AbeGIGdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:33:45 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48B842084C;
        Mon,  9 Jul 2018 06:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531118025;
        bh=esYt3PlA2cn/7ajr4JRQLmfCGlQRuYsvI+8HOiLeNjs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Z9hVSBfiXreLVL/yqez/NZz1jzT2tHZX5l+tXzKXjLAjlorqLbpOMB4ENaCk575a4
         fe7p9MfCNsXzwtG1GxjTMRp+d5oqyW80CYwsbpx1xfaVykV6hAb3ZyOLfMZSRl92F0
         DVc4uPu+vpbyEVaMA6DEtEVEte9O+RDJn47f4fGI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     linux@armlinux.org.uk, matti.vaittinen@fi.rohmeurope.com,
        mazziesaccount@gmail.com, sboyd@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180628075453.GA7793@localhost.localdomain>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <20180628075453.GA7793@localhost.localdomain>
Message-ID: <153111802456.143105.16373079820431081414@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: clkdev - add managed versions of lookup registrations
Date:   Sun, 08 Jul 2018 23:33:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-06-28 00:54:53)
> Add devm_clk_hw_register_clkdev, devm_clk_register_clkdev and
> devm_clk_release_clkdev as a first styep to clean up drivers which are

s/styep/step/

> leaking clkdev lookups at driver remove.
> =

> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> =

>  drivers/clk/clkdev.c   | 165 +++++++++++++++++++++++++++++++++++++++++--=
------
>  include/linux/clkdev.h |   8 +++

Also need to update the Documentation file at
Documentation/driver-model/devres.txt

>  2 files changed, 147 insertions(+), 26 deletions(-)
> =

> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 7513411140b6..4752a0004a6c 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -390,7 +390,7 @@ void clkdev_drop(struct clk_lookup *cl)
>  }
>  EXPORT_SYMBOL(clkdev_drop);
>  =

> -static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
> +static struct clk_lookup *do_clk_register_clkdev(struct clk_hw *hw,

Don't rename this.

>                                                 const char *con_id,
>                                                 const char *dev_id, ...)
>  {
> @@ -404,6 +404,24 @@ static struct clk_lookup *__clk_register_clkdev(stru=
ct clk_hw *hw,
>         return cl;
>  }
>  =

> +static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
> +       const char *con_id, const char *dev_id)
> +{
> +       struct clk_lookup *cl;
> +
> +       /*
> +        * Since dev_id can be NULL, and NULL is handled specially, we mu=
st
> +        * pass it as either a NULL format string, or with "%s".
> +        */
> +       if (dev_id)
> +               cl =3D do_clk_register_clkdev(hw, con_id, "%s",
> +                                          dev_id);
> +       else
> +               cl =3D do_clk_register_clkdev(hw, con_id, NULL);
> +
> +       return cl;

I think this is the same code as before? Try to minimize the diff so we
can focus on what's really changing.

> +}
> +
>  /**
>   * clk_register_clkdev - register one clock lookup for a struct clk
>   * @clk: struct clk to associate with all clk_lookups
[...]
> +
> +/**
> + * devm_clk_hw_register_clkdev - managed clk lookup registration for clk=
_hw
> + * @dev: device this lookup is bound
> + * @hw: struct clk_hw to associate with all clk_lookups
> + * @con_id: connection ID string on device
> + * @dev_id: format string describing device name
> + *
> + * con_id or dev_id may be NULL as a wildcard, just as in the rest of
> + * clkdev.
> + *
> + * To make things easier for mass registration, we detect error clk_hws
> + * from a previous clk_hw_register_*() call, and return the error code f=
or
> + * those.  This is to permit this function to be called immediately
> + * after clk_hw_register_*().
> + */
> +int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
> +                               const char *con_id, const char *dev_id)
> +{
> +       struct clk_lookup **cl =3D NULL;

Don't assign to NULL to just overwrite it later.

>  =

>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);

Put another newline here.

> +       cl =3D devres_alloc(devm_clkdev_release, sizeof(*cl), GFP_KERNEL);
> +       if (cl) {
> +               *cl =3D __clk_register_clkdev(hw, con_id, dev_id);

Why can't we just call clk_hw_register_clkdev()? Sure the IS_ERR()
chain is duplicated, but that can be left out of the devm version and
rely on the clk_hw_register_clkdev() to take care of it otherwise.


> +               if (*cl)
> +                       devres_add(dev, cl);
> +               else
> +                       devres_free(cl);
> +       }
> +       return (cl && *cl) ? 0 : -ENOMEM;
> +}
> +EXPORT_SYMBOL(devm_clk_hw_register_clkdev);
>  =

> -       /*
> -        * Since dev_id can be NULL, and NULL is handled specially, we mu=
st
> -        * pass it as either a NULL format string, or with "%s".
> -        */
> -       if (dev_id)
> -               cl =3D __clk_register_clkdev(hw, con_id, "%s", dev_id);
> -       else
> -               cl =3D __clk_register_clkdev(hw, con_id, NULL);
> -
> -       return cl ? 0 : -ENOMEM;
> +/**
> + * devm_clk_register_clkdev - managed clk lookup registration for a stru=
ct clk
> + * @dev: device this lookup is bound
> + * @clk: struct clk to associate with all clk_lookups
> + * @con_id: connection ID string on device
> + * @dev_id: string describing device name
> + *
> + * con_id or dev_id may be NULL as a wildcard, just as in the rest of
> + * clkdev.
> + *
> + * To make things easier for mass registration, we detect error clks
> + * from a previous clk_register() call, and return the error code for
> + * those.  This is to permit this function to be called immediately
> + * after clk_register().
> + */
> +int devm_clk_register_clkdev(struct device *dev, struct clk *clk,
> +                            const char *con_id, const char *dev_id)

I wouldn't even add this function, to encourage driver writers to
migrate to clk_hw based registration functions and to avoid removing it
later on.

> +{
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +       return devm_clk_hw_register_clkdev(dev, __clk_get_hw(clk), con_id,
> +                                          dev_id);
>  }
> -EXPORT_SYMBOL(clk_hw_register_clkdev);
> +EXPORT_SYMBOL(devm_clk_register_clkdev);
> diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
> index 4890ff033220..27ebeae8ae26 100644
> --- a/include/linux/clkdev.h
> +++ b/include/linux/clkdev.h
> @@ -52,4 +52,12 @@ int clk_add_alias(const char *, const char *, const ch=
ar *, struct device *);
>  int clk_register_clkdev(struct clk *, const char *, const char *);
>  int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
>  =

> +int devm_clk_register_clkdev(struct device *dev, struct clk *clk,
> +                            const char *con_id, const char *dev_id);
> +int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
> +                               const char *con_id, const char *dev_id);
> +void devm_clk_release_clkdev(struct device *dev, const char *con_id,
> +                            const char *dev_id);
> +
> +
>  #endif
