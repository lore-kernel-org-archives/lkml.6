Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6FCE4C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F21208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F21208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754890AbeFNI2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:28:02 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39791 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeFNI2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:28:00 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so3557159uad.6;
        Thu, 14 Jun 2018 01:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zmFiVTAdeeFAuLqoGVcqozHuHDGvzcssJavB6QZC7k=;
        b=CoglGvcyCXJpwt8eGs2kHXNehkQqa2/utlKkvVEynXTe6vd1jE/ejFbDl4VLLsP1KY
         1nshpXgT3MH72N5kIhGOzmujG2R/MdEJrNNohhi4gwmmVSuMGOwsJi2ZLRctGsVVz5VF
         TDykzo1m5zaLlB5hKfm9L9ev6zPd3QZV/rR66EM1IVDBDExDxPrtkZnuQvwkSpQHsQAT
         SsqlS69ybtTcJLtnjOJ2+1r6T9Z4R8D7VrLCPNNCAX4y9K37+nUvtxOMGpwu87SiiOAU
         sMrvxIikXJGbRkcBFbhgMkM0/KfwYuo24QaRirX3Jf1zVAj80JWm9uANb0DxLTOfy26V
         yMmw==
X-Gm-Message-State: APt69E1vIgQndcl8eAOFD5X/rwGT11JzEaQLrDO38vj+PhD4t/ynb7XJ
        Iq+7pfMeFJdOBQ2vjuqYyXzjhMuL3ZCuaA6SNEFPM16F
X-Google-Smtp-Source: ADUXVKIi8pPl1avWyYFaXWmsUWXC0lcKwshkVnwdWHOjKa2OV/ZPjs8dkxxMly9zgAxejlpCq8AdBNRtVidxo3lHZHo=
X-Received: by 2002:ab0:5105:: with SMTP id e5-v6mr1100387uaa.33.1528964879734;
 Thu, 14 Jun 2018 01:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
In-Reply-To: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Jun 2018 10:27:47 +0200
Message-ID: <CAMuHMdVixknUDYZUHafCqNY02z=T-WC2s+Qh6GkpejmoJU0fuQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

(the "m68k" later in the thread caught my attention ;-)

On Tue, Jun 12, 2018 at 2:02 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> There are still quite a few cases where a device might want to get to a
> different node of the device-tree, obtain the resources and map them.
>
> Drivers doing that currently open code the whole thing, which is error
> proe.
>
> We have of_iomap() and of_io_request_and_map() but they both have shortcomings,
> such as not returning the size of the resource found (which can be necessary)
> and not being "managed".
>
> This adds a devm_of_iomap() that provides all of these and should probably
> replace uses of the above in most drivers.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks for your patch!

> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -40,6 +40,11 @@ extern void __iomem *of_iomap(struct device_node *device, int index);
>  void __iomem *of_io_request_and_map(struct device_node *device,
>                                     int index, const char *name);
>
> +/* Request and map, wrapper on devm_ioremap_resource */
> +extern void __iomem *devm_of_iomap(struct device *dev,
> +                                  struct device_node *node, int index,
> +                                  resource_size_t *size);
> +
>  /* Extract an address from a device, returns the region size and
>   * the address space flags too. The PCI version uses a BAR number
>   * instead of an absolute index

Do you need a dummy for !CONFIG_OF_ADDRESS, to aid compile-testing?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
