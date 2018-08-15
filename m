Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDC7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2E021479
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e6XsM/wR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2E021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbeHOSUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:20:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37364 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbeHOSUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:20:40 -0400
Received: by mail-pl0-f68.google.com with SMTP id d5-v6so608946pll.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=rnTzvgA36ckKe0nn6tIRwKJTxndspYTB4aAIi0BI1q0=;
        b=e6XsM/wRKt3DEA1MLk1YYG1CSYEcLkdWgXVJs/+boYVVYpbEjgkVBq809jlRgdyjr5
         dnNDvGg0VrLfF1zD/rw3xlRwc1C3Wn9mFY061ctNWF9avAJgFJWYpOcA0gG1PuOM10il
         InKGdS+1wH/r7Gpc/mbvBXW7KolWHGtdxaiB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=rnTzvgA36ckKe0nn6tIRwKJTxndspYTB4aAIi0BI1q0=;
        b=Q8OTFkCRfpt8Hc+x8RuNcxo50tM/LU8lz8XyF4GFmFzb8CX46R7YYjEk48357pUlMe
         fNuh+rKCS3FnfgSriRmUcXTmtaLqFnd1u8sD+7UQSIlAr++JACEgX9SoUUXWYWcPQnSY
         TRvQqeeIdHkpLoLSMGBlTZD5sa+5zql0zeivsXner3KLbp25aUw5yoUru4InY0wW2lEg
         bSgLXXvK9Vp7p2bNOxBmXox5djhheUoz8gpZ8PPF6WWJ4I0iHL65KMe/LOn2S3mQapLB
         HWT6RC0AcklWQrCYw1aVDnLDtf1e+RkGEuGZE0Mz8vWr5UMYPLk11N1bleEQmVeU8Z7o
         GG5A==
X-Gm-Message-State: AOUpUlFp/1QwxZpdAVbld7cF1Eo5cDnKMJCMpdR7cPvORKsyEtEbRSLE
        +5IdU+NfylGx61Ph/SRJh/Qtrg==
X-Google-Smtp-Source: AA+uWPzM4l6VLTsFb/+S3QxWyyyB4iIud3qrlqJBO6l+G0ahlsgpHxPpNaTQGfx4qayZpTJSaXafNw==
X-Received: by 2002:a17:902:82c7:: with SMTP id u7-v6mr24706301plz.83.1534346884148;
        Wed, 15 Aug 2018 08:28:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id x25-v6sm22145041pgv.63.2018.08.15.08.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 08:28:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180814173058.26143-1-ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        david.brown@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
References: <20180814173058.26143-1-ilina@codeaurora.org>
Message-ID: <153434688280.37448.5200368407995060713@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] arm64: dts: msm: add PDC device bindings for sdm845
Date:   Wed, 15 Aug 2018 08:28:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-08-14 10:30:58)
> Add PDC interrupt controller device bindings for SDM845.
> =

> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> =

> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/q=
com/sdm845.dtsi
> index 24e254efb9d1..399bfbd52c5b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1106,6 +1106,15 @@
>                         };
>                 };
>  =

> +               pdc: interrupt-controller@b220000 {

Please sort this by unit address within the SoC node.

> +                       compatible =3D "qcom,sdm845-pdc";
> +                       reg =3D <0xb220000 0x30000>;
> +                       qcom,pdc-ranges =3D <0 512 94>, <94 641 15>, <115=
 662 7>;
> +                       #interrupt-cells =3D <2>;
> +                       interrupt-parent =3D <&intc>;
> +                       interrupt-controller;
> +               };
> +
>                 timer@17c90000 {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
