Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C530ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10EB2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0lATk4k+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10EB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJSEZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbeJSEZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:25:25 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39F02098A;
        Thu, 18 Oct 2018 20:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539894165;
        bh=Cp1vWvodqUJ2SludGUJDRiO4xD4RlIkFUGNPaQ0UzJQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=0lATk4k+etLGlCBEJ7xzDqShDwmBwnjiuCdwBmHpg7jCrffHVqeA2O3E1eMDGEV4L
         AawrA+0UDhEjx5y4tSJxbbko0SFifbqpWW3CNo1D1tICQ3oFv+iwrye0eG9/k33pxk
         yh1ov6QJTd7GvJpS65YD9eqJZk513V1AOx6MzP54=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alan Tull <atull@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181018195411.3449-1-atull@kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Alan Tull <atull@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181018195411.3449-1-atull@kernel.org>
Message-ID: <153989416422.53599.5865157270835783532@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: fixed-rate: fix of_node_get-put imbalance
Date:   Thu, 18 Oct 2018 13:22:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Tull (2018-10-18 12:54:11)
> When the fixed rate clock is created by devicetree,
> of_clk_add_provider is called.  Add a call to
> of_clk_del_provider in the remove function to balance
> it out.
> =

> Signed-off-by: Alan Tull <atull@kernel.org>
> ---

Fixes tag? I'll tack one on.

>  drivers/clk/clk-fixed-rate.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> index b5c46b3f8764..6d6475c32ee5 100644
> --- a/drivers/clk/clk-fixed-rate.c
> +++ b/drivers/clk/clk-fixed-rate.c
> @@ -200,6 +200,7 @@ static int of_fixed_clk_remove(struct platform_device=
 *pdev)
>  {
>         struct clk *clk =3D platform_get_drvdata(pdev);
>  =

> +       of_clk_del_provider(pdev->dev.of_node);
>         clk_unregister_fixed_rate(clk);
>  =

>         return 0;
