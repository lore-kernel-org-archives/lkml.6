Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AF0208E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XEWekT+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AF0208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933917AbeGFRbT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:31:19 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44137 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933649AbeGFRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:31:17 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so3178653pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=t5fGN26Y7DbGOJ/1lIZnEr/abLwC22h6Y/Fao3dYMFs=;
        b=XEWekT+yrlP3ZeMJxIE3XJwq/5/4wnJfZCMw+ZtMVjYPcSVyUvJhPBIFYK5PRJBw25
         JOFQ988/+o5Ih8PxCaIX/EV3rUQOz1elPNIr9s1+3g459kFQ4cyRxU7zDfQF3k01BVUX
         56tunb49py7nQB4ZIXk1cceWZE4+IyHnnT/gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=t5fGN26Y7DbGOJ/1lIZnEr/abLwC22h6Y/Fao3dYMFs=;
        b=bIGM/IvchkJBkXyqrEwXMR9djCasN1/InezwVKMP0Yt65uOlISVf/HXJQC3mvFIpxe
         HXmeDU/38GPAUhhY2uNbMQ+xB7stJ0KLtjUxLXKZ/WijQ0rCPpduU3kulJwr+fJsyw1v
         zGp0dcCrHg39o7C8UxF0gpomEwbw97dgUKlbWmhSjIU06lBkx6hXhYcNjW3EpbV66PW0
         L8vWeY1HAUTgBBcCC2V7L1h/n+O/Qm3CGzshmsKHqtfH0oKBdbYfcEOsFWTgkREp4U2C
         U8eNVpVHZ+IsOUT0iJahMT3Rqg3irR6jnFtsfGRoCoqyFJjnfnO/x/rAN6RaBJG4JD+w
         oD+g==
X-Gm-Message-State: APt69E2qM+aKKsXbeSDGCy8Jibllw8vvg+WCmdGMTPIVWBeB4U1Z/Cbs
        neUO+6dYB7Jx9gnNFAbZPLNrTw==
X-Google-Smtp-Source: AAOMgpd7lebZQ0srD0yHZgrW/9H446IKa47XmsteJqPFjObZPbOvL8sPMrtuLTnyqB+fDVc93u7Eyw==
X-Received: by 2002:a17:902:5a4f:: with SMTP id f15-v6mr11152679plm.253.1530898276734;
        Fri, 06 Jul 2018 10:31:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id b6-v6sm8401509pgc.85.2018.07.06.10.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:31:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>, smohanad@codeaurora.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, vivek.gautam@codeaurora.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
Message-ID: <153089827550.143105.2506072427444330254@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 6/6] arm64: dts: sdm845: Add tsens nodes
Date:   Fri, 06 Jul 2018 10:31:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2018-07-02 05:44:09)
> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> sensors.
> =

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> =

> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/q=
com/sdm845.dtsi
> index cdaabeb..edf8505 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -221,6 +221,22 @@
>                         #interrupt-cells =3D <2>;
>                 };
>  =

> +               tsens0: tsens@c222000 {

These unit addresses should match the first reg property, not the second
one.

> +                       compatible =3D "qcom,tsens-v2.4.0", "qcom,tsens-v=
2";
> +                       reg =3D <0xc263000 0x1ff>, /* TM */
> +                             <0xc222000 0x1ff>; /* SROT */
> +                       #qcom,sensors =3D <13>;
> +                       #thermal-sensor-cells =3D <1>;
> +               };
> +
> +               tsens1: tsens@c223000 {
> +                       compatible =3D "qcom,tsens-v2.4.0", "qcom,tsens-v=
2";
> +                       reg =3D <0xc265000 0x1ff>, /* TM */
> +                             <0xc223000 0x1ff>; /* SROT */
> +                       #qcom,sensors =3D <8>;
