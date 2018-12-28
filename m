Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EFFC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60546218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546036038;
	bh=dyNMuDweaydd0HjxdrP8GOFlbrOFXiI/i9SdCW3y25E=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=bVVEgy+ao+qr9ohhJJ/wWQVMMN5MdptAQW8udxxyZqGRNepj5zA6VI+RWx/PKYRPP
	 BpMU7OuFQwyxVZ28LxF6rH9vQcdj7Wsk4nVB5GAa8Tg/kd2qxEGW2ELMVOj2twmRR7
	 Ak8dcdO7+VvzbtG4RVlOV6GOkD5zIII9Jsmz1SZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeL1W1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:27:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeL1W1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:27:17 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC461206C0;
        Fri, 28 Dec 2018 22:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546036036;
        bh=dyNMuDweaydd0HjxdrP8GOFlbrOFXiI/i9SdCW3y25E=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=tIgcdk8jTBzT0g2OHv6ArERZ/KlOGQy46nTmDRsE/h8aX4Y56mtyU74KZFP9UkmC8
         49QDqTYjM8lRcoSSMpCGHtI163apIhGsvDvfcZ4fbtogv1DDlG5fveWsf/ZHPPzzsu
         x9QafgQjJqw+wwl1BisYn1En0MXhlQ4YDI0zZiSI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Niklas Cassel <niklas.cassel@linaro.org>
Message-ID: <154603603502.179992.17724806534594632860@swboyd.mtv.corp.google.com>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org> <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com> <20181218143503.GA32562@centauri.ideon.se>
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names from DT
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, jorge.ramirez-ortiz@linaro.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, bjorn.andersson@linaro.org, vkoul@kernel.org,
        sibis@codeaurora.org, georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181218143503.GA32562@centauri.ideon.se>
Date:   Fri, 28 Dec 2018 14:27:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Niklas Cassel (2018-12-18 06:35:03)
>=20
> This is the existing DT nodes for msm8916:
>=20
>                a53pll: clock@b016000 {
>                         compatible =3D "qcom,msm8916-a53pll";
>                         reg =3D <0xb016000 0x40>;
>                         #clock-cells =3D <0>;
>                 };
>=20
>                 apcs: mailbox@b011000 {
>                         compatible =3D "qcom,msm8916-apcs-kpss-global", "=
syscon";
>                         reg =3D <0xb011000 0x1000>;
>                         #mbox-cells =3D <1>;
>                         clocks =3D <&a53pll>;
>                         #clock-cells =3D <0>;
>                 };
>=20
>=20
> This is the (suggested) DT nodes for qcs404:
>=20
>                 apcs_hfpll: clock-controller@0b016000 {
>                         compatible =3D "qcom,hfpll";
>                         reg =3D <0x0b016000 0x30>;
>                         #clock-cells =3D <0>;
>                         clock-output-names =3D "apcs_hfpll";
>                         clocks =3D <&xo_board>;
>                         clock-names =3D "xo";
>                 };
>=20
>                 apcs_glb: mailbox@b011000 {
>                         compatible =3D "qcom,qcs404-apcs-apps-global", "s=
yscon";
>                         reg =3D <0x0b011000 0x1000>;
>                         #mbox-cells =3D <1>;
>                         clocks =3D <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_h=
fpll>;
>                         clock-names =3D "aux", "pll";
>                         #clock-cells =3D <0>;
>                 };
>=20
> qcs404 specifies two clocks, with an accompanied clock-name for each cloc=
k.
>=20
> msm8916 specifies a single clock, without an accompanied clock-name.
>=20
> It is possible to append clock-names =3D "pll" for the existing clock,
> as well as to define the aux clock in the apcs node in the msm8916 DT:
> clocks =3D <&gcc GPLL0_VOTE>;
> clock-names =3D "aux";
>=20
> However, since the DT is treated as an ABI, the existing DT for msm8916 m=
ust
> still work, so I don't think that it is possible to ignore having backwar=
ds
> compability in the apcs clock driver.
>=20

We typically allow one clk to match the NULL connection name, so I think
things should work if you clk_get(dev, NULL) on 8916 and then try the
specific "aux" and "pll" strings strings after that for updated DT. Not
sure if that helps you here though.

And I would push to try and make all the clk connections between clk
controller nodes specified now. It will be useful to avoid global string
lookups in the future, so the sooner the better.

