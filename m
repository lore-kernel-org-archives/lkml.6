Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FACDC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33B920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfXziU31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33B920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbeGZBAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731550AbeGZBAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:00:01 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4969C20843;
        Wed, 25 Jul 2018 23:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532562359;
        bh=ZK1YxzdIyuHaHauPzyoL95HWVxcbMhzmtGYWDaIDi9c=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=NfXziU31s5VyO7V7W9gwzdZUOtyhqw8J9Zv087TP3bWSr7aVOCWPs5pJUz1e2P/qd
         hrvufAklW9p9H3oK4TR/1N0vOwZm2NQzaQAWJft4oyyXmyX6dICVdIMcc0HwhWyB0J
         84StkVk5anBAdR7O0Nj0rpsngUYpvrxbfoAukM4E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180719015845.GA10768@embeddedor.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20180719015845.GA10768@embeddedor.com>
Message-ID: <153256235859.48062.6895683993866147909@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] reset: hisilicon: fix potential NULL pointer dereference
Date:   Wed, 25 Jul 2018 16:45:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2018-07-18 18:58:45)
> There is a potential execution path in which function
> platform_get_resource() returns NULL. If this happens,
> we will end up having a NULL pointer dereference.
> =

> Fix this by adding asanity check in order to avoid a
> NULL pointer dereference.
> =

> This code was detected with the help of Coccinelle.
> =

> Cc: stable@vger.kernel.org
> Fixes: 97b7129cd2af ("reset: hisilicon: change the definition of hisi_res=
et_init")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/clk/hisilicon/reset.c | 3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
> index 2a5015c..5dfb48b 100644
> --- a/drivers/clk/hisilicon/reset.c
> +++ b/drivers/clk/hisilicon/reset.c
> @@ -109,6 +109,9 @@ struct hisi_reset_controller *hisi_reset_init(struct =
platform_device *pdev)
>                 return NULL;
>  =

>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return NULL;
> +
>         rstc->membase =3D devm_ioremap(&pdev->dev,
>                                 res->start, resource_size(res));

Why can't we use devm_ioremap_resource() here instead?

