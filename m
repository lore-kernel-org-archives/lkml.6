Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7F0205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550859105;
	bh=z9GfSWmEy+4BeueRBKwvrwdgS3pjD+tENf7hvjosMwQ=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=xswYKg1bj0tiry8cxmfcUsWnNS1vkg2L7cW9yqDGqegnzgt+Wrbt8sQRCvR7sV6JT
	 9JBk/FptPSxT8E0N3H/05+e4ncIziGPiDO6GzCd0XQ1XQxsg1NJt2LFYDzYSkPvqzl
	 iDb8U4P8CGVApXCRlJB0yGxBtmydRT4ey66wclU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfBVSLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:11:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfBVSLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:11:44 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E65D5205C9;
        Fri, 22 Feb 2019 18:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550859103;
        bh=z9GfSWmEy+4BeueRBKwvrwdgS3pjD+tENf7hvjosMwQ=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=k420iDiel0bMqAmf47xL4TtQ/1RWLUlI1+8l+WWjxqe9poklcyuFN/SBtWImtxjiD
         R1JoWrZG39joFVKWVLOzN/uhkfZkCq0wA4GUE/KFWMKzdE9cf3tM3+gTWiM9kXOLDi
         skM0ne0K+1VXQVXOfDAN3say/b7v16bt1Qexfddg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 05/14] clk: qcom: apcs-msm8916: get parent clock names from DT
Message-ID: <155085910216.77512.12604271825136479370@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1548700381-22376-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548700381-22376-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
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
Date:   Fri, 22 Feb 2019 10:11:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:52)
> @@ -61,6 +65,25 @@ static int qcom_apcs_msm8916_clk_probe(struct platform=
_device *pdev)
>         if (!a53cc)
>                 return -ENOMEM;
> =20
> +       /* check if the parent names are present in the device tree */

This looks odd.

> +       ret =3D devm_clk_bulk_get(parent, ARRAY_SIZE(pclks), pclks);
> +       if (ret =3D=3D -EPROBE_DEFER)
> +               return ret;

Why can't we use of_clk_parent_fill() if we know this is always a DT
platform?  The parent clks may not be registered at the time of probe?
Maybe this series should wait for the parent registration stuff I'm
working on so that this can be made simpler.

> +
> +       if (!ret) {
> +               gpll0_a53cc[0] =3D __clk_get_name(pclks[0].clk);
> +               gpll0_a53cc[1] =3D __clk_get_name(pclks[1].clk);
> +               a53cc->pclk =3D pclks[1].clk;
> +       } else {
> +               /* support old binding where only pll was explicitily def=
ined */
> +               a53cc->pclk =3D devm_clk_get(parent, NULL);
> +               if (IS_ERR(a53cc->pclk)) {
> +                       ret =3D PTR_ERR(a53cc->pclk);
> +                       dev_err(dev, "failed to get clk: %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
>         init.name =3D "a53mux";
>         init.parent_names =3D gpll0_a53cc;
>         init.num_parents =3D ARRAY_SIZE(gpll0_a53cc);
