Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF06C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5D620818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf4PMi1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5D620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeKJCxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeKJCxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:53:46 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 325C920818;
        Fri,  9 Nov 2018 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541783537;
        bh=eQYW/0sECoOUchB0kgzicyHU4OR/etvZrEpPsp6yiBU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Sf4PMi1AB1D8/LpZbdeWSgkmSCglG4ZEno3SXL9hruIB1dQr+iOodcMDuuRQ7zapd
         vS+B5LtQU82SzqnCJg/ETK/a1uhV9DDX+pW/ldcqYy8fbQFmJUMqH+KWNyzzZKm2Tf
         2IueODkJRYJ0fN6Wdn1ux4B+d104yRgdCXr95yzc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181109095054.13924-1-vkoul@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181109095054.13924-1-vkoul@kernel.org>
Message-ID: <154178353645.88331.795912528906051068@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: gcc: Fix board clock node name
Date:   Fri, 09 Nov 2018 09:12:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2018-11-09 01:50:54)
> Device tree node name are not supposed to have "_" in them so fix the
> node name use of xo_board to xo-board
> =

> Fixes: 652f1813c113 ("clk: qcom: gcc: Add global clock controller driver =
for QCS404")
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> =

> Steve: RobH pointed this on DTS patches, would be great if you can pick t=
his
> as a fix

Ok.

> =

>  drivers/clk/qcom/gcc-qcs404.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> index e4ca6a45f313..ef1b267cb058 100644
> --- a/drivers/clk/qcom/gcc-qcs404.c
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -265,7 +265,7 @@ static struct clk_fixed_factor cxo =3D {
>         .div =3D 1,
>         .hw.init =3D &(struct clk_init_data){
>                 .name =3D "cxo",
> -               .parent_names =3D (const char *[]){ "xo_board" },
> +               .parent_names =3D (const char *[]){ "xo-board" },

We have xo_board used everywhere else in drivers/clk/qcom/ so this makes
me concerned. Wouldn't a better answer be to add clock-output-names to
the xo-board DT node and have arm-soc merge that through. I mostly want
to keep things consistent here so that if we need to inject an xo_board
clk into the system then we can do so generically instead of making it
per-platform. Of course, if we're never going to have this problem on
qcs404 then it will be fine to start differing here. So I'm leaning
towards merge this patch, just please ack my concern here and tell me it
won't be a problem and I'll be happy to merge to clk-fixes.

BTW, can you also specify a 'clocks' property in the GCC node and send
the xo_board node there? In fact, we should do that for every GCC node
in the tree. Care to do that and also add sleep_clk to each clock
controller node that uses it? This is useful to do so that we can more
easily see where clocks are going between clock controller nodes.

