Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4B2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659EB2183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546897293;
	bh=mWqCUhMskCDZLWgeA3znHWRacla8TBvkOWC0TKcej9s=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=Ape88Ddbg88UEYrA7M2ivXcu5krWxYSYqfrqaKMT3c1701B0mHoO6LgUTYig3nKvA
	 HDK4rHqbK9Y8jHQfxMnBlnTN3OxmFB0IfjPUzNXHFUe7kmbZaMhLD+te7h25KXCc8F
	 iEa28jfdajM6fcGgR2WSJfC3z4n+5KwGygWeIkSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfAGVlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfAGVlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:41:32 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E3EE2087F;
        Mon,  7 Jan 2019 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546897291;
        bh=mWqCUhMskCDZLWgeA3znHWRacla8TBvkOWC0TKcej9s=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=nGZdE6+tZIZQBvVCq8x1kDdZdZBZtUeXwLsMI6niR/XRkV0+lF9AhgzfVjazPLvOL
         3pk7LFxwj75A8SZakM7cvPdt/KtEvZMgZJYkF/cUt3m1qPSRi8FYydAvBmSVZCGXPJ
         D5lus/fPkuaDfCRfgprFMc3nbPE45mpea74Dzovw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/5] mfd: qcom-spmi-pmic: use devm_mfd_add_devices instead of devm_of_platform_populate
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
In-Reply-To: <20190107021145.6370-3-masneyb@onstation.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20190107021145.6370-1-masneyb@onstation.org> <20190107021145.6370-3-masneyb@onstation.org>
Message-ID: <154689729020.15366.16314952173889307636@swboyd.mtv.corp.google.com>
Date:   Mon, 07 Jan 2019 13:41:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-06 18:11:42)
> +       },
> +       {
> +               .name =3D "pm8941-regulators",
> +               .of_compatible =3D "qcom,pm8941-regulators",
> +       },
> +};
> +
>  static int pmic_spmi_probe(struct spmi_device *sdev)
>  {
>         struct regmap *regmap;
> @@ -136,7 +191,9 @@ static int pmic_spmi_probe(struct spmi_device *sdev)
>         if (sdev->usid % 2 =3D=3D 0)
>                 pmic_spmi_show_revid(regmap, &sdev->dev);
> =20
> -       return devm_of_platform_populate(&sdev->dev);
> +       return devm_mfd_add_devices(&sdev->dev, PLATFORM_DEVID_AUTO,
> +                                   pmic_spmi_cells,
> +                                   ARRAY_SIZE(pmic_spmi_cells), NULL, 0,=
 NULL);

Now this seems worse. We have gotten by without having to explicitly
list all the devices that are inside the PMIC as mfd cells. But now, to
avoid creating the irqs before the hierarchy is installed, we have to
undo all of that and rely on the difference in behavior of
of_platform_populate() and mfd_add_devices(). That's pretty obscure to
figure out.

I'd prefer we drop this patch and keep disassociating virqs and
reassociating them in the gpio driver. Then we can remove the interrupts
properties in all the DTS files and finally remove the disassociate and
reassociating code in the gpio driver when all the DT files are cleaned
up. It makes things less confusing that way and doesn't require updates
to this driver.

