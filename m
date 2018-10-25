Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06896ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA6620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K3tRZn23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA6620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeJZFMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:12:53 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:32800 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeJZFMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:12:52 -0400
Received: by mail-vk1-f193.google.com with SMTP id l186so2545954vke.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fO5eD7yhqX038D2KWBCLSsDDH2MSjoa7aGOG1/O2KMA=;
        b=K3tRZn2363C+BK+itXZtPbqoKiVaH3AibBn7UAKDMBJdmOn0sySIqNlbYec2ButisQ
         xFileYIGUCSjLEP0WAiao0VlWAvt2ccV6FMWeq8Ij9IIIobmQNHjqQKtRgIBKplvZqrl
         oKVDTcwYVxPDbd1hz6yUdv6T/vDLP5k5BqB+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO5eD7yhqX038D2KWBCLSsDDH2MSjoa7aGOG1/O2KMA=;
        b=GaC36nCaJ+OLztQyaTYWWI3NdM/FOXp7VmeVfPIny7brOYxQKrgL7E9bz3xau2VOCe
         XqXlu1ljKLQlR/AOhuVWBBHsT6oGOyZsL4TzAm/tfvEJcP0axkLF7+XjfMk0XUtTyTB8
         QfgwDcmgFRbWwWowRRPwRhhkOKAgOWt0WuVVj3OngzVFCXo4dsi+dj9IXKWdnyrO9XQG
         RZY69VWj30vbLaDk3fmCVEUb+OOvlI9jRkNze79aadv61UaU/qo9KmZIYCmYlq5oZ7ox
         7Hg8o0Gv5oVcj6Bzp0WIhvUanTzybJQsGWeG6Rr67SU7pGM8+QXzh+Ni/upSPunC9AXn
         4zJg==
X-Gm-Message-State: AGRZ1gK+uwyvUEFr8YWCyVVJzQXPKsYxsmei4Ife3lijUqG1t2GPQiF5
        w4lohJ563vjywOuq6JBSs/YcIEVwZ2s=
X-Google-Smtp-Source: AJdET5fxwi3S0XnRMxGZn221pAP+ptUdbGj/a62gkRZgWjgCg5e8nTs07wMAWM83tkRczvj5/YRiGg==
X-Received: by 2002:a1f:ed86:: with SMTP id l128mr375632vkh.21.1540499917974;
        Thu, 25 Oct 2018 13:38:37 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id e80-v6sm2042155vke.52.2018.10.25.13.38.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:38:37 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id x3so379926ual.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:38:36 -0700 (PDT)
X-Received: by 2002:a9f:3829:: with SMTP id p38mr385577uad.25.1540499916395;
 Thu, 25 Oct 2018 13:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181025172318.31353-1-mgautam@codeaurora.org>
In-Reply-To: <20181025172318.31353-1-mgautam@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Oct 2018 13:38:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xk0VDp2mQ9B25XXovabiHAHr=Dm1v3Pavf_iaNGOexnw@mail.gmail.com>
Message-ID: <CAD=FV=Xk0VDp2mQ9B25XXovabiHAHr=Dm1v3Pavf_iaNGOexnw@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sdm845: Fix pcs_misc region address
 for UNI PHY
To:     Manu Gautam <mgautam@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Oct 25, 2018 at 10:23 AM Manu Gautam <mgautam@codeaurora.org> wrote:
>
> Correct address for pcs_misc register region of USB3 QMP UNI PHY.
> These registers are used during runtime-suspend/resume routines
> of phy.
>
> Fixes: ca4db2b538a1 ("arm64: dts: qcom: sdm845: Add USB-related nodes")
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..84bee81562a5 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1156,7 +1156,7 @@
>                                 reg = <0x88eb200 0x128>,
>                                       <0x88eb400 0x1fc>,
>                                       <0x88eb800 0x218>,
> -                                     <0x88e9600 0x70>;
> +                                     <0x88eb600 0x70>;

Whoops, sorry for not noticing this earlier.  Thanks for the fix!

Evan's most recent patch to the bindings [1] should also be fixed
eventually too.  It feels like those patches have gone through enough
spins though, so maybe we can just post this fix atop those?

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lkml.kernel.org/r/20181024172735.154304-2-evgreen@chromium.org
