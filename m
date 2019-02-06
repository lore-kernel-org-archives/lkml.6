Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7283C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8402C2080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549482013;
	bh=XopYzYf3s1Zy0ZBiBCEL0/QigrtYkhisrvuFBbSdzG8=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=XMzxw5g/DEVVbCXtD6W1hzmUWiJBnqP2u8dZ5aG7XzqZ75eBrjbqNJjGI482CqHf0
	 vzaKO7VALaYKsWjZWyUPvNv43k0M2Q5Z+eYqyqU0NYzakC305wcsVH8YS7zRm+rl2s
	 aXtL2lFd0FMojr9P1W2PoXVFPfo9cB7Cb+7G5Zqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBFTkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfBFTkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:40:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 965A12080D;
        Wed,  6 Feb 2019 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549482009;
        bh=XopYzYf3s1Zy0ZBiBCEL0/QigrtYkhisrvuFBbSdzG8=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=dCbjH+X+tGQ8v/v5Vcgm8mY8bOmgVDL83jTqX6b0vApkIwUmi+LkQ9ScYqJZFaP0z
         MM1ffw5o+eLE3kyLzX3SLEi2xTDijbTCIsdDdhleP1o8/3NstQs124xaop7uyZRUTz
         nflV+3jtIkgSkqkFIHJ6ACkEKD7A6IbldTcLc4tg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
In-Reply-To: <20190130235022.21949-1-katsuhiro@katsuster.net>
User-Agent: alot/0.8
Subject: Re: [PATCH] clk: fractional-divider: check parent rate only for general approximation
Message-ID: <154948200879.115909.2117234752247335645@swboyd.mtv.corp.google.com>
References: <20190130235022.21949-1-katsuhiro@katsuster.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 06 Feb 2019 11:40:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Heiko because it mentions Rockchip

Quoting Katsuhiro Suzuki (2019-01-30 15:50:22)
> Custom approximation of fractional-divider may not need parent clock
> rate checking. For example Rockchip SoCs work fine using grand parent
> clock rate even if target rate is greater than parent.
>=20
> This patch removes parent clock rate check from custom approximation.
>=20
> For detailied example, clock tree of Rockchip I2S audio hardware.

s/detailied/detailed/

>   - A i2s1_div is integer divider can divide input clock 1/1 ~ 1/16.
>     Initialize divider value is 1.

s/Initialize/Initial/

>   - A i2s1_frac is fractional divider can divide input to x/y, x and
>     y are 16bit integer.
>   - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.
>=20
> CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK
> GPLL --> |          | ,--------------'    |          |
>                       `--> i2s1_frac ---> |          |
>=20
> Clock mux system try to choose suitable one from i2s1_div and
> i2s1_frac for master clock (MCLK) of I2S1.
>=20
> Bad scenario as follows:
>   - Try to set MCLK to 8.192MHz (32kHz audio replay)
>     Candidate setting is
>     - i2s1_div : GPLL / 60           =3D 8.192MHz
>     i2s1_div is same as target clock rate, so mux choose this.
>     i2s1_div output rate is changed 491.52MHz -> 8.192MHz
>=20
>   - After that try to set to 11.2896MHz (44.1kHz audio replay)
>     Candidate settings are
>     - i2s1_div : CPLL / 107 =3D 11.214945MHz
>     - i2s1_frac: i2s1_div   =3D 8.192MHz
>       This is because clk_fd_round_rate() thinks target rate
>       (11.2896MHz) is higher than parent rate (i2s1_div =3D 8.192MHz)
>       and returns parent clock rate.
>     Clock mux system choose i2s1_div, but this clock rate is not
>     acceptable for I2S driver, so users cannot replay audio.
>=20
> Expected behavior is:
>   - Try to set master clock to 11.2896MHz (44.1kHz audio replay)
>     Candidate settings are
>     - i2s1_div : CPLL / 107          =3D 11.214945MHz
>     - i2s1_frac: i2s1_div * 147/6400 =3D 11.2896MHz
>                  (change i2s1_div to GPLL / 1 =3D 491.52MHz)
>       If apply this commit, clk_fd_round_rate() calls custom
>       approximate function of Rockchip even if target rate is higher
>       than parent. Custom function changes both grand parent
>       (i2s1_div) and parent (i2s_frac) settings at same time.

Can you indicate what that function is? Is this merged upstream or
something you're developing now?

>     Clock mux system can choose i2s1_frac and audio works fine.

I think this last paragraph from "If apply this commit" can be
unindented from the expected behavior section.

>=20
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  drivers/clk/clk-fractional-divider.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fract=
ional-divider.c
> index 545dceec0bbf..b0fc5509e0ff 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsi=
gned long rate,
>         unsigned long m, n;
>         u64 ret;
> =20
> -       if (!rate || rate >=3D *parent_rate)
> +       if (!rate)
>                 return *parent_rate;

Ok. I think it would be clearer if we had

	unsigned long flags =3D clk_hw_get_flags()

	if (!rate ||
	    !(flags & CLK_SET_PARENT_RATE) && rate >=3D *parent_rate)

indicating that the parent of the clk isn't expected to change rate so
we can only achieve that much frequency. Plus some sort of comment to
this effect would be helpful too.

We could also introduce macros to check clk flags. Then it would read
nicer:

	if (!rate || clk_hw_can_set_parent_rate(hw) && rate >=3D ...)

