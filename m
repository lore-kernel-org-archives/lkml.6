Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D0EC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15C620844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wF5Nr81j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15C620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbeGZAiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731737AbeGZAiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:38:52 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B888F20833;
        Wed, 25 Jul 2018 23:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532561095;
        bh=uvZ7fZHbqsWGhawbu10rs+Q1Cz7f0vMIT1wTfTdEbxg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=wF5Nr81jR00ojVQoIJaiW9PQPVWnvWlIkYkKGEmPN+vWH2toYSMm5zxejii3O2NKP
         agfsVv5H2bAbVIkgWwkRxVAeNKv9B6rqNebez4W3YxsCVJodBgk8pibDeMmo3VZttW
         LZoQCK4xLSfuztNwV8NvMTuRo/2Kwj1HvgGpGlAY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180720075422.26563-1-marcel@ziswiler.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
References: <20180720075422.26563-1-marcel@ziswiler.com>
Message-ID: <153256109511.48062.12389268791907553857@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: tegra: probe deferral error reporting
Date:   Wed, 25 Jul 2018 16:24:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marcel Ziswiler (2018-07-20 00:54:22)
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> =

> Actually report the error code from devm_regulator_get() which may as
> well just be a probe deferral.
> =

> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> =

> ---
> =

>  drivers/clk/tegra/clk-dfll.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index 48ee43734e05..b2123084e175 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -1609,8 +1609,9 @@ int tegra_dfll_register(struct platform_device *pde=
v,
>  =

>         td->vdd_reg =3D devm_regulator_get(td->dev, "vdd-cpu");
>         if (IS_ERR(td->vdd_reg)) {
> -               dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
> -               return PTR_ERR(td->vdd_reg);
> +               ret =3D PTR_ERR(td->vdd_reg);
> +               dev_err(td->dev, "couldn't get vdd_cpu regulator: %d\n", =
ret);

Do you want to know that a probe defer is happening? Usually patches are
sent to make that error path silent.

