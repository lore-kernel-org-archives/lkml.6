Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7E2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A62921536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHlmSGsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A62921536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeI0Eit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:38:49 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39622 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeI0Eit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:38:49 -0400
Received: by mail-vs1-f67.google.com with SMTP id d1-v6so362153vsm.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9UnrNT9ru6glr54gccQTs5a2cgpOYhK1XM7LTbnnI4=;
        b=lHlmSGsDo6lsopBjPvuL2YGZ/b6aJjB7vVUAIMrKC6fP4SuTsqvBGJ3/M64HdDu8DI
         A8TFqe0OxLT+5jCZBOstTQnyDhflsL+CrGUM7SSD7rYJ7JSZpuEwn71QEzloHeBQiHxe
         6Y0cl5IACgrTp8KEdi3qRC0KXNpa2tzaBE8p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9UnrNT9ru6glr54gccQTs5a2cgpOYhK1XM7LTbnnI4=;
        b=Sya+GjfWrkHjB10sPj+JdT5l1WAuOMIobQWjfm/unUr67wOYON/yj+AKlW+hWZUCP1
         4Xec26Nyn6i1b5uA88/p5GhFef/6WMT49O8GhK+l5mxtwEK/sOzk1FXufiHAyjUN/9X2
         hXXTXdvHVg1ftGqxTbURwGOQFwd3sdw7N4mdDGWRqr+OqPLhmqjKfmF2WGMH2XqO0nye
         QNYKH+D+ec0ayXigE85XAMdsRrGkRFhXshroRjAv48CGWZk8myx1038anEolHzDR8jUB
         mFmFPRV5qwhSmVF9vpl/dX4WLeMu4VFbBsadWrrlS8x0OvYSvlRSFkSGPsYsqDSTOh6O
         /yuQ==
X-Gm-Message-State: ABuFfoh/pGRKKn7NGXh7Y73L95m17t6TOjcdvUUphCEeY1Botl/9n4+t
        Vw0Uev7yWwemvMjaJY3rjkmebpFGPAM=
X-Google-Smtp-Source: ACcGV63n0UDvtCpEHFkDFT0HtubkSiQ/Bm7DMrLcXlMsh/JLuWeUrUhl7x5Zq5tXXv4vLTSIff4bTQ==
X-Received: by 2002:a67:c982:: with SMTP id y2-v6mr2414053vsk.94.1538000621672;
        Wed, 26 Sep 2018 15:23:41 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id m197-v6sm62517vkh.14.2018.09.26.15.23.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 15:23:40 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id j14-v6so136062vke.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:23:40 -0700 (PDT)
X-Received: by 2002:a1f:e86:: with SMTP id 128-v6mr2444841vko.4.1538000619968;
 Wed, 26 Sep 2018 15:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180926205204.184898-1-ryandcase@chromium.org>
In-Reply-To: <20180926205204.184898-1-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Sep 2018 15:23:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNe8BjTx9AXx01tpPk5+dUEwOqU12H3r9_H40Asgte2A@mail.gmail.com>
Message-ID: <CAD=FV=VNe8BjTx9AXx01tpPk5+dUEwOqU12H3r9_H40Asgte2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
To:     ryandcase@chromium.org
Cc:     Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Trent Piepho <tpiepho@impinj.com>, boris.brezillon@bootlin.com,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 26, 2018 at 1:54 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> From: Girish Mahadevan <girishm@codeaurora.org>
>
> Bindings for Qualcomm Quad SPI used on SoCs such as sdm845.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
> Changes in v3:
> - Added generic compatible string in addition to specific SoC
>
> Changes in v2:
> - Added commit text
> - Removed invalid property
> - Updated example to match sdm845 with attached spi-nor
>
>  .../bindings/spi/qcom,spi-qcom-qspi.txt       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt

This looks good to me and change in v3 to add the SoC-specific string
in addition to the more generic string identifying the IP block
version matches my understanding of the correct things to do (as
discussed in the v2 patch).

Reviewed-by: Douglas Anderson <dianders@chromium.org>
