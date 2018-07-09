Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB246C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B4F20871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="WFDeC6Wf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYu+8PFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B4F20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932654AbeGILhz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:37:55 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43093 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeGILhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:37:53 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so35194704oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=u07vxpkpvC6UczGfn2z3I+VTROvJvgAbh+lh4jhvtAI=;
        b=WFDeC6Wftl7RAQNms2RGpbIepYtCqmSeMHCCjuoP5IvHk3Hd2Sh4Uixx9ABXIk8csc
         sEI8X0XKZUBPIUvt7QURHyT2tma8Jt51pXEDBcWO3xtVCEutbpKNByIrCbNLNz9+FrUF
         /N5lwnVrQhlpqZcxKEARrB71lPQxn9ZtVDFJ3p42GZ0ehv0pGxQwc5X9pqjJdN2/YGcp
         E+B8GPvULLmH5ZuJOWgBhbEzJBIjTlUgVEQPWllgPF9CiKsfjRgt1Cv5hAn1OuSieNf/
         hh9myLrMzWOSzZH2DGurAJdMqo8AyY3QczsyOxnXg12KWzVaUE6Kn7Oga/aXwcfMGQK5
         jVuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=u07vxpkpvC6UczGfn2z3I+VTROvJvgAbh+lh4jhvtAI=;
        b=eYu+8PFs3JOou3jx00iARk+P4M5+5DllSHFePCsjJyfTw/jIZZt6teZ346M+BWfTMi
         6WoCqUZ+owtX4cLMf0D0c5UH1OuXG5IxSk5akiLGBW6byLfWHLrDzllGxuZV7Urt7SyP
         vFHGrvzOs4QTn3YMUCZbir12rUI+KTc90NNYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=u07vxpkpvC6UczGfn2z3I+VTROvJvgAbh+lh4jhvtAI=;
        b=c3wqDN1Sp202L9mCukf1i7mpLx7+yza1Hqwd0IMMFLzzeWlV40CkGaVs4Z3r088i1Y
         E6/7ICL7gRfV+tzsRZblcjsrNaQDDTQfVLcxzXQcZgBWg9VQdfxQqdc/6S+13rWbIGw2
         CXVuxKjN+n4ln3UKihgNpzoGXJwKEYG3HQFN7FM4iVBYxfQVRazqQ/YNdrhvt8npkCZ0
         l/k/iFfl1p56un4Ccq3v/uk1uxAY5SKcFUEOTXi3HLCjv7cL0vRgPb2Upkd6IWGCJSfo
         qMDjjPdC3JU7KxWxi3QtifeulEHKB/DOJrr/4NpKXXbcHMHUef8VvePy0Krn47FMf1At
         RseQ==
X-Gm-Message-State: APt69E2JzY2tIE1U5oL+TgPnV7yh6w8ejep3haOOFkGhbR4p6/dX5CyT
        JCpu5Emdewt5qPI39hNAZaHRFyC9yHK5sKOYBBUcD2DdtP8=
X-Google-Smtp-Source: AAOMgpd3dCVOlBVfU1Myv/KblpzNkrk4Y9v3zfDJ0Qxrjy+dW+MNBow/h1ypEkvJ232OWtAOHny4Db23wUrNubznl0w=
X-Received: by 2002:aca:d44a:: with SMTP id l71-v6mr23942315oig.199.1531136272653;
 Mon, 09 Jul 2018 04:37:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 04:37:51 -0700 (PDT)
In-Reply-To: <742cf44d162523a66bb4ce60e15449dfbf88800a.1531133612.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org> <742cf44d162523a66bb4ce60e15449dfbf88800a.1531133612.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 9 Jul 2018 17:07:51 +0530
X-Google-Sender-Auth: Aq8oyLJvat7MVBa9ughMDkkbCAI
Message-ID: <CAHLCerMsVwrkeK+dVpqapM5EXcYuGxrFE8FdNL4r6NJoWW5awg@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] arm64: dts: sdm845: Add tsens nodes
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 4:57 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> sensors. It uses version 2 of the TSENS IP, so use the fallback property to
> allow more common code.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb..d97ee00 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -221,6 +221,22 @@
>                         #interrupt-cells = <2>;
>                 };
>
> +               tsens0: tsens@c222000 {

Oops, sending out v6 to fix this.

> +                       compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +                       reg = <0xc263000 0x1ff>, /* TM */
> +                             <0xc222000 0x1ff>; /* SROT */
> +                       #qcom,sensors = <13>;
> +                       #thermal-sensor-cells = <1>;
> +               };
> +
> +               tsens1: tsens@c223000 {
> +                       compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +                       reg = <0xc265000 0x1ff>, /* TM */
> +                             <0xc223000 0x1ff>; /* SROT */
> +                       #qcom,sensors = <8>;
> +                       #thermal-sensor-cells = <1>;
> +               };
> +
>                 spmi_bus: spmi@c440000 {
>                         compatible = "qcom,spmi-pmic-arb";
>                         reg = <0xc440000 0x1100>,
> --
> 2.7.4
>
