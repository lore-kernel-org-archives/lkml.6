Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1D9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE00B214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YC0DblCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeLRACv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:02:51 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44314 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeLRACv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:02:51 -0500
Received: by mail-vk1-f194.google.com with SMTP id h128so3270122vkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bs/yh5T6L+JfszVJt9/gLFo3oXU7dwETfDz+PIBmpB8=;
        b=YC0DblCzylYUlvhQht4wduCPVGt4disnpRCiq1IMuE8KftbT+kiTsOWScWCxurJzg5
         IwlgJHOxl/GnbC5dKT8XIOHOBEuTBr0g1mZtAr3R1nAM4tMkR/2PBG/YrB8Q/xsaR8HY
         1mUaOUw4O9Mp5UWftFcxSwY/an/2smJrw4Yc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bs/yh5T6L+JfszVJt9/gLFo3oXU7dwETfDz+PIBmpB8=;
        b=GiVV3UK1Hb7eUjZQbFspZG0CS1AHKgT23T6g3oe6itFq1ww6DaCh6IxT+uaIdSBgUA
         SiLGRRsMcnbXQ0jQP5zn679KgIiG1K5Sp9bxHiPLCO27uLXIJPgM2XMHN0p3PgZisMyD
         Lm7fXdA+/E9DFVqZb3M600IaS8n/LgXE2yzHdceLIEXJm4TBl2NtKIEEAaO0eSoM8Nsc
         Pk72wGVTkgjiVT+uH1rJ1U2OG12Nuw7+CkemIRy0xm0DNYyT+PeAyeODIsf50GpsK5gZ
         RylagxV8YeoKEY7YIiYD6OozTZaH9JyXUpQveo9tCPw3ikiBgGv6yDrcx+tJQps7x3Yh
         5UpQ==
X-Gm-Message-State: AA+aEWZBNmjwb4k0n7OaOJnESka9ArrAZ7s2e2qx31Y59MgLbp7hXF8U
        6tzoXhgJC1NhvctkfetvZMlltofxQPY=
X-Google-Smtp-Source: AFSGD/VdePupVVzkzt7U721TJtg3Iqwx9VlJJicm9seBzlaTChY2zDDRsogLuraqFlUIECC/O47+XA==
X-Received: by 2002:a1f:f8cf:: with SMTP id w198mr6676990vkh.82.1545091368421;
        Mon, 17 Dec 2018 16:02:48 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id n15sm5764687vsi.5.2018.12.17.16.02.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:02:48 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id n13so977883vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:02:47 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr7369738vsj.144.1545091366712;
 Mon, 17 Dec 2018 16:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20181217100724.4593-1-sibis@codeaurora.org> <20181217100724.4593-6-sibis@codeaurora.org>
In-Reply-To: <20181217100724.4593-6-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Dec 2018 16:02:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WEhobH=fBTonJdABYzOqykgk6XYt9=3eoHap8K6rAQKA@mail.gmail.com>
Message-ID: <CAD=FV=WEhobH=fBTonJdABYzOqykgk6XYt9=3eoHap8K6rAQKA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sdm845: Add power-domain for
 Q6V5 MSS node
To:     sibis@codeaurora.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 17, 2018 at 2:08 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add power-domains cx, mx, mss and load_state for Q6V5 MSS node.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>
> This patch depends on the following bindings:
> https://patchwork.kernel.org/patch/10725801/ - rpmhpd dt bindings
> https://patchwork.kernel.org/patch/10725793/ - rpmhpd dt node
> https://patchwork.kernel.org/patch/10678301/ - AOP QMP dt bindings
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

As per my comments on patch #5, I think this patch (AKA patch #6)
should be folded in there.


> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 33ff8668828f..56f5f55db9e2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1401,6 +1401,12 @@
>                         qcom,halt-regs = <&tcsr_mutex_regs
>                                                 0x23000 0x25000 0x24000>;
>
> +                       power-domains = <&aoss_qmp_pd AOSS_QMP_LS_MODEM>,
> +                                       <&rpmhpd SDM845_CX>,
> +                                       <&rpmhpd SDM845_MX>,
> +                                       <&rpmhpd SDM845_MSS>;
> +                       power-domain-names = "load_state", "cx", "mx", "mss";

I guess you changed this to "load_state" from "aop" before?  Is there
code that actually uses this?


-Doug

-Doug
