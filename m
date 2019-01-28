Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE94FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796752148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dGOTS9Qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfA1TZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:25:07 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38162 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfA1TZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:25:06 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so10454392vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQY6Zal4DC++bZdpHMJ7+qGiQeQDdJgSt9Ldg8BCEd8=;
        b=dGOTS9QnfoLXq3htIaA2MOdWKp89qLma1tYgvj6HIyPsZf4W1jCkx+tQ5ihMRiL5+z
         JqXwHGGPw4ii0fGorBIzgldXhPBvJWppIMTCgV1PAtU6YMCXjhccosonhG/pNky/ONpV
         UwlXnXR4Px8LDRKrJxelCejHJVQj1OotokYg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQY6Zal4DC++bZdpHMJ7+qGiQeQDdJgSt9Ldg8BCEd8=;
        b=Zyi39w6/P+JOXd3NTYThyECInkOGk/V71AOjbvYSNq8LQkA6AuV3sbd7FEh29mfd1G
         XjVriDFSWbFAHyTsFRk026d0Trm6jwxWUti5mKcq7foPss+AbXOId7fXP6Y2xuMcCmue
         pT8uiYUeAhY7IiuVoALzUwERHy/6Dbn4OgEGTShSCXYPiUNYtNs6wRtFt0CoTN6ik635
         QZMcaYJA+qP8Y3cTKs4NMR9XNy9JcIqCnzba76VQX8Gc+xjLXnGsgh7GXF7KmdVU7u5I
         FEj4CsL19XTVNmRx+Hjdv7jtCUbz/8epRSISsaYtnpPPP7L/v4ChdZicZf9TfjI1cgMo
         IHCw==
X-Gm-Message-State: AJcUukc/s10pF4kabXRrKGOhEWkhR+yJDbgBDJeV6ylgbXS5mocO2F0Q
        bgVcJW1qrYeCH7J7A9qyE1qGtUDf3M0=
X-Google-Smtp-Source: ALg8bN7agJdLZXgTZsNlwsXWAvxZkh8DGEbpC9obG/aopDSqhzeXC3j34ZPn3eHZOIHr6ywxfJHhJg==
X-Received: by 2002:a67:ebc3:: with SMTP id y3mr9619795vso.75.1548703505014;
        Mon, 28 Jan 2019 11:25:05 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id j95sm51722007uad.6.2019.01.28.11.25.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 11:25:04 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id h78so10455010vsi.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:25:03 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr10141181vsk.111.1548703502172;
 Mon, 28 Jan 2019 11:25:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org> <d0370bc569491d11827a6eb12a75a236c3d60a0e.1548419933.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <d0370bc569491d11827a6eb12a75a236c3d60a0e.1548419933.git.saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Jan 2019 11:24:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XjVU=stq9U+tBtJpAiQa+6hDKi8+F5LOX4bq68-wQNaA@mail.gmail.com>
Message-ID: <CAD=FV=XjVU=stq9U+tBtJpAiQa+6hDKi8+F5LOX4bq68-wQNaA@mail.gmail.com>
Subject: Re: [PATCHv5 7/7] arm64: dts: qcom: sdm845: Remove the duplicate
 header inclusion
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 28, 2019 at 11:16 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Remove the duplicate inclusion of qcom,gcc-sdm845.h
> mistakenly introduced by commit 6e17f8140521 ("arm64:
> dts: sdm845: add prng-ee node").
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e49f71d00854..eafe8e47471e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -12,7 +12,6 @@
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> -#include <dt-bindings/clock/qcom,gcc-sdm845.h>

You can probably stop sending this one.  It's in Andy's tree now.  See
commit ea0edd7e63f4 ("arm64: dts: qcom: sdm845: Remove the duplicate
header inclusion").
