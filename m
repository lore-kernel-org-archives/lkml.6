Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7730C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04EF2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PNSvV8Qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBAXzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:55:05 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41718 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfBAXzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:55:04 -0500
Received: by mail-vs1-f66.google.com with SMTP id t17so5278211vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 15:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9x5KotFYPTsyMcDIrEHxet0+0JZO/9RJY44ytooLU6A=;
        b=PNSvV8QpImoiG1KsAUGK+Pt43Qn+hgcSTf2jCQR0TA0pSVrb+EAko5LHv7PJJIzggL
         z2xvnDkyfDyGTl1VWiyGsKqGQIvDuQ6XvD7OTcQ0PKWCCKi+KZGn5cqKJLm19Jfss0gJ
         Xc//rOu5ZW7vS8/B/8GdwOcbIJXTGIgrMtCPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9x5KotFYPTsyMcDIrEHxet0+0JZO/9RJY44ytooLU6A=;
        b=XcP9d47ThcErqcrGyeOTK1aH9nzUsvxDn7Nu9BxuTNhJqObTJDe9HAL1cirDrUzfNA
         28CaB4WScfRtzskaB6+8GXO4aFHpZNatBUk2M+AUB2kzOXBVLycacVq7Ug1ZXvjXC2Bv
         jhbyzU1ZNc720jGWepWYNFanZlEHfh7IUZOB9EpmduuLkqsemxRpHN4pkFd0vM9LqB2V
         JK8syEzljShWbkvFfWfVolZktg5ywFTnfi3r7LCK6iX59vHr2QIh8BWRBQiC3m5cqvdl
         mp3mv7GzL/rdht0OR7gJo9wLBfveA97jnIQv75Gu58QTab8k9A5uglsj5joPZiZhLTqg
         UA7g==
X-Gm-Message-State: AJcUukcty9ep/PakzRLBoZ/+ZmnACW91cvobjj+L/50X2TfVfFqZk0Ca
        R9suvbeTsZPLdA0KPfiQU0eTrWwUgLo=
X-Google-Smtp-Source: ALg8bN680ySmMfpQnpJCAp8BmgrWsK9IxqxOHy6PLeqWW42tn/nac+UQO6EhsY9vvB6VVEeHAspwfg==
X-Received: by 2002:a67:2901:: with SMTP id p1mr18243985vsp.79.1549065303214;
        Fri, 01 Feb 2019 15:55:03 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id l197sm11327860vke.18.2019.02.01.15.55.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 15:55:02 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id x28so5259170vsh.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 15:55:02 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr18101835vsj.144.1549065301731;
 Fri, 01 Feb 2019 15:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20190131003933.11436-1-bjorn.andersson@linaro.org> <20190131003933.11436-4-bjorn.andersson@linaro.org>
In-Reply-To: <20190131003933.11436-4-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Feb 2019 15:54:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V068E_d-RyJdCTm4ycj+oSfe7zC8goGKhKbyELaN63GQ@mail.gmail.com>
Message-ID: <CAD=FV=V068E_d-RyJdCTm4ycj+oSfe7zC8goGKhKbyELaN63GQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 30, 2019 at 4:40 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index d19486ba1e5e..07d9cd6fba7d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -325,6 +325,64 @@
>                 };
>         };
>
> +       adsp_pas: remoteproc-adsp {
> +               compatible = "qcom,sdm845-adsp-pas";

After discussion with you offline I now understand why this is using
"-pas" and not "-pil".

...and I understand that on my particular board (which should use
"-pil") we'll juse leave this as status = "disabled".

It would be good if something in this series updated the bindings to
make it clearer since I can't find anything in these two files:

Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt

...explain when the "-pil" is used and when the "-pas" is used.


-Doug
