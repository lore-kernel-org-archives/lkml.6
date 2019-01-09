Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DFAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC11206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d7e9Ny3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfAIW5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:57:15 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33279 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfAIW5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:57:14 -0500
Received: by mail-ua1-f65.google.com with SMTP id t8so3009906uap.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsdxCcv8/JRksb9dNzq/93JGI+gwRbu29X95bcXC4uc=;
        b=d7e9Ny3U0XW/TAHbTgfSveFPDeGV/DsF6KuOKQ//6bO/ZNw4xyopfnAhAOq3UJdzl5
         uPYAcVIMnKkd6Ol01MD0GrJhTr8VIhWdty506jIGRZw1Y41jrwGITcDOFu9FruGmJbvl
         GQyW+lrPlZ7TR+S2wliwcksi8Fc8tqaUJ8ZU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsdxCcv8/JRksb9dNzq/93JGI+gwRbu29X95bcXC4uc=;
        b=KWgP2QvOfAjdLMCnKl4n4xbPJolAFuWzgClqMMCqICOoL0TzSVdlyOOCY6bz9wPa8X
         hxT2abK/EyFr12/Nv54BebYkxq9lWnPVTQrrN0uF50Mho7eT96JkfEDK2Ws/BD/XmJbJ
         Q6n8d1dEWagjdh8cNcKltXIG1IEDKm7ZCBQoPRKVfF8Al4zzonVVS7i1wZ5dl2/8unYo
         MxWAIvsTrKWNdmsePDmnjgRPKwHkskRW2EZ4lN2BFJFKGx+KPOHLyicBbxxT1deFXKYc
         9FLX1yIN2DCcW5Yeh6Up0o3JzNnoAE3VrpZ9DXqJ6UpN/PyjRPRy3KeW9ThiQHwdiF7B
         Y1cg==
X-Gm-Message-State: AJcUukdXJf/R9Zi5mKMU4i9pncPto2E7LREaBI4vy3oh5XuhN/0yTiP8
        /iXJs24yrGbUlQCJxojvsuF23C0Cy1w=
X-Google-Smtp-Source: ALg8bN4rBsXzjdQ7B7I9Aztql9LdXoPKoAnS6Bj5HuXC0ofW3hXgSqkOMTQiuwAPhqxEjCCN21QxeQ==
X-Received: by 2002:ab0:498d:: with SMTP id e13mr3008243uad.134.1547074633029;
        Wed, 09 Jan 2019 14:57:13 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id q193sm27981421vsd.0.2019.01.09.14.57.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 14:57:11 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 197so2065242vkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:57:11 -0800 (PST)
X-Received: by 2002:a1f:e807:: with SMTP id f7mr2951324vkh.16.1547074630978;
 Wed, 09 Jan 2019 14:57:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org> <5f400b3a15cab5dd071e4a129d38cb21e7123b78.1547054308.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <5f400b3a15cab5dd071e4a129d38cb21e7123b78.1547054308.git.saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Jan 2019 14:57:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UgFwVdsTuaQhVA9q18Ns8n278A4mx=TrvuOW3mmZm84A@mail.gmail.com>
Message-ID: <CAD=FV=UgFwVdsTuaQhVA9q18Ns8n278A4mx=TrvuOW3mmZm84A@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm845: Remove the duplicate header inclusion
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 9, 2019 at 9:48 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Remove the duplicate inclusion of qcom,gcc-sdm845.h
> mistakenly introduced by commit 6e17f8140521 ("arm64:
> dts: sdm845: add prng-ee node").
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 03683179b8f7..8dced99f875e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -12,7 +12,6 @@
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> -#include <dt-bindings/clock/qcom,gcc-sdm845.h>

This was on my TODO list, but you beat me to it.  This could land any
time and is completely separate from the other patches in this series.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
