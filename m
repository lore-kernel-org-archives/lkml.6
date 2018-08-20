Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD2C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF5A21570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ifnYGrxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF5A21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeHTVds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:33:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33011 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeHTVds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:33:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so7180661pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=7Z3tPt5WBztfVkB4fKlYZedLLtDuiOvDCey342tNvu8=;
        b=ifnYGrxMDGNd7HyoRPDwPo2qHZzQzgC7TCB+eKpGGGPcpQW/V09ka6rhxDPHTy12E8
         Oi/M5gRXWG2XsDIf3yHdwmjsaxr7aa9yjnHmK6xE3kksVoRl1OqW46Iq/k6X2yK+C51V
         siqdmP0ySBRm5ZUMntGltnuVASCMweec6GJbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=7Z3tPt5WBztfVkB4fKlYZedLLtDuiOvDCey342tNvu8=;
        b=O49n8gy+ByCHepObgpvFOxgY5LIvHFYzew+E5XdVtJYUgus0GLHhDf+umvn61lcC9z
         1fRQUYOb8EYeih57xF3croFikqUL/d9YP+ZQZ7U4l23lQ8e8r+am3OEO9ZNvs4sOzqDF
         3eNXr6vknjPF7WdJfO6zv0xYpAqOh89jHCThezHt/pGSunD+szPc0sDlAnEditTk87Os
         NiA5CJ2m6HsK/nkyEBbhHloo/vFlP+VOBHR5N7ycLyzfb5kipPkzRoNRohFNjj83AQDH
         R/ozTNmEwzvrb/xIFqHxkAvvnuCHoffg2x2LlVK0vmWns3t+776Y4AkRpYwmJVv/Gf0S
         8EoA==
X-Gm-Message-State: AOUpUlFsmDcQu7mH3AupATnxEyFJnDhLqauHtXhKV9D7frnEcqTmXAsw
        kpi+8PfFHsAvvQichi0kxBOhfQ==
X-Google-Smtp-Source: AA+uWPxYhmlvmPCF+LfT3ugdntkJzCTzh5lAvryNz1EnVcUwtG8wGAnjQLMh09n9I5RdgR93aBDf7Q==
X-Received: by 2002:a62:5613:: with SMTP id k19-v6mr49335247pfb.212.1534789027175;
        Mon, 20 Aug 2018 11:17:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id n4-v6sm5814201pgp.80.2018.08.20.11.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 11:17:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180810215150.82490-2-dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, tfiga@chromium.org,
        Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180810215150.82490-1-dianders@chromium.org>
 <20180810215150.82490-2-dianders@chromium.org>
Message-ID: <153478902525.28926.6688429060107225232@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add USB-related nodes
Date:   Mon, 20 Aug 2018 11:17:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-08-10 14:51:48)
> From: Manu Gautam <mgautam@codeaurora.org>
> =

> This adds nodes for USB and related PHYs.
> =

> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> [dianders: reworked quite a bit]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

One question below, otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> =

> Changes in v2:
> - Use "0x784000" for qfprom rather than "0x780000" as per docs.

?

> - Add calibration for 2nd USB port too
> =

>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 196 +++++++++++++++++++++++++++
>  1 file changed, 196 insertions(+)
> =

> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/q=
com/sdm845.dtsi
> index ae57c065780c..f13d8c2fb4a5 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  =

>  / {
> @@ -249,6 +250,23 @@
>                         #power-domain-cells =3D <1>;
>                 };
>  =

> +               qfprom@784000 {

This doesn't match reg property.

> +                       compatible =3D "qcom,qfprom";
> +                       reg =3D <0x780000 0x8ff>;

Because this should be 0x784000?

> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +
> +                       qusb2p_hstx_trim: hstx-trim-primary@1eb {
> +                               reg =3D <0x1eb 0x1>;
> +                               bits =3D <1 4>;
> +                       };
> +
> +                       qusb2s_hstx_trim: hstx-trim-secondary@1eb {
> +                               reg =3D <0x1eb 0x2>;
> +                               bits =3D <6 4>;
> +                       };
> +               };
> +
>                 qupv3_id_0: geniqup@8c0000 {
>                         compatible =3D "qcom,geni-se-qup";
>                         reg =3D <0x8c0000 0x6000>;
