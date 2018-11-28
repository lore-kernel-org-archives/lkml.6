Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EBD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bco2TzFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EBD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeK1RUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:20:52 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35799 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1RUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:20:52 -0500
Received: by mail-vs1-f68.google.com with SMTP id e7so15364554vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YaHZfO/qCQH1VESItFAu4BMUvRx9Jd7R3b6gkSc1kzM=;
        b=Bco2TzFW5PjK3A8u1TZoSS/ASK/Z0SoC6OLCQk1EWhOZgo5tLpQ3Oe2toCjZnqLz5w
         hpwS9dxRfsOzw2Hd/t196Au5wcca6spQsskvM1cYneP4oLWlLGxe0u2t07wY3zuz29yh
         PLnpWcYTIg325rhdbHvGFvSIzr3ruECk7mD/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaHZfO/qCQH1VESItFAu4BMUvRx9Jd7R3b6gkSc1kzM=;
        b=gspu92IW9TXbPBsELiZR4MqKnwNAa+Y75STuZE5DS7PJaBnk1RH3enljpGiKidHII7
         DsePPcnHJ8F2lNs1JdHqwkNOFm8dpOnSEiI/j8sznuoX38ozhrc5OMIsKgDLqxWe4OPZ
         3KebFKgeYfzBpPe0iM/oSDaS9YbfTpXlAYEtc680YzVLDL2WGGFnumDV7EEIJox9HtHt
         UVDvoO7MP0cu9/CAKnnPZ5ks4tAPdEP5ZrW7e68OnuBR/I9QoO4r9zUeTQ4PijzMUOIj
         iAdbbLs2b+Zis2F/f9IR48/lQ9YTxiXuXw0DvZeP6y2JLdNcjBpLAU9IQ6fYkdEoXW34
         PgaQ==
X-Gm-Message-State: AGRZ1gLrZ1Y3azRLI7sHUBVVtKX76Nz5gs964aEKfB/78ZipgLVPEEYM
        p/dQ03wzF9AbHY5FCF+v0G7ecLsDaGM=
X-Google-Smtp-Source: AJdET5e6LjsaQwYgA/5ak2dZJpvswUfUeuoqSg/5TZ+tt3LvT66Vi0no0Y1ll/3UYiAHk/DtoN+i9w==
X-Received: by 2002:a67:1346:: with SMTP id 67mr13471218vst.31.1543386020756;
        Tue, 27 Nov 2018 22:20:20 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id k200sm2154798vke.9.2018.11.27.22.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 22:20:20 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id v24so8502100uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:20:20 -0800 (PST)
X-Received: by 2002:ab0:1c12:: with SMTP id a18mr13972201uaj.15.1543385566600;
 Tue, 27 Nov 2018 22:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20181126231159.122298-1-mka@chromium.org> <20181126231159.122298-7-mka@chromium.org>
In-Reply-To: <20181126231159.122298-7-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 22:12:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VZ+9D8Ho+ncSvgdHAPEX52ocZXFAJQP47FwcwT-VXfLA@mail.gmail.com>
Message-ID: <CAD=FV=VZ+9D8Ho+ncSvgdHAPEX52ocZXFAJQP47FwcwT-VXfLA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of
 the DSI PHYs
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 26, 2018 at 3:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add 'bi_tcxo' as ref clock for the DSI PHYs, it was previously
> hardcoded in the PLL 'driver' for the 10nm PHY.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> based on "[v4,1/3] arm64: dts: qcom: sdm845: Add dpu to sdm845 dts file"
>   (https://patchwork.kernel.org/patch/10666253/)
>
> Changes in v2:
> - patch added to the series
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
