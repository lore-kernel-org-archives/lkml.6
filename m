Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3755EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094982070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550859157;
	bh=LjMXoNtcXYUdEOY3ueVHbXKeT7w1E5goTW+q5BHQ3Bc=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=Ek9R3FSWekm5PqJAUtnc/mmPspzSKiiyXtprklknC3u/JV5A8/SYqFs+Ke4ppU5UH
	 BQIxssPHD1bjevrcRichc89hbIQzvRzqq9r+moAIMSCogpYWORbpq3bv5W/dLa7YxA
	 9PyHiK6nh4sbEa+DX680HKahuOMp9PTS2S//w9Ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfBVSMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:12:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfBVSMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:12:35 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B909206B6;
        Fri, 22 Feb 2019 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550859154;
        bh=LjMXoNtcXYUdEOY3ueVHbXKeT7w1E5goTW+q5BHQ3Bc=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=D4o2np/8wAIqY/xnEO//3DssQfk9LiQyqN1Oi6ZiIzmf92/olWsKS1WmIr8GtDy+t
         AEWfLhzsr3t4cPTXVjZVc1gggpFd3UDQqTYMrOKIzokxq8+kWj1OOxCGpQ8/xK9Vjy
         t8RbFaI32zPDiM4SvN4alme5PUU8Yrzafo7dox5M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 08/14] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Message-ID: <155085915374.77512.3766517034394591147@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1548700381-22376-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548700381-22376-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
To:     andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        david.brown@linaro.org, enric.balletbo@collabora.com,
        heiko@sntech.de, horms+renesas@verge.net.au,
        jagan@amarulasolutions.com, jassisinghbrar@gmail.com,
        jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, olof@lixom.net, robh+dt@kernel.org,
        sibis@codeaurora.org, will.deacon@arm.com
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Date:   Fri, 22 Feb 2019 10:12:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:55)
> When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
> to keep the software model of the clock in line with reality, the
> framework transverses the clock tree and disables those clocks that
> were enabled by the firmware but have not been enabled by any device
> driver.
>=20
> If CPUFREQ is enabled, early during the system boot, it might attempt
> to change the CPU frequency ("set_rate"). If the HFPLL is selected as
> a provider, it will then change the rate for this clock.
>=20
> As boot continues, clk_disable_unused_subtree will run. Since it wont
> find a valid counter (enable_count) for a clock that is actually
> enabled it will attempt to disable it which will cause the CPU to
> stop. Notice that in this driver, calls to check whether the clock is
> enabled are routed via the is_enabled callback which queries the
> hardware.
>=20
> The following commit, rather than marking the clock critical and
> forcing the clock to be always enabled, addresses the above scenario
> making sure the clock is not disabled but it continues to rely on the
> firmware to enable the clock.
>=20
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/clk/qcom/hfpll.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
> index 0ffed0d..9d92f5d 100644
> --- a/drivers/clk/qcom/hfpll.c
> +++ b/drivers/clk/qcom/hfpll.c
> @@ -58,6 +58,7 @@ static int qcom_hfpll_probe(struct platform_device *pde=
v)
>                 .parent_names =3D (const char *[]){ "xo" },
>                 .num_parents =3D 1,
>                 .ops =3D &clk_ops_hfpll,
> +               .flags =3D CLK_IGNORE_UNUSED,

Please put some sort of similar comment in the code so we can find it
without git history digging.

