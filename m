Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CBAC46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAC2214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox+Ov+Y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAC2214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJKA7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbeJKA7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:59:44 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E872082B;
        Wed, 10 Oct 2018 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539192993;
        bh=payLvY5X4fC6xFTJ0QA/lTT1nD1AkdMFp/wzJSwbpNw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ox+Ov+Y1KPdleiuiM1RnQz03sSOj1FjSDjRO17VBAK6aCTLfEaJyob5zG/cMz9kSQ
         ikJNGgleBh3CZs0m5N5xc7iWXcaAlnF61PBkZ63vTrOlNBMZNSWJYNdnUwH9vg9B+9
         B1or1ynbCtDZG1LZTu5QxRGsuGI+/Q17XZ/8iiTA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180914153421.7090-1-gregory.clement@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20180914153421.7090-1-gregory.clement@bootlin.com>
Message-ID: <153919299293.119890.9655297515756412545@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: mvebu: armada-37xx-tbg: Balance devm_clk_get in probe
Date:   Wed, 10 Oct 2018 10:36:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-09-14 08:34:21)
> The parent clock is get only to have its name, and then the clock is no
> more used, so we can safely free it using devm_clk_put.
> =

> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/clk/mvebu/armada-37xx-tbg.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/arma=
da-37xx-tbg.c
> index 71f30149e80e..caaa91a41683 100644
> --- a/drivers/clk/mvebu/armada-37xx-tbg.c
> +++ b/drivers/clk/mvebu/armada-37xx-tbg.c
> @@ -102,6 +102,7 @@ static int armada_3700_tbg_clock_probe(struct platfor=
m_device *pdev)
>                 return -EINVAL;
>         }
>         parent_name =3D __clk_get_name(parent);
> +       devm_clk_put(dev, parent);

So then why use devm_clk_get()? Please replace both so tha
devm_clk_put() doesn't need to be used..

>  =

>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         reg =3D devm_ioremap_resource(dev, res);
