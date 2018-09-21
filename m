Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A32ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EAF21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WLUMkU73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EAF21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391139AbeIUXaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:30:23 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40430 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIUXaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:30:23 -0400
Received: by mail-vs1-f65.google.com with SMTP id w138-v6so397122vsw.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMq2LjXCYVs8OMEP76EiqATN+P77az8zBB+g9RZHhqg=;
        b=WLUMkU73Q6hFS5bPSNPVirMZrjR2GMWZebanhMlpsuOpuYQQMZtxroCuUmxZS12+mt
         Ncj/cWjF01xSd9DFw4LYeyrGnzspSBtH0SeCbV4g5TEsfsDj7/MEhciTdgNlcsNEdc8Z
         r6iVhjMd56tyK28XT1CTX4sAnkNoDgsWZBR04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMq2LjXCYVs8OMEP76EiqATN+P77az8zBB+g9RZHhqg=;
        b=dRSp6gblRnZLKCvOWm35GCCwvXMv0VeFFVODImed5yM1u9weeGBVfk2WG2ufx/Ex4Y
         5iQ9+3ragFbRYfE1t7BJhvfQxAaOkMDs5TcXfSQWNTdnbOII/zXcu9ch4tayYEZwkdx7
         148Si/bpmN3VY9bXQnE2ifOLObcKqNgaBHO03joef75OJj0FkfnorqvERZeQQOCOkVqy
         5OPgR6v1NPkge1aQDQ3sjW/UiLq9nBLX09ww+Jvg946OTqoRmSy2gHia0Ud4Nwgba+vm
         /BrBfhyigehRnvMyazF+NHj8++z2FMrUlQLcuIG++y8P8Q6UWk0J5qSJzSRqlG0pL9nT
         kdBA==
X-Gm-Message-State: APzg51D5pQYiDCpX633VejnSB+ik8rZwe+VLGjx9jzd0CWrz2gLXCNnU
        Bto28G2IkI+VheFgAyMrTFTy8Nh7c2Q=
X-Google-Smtp-Source: ANB0VdZKF1wQoWjoZprW+990aaVC5Y4ikspjoz7CUAmgtXZkHlgEfOKfAVoBskYBVn5wzQqQy+QnUw==
X-Received: by 2002:a67:6844:: with SMTP id d65-v6mr13579403vsc.17.1537551626987;
        Fri, 21 Sep 2018 10:40:26 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 29-v6sm805171vkd.42.2018.09.21.10.40.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:40:26 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id q7-v6so6102012uam.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:40:25 -0700 (PDT)
X-Received: by 2002:ab0:1601:: with SMTP id k1-v6mr13782085uae.83.1537551625587;
 Fri, 21 Sep 2018 10:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180920224055.164856-1-ryandcase@chromium.org> <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
In-Reply-To: <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Sep 2018 10:40:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
Message-ID: <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, ryandcase@chromium.org,
        boris.brezillon@bootlin.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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

On Fri, Sep 21, 2018 at 10:31 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Ryan Case (2018-09-20 15:40:54)
> > diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> > new file mode 100644
> > index 000000000000..ecfb1e2bd520
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> > @@ -0,0 +1,36 @@
> > +Qualcomm Quad Serial Peripheral Interface (QSPI)
> > +
> > +The QSPI controller allows SPI protocol communication in single, dual, or quad
> > +wire transmission modes for read/write access to slaves such as NOR flash.
> > +
> > +Required properties:
> > +- compatible:  Should contain:
> > +               "qcom,sdm845-qspi"
>
> Does someone have a more generic compatible string that can be added
> here to indicate the type of quad SPI controller this is? I really doubt
> this is a one-off hardware block for the specific SDM845 SoC.

The compatible string used to be "qcom,qspi-v1".  ...but Rob Herring
requested [1] "an SoC specific compatible string".  While we could do
a compatible string like:

  "qcom,sdm845-qspi", "qcom,qspi-v1".

I'm curious if that buys us anything.  From all my previous experience
with device tree it is fine to name a compatible string for a
component based on the first SoC that used it.  If we later find that
this is also used in an "msm1234" we could always later do the
compatible string for that device as:

  "qcom, msm1234-qspi", "qcom,sdm845-qspi"

...and we don't need to try to come up with a generic name.
Obviously, though, I'll cede to whatever Rob says here though.

-Doug


[1] http://lkml.kernel.org/r/20180716222721.GA12854@rob-hp-laptop


>
> > +- reg:         Should contain the base register location and length.
> > +- interrupts:  Interrupt number used by the controller.
> > +- clocks:      Should contain the core and AHB clock.
> > +- clock-names: Should be "core" for core clock and "iface" for AHB clock.
> > +
