Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6653AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD042184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546558210;
	bh=BDwlvmRDLvPAcFZk63HU0X0XcnUsSn+Lb1Gx9m7iqSE=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=FoenGont0h0+qauU6qgEq5HJcZ+ciSGxs9JOMJY5frJR9oPw0QlYo4lEhcFJvU4dA
	 ocxGmn20p1iQPto/V+lRCKDK3BNUVgW/ks1MXq6NVbz4fxsee5bQi09t+CuxNNO6vo
	 r1KWUvmLKzi5W4JtalxzqmyN+/jX50TNqAIdFgnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfACXaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfACXaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:30:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BCC0217F5;
        Thu,  3 Jan 2019 23:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546558207;
        bh=BDwlvmRDLvPAcFZk63HU0X0XcnUsSn+Lb1Gx9m7iqSE=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=MhR6FEcSYzUWYs9BiuILDnrCG7/LIF3lgYCdVlGQvocDvYpMq2IH8q+TYixuMXtFd
         /zYjGWxI7NVNMHCvIKTDf5tDEB7hfl56EpGXydXcbdx4VMzeD2fwhETqlQdpeguCgR
         TNDgG8fzp9a5LULUexKYkOUjNIIIEvuGrK0PuBd4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] phy: qualcomm: usb: Add Super-Speed PHY driver
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        vkoul@kernel.org
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        gregkh@linuxfoundation.org, kishon@ti.com, mark.rutland@arm.com,
        robh+dt@kernel.org
In-Reply-To: <2f38642e-27a0-0fd7-928e-8e782d0bc7c6@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1544176558-7946-3-git-send-email-jorge.ramirez-ortiz@linaro.org> <154533779333.79149.17234544366247143930@swboyd.mtv.corp.google.com> <2f38642e-27a0-0fd7-928e-8e782d0bc7c6@linaro.org>
Message-ID: <154655820653.15366.12989225525562032193@swboyd.mtv.corp.google.com>
Date:   Thu, 03 Jan 2019 15:30:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez (2018-12-26 09:53:08)
> On 12/20/18 21:29, Stephen Boyd wrote:
> > Quoting Jorge Ramirez-Ortiz (2018-12-07 01:55:58)
> >=20
> >> +       struct regulator *vdda1p8;
> >> +       struct regulator *vbus;
> >> +       struct regulator *vdd;
> >> +       unsigned int vdd_levels[LEVEL_NUM];
> >> +};
> >> +
> >> +static inline void qcom_ssphy_updatel(void __iomem *addr, u32 mask, u=
32 val)
> >> +{
> >> +       writel((readl(addr) & ~mask) | val, addr);
> >> +}
> >> +
> >> +static int qcom_ssphy_config_vdd(struct ssphy_priv *priv,
> >> +                                enum phy_vdd_level level)
> >> +{
> >> +       return regulator_set_voltage(priv->vdd,
> >> +                                    priv->vdd_levels[level],
> >> +                                    priv->vdd_levels[LEVEL_MAX]);
> >=20
> > regulator_set_voltage(reg, 0, max) is very suspicious. It's voltage
> > corners where the voltages are known?
>=20
> sorry I dont understand the question
>=20
> this regulator on the ss phy wold be
> vreg_l3_1p05: l3 {
>                 regulator-min-microvolt =3D <976000>;
>                 regulator-max-microvolt =3D <1160000>;

Is this also the CX or MX voltage for the SoC? There would be a pin like
VDDCX or VDDMX on the SoC part that is connected to this regulator if
that's the case. Because you have "LEVEL" in the code it makes it sounds
like it's voltage corners here so I suspect this is mapping into the
voltage corner stuff that qcom has.

> };
> >=20
> >> +}
> >> +
> >> +static int qcom_ssphy_ldo_enable(struct ssphy_priv *priv)
> >> +{
> >> +       int ret;
> >> +
> >> +       ret =3D regulator_set_load(priv->vdda1p8, 23000);
> >=20
> > Do you need to do this? Why can't the regulator be in high power mode
> > all the time and then go low power when it's disabled?
>=20
> this regulator is shared with the usb hs phy and each (ss/hs) have=20
> different load requirements. why would it be wrong for the ss phy to=20
> announce its needs (which will differ from those of the hs phy)?

Yes they have different load requirements, but in the end I would guess
they always push the regulator into high power mode when the device is
active and drop the load requirement when it's inactive. If it matches
the enable state of the regulator then there isn't much need for setting
a load explicitly besides stating that when the regulator is on it
should be in high power mode and when it's off it should be in low power
mode and off.

