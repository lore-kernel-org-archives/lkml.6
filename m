Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAE0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D5620675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547656651;
	bh=0E8482UkW9G/eNFSVcOQ9clPk1Mh0QWM7J0ZBRY6xGo=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=KG3zeV41MLo/oGtXwey/dZcm7kscwlf5j/jfyLy6vJ2VvtW8SxZA5wPBtvwQ56h24
	 xtEJrun0algfqfrrgvJPwte8g9wJ4N3gyZs1EkeYpSjikDcge9i+2sH0HrhoOpYn8E
	 UpaZk1Kc0Gf4O41T80zzGHD6DGg7JFxO8sT1lNhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393883AbfAPQh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:37:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfAPQh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:37:28 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AA7220657;
        Wed, 16 Jan 2019 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547656647;
        bh=0E8482UkW9G/eNFSVcOQ9clPk1Mh0QWM7J0ZBRY6xGo=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=o3jDF7qle1YpwxzRG8WWn+0wkNIreblaKhq2B7jUfYftpOlmqWzqGNJDcGPxb7+mN
         xv3iCDcW15wc5jHgA3vNhuAduoJVgFB2oveKrzoS8mCIbHTc0HTUd4HY2ZAPQnycly
         D6tkMAdh5+zq9k1nOLVbFzMZKq8vKg8/BPmcVG8k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: mmp2: avoid disabling the SP clock when unused
User-Agent: alot/0.8
In-Reply-To: <20190116093505.1920945-1-lkundrak@v3.sk>
References: <20190116093505.1920945-1-lkundrak@v3.sk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <154765664632.169631.9344557684702266461@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 16 Jan 2019 08:37:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-01-16 01:35:05)
> There could be vital functionality running on the SP PJ1 core it can not =
be
> restarted just by turning the clock back on.
>=20
> On the OLPC laptop, the keyboard controller code runs there. It
> wouldn't be possible to load the driver for it as a module if the clock
> is disabled on boot.
>=20
> Cc: stable@vger.kernel.org # v4.18+
> Fixes: commit fc27c2394d96 ("clk: mmp2: add SP clock")
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/clk/mmp/clk-of-mmp2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
> index f2a1c9bbaa63..3e33f1295f59 100644
> --- a/drivers/clk/mmp/clk-of-mmp2.c
> +++ b/drivers/clk/mmp/clk-of-mmp2.c
> @@ -246,7 +246,7 @@ static struct mmp_param_gate_clk apmu_gate_clks[] =3D=
 {
>         {MMP2_CLK_CCIC1, "ccic1_clk", "ccic1_mix_clk", CLK_SET_RATE_PAREN=
T, APMU_CCIC1, 0x1b, 0x1b, 0x0, 0, &ccic1_lock},
>         {MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SET_RA=
TE_PARENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
>         {MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK_SET=
_RATE_PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
> -       {MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT, APMU_SP, 0x1b,=
 0x1b, 0x0, 0, &sp_lock},
> +       {MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT | CLK_IGNORE_UN=
USED, APMU_SP, 0x1b, 0x1b, 0x0, 0, &sp_lock},

Is it a critical clk that should never be turned off? If so, mark it as
CLK_IS_CRITICAL. Either way, please add a comment in the code about why
CLK_IGNORE_UNUSED or CLK_IS_CRITICAL is used.

