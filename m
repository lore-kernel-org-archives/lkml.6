Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B5CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923B820832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DhZWraYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923B820832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeK1QmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:42:21 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46726 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeK1QmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:42:21 -0500
Received: by mail-vs1-f66.google.com with SMTP id r14so15298871vsc.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 21:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2b4V0NYgh0a9cR7D62GI5pYAgqupLM7mCCU32Tyv14=;
        b=DhZWraYj+9epeDosLbEU0LHcUWtCvVeXrLiDJq6XaZ1yZShX3wI3rCIWyVcknQ3YKo
         lR7cJo5bOeZiyq7UVXnN5E7lxCIOMnJuxG/hJJ7PGb9E5odiH3ap7vV0g073wZnnATbG
         Ik2c9wLo5bTp/UityEPETZjhyhzUmh2v12X8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2b4V0NYgh0a9cR7D62GI5pYAgqupLM7mCCU32Tyv14=;
        b=sviFoPOsMnnGYgbuYjT1R65yFZlP4CZy00svV7VpAERMfoSlpEPFM/n3up2SsNXA1T
         Z6h4Rf347YwDAt+yRaFjrg2nhV4fb0FyFNgKAyiaR3WsR+O++tgCBHf2VUS9SIsq6rst
         2U4zVchrY3D5zUhHtRaQZcZzpW5w3e5B6KtBUTwOn2FBspovZ0YyGCACyYpz+byUbqRe
         4j78wVlkvUHmbYLpNzu5ofOOLSqF2An5A/JHRRCKblEcuD51gW5PSYMhXKCejXgoHrlR
         w5wZiZI3nG5/AlXwgDXkvEalaBxXpkk4eT2P4WhCb7+FJgNkhvmWY/QyTm8ufVU4YcJz
         qXiA==
X-Gm-Message-State: AGRZ1gIzpG6t/IWbnc3LEY1DEugRCttoT9xAugiYiagaDkJ0S5dzRxZD
        Lm07ggAgw9/o0mS/F8aiVOwd9pq4exU=
X-Google-Smtp-Source: AJdET5eLDSerkQM5vXyHFmZR8MrYMENKc8JdbuEQ7IVH3x4zzaSv9M4NvQEnzOsVQnCOEn/MqnGw0A==
X-Received: by 2002:a67:7b0a:: with SMTP id w10mr15231618vsc.5.1543383715871;
        Tue, 27 Nov 2018 21:41:55 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id x132sm1953090vsc.34.2018.11.27.21.41.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 21:41:53 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id t132so4883718vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 21:41:53 -0800 (PST)
X-Received: by 2002:a1f:1881:: with SMTP id 123mr4108288vky.40.1543383713013;
 Tue, 27 Nov 2018 21:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20181126231159.122298-1-mka@chromium.org> <20181126231159.122298-2-mka@chromium.org>
In-Reply-To: <20181126231159.122298-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 21:41:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WvXFpZDJGbdvvY=HL_=tDWyhKpTg7zu8s=gUuJgK1ebg@mail.gmail.com>
Message-ID: <CAD=FV=WvXFpZDJGbdvvY=HL_=tDWyhKpTg7zu8s=gUuJgK1ebg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: msm/dsi: Add ref clock for PHYs
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
> Allow the PHY drivers to get the ref clock from the DT.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - add the ref clock for all PHYs, not only the 10nm one
> - updated commit message
> ---
>  Documentation/devicetree/bindings/display/msm/dsi.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
> index dfc743219bd88..b0485559a719c 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi.txt
> +++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
> @@ -106,6 +106,7 @@ Required properties:
>  - clocks: Phandles to device clocks. See [1] for details on clock bindings.
>  - clock-names: the following clocks are required:
>    * "iface"
> +  * "ref"

We can't quite make ref "required" because there are some old device
tree files dating back to 2016 that would be broken.  It could be
listed as optional, but I _think_ Rob is OK with it being listed as
"required" for all new device tree files with the footnote that if
it's not present then the code will still work.
