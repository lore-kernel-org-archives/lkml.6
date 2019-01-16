Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929AF206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="nmFSGF5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfAPALO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:11:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33100 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfAPALN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:11:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so5246216qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 16:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UWxkyK0epyPeU314jsRls3vNFn1c0AujvqZOvXdHDM=;
        b=nmFSGF5+YkIzhYrqbNwAkkJsJfCkjt4oSwtmOTJEido0I6J3ojm6ipVIn3MJdHxhJj
         9Y2FylhgPGO2V7mJzP3IEkPKSVPgOV1aPQlSW8YMod+NNBQsQAKUeVPrCFxov8y/aUTd
         bdfRFdh931J+3XUvq1oGcF3vvxbaV7504yAEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UWxkyK0epyPeU314jsRls3vNFn1c0AujvqZOvXdHDM=;
        b=ZRMqovgfuQzoW0p7MSWL14fnO6aungwbMo26Mtskq81cQmC0ltNeMkvM93JChNrFeh
         ZILHfZvapWXN5MwE012wWhAxdJuVnQnIR3pynNVUQ+SRyieobc30ARY1q3L0d/Gdg8kn
         HRKeG1T69wlwT55dxC87n6kkVIQh/FPjytXK2bR8ApW9RFERX3thqoyr2bXE3HGGtc05
         mqnY3ZstqIqbopSKJ8iMGdNGiYqlODSdqarOgy78HNh2Borl5ZD3q3TH9MGVIqKhW1kK
         e5WoDOguIRNnk/7NV1f2xqaQ4VxXHNnIkochvFyJVf+Ibkb0GMbmWx4JBXPkLUmvNs0y
         UHCw==
X-Gm-Message-State: AJcUukcA6czk0rkolVUJkPkNlVVLI+TP7d7RRvtHFk/xYrzhtJj2ZZlK
        l1ftrHG5nfosDMSki/Jtn7KaR4RVSeBg89XPYTWGjP2e5DI=
X-Google-Smtp-Source: ALg8bN4QOX2GrSFP9TsPFlPxQIvJb5FHhVnrwz3LVEvABZFa80Qz14Xsq6181xv66iH5XLoPQV3FbKMcbfw3EV3lghM=
X-Received: by 2002:a0c:e751:: with SMTP id g17mr5083778qvn.160.1547597472528;
 Tue, 15 Jan 2019 16:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20190115015146.2412785-1-vijaykhemka@fb.com>
In-Reply-To: <20190115015146.2412785-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Jan 2019 11:11:01 +1100
Message-ID: <CACPK8Xesi2tQzH1d=Ow6VucO3qo6ptosKb-WDi-Cw1vg5FXGzg@mail.gmail.com>
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: make memory-region optional
To:     Vijay Khemka <vijaykhemka@fb.com>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

On Tue, 15 Jan 2019 at 12:51, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Makiing memory-region as optional parameter in device tree if
> user needs to use memory-region then define in devicetree.

Thank you for finding the time to do this work. You're not the first
to be blocked by this limitation, but you are the first who found the
time to propose a patch.

I think we should complete the rework to make the flash device
optional too. Can you do a v2 with a proposal for that?

>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index a024f8042259..20507f0764fb 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -90,6 +90,10 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                 if (map.window_id != 0)
>                         return -EINVAL;
>
> +               /* If memory-region is not described in device tree */
> +               if (!lpc_ctrl->mem_size)
> +                       return -EINVAL;
> +
>                 map.size = lpc_ctrl->mem_size;
>
>                 return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
> @@ -129,6 +133,10 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                         addr = lpc_ctrl->pnor_base;
>                         size = lpc_ctrl->pnor_size;
>                 } else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
> +                       /* If memory-region is not described in device tree */
> +                       if (!lpc_ctrl->mem_size)

Should it print a message here? I think a dev_dbg makes sense.

> +                               return -EINVAL;
> +
>                         addr = lpc_ctrl->mem_base;
>                         size = lpc_ctrl->mem_size;
>                 } else {
> @@ -214,22 +222,20 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>
>         dev_set_drvdata(&pdev->dev, lpc_ctrl);
>
> +       /* If memory-region is described in device tree then store */
>         node = of_parse_phandle(dev->of_node, "memory-region", 0);
> -       if (!node) {
> -               dev_err(dev, "Didn't find reserved memory\n");
> -               return -EINVAL;
> -       }
> +       if (node) {

Print a debug message when we didn't find the node.

> +               rc = of_address_to_resource(node, 0, &resm);
> +               of_node_put(node);
> +               if (rc) {
> +                       dev_err(dev, "Couldn't address to resource for reserved memory\n");
> +                       return -ENOMEM;
> +               }
>
> -       rc = of_address_to_resource(node, 0, &resm);
> -       of_node_put(node);
> -       if (rc) {
> -               dev_err(dev, "Couldn't address to resource for reserved memory\n");
> -               return -ENOMEM;
> +               lpc_ctrl->mem_size = resource_size(&resm);
> +               lpc_ctrl->mem_base = resm.start;
>         }
>
> -       lpc_ctrl->mem_size = resource_size(&resm);
> -       lpc_ctrl->mem_base = resm.start;
> -
>         lpc_ctrl->regmap = syscon_node_to_regmap(
>                         pdev->dev.parent->of_node);
>         if (IS_ERR(lpc_ctrl->regmap)) {

Down below here is this line:

>        dev_info(dev, "Loaded at %pr\n", &resm);

As resm is first used for the flash resource and then the memory
region, it will display the location of the flash when the memory
region is not present. This is confusing. You should either print out
the regions separately, or consider removing this dev_info completely.

> --
> 2.17.1
>
