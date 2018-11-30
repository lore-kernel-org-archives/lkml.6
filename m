Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B727CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6EE2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSbG7sI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6EE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeK3UCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbeK3UCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:02:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 024962081C;
        Fri, 30 Nov 2018 08:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543568051;
        bh=mu+qjgNqKeZG+Iq9sFz1YwTtk5K9QeBfjySuziAggTA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=FSbG7sI1IWhnZygpLvQouRAat7e4sUwMQ80hU1vKlEjZpZL4OC0EyEOfcJWuTB80T
         QSw2CDekKgkreaTpr7t/pGw3NLmqFsnoYe+/qA6BKigSnI0A3HhHWFsS4FgYdDrlxy
         FbwB+1xs9LIf8OwBWbuGznw/GMdmFLbHRNy3aG7A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and provider
 registrations
Date:   Fri, 30 Nov 2018 00:54:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-11-13 03:55:58)
> With MFD devices the clk properties may be contained in MFD (parent) DT
> node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
> subdevice not to MFD device (parent). Add
> devm_of_clk_add_hw_provider_parent to tackle this issue.
> =

> Also clkdev registration lacks of managed registration functions and it
> seems few drivers do not drop clkdev lookups at exit. Add
> devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
> releasing at exit.

Please split this into clkdev and non-clkdev devm functionality.

> =

> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  Documentation/driver-model/devres.txt |   3 +
>  drivers/clk/clk.c                     |  28 ++++++--
>  drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++++--=
------
>  include/linux/clk-provider.h          |  11 +++
>  include/linux/clkdev.h                |   4 ++
>  5 files changed, 136 insertions(+), 32 deletions(-)
> =

> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver=
-model/devres.txt
> index 43681ca0837f..fac63760b01c 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -238,6 +238,9 @@ CLOCK
>    devm_clk_put()
>    devm_clk_hw_register()
>    devm_of_clk_add_hw_provider()
> +  devm_of_clk_add_parent_hw_provider()
> +  devm_clk_hw_register_clkdev()
> +  devm_clk_release_clkdev()

The 'release' or non-common functions shouldn't be documented here.

>  =

>  DMA
>    dmaenginem_async_device_register()
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index af011974d4ec..9bb921eb90f6 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3893,12 +3893,12 @@ static void devm_of_clk_release_provider(struct d=
evice *dev, void *res)
>         of_clk_del_provider(*(struct device_node **)res);
>  }
>  =

> -int devm_of_clk_add_hw_provider(struct device *dev,
> +static int __devm_of_clk_add_hw_provider(struct device *dev,
>                         struct clk_hw *(*get)(struct of_phandle_args *clk=
spec,
>                                               void *data),
> -                       void *data)
> +                       struct device_node *of_node, void *data)
>  {
> -       struct device_node **ptr, *np;
> +       struct device_node **ptr;
>         int ret;
>  =

>         ptr =3D devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
> @@ -3906,10 +3906,9 @@ int devm_of_clk_add_hw_provider(struct device *dev,
>         if (!ptr)
>                 return -ENOMEM;
>  =

> -       np =3D dev->of_node;
> -       ret =3D of_clk_add_hw_provider(np, get, data);
> +       *ptr =3D of_node;
> +       ret =3D of_clk_add_hw_provider(of_node, get, data);
>         if (!ret) {
> -               *ptr =3D np;

Why is this moved outside of the if condition? In fact, why isn't just
the first line in this hunk deleted and passed to this function as
struct device_node *np?

>                 devres_add(dev, ptr);
>         } else {
>                 devres_free(ptr);
> @@ -3917,8 +3916,25 @@ int devm_of_clk_add_hw_provider(struct device *dev,
>  =

>         return ret;
>  }

Nitpick: Add a newline here.

> +int devm_of_clk_add_hw_provider(struct device *dev,
> +                       struct clk_hw *(*get)(struct of_phandle_args *clk=
spec,
> +                                             void *data),
> +                       void *data)
> +{
> +       return __devm_of_clk_add_hw_provider(dev, get, dev->of_node, data=
);
> +}
>  EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);
>  =

> +int devm_of_clk_add_parent_hw_provider(struct device *dev,
> +                       struct clk_hw *(*get)(struct of_phandle_args *clk=
spec,
> +                                             void *data),
> +                       void *data)
> +{
> +       return __devm_of_clk_add_hw_provider(dev, get, dev->parent->of_no=
de,

I'm wondering if we can somehow auto-detect this in
devm_of_clk_add_hw_provider() by looking for #clock-cells in the node.
If it isn't there, then we go to the parent node and look for a
#clock-cells property there in the DT node for that device. Does that
make sense? Then there isn't any new API and we can attach the lifetime
of the devm registration to the presence of the property indicating this
is a clk controller or not.

> +                                            data);
> +}
> +EXPORT_SYMBOL_GPL(devm_of_clk_add_parent_hw_provider);

Can we get some kernel doc on these functions?

> +
>  /**
>   * of_clk_del_provider() - Remove a previously registered clock provider
>   * @np: Device node pointer associated with clock provider
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 9ab3db8b3988..f6100b6e06fd 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
[...]
> +
> +/**
> + * devm_clk_release_clkdev - Resource managed clkdev lookup release
> + * @dev: device this lookup is bound
> + * @con_id: connection ID string on device
> + * @dev_id: format string describing device name
> + *
> + * Drop the clkdev lookup created with devm_clk_hw_register_clkdev.
> + * Normally this function will not need to be called and the resource
> + * management code will ensure that the resource is freed.
> + */
> +void devm_clk_release_clkdev(struct device *dev, const char *con_id,
> +                            const char *dev_id)
> +{
> +       struct clk_lookup *cl;
> +       int rval;
> +
> +       cl =3D clk_find(dev_id, con_id);
> +       WARN_ON(!cl);
> +       rval =3D devres_release(dev, devm_clkdev_release,
> +                             &devm_clk_match_clkdev, cl);

Nitpick: Drop & on functions taken as pointers.

> +       WARN_ON(rval);
> +}
> +EXPORT_SYMBOL(devm_clk_release_clkdev);
