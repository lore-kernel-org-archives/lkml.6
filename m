Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1C2C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 02:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC13220842
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 02:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRF19/f1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC13220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeIAG4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 02:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbeIAG4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 02:56:09 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8618F20841;
        Sat,  1 Sep 2018 02:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535769950;
        bh=aNvxFNm/VKHMUCMozq0LGliYHp3pCKPgA8sJHqz6DrQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tRF19/f1H/YyPtq+RgTvgjSCa4ANNILbViGKQ88C4oq0bDYjtjJpRbEtPb3lfO1Pa
         FXpq5NEjt27Nxlz2L2LkH0j6T/7O4LLGP4c6vw45bLQGQexQp1i+jZf+fw4vzGM7tT
         quYKw9cK1XmAlr0oo+AJRstSzlvZhxk1Q4oSmlK4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1535724443-21150-2-git-send-email-phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Edworthy <phil.edworthy@renesas.com>
References: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
 <1535724443-21150-2-git-send-email-phil.edworthy@renesas.com>
Message-ID: <153576994987.19113.11376893046599589648@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/2] clk: Add of_clk_get_by_name_optional() function
Date:   Fri, 31 Aug 2018 19:45:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Phil Edworthy (2018-08-31 07:07:22)
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 9ab3db8..4adb99e 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -54,30 +54,29 @@ EXPORT_SYMBOL(of_clk_get);
>  =

>  static struct clk *__of_clk_get_by_name(struct device_node *np,
>                                         const char *dev_id,
> -                                       const char *name)
> +                                       const char *name,
> +                                       bool optional)
>  {
>         struct clk *clk =3D ERR_PTR(-ENOENT);
> +       struct device_node *child =3D np;
> +       int index =3D 0;
>  =

>         /* Walk up the tree of devices looking for a clock that matches */
>         while (np) {
> -               int index =3D 0;
>  =

>                 /*
>                  * For named clocks, first look up the name in the
>                  * "clock-names" property.  If it cannot be found, then
> -                * index will be an error code, and of_clk_get() will fai=
l.
> +                * index will be an error code.
>                  */
>                 if (name)
>                         index =3D of_property_match_string(np, "clock-nam=
es", name);
> -               clk =3D __of_clk_get(np, index, dev_id, name);
> -               if (!IS_ERR(clk)) {
> -                       break;
> -               } else if (name && index >=3D 0) {
> -                       if (PTR_ERR(clk) !=3D -EPROBE_DEFER)
> -                               pr_err("ERROR: could not get clock %pOF:%=
s(%i)\n",
> -                                       np, name ? name : "", index);
> +               if (index >=3D 0)
> +                       clk =3D __of_clk_get(np, index, dev_id, name);
> +               if (!IS_ERR(clk))

Was this change necessary? It looks like we can leave it all alone and
keep passing a negative number to __of_clk_get() and have that return an
error pointer which we then return immediately as an error. But, if the
clock is optional and we've passed a name here, shouldn't we treat an
error from of_property_match_string() as success too? This is all
looking pretty fragile so maybe it can be better commented and also more
explicit instead of relying on the reader to jump through all the
function calls to figure out what the return value is in some cases.

>                         return clk;
> -               }
> +               if (name && index >=3D 0)
> +                       break;

And this causes us to duplicate logic down below because we have to
check it again if it's not optional or some other error condition?

>  =

>                 /*
>                  * No matching clock found on this node.  If the parent n=
ode
> @@ -89,6 +88,16 @@ static struct clk *__of_clk_get_by_name(struct device_=
node *np,
>                         break;
>         }
>  =

> +       /* The clock is not valid, but it could be optional or deferred */
> +       if (optional && PTR_ERR(clk) =3D=3D -ENOENT) {
> +               clk =3D NULL;
> +               pr_info("no optional clock %pOF:%s\n", child,
> +                       name ? name : "");

Is this intentionally pr_info?

> +       } else if (name && index >=3D 0 && PTR_ERR(clk) !=3D -EPROBE_DEFE=
R) {
> +               pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
> +                       child, name, index);
> +       }
> +
>         return clk;
>  }
> =20
