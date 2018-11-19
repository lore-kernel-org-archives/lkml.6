Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADA9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338C32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hr1tBqem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338C32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeKTFoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:44:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41154 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbeKTFoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:44:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so14249382pgh.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=kXDjwIo4PpzRi16zFOsiBpRl5SRgeMfC9kIFAaaG81Y=;
        b=hr1tBqem3K5lpqct8k2pFQbK43FLNCWaGgIS6orXrrxVMZbuiNSnNx0EYhPHipy8Fh
         UN7IzzL6r4dHmRg77ic09t9Rcb2s/kAQVt7zzPpAJTDaOdvcruKpMNcicr6H+4prqxfl
         41ENg9/mbyOOun+VvsQOHE5nCgd1NjHQAAN8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=kXDjwIo4PpzRi16zFOsiBpRl5SRgeMfC9kIFAaaG81Y=;
        b=Z6L0q6Qv66EJrhlEzqC/Hr+7W2HXiWxopWr003Wznwa4OyutWC5CJhHtfJBwUinnZg
         5i7kF39eo3G86wEtby9OrY6OW6hUxq5qZNx0I6p8vBTjtH4OIfVfEHj3+atg8JbPsScP
         OXhN417RYowBpWLifpjMuaMGH6oZX+5l93vCkfOM58DukK0YFltGPsHzIksTMGL4cfRj
         wCWBXlwkvmhzRonKC/sDweAhQDeAnHG9LD5QsCQlK1ZN7mwufaj+4uziSW45/v26QC2o
         5ssQPQiPqFALPXrYTpCYq4ih0vYXtV2SDp7GF+a6hVIINcYJItzE23h9OM2NnrQPRp1k
         dknA==
X-Gm-Message-State: AGRZ1gJueE0W5iC8YJCtIPdCUfyGRAacenNK048eISYi6UhCYrdw8VD1
        cBiBfKzoGqSZ38RZ/5ZYnCP9PA==
X-Google-Smtp-Source: AJdET5d7hkaUII6R/nqhCgQZ9fij/XGPhZfU8BTz4cFJ7wzqhVD4jbFD3XhLday7/GqWCpgpq86xdQ==
X-Received: by 2002:a65:4049:: with SMTP id h9mr20980391pgp.304.1542655150450;
        Mon, 19 Nov 2018 11:19:10 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id b5sm27352302pfc.150.2018.11.19.11.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 11:19:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181026173544.136037-5-evgreen@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Can Guo <cang@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
References: <20181026173544.136037-1-evgreen@chromium.org>
 <20181026173544.136037-5-evgreen@chromium.org>
Message-ID: <154265514855.88331.12521366940818102477@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
Date:   Mon, 19 Nov 2018 11:19:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2018-10-26 10:35:43)
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dt=
s/qcom/sdm845-mtp.dts
> index eedfaf8922e2..d5fddea71a85 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -356,6 +356,20 @@
>         status =3D "okay";
>  };
>  =

> +&ufshc1 {
> +       status =3D "okay";
> +
> +       vcc-supply =3D <&vreg_l20a_2p95>;
> +       vcc-max-microamp =3D <600000>;

Is this board dependent? I would guess this is SoC specific and not
board specific.

> +};
> +
> +&ufsphy1 {
> +       status =3D "okay";
> +
> +       vdda-phy-supply =3D <&vdda_ufs1_core>;
> +       vdda-pll-supply =3D <&vdda_ufs1_1p2>;

These two properties can be specified in the SoC dtsi file instead of
each board variant file. This way we don't have to specify the things
that are SoC independent in each board file. The board integrator just
has to attach the labels to the right regulator nodes, in this case
vdda_ufs1_core and vdda_ufs1_1p2, and then the sdm845.dtsi file will be
matched up with the right regulator automatically. It's also nice so
that board integrators don't have to know anything besides what
regulator goes to what pin on the SoC.

The status property has to stay of course.

