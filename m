Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56BDC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9A320834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiVJ17XP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9A320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLDTiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeLDTiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:38:19 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F009A2081C;
        Tue,  4 Dec 2018 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543952298;
        bh=cngnxl+fU+ayv84S7RyWF15Ik1K/InQVU3DcM+FUCIo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=GiVJ17XPmwirSW3mJ0E2FkVcefeNrshizET7NcDG5jnG7MaXqI0k5osnMaoe5bl93
         N0qcwqGPHLoThI7bvvwW7BEyh5aqaCz7dfGbCTMTXf8GwCM4yC0mxMeuaDcfx1/NgI
         a7rHJUjnXT+FztrZ9FswBU/UCMObuhTN+6XwjK+A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered device
 has no provider info
Date:   Tue, 04 Dec 2018 11:38:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-04 03:34:53)
> It seems to be usual for MFD devices that the created 'clock sub-device'
> do not have own DT node. The clock provider information is usually in the
> main device node which is owned by the MFD device. Change the devm variant
> of clk of-provider registration to check the parent device node if given
> device has no own node or if the node does not contain the #clock-cells
> property. In such case use the parent node if it contains the #clock-cell=
s.
> =

> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/clk/clk.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 78c90913f987..66dc7c1483d7 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3893,6 +3893,11 @@ static void devm_of_clk_release_provider(struct de=
vice *dev, void *res)
>         of_clk_del_provider(*(struct device_node **)res);
>  }
>  =

> +static int of_is_clk_provider(struct device_node *np)
> +{
> +       return !!of_find_property(np, "#clock-cells", NULL);
> +}
> +
>  /**
>   * devm_of_clk_add_hw_provider() - Managed clk provider node registration
>   * @dev: Device acting as the clock provider. Used for DT node and lifet=
ime.
> @@ -3901,8 +3906,11 @@ static void devm_of_clk_release_provider(struct de=
vice *dev, void *res)
>   *
>   * Returns 0 on success or an errno on failure.
>   *
> - * Registers clock provider for given device's node. Provider is automat=
ically
> - * released at device exit.
> + * Registers clock provider for given device's node. If the device has n=
o DT
> + * node or if the device node lacks of clock provider information (#cloc=
k-cells)
> + * then the parent device's node is scanned for this information. If par=
ent node
> + * has the #clock-cells then it is used in registration. Provider is
> + * automatically released at device exit.
>   */
>  int devm_of_clk_add_hw_provider(struct device *dev,
>                         struct clk_hw *(*get)(struct of_phandle_args *clk=
spec,
> @@ -3912,12 +3920,17 @@ int devm_of_clk_add_hw_provider(struct device *de=
v,
>         struct device_node **ptr, *np;
>         int ret;
>  =

> +       np =3D dev->of_node;
> +
> +       if (!of_is_clk_provider(dev->of_node))
> +               if (of_is_clk_provider(dev->parent->of_node))
> +                       np =3D dev->parent->of_node;

As said on v5, let's just modify of_clk_add_provider() to do the parent
search.

