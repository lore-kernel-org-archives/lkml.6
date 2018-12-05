Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC8C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D371D20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D371D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeLESVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:21:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45097 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeLESVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:21:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so19219843ljd.12;
        Wed, 05 Dec 2018 10:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4154P4SeFkHg5lRonBhn1yP7c3OfbebgZCOeZYCgayo=;
        b=k5r1pnND38Y32hGkl0nO8QZF84YmSmmKmpfwZMyNe6todesLeUzTGkVxiGGQHucS1+
         fok17e9ReAK+SsZzPQ6tE8MEhCuti6CU00x2YlDsZCz1M1pbkAPPeGU0ukhGr5emdyNJ
         q3m17DD8B+aaNmXsLs2vhlqdHbMvCHObpE3pnJl7mxMKLfRFwC/AEPf4blNafPzoLYtQ
         BIq/i2necwLnhSrGTBHgAckkBvFAzr6ou/cxzNgxWe+GkSQUtJDz2OiPDPUBcTQQXkFh
         Howg2hebW9jHp/USQ6vidTTZ+h/MokTx9jovg1zi5+kAyvePjrRJRFB0qX1PRhNK1lAC
         bPAQ==
X-Gm-Message-State: AA+aEWaLCRJlztuas6qMYjQb5tf2TMHJO5e1k0Dgbv+V/EnMKnyiMAvh
        6glqnXXRt4/TeLBhzDzENSA=
X-Google-Smtp-Source: AFSGD/WANUvT+PdsYCMdb7t9W6H3FQKUHEcDkyfIdMqDF1+Wwhh5XYSFkXddgEIYris5VMh04xMMEA==
X-Received: by 2002:a2e:2f15:: with SMTP id v21-v6mr6875126ljv.56.1544034063702;
        Wed, 05 Dec 2018 10:21:03 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi. [84.253.205.125])
        by smtp.gmail.com with ESMTPSA id y1-v6sm3889220ljh.39.2018.12.05.10.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 10:21:01 -0800 (PST)
Date:   Wed, 5 Dec 2018 20:20:58 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mazziesaccount@gmail.com, mturquette@baylibre.com,
        cw00.choi@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, pavel@ucw.cz, andrew.smirnov@gmail.com,
        pombredanne@nexb.com, sjhuang@iluvatar.ai, akshu.agrawal@amd.com,
        djkurtz@chromium.org, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered
 device has no provider info
Message-ID: <20181205182058.GF31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
 <20181205070046.GD31204@localhost.localdomain>
 <154403037317.88331.9382087418367713867@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154403037317.88331.9382087418367713867@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:19:33AM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-12-04 23:00:46)
> > But that won't solve the issue if we don't do "dirty hacks" in driver.
> > The devm interface still only gets the device-pointer, not the DT node
> > as argument. And if DT node for device is NULL (like in MFD cases) -
> > then there is no parent node, only parent device with a node. For plain
> > of_clk_add_provider() the driver can just give the parent's node pointer
> > in cases where it knows it is the parent who has the provider data in
> > DT. But our original problem is in devm interfaces.
> > 
> 
> I was misunderstanding the MFD design. Should still work though, so I
> squashed this into the patch to clean things up a bit. Does this work
> for you?

This looks good to me. Especially changing the of_is_clk_provider to
get_clk_provider_node which allows to remove some repetition. If you
apply this then I will drop my patch from the series. Just please let me
know. I will cook version 7 of the series at Friday - tomorrow is the
independence day in Finland and I'll be offline =)

Thanks!

> 
> ------8<-----
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index bb689161f0f5..6ff852bda892 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3893,9 +3893,23 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
>  	of_clk_del_provider(*(struct device_node **)res);
>  }
>  
> -static int of_is_clk_provider(struct device_node *np)
> +/*
> + * We allow a child device to use its parent device as the clock provider node
> + * for cases like MFD sub-devices where the child device driver wants to use
> + * devm_*() APIs but not list the device in DT as a sub-node.
> + */
> +static struct device_node *get_clk_provider_node(struct device *dev)
>  {
> -	return !!of_find_property(np, "#clock-cells", NULL);
> +	struct device_node *np, *parent_np;
> +
> +	np = dev->of_node;
> +	parent_np = dev->parent ? dev->parent->of_node : NULL;
> +
> +	if (!of_find_property(np, "#clock-cells", NULL))
> +		if (of_find_property(parent_np, "#clock-cells", NULL))
> +			np = parent_np;
> +
> +	return np;
>  }
>  
>  /**
> @@ -3920,17 +3934,12 @@ int devm_of_clk_add_hw_provider(struct device *dev,
>  	struct device_node **ptr, *np;
>  	int ret;
>  
> -	np = dev->of_node;
> -
> -	if (!of_is_clk_provider(dev->of_node))
> -		if (of_is_clk_provider(dev->parent->of_node))
> -			np = dev->parent->of_node;
> -
>  	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
>  			   GFP_KERNEL);
>  	if (!ptr)
>  		return -ENOMEM;
>  
> +	np = get_clk_provider_node(dev);
>  	ret = of_clk_add_hw_provider(np, get, data);
>  	if (!ret) {
>  		*ptr = np;
> @@ -3981,13 +3990,8 @@ static int devm_clk_provider_match(struct device *dev, void *res, void *data)
>  void devm_of_clk_del_provider(struct device *dev)
>  {
>  	int ret;
> -	struct device_node *np;
> -
> -	np = dev->of_node;
> +	struct device_node *np = get_clk_provider_node(dev);
>  
> -	if (!of_is_clk_provider(dev->of_node))
> -		if (of_is_clk_provider(dev->parent->of_node))
> -			np = dev->parent->of_node;
>  	ret = devres_release(dev, devm_of_clk_release_provider,
>  			     devm_clk_provider_match, np);
>  
> 

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
