Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5F6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE54F208B9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AFbhIFPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE54F208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeHXTsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:48:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40348 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeHXTsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:48:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id s13-v6so4602287pfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=Hr4TBwYj7koLUevDHCY5CFiTLC8CFFPV6YeOfZHcG9Y=;
        b=AFbhIFPVgd39uf9hbsFkQihlNklXij8ubZR2ni8OHGN5kpZ3Faoi8cFhvj629+xiBG
         rtz3wH2ZaWYYfIOSvVBkVzy1QexDsLIl4UeG2e+qaW1Z1b/QQKQOnLvQLGEzsVOF0+a6
         MUNEEUiDTWShRmXMMtqdpezXxAg42otTkCuaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=Hr4TBwYj7koLUevDHCY5CFiTLC8CFFPV6YeOfZHcG9Y=;
        b=jt4N71xK+DkcPxeBGg1Kgmp6wqatbBoWhf2fMfpGqJ9TErlWjBYdOt/h0YF06w27jn
         jdlJoNcTiuDzyA13OhvoNQmPs/h61Yf405EYmYyf2EzKdGIQG2ZW03ILB/xHESio4Zf7
         4NL2zGGJpntmWQdiaBrrIQH0NCHrW3aaL7Mrc+5VeXpkGgoMw95Uft2YNUfcB1Pjbb2e
         /v0ulF7UA4Dzh0KtNfO97LSHAfNby3Up+xdxwcDYKJaOAXrJf5KEaPPtg11+92Ot51Ll
         cj08X5OSnS2NQkNwes5o0hdUs4BX/X1KBu+Rb9OcyReUn6TFkbSDMgVGz+bV8HYdU9wB
         8wyA==
X-Gm-Message-State: APzg51D45xsMgRD3WlZlNueIMmNWlkA/TUjUMc0Qc6YKaD4QWyklFgJg
        //PFn6s6ys2OlnUk4chEtQWAMQ==
X-Google-Smtp-Source: ANB0VdYtcvskkRhVD74145xrZ3r64cd4QKq7V56QYcGG3mddqmVPKdGB2gLjyHcgx21HM8xwFRff8w==
X-Received: by 2002:a62:4083:: with SMTP id f3-v6mr2683883pfd.229.1535127198551;
        Fri, 24 Aug 2018 09:13:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id n24-v6sm12431841pfi.161.2018.08.24.09.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 09:13:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180822173629.202885-3-dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, tfiga@chromium.org,
        Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
References: <20180822173629.202885-1-dianders@chromium.org>
 <20180822173629.202885-3-dianders@chromium.org>
Message-ID: <153512719741.28926.12143989866944999581@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB regulators
Date:   Fri, 24 Aug 2018 09:13:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-08-22 10:36:28)
> Add regulator devices for PMIC regulators managed via VRM and XOB
> RPMh accelerators.
> =

> A few notes here:
> - Regulators are added directly to the board file.  While it's true
>   that this will mean a bunch of copy/pasting for other boards that
>   are very similar, this is probably the right call since boards
>   could make changes to the way these regulators are hooked up and
>   trying to find a way to avoid duplication will result in some
>   confusing node overrides.
> - Regulators that are hooked up to supply pins on the SoC are given
>   an alias matching the name of that pin (pin name comes from the
>   Qualcomm SoC "device specification" doc).
> - Other regulator labels are based on the schematic.  If there is
>   more than one logical name on the schematic for the same rail the
>   secondary names are also listed and should be referred to as
>   appropriate.
> - Regulators all default to HPM mode w/ no ability to switch modes.
>   Future patches can switch things to LPM and possibly add
>   dynamic load switching if we have determined there's a benefit.
>   This should only be done for rails where we'll actually be able
>   to take advantage of the lower power modes so we don't need to
>   churn with lots of patches adding regulator_set_load() calls
>   to drivers.
> =

> NOTE: This patch is loosely based on one originally shared to me by
> David Collins.
> =

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

