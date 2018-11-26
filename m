Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A25C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB9D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fwTz4Q08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB9D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeK0BKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:10:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33788 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeK0BKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:10:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so16726836otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKbLK+6EzXG6TUg5/RxPXpDuZAYgqiDdu+HBYlQmgjk=;
        b=fwTz4Q08Vhdnd1iOq5qedCwmlZZiKYJEk5nHvvodQGXjtpcok2CoHbrW1yWGCDLJOS
         j2Cdc85uzC/bH57MO1nNjSrxUl04iX7HhyMvU6dXLZv89aOm68gK6C/6/wCA8SN2uKzW
         v3usiMbqqhdeOHX3b126iy6c+TEl3WdC9bg58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKbLK+6EzXG6TUg5/RxPXpDuZAYgqiDdu+HBYlQmgjk=;
        b=QPU9jkZ/OjsXMTQF+4OW1/w1AqPJILCWFJAuxCHc44n/31at7NW1INwOv8+qK3l1Ut
         sV79247XC5L4nPrPXIC3SmJHGqIUfUvSYbfMHjjIEbW594IujbA6W1JeXhS2DdOdt483
         dBxLzf274c8WzxbuadM0/m36gXDmPPD+pIk29aq+5wshTRy0wFPEBth5XjmjgjtuEDrz
         A/pdtEmAkwhhjl2VebCgcZdBRf8uOls2TX977SKA6i3ADa4HKdQWPHkg8c4hHZbXxsfk
         rnP/iAZoPksJMm2qM10H7V1nTozcqe2u0lfOcjNOqmi/cRJCEZvVnfo3Uo6/YQZmFMOE
         8kMw==
X-Gm-Message-State: AA+aEWbGHZ2HQqX/UhCGgS4jIsk1PxkBB1j3lZG7cFWjX9PRrNzi3xaF
        b/g4d3x1H/xQ59s69sKTG2Spt3xfKvj/EmegV3ggDw==
X-Google-Smtp-Source: AFSGD/Ww0PP63N94Ta2tdYRzyVplBAVGkD5yf7oj0605sJYOe4MQUwCUXomXICgMMGtxcTUzQ3tUa85QcYbwpTUQtu8=
X-Received: by 2002:a05:6830:13d7:: with SMTP id e23mr15744825otq.2.1543241787075;
 Mon, 26 Nov 2018 06:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20181126105050.592727680@linuxfoundation.org> <20181126105054.941598787@linuxfoundation.org>
In-Reply-To: <20181126105054.941598787@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 26 Nov 2018 19:46:15 +0530
Message-ID: <CA+G9fYsyM9VS8QkaEizQT_LSvZyT+h6zdoWZbhVQtd1n60Bniw@mail.gmail.com>
Subject: Re: [PATCH 4.14 58/62] mtd: rawnand: atmel: fix OF child-node lookup
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        nicolas.ferre@microchip.com, rainyfeeling@outlook.com,
        boris.brezillon@bootlin.com, johan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you see build failure arm x15 beagleboard on 4.14 due to this patch ?

On Mon, 26 Nov 2018 at 16:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Johan Hovold <johan@kernel.org>
>
> commit 5d1e9c2212ea6b4dd735e4fc3dd6279a365d5d10 upstream.
>
> Use the new of_get_compatible_child() helper to lookup the nfc child
> node instead of using of_find_compatible_node(), which searches the
> entire tree from a given start node and thus can return an unrelated
> (i.e. non-child) node.
>
> This also addresses a potential use-after-free (e.g. after probe
> deferral) as the tree-wide helper drops a reference to its first
> argument (i.e. the node of the device being probed).
>
> While at it, also fix a related nfc-node reference leak.
>
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Cc: stable <stable@vger.kernel.org>     # 4.11
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Josh Wu <rainyfeeling@outlook.com>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  drivers/mtd/nand/atmel/nand-controller.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> --- a/drivers/mtd/nand/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/atmel/nand-controller.c
> @@ -2077,8 +2077,7 @@ atmel_hsmc_nand_controller_legacy_init(s
>         int ret;
>
>         nand_np = dev->of_node;
> -       nfc_np = of_find_compatible_node(dev->of_node, NULL,
> -                                        "atmel,sama5d3-nfc");
> +       nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
>         if (!nfc_np) {
>                 dev_err(dev, "Could not find device node for sama5d3-nfc\n");
>                 return -ENODEV;
> @@ -2492,15 +2491,19 @@ static int atmel_nand_controller_probe(s
>         }
>
>         if (caps->legacy_of_bindings) {
> +               struct device_node *nfc_node;
>                 u32 ale_offs = 21;
>
>                 /*
>                  * If we are parsing legacy DT props and the DT contains a
>                  * valid NFC node, forward the request to the sama5 logic.
>                  */
> -               if (of_find_compatible_node(pdev->dev.of_node, NULL,
> -                                           "atmel,sama5d3-nfc"))
> +               nfc_node = of_get_compatible_child(pdev->dev.of_node,
> +                                                  "atmel,sama5d3-nfc");
> +               if (nfc_node) {
>                         caps = &atmel_sama5_nand_caps;
> +                       of_node_put(nfc_node);
> +               }
>
>                 /*
>                  * Even if the compatible says we are dealing with an
>
>

/drivers/mtd/nand/atmel/nand-controller.c: In function
'atmel_hsmc_nand_controller_legacy_init':
/drivers/mtd/nand/atmel/nand-controller.c:2080:11: error: implicit
declaration of function 'of_get_compatible_child'; did you mean
'of_get_next_available_child'? [-Werror=implicit-function-declaration]
   nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
            ^~~~~~~~~~~~~~~~~~~~~~~
            of_get_next_available_child
 /drivers/mtd/nand/atmel/nand-controller.c:2080:9: warning: assignment
makes pointer from integer without a cast [-Wint-conversion]
   nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
          ^
 /drivers/mtd/nand/atmel/nand-controller.c: In function
'atmel_nand_controller_probe':
 /drivers/mtd/nand/atmel/nand-controller.c:2501:12: warning:
assignment makes pointer from integer without a cast
[-Wint-conversion]
    nfc_node = of_get_compatible_child(pdev->dev.of_node,
             ^

Full build log link,
https://ci.linaro.org/job/openembedded-lkft-linux-stable-rc-4.14/DISTRO=rpb,MACHINE=am57xx-evm,label=docker-lkft/336/consoleFull

Best regards
Naresh Kamboju
