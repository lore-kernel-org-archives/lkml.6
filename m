Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B43C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CCA206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuvnwFu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CCA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeLEHR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbeLEHR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:17:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94F8206B7;
        Wed,  5 Dec 2018 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543994277;
        bh=0IvXpJeJXu00HIXTSp7TLtsxyalDAfaE1CTqqwJAClI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=SuvnwFu+33tIF6EMqfOWZ09Bn5zPP617pnLZmbYEBdwhpwiTR0i7IfuqfVqetzs0d
         ZOOweqAARe4nwgntMDHh6ZFyiRSNCzocNwjbD3oYf+hHETHvJ7z9J/pXXon+oy965x
         5Hdyc0Vek7HafgnrqoA5eWjDcj6qRdW5pyMl6z4o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204193416.24661-1-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20181204163257.32085-1-jbrunet@baylibre.com>
 <20181204193416.24661-1-sboyd@kernel.org>
Message-ID: <154399427706.88331.4744072908182655454@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: socfpga: Don't have get_parent for single parent ops
Date:   Tue, 04 Dec 2018 23:17:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Dinh's korg email)

I also wonder if this driver is even used anymore or maybe we can delete
it?

Quoting Stephen Boyd (2018-12-04 11:34:16)
> This driver creates a gate clk with the possibility to have multiple
> parents. That can cause problems if the common clk framework tries to
> call the get_parent() op and gets back a number that's larger than the
> number of parents the clk says it supports in
> clk_init_data::num_parents. Let's duplicate the clk_ops structure each
> time this function is called and drop the get/set parent ops when there
> is only one parent. This allows the framework to consider a number
> larger than clk_init_data::num_parents as an error condition of the
> get_parent() clk op, clearing the way for proper code.
> =

> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/socfpga/clk-gate.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> =

> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gat=
e.c
> index aa7a6e6a15b6..73e03328d5c5 100644
> --- a/drivers/clk/socfpga/clk-gate.c
> +++ b/drivers/clk/socfpga/clk-gate.c
> @@ -176,8 +176,7 @@ static struct clk_ops gateclk_ops =3D {
>         .set_parent =3D socfpga_clk_set_parent,
>  };
>  =

> -static void __init __socfpga_gate_init(struct device_node *node,
> -       const struct clk_ops *ops)
> +void __init socfpga_gate_init(struct device_node *node)
>  {
>         u32 clk_gate[2];
>         u32 div_reg[3];
> @@ -188,12 +187,17 @@ static void __init __socfpga_gate_init(struct devic=
e_node *node,
>         const char *clk_name =3D node->name;
>         const char *parent_name[SOCFPGA_MAX_PARENTS];
>         struct clk_init_data init;
> +       struct clk_ops *ops;
>         int rc;
>  =

>         socfpga_clk =3D kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
>         if (WARN_ON(!socfpga_clk))
>                 return;
>  =

> +       ops =3D kmemdup(&gateclk_ops, sizeof(gateclk_ops), GFP_KERNEL);
> +       if (WARN_ON(!ops))
> +               return;
> +
>         rc =3D of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
>         if (rc)
>                 clk_gate[0] =3D 0;
> @@ -202,8 +206,8 @@ static void __init __socfpga_gate_init(struct device_=
node *node,
>                 socfpga_clk->hw.reg =3D clk_mgr_base_addr + clk_gate[0];
>                 socfpga_clk->hw.bit_idx =3D clk_gate[1];
>  =

> -               gateclk_ops.enable =3D clk_gate_ops.enable;
> -               gateclk_ops.disable =3D clk_gate_ops.disable;
> +               ops->enable =3D clk_gate_ops.enable;
> +               ops->disable =3D clk_gate_ops.disable;
>         }
>  =

>         rc =3D of_property_read_u32(node, "fixed-divider", &fixed_div);
> @@ -234,6 +238,11 @@ static void __init __socfpga_gate_init(struct device=
_node *node,
>         init.flags =3D 0;
>  =

>         init.num_parents =3D of_clk_parent_fill(node, parent_name, SOCFPG=
A_MAX_PARENTS);
> +       if (init.num_parents < 2) {
> +               ops->get_parent =3D NULL;
> +               ops->set_parent =3D NULL;
> +       }
> +
>         init.parent_names =3D parent_name;
>         socfpga_clk->hw.hw.init =3D &init;
>  =

> @@ -246,8 +255,3 @@ static void __init __socfpga_gate_init(struct device_=
node *node,
>         if (WARN_ON(rc))
>                 return;
>  }
> -
> -void __init socfpga_gate_init(struct device_node *node)
> -{
> -       __socfpga_gate_init(node, &gateclk_ops);
> -}
