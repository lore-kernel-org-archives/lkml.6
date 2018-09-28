Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3044C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7172B206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="THovtu/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7172B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeI2EfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeI2EfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:35:02 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448F72082C;
        Fri, 28 Sep 2018 22:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538172555;
        bh=HNJsIfW4Zwj9YHU/6iKGze1QgCcDLZL+IOQ3QzMwOLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=THovtu/58atNNVIcXJRAN9GK6wh1VPUg45sW17WGqSOrErP2mRLAXPp/Let9RXE+F
         eItgr/qz0YzZQQQHNjoxghIWo1qgcd2lA8TUh+2Xd43IUmA98GzeM+8u8fQzIAaJS6
         oyXEUfJG5BnnvCk04JUaGizZSXvjAYhzKskAISZ8=
Received: by mail-qt1-f170.google.com with SMTP id q41-v6so3536735qtq.10;
        Fri, 28 Sep 2018 15:09:15 -0700 (PDT)
X-Gm-Message-State: ABuFfogvlK+/Zrd7at+nN77bglEs6KV56Kfqi6sYK5sa3pWArM25wJsO
        LJhlQZNkn3/iezXZcr3V8pJtApVxf27fAA9PwA==
X-Google-Smtp-Source: ACcGV60hFKFRnTk0/nbtL5dmVTvlvFzfy8F65G/nPcUDndGSKj4026QkIjOyeyW12d+iuZRWpicx04xBNw5l+IrJXX0=
X-Received: by 2002:aed:3983:: with SMTP id m3-v6mr484695qte.164.1538172554449;
 Fri, 28 Sep 2018 15:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-46-robh@kernel.org>
In-Reply-To: <20180828015252.28511-46-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 17:09:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJfAsv-MOgk2Ycs2VBj2vK0m29B_3FxwJV5xUjnMbH4sg@mail.gmail.com>
Message-ID: <CAL_JsqJfAsv-MOgk2Ycs2VBj2vK0m29B_3FxwJV5xUjnMbH4sg@mail.gmail.com>
Subject: Re: [PATCH] tty: Convert to using %pOFn instead of device_node.name
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 8:55 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-serial@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/tty/ehv_bytechan.c                  | 12 ++++++------
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c |  8 ++++----
>  drivers/tty/serial/pmac_zilog.c             |  4 ++--
>  3 files changed, 12 insertions(+), 12 deletions(-)

Hey Greg, Is this still in your queue? Maybe you've just been extra
busy lately. ;)

Rob
>
> diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
> index eea4049b5dcc..769e0a5d1dfc 100644
> --- a/drivers/tty/ehv_bytechan.c
> +++ b/drivers/tty/ehv_bytechan.c
> @@ -128,8 +128,8 @@ static int find_console_handle(void)
>          */
>         iprop = of_get_property(np, "hv-handle", NULL);
>         if (!iprop) {
> -               pr_err("ehv-bc: no 'hv-handle' property in %s node\n",
> -                      np->name);
> +               pr_err("ehv-bc: no 'hv-handle' property in %pOFn node\n",
> +                      np);
>                 return 0;
>         }
>         stdout_bc = be32_to_cpu(*iprop);
> @@ -661,8 +661,8 @@ static int ehv_bc_tty_probe(struct platform_device *pdev)
>
>         iprop = of_get_property(np, "hv-handle", NULL);
>         if (!iprop) {
> -               dev_err(&pdev->dev, "no 'hv-handle' property in %s node\n",
> -                       np->name);
> +               dev_err(&pdev->dev, "no 'hv-handle' property in %pOFn node\n",
> +                       np);
>                 return -ENODEV;
>         }
>
> @@ -682,8 +682,8 @@ static int ehv_bc_tty_probe(struct platform_device *pdev)
>         bc->rx_irq = irq_of_parse_and_map(np, 0);
>         bc->tx_irq = irq_of_parse_and_map(np, 1);
>         if ((bc->rx_irq == NO_IRQ) || (bc->tx_irq == NO_IRQ)) {
> -               dev_err(&pdev->dev, "no 'interrupts' property in %s node\n",
> -                       np->name);
> +               dev_err(&pdev->dev, "no 'interrupts' property in %pOFn node\n",
> +                       np);
>                 ret = -ENODEV;
>                 goto error;
>         }
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> index 24a5f05e769b..ea7204d75022 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> @@ -1151,8 +1151,8 @@ static int cpm_uart_init_port(struct device_node *np,
>         if (!pinfo->clk) {
>                 data = of_get_property(np, "fsl,cpm-brg", &len);
>                 if (!data || len != 4) {
> -                       printk(KERN_ERR "CPM UART %s has no/invalid "
> -                                       "fsl,cpm-brg property.\n", np->name);
> +                       printk(KERN_ERR "CPM UART %pOFn has no/invalid "
> +                                       "fsl,cpm-brg property.\n", np);
>                         return -EINVAL;
>                 }
>                 pinfo->brg = *data;
> @@ -1160,8 +1160,8 @@ static int cpm_uart_init_port(struct device_node *np,
>
>         data = of_get_property(np, "fsl,cpm-command", &len);
>         if (!data || len != 4) {
> -               printk(KERN_ERR "CPM UART %s has no/invalid "
> -                               "fsl,cpm-command property.\n", np->name);
> +               printk(KERN_ERR "CPM UART %pOFn has no/invalid "
> +                               "fsl,cpm-command property.\n", np);
>                 return -EINVAL;
>         }
>         pinfo->command = *data;
> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> index 3d21790d961e..a4ec22d1f214 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c
> @@ -1566,9 +1566,9 @@ static int pmz_attach(struct macio_dev *mdev, const struct of_device_id *match)
>          * to work around bugs in ancient Apple device-trees
>          */
>         if (macio_request_resources(uap->dev, "pmac_zilog"))
> -               printk(KERN_WARNING "%s: Failed to request resource"
> +               printk(KERN_WARNING "%pOFn: Failed to request resource"
>                        ", port still active\n",
> -                      uap->node->name);
> +                      uap->node);
>         else
>                 uap->flags |= PMACZILOG_FLAG_RSRC_REQUESTED;
>
> --
> 2.17.1
>
