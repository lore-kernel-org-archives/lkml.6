Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67E8C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D72221473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWaMb+01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D72221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJDFVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:21:38 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46731 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJDFVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:21:38 -0400
Received: by mail-ua1-f68.google.com with SMTP id 19so2699986uas.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0TDFypTotBql+A7b4yAJX6Grzolu4RqSeUtinc2Naw=;
        b=JWaMb+01+q7GFZLTVc2dlFWYPVloCL3YdJq6NJNpDS1MR2/jskYsvKdRiqpKvwUBSA
         T4O3Zcs08LYrBIUby1Nlu0KVlTufi61QOdvXhjlXFxkVwNgySlZ7/8t2ICUhgBMbUr65
         WZE+bkGP5bFeHkJ8h11Ux9wMPaAN7Mt3pZYlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0TDFypTotBql+A7b4yAJX6Grzolu4RqSeUtinc2Naw=;
        b=tr3DUz+d4mvopK5i0fdIQCWEYW+YJGQL4buOGHe4dOstByQ/ZmzfP80JbNBE804AP+
         ohqa9VGm7HavnCC2Yv5XymMcnYzmLg6e1xiyeFu0X567PpSnNUomGCpWjgCjVZg0iVjX
         FM5qjFLZkQpy7GE1cfga6ZhBVJBE6/Ux/RT6ednkylm67gs0BWJ+9uO9pocy30qjzzFk
         rWnkU1tCqvdtaxxCKNYECH8Z2z9PoYvX5sHuR4gHNenrQgcSnzzUjf5yx2cxUw1PDJze
         aXiOuctMuG2XKYkqvdc0pUEED4C3BhQL6kHE82KdIQZr5BcbMuVqe9nNFZLFLUENTZTY
         kxvA==
X-Gm-Message-State: ABuFfogXOGqYJiBRhXOw4HYmGtJCeWLes72vI1D/Fw3nOhFSeF6elLw/
        63ShWzqURY7KOt3ESlcY/l03oTu+gxI=
X-Google-Smtp-Source: ACcGV61E+3o24fAjfYzA+/NJjScMGaRfUqkmLZ2rSyGQnNhDmiosBJA/v5FNhCb+RVYwueMAslvZqA==
X-Received: by 2002:a9f:2f17:: with SMTP id x23-v6mr1494882uaj.54.1538605876799;
        Wed, 03 Oct 2018 15:31:16 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a35sm1895892uaa.1.2018.10.03.15.31.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 15:31:15 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id w8-v6so4237942vsl.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:31:15 -0700 (PDT)
X-Received: by 2002:a67:83d5:: with SMTP id f204-v6mr1431010vsd.6.1538605875406;
 Wed, 03 Oct 2018 15:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181003211239.41069-1-mka@chromium.org>
In-Reply-To: <20181003211239.41069-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Oct 2018 15:31:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XAqyLqyQQmM8pqPUh-ZvbxXgjSaypqGd4-orpWg3btgA@mail.gmail.com>
Message-ID: <CAD=FV=XAqyLqyQQmM8pqPUh-ZvbxXgjSaypqGd4-orpWg3btgA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add UART nodes
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 3, 2018 at 2:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> +                       uart8: serial@a80000 {
> +                               compatible = "qcom,geni-uart";
> +                               reg = <0xa80000 0x4000>;
> +                               clock-names = "se";
> +                               clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;

uart8/10/11/12/13/14/15 are on GCC_QUPV3_WRAP1_S0_CLK, not WRAP0.

Everything else here looks good.  I ran my old hacky script at
<http://crosreview.com/1091631> (mentioned in the message of commit
897cf34e7305 ("arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9
nodes")) after changing it to generate "qcom,geni-uart" as the
compatible string and changing it to generate nodes for all UARTs and
the diff looks fine.

...so once you fix the clock reference feel free to add my Reviewed-by.

-Doug
