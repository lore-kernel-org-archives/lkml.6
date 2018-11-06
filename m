Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0956C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F242083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MtWX7tlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F242083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbeKGIj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:39:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35574 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeKGIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:39:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id v9-v6so4516541pff.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 15:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=6pbIB1l4PwcsiauGWQW0UUkxGdO3VV1U8XhpOQjYXVI=;
        b=MtWX7tlWcQT85GxjWtnnDSIPwU5goHyHEgFMAVjNVrQr4i3aKcLr3OIVP7YzU4t6Kh
         lzZyiqX2kQav3+R3Ork0QGaEY2EQXDGu+gBiBca63Xj7WUVDXEiSu78txAaOwtQtlxEZ
         lhRFmUn8OMed3w69gTl8kXjeqof9o/6ZG94WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=6pbIB1l4PwcsiauGWQW0UUkxGdO3VV1U8XhpOQjYXVI=;
        b=PByeJanEaFdXMIRBS79/UCztzln2XoHC5OTpTlmcJ+j55cAzmpLpX9Gb+whPRegk3R
         XDd+gundB93qwYQXvUsGC9ePGVOq7NshgV57ashLBU5U/P7pIn5Yzj+R3j9BMltC7N3Z
         Gdf/KecUudO/2TqPRXvtjirz7qPC7N1zXSAoJjmUqOkAPOmKQR7yw+7acj55DmDejns3
         dr56fPx1l1ion0t8N5wXmNb02a/AH8OoBy91NFhrLoap4qeLpUNixPp6qGD2vmNIV14b
         g53czLKo/u8mieAi0bEjpBEsdSrr38fTrES4PWWihoMMV/xNcXPq15XmD0PHdvn/yoXC
         spYg==
X-Gm-Message-State: AGRZ1gJuANHdh3ZVXvPCrpMZiHiBNIz3e3UClRUpKKRfnPvYq21m6fmk
        ZEgPmuXpGLVbynJ+TRCEC5CAvA==
X-Google-Smtp-Source: AJdET5cmeNdR31LhtXQKzaXPFGJnYMOVwZ2PfpuAWq4LEsnecUg/SmF4hrsdNF1lrfT2jymId9qu2g==
X-Received: by 2002:a63:451a:: with SMTP id s26mr15699712pga.150.1541545909705;
        Tue, 06 Nov 2018 15:11:49 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 186-v6sm10286859pfe.39.2018.11.06.15.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 15:11:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181102214534.184593-2-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <20181102214534.184593-1-mka@chromium.org>
 <20181102214534.184593-2-mka@chromium.org>
Message-ID: <154154590845.88331.13649449650347478513@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] drm/msm/dsi: Get PHY ref clock from the DT
Date:   Tue, 06 Nov 2018 15:11:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-02 14:45:34)
> @@ -630,7 +632,8 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll=
_10nm)
>         char clk_name[32], parent[32], vco_name[32];
>         char parent2[32], parent3[32], parent4[32];
>         struct clk_init_data vco_init =3D {
> -               .parent_names =3D (const char *[]){ "xo" },
> +               .parent_names =3D (const char *[]){
> +                       __clk_get_name(pll_10nm->vco_ref_clk) },

I find this syntax odd, in addition to needing to check for NULL here as
Sean pointed out. Preferably just have it be the address of the
character pointer instead of making an anonymous array and then casting
that inline, i.e

		.parent_names =3D &ref_clk_name,

>                 .num_parents =3D 1,
>                 .name =3D vco_name,
>                 .flags =3D CLK_IGNORE_UNUSED,
> @@ -786,6 +789,12 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct pla=
tform_device *pdev, int id)
>         pll_10nm->id =3D id;
>         pll_10nm_list[id] =3D pll_10nm;
>  =

> +       pll_10nm->vco_ref_clk =3D devm_clk_get(&pdev->dev, "ref");
> +       if (IS_ERR(pll_10nm->vco_ref_clk)) {
> +               dev_err(&pdev->dev, "couldn't get 'ref' clock\n");

This might be because of probe defer, which may be annoying to see this
failure many times.

> +               return (void *)pll_10nm->vco_ref_clk;
> +       }
> +
>         pll_10nm->phy_cmn_mmio =3D msm_ioremap(pdev, "dsi_phy", "DSI_PHY"=
);
>         if (IS_ERR_OR_NULL(pll_10nm->phy_cmn_mmio)) {
>                 dev_err(&pdev->dev, "failed to map CMN PHY base\n");
