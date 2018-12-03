Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBE72082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb9rGxRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBE72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeLCQNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeLCQNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:13:23 -0500
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com [209.85.161.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55E8F208A3;
        Mon,  3 Dec 2018 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543853596;
        bh=CoOQvEve5ucSkdY9B16go4oJlZd2FaSD3tcs929fKSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pb9rGxRxV7iKQCT79+S4lQrnU6ZetWHWhPZvJv0oHm46fGR4kJNT8hE8nDKY9co5f
         +bQJsVmknKg9WbwkFoXDi+I9IZjz++LddAfgHawfkM0JqTzE8hZ/F3ZPvQgLNNh2IP
         yTZqN8rgZ9h7NOTlpKCGIHkS1uVrE2245uEIO/F0=
Received: by mail-yw1-f47.google.com with SMTP id l200so5587359ywe.10;
        Mon, 03 Dec 2018 08:13:16 -0800 (PST)
X-Gm-Message-State: AA+aEWYoDgfJQgPqglLhhX4xkQABlxs2TlL6hbH5i3vd6pXupu9eYs1w
        gbfPjs/qTPQ1PFxbecLP2ARkf1geJHOiYCzNwIo=
X-Google-Smtp-Source: AFSGD/UP85XWMCmfvQTb5KgZGVerB7YJCHpDVKdjYodS9fJ11TXZTaWbO5h81PUhH97+iOPwFPK//pmnUSGuy/BTHDc=
X-Received: by 2002:a81:5984:: with SMTP id n126mr15855088ywb.433.1543853595331;
 Mon, 03 Dec 2018 08:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20181203122145.1534-1-nsaenzjulienne@suse.de>
In-Reply-To: <20181203122145.1534-1-nsaenzjulienne@suse.de>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 3 Dec 2018 10:12:39 -0600
X-Gmail-Original-Message-ID: <CANk1AXRxUai9SmSFt1uMXVRcoumh+ziKCi8WHb2tCG5Wx4Txow@mail.gmail.com>
Message-ID: <CANk1AXRxUai9SmSFt1uMXVRcoumh+ziKCi8WHb2tCG5Wx4Txow@mail.gmail.com>
Subject: Re: [PATCH] fpga: stratix10-soc: fix wrong of_node_put() in init function
To:     nsaenzjulienne@suse.de
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 6:22 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:

Hi Nicolas,

Thanks for catching this!  I'll fix up one formatting thing (below).

>
> After finding a "firmware" dt node stratix10 tries to match it's
> compatible string with it. To do so it's calling of_find_matching_node()
> which already takes care of decreasing the refcount on the "firmware"
> node. We are then incorrectly decreasing the refcount on that node
> again.
>
> This patch removes the unwarranted call to of_node_put().
>
> Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Alan Tull <atull@kernel.org>

> ---
>  drivers/fpga/stratix10-soc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index a1a09e04fab8..e75dbe583152 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -509,13 +509,11 @@ static int __init s10_init(void)
>
>         np = of_find_matching_node(fw_np, s10_of_match);
>         if (!np) {
> -               of_node_put(fw_np);
>                 return -ENODEV;
>         }

We don't need the brackets anymore around the return statement.  I'll fix it up.

Thanks,
Alan

>
>         of_node_put(np);
>         ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
> -       of_node_put(fw_np);
>         if (ret)
>                 return ret;
>
> --
> 2.19.2
>
