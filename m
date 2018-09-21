Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10730ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55AC21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZcmBLwh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55AC21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391298AbeIVAis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:38:48 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34061 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391285AbeIVAir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:38:47 -0400
Received: by mail-vk1-f195.google.com with SMTP id s10-v6so321982vkh.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daSwPJoBLFxU3Hw4bXbtpBZBo8Tk+a7yjKoCE+I60Ew=;
        b=ZcmBLwh+fpOHB7yFD5E+dWOCybcsV1s7MDhUBBs7VZXVqjsFlGduQ9jefC3R2wibb+
         OKM9J7+hiS8n3qtG4KII+IUBwL2pYwb981gK95dxxGK32ImuBDaWw0c60qrJfoO5Dzfb
         SV/bXVBtzxgUH3+hfgltb2B94bHc++MgAFQF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daSwPJoBLFxU3Hw4bXbtpBZBo8Tk+a7yjKoCE+I60Ew=;
        b=AoZYQUenO/ieCIvuUFlyimswVModxjEuzz4Ivg58lTmk+LDfWm3At5fF/XjLT713Em
         GwCfL5n9zLxEx6sfB5emaDe6IYpJxf12rRBwYniVCt4VzHeJA3RryUTjVDPNZye+vKSH
         suLSPMiCPQp9k/2myk3LELpLsuht27v0PFJ2K/H1jgK8w3NFPe8IY5NdHstmgLglV/a1
         ro2tfZrvCeIRXmzAhPRzsbAmKmu3+QC2rP8amSN3si+UYkm1rOb37QxSUKH1qyJH0hVw
         2mxWerHhQHqnM1yMgoHdSniZZIq5ifzTahuQJ7Vr0/s6pGU4kHnu+9trOgDQWZXntoqg
         frag==
X-Gm-Message-State: APzg51ASAjTV6W6oGeM4CthRTwQFuSAAAv8cCHClBn4lCmueO3RtrHI1
        M75Mzh64B/ThAjXgTx9CxmUUYl6GJiA=
X-Google-Smtp-Source: ANB0VdZiXyDFNHdt+HaxmITQEzYUS7PtVCdkg8ZSKw0Ds+nNO4LUSwqFVclOmfaA2nvoFAsHjWaX/A==
X-Received: by 2002:a1f:d507:: with SMTP id m7-v6mr12365738vkg.40.1537555716947;
        Fri, 21 Sep 2018 11:48:36 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id e185-v6sm4457072vkd.15.2018.09.21.11.48.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 11:48:36 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id y11-v6so5240653vso.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:48:35 -0700 (PDT)
X-Received: by 2002:a67:8391:: with SMTP id f139-v6mr13978740vsd.6.1537555715438;
 Fri, 21 Sep 2018 11:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
 <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com> <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
In-Reply-To: <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Sep 2018 11:48:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vsj-u=-6dU245p7aAT76sKLAiOJBK+1M6EnTQ6es5Lug@mail.gmail.com>
Message-ID: <CAD=FV=Vsj-u=-6dU245p7aAT76sKLAiOJBK+1M6EnTQ6es5Lug@mail.gmail.com>
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

Stephen
On Fri, Sep 21, 2018 at 11:40 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2018-09-21 10:40:14)
> > Hi,
> >
> > On Fri, Sep 21, 2018 at 10:31 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Ryan Case (2018-09-20 15:40:54)
> > > > diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> > > > new file mode 100644
> > > > index 000000000000..ecfb1e2bd520
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> > > > @@ -0,0 +1,36 @@
> > > > +Qualcomm Quad Serial Peripheral Interface (QSPI)
> > > > +
> > > > +The QSPI controller allows SPI protocol communication in single, dual, or quad
> > > > +wire transmission modes for read/write access to slaves such as NOR flash.
> > > > +
> > > > +Required properties:
> > > > +- compatible:  Should contain:
> > > > +               "qcom,sdm845-qspi"
> > >
> > > Does someone have a more generic compatible string that can be added
> > > here to indicate the type of quad SPI controller this is? I really doubt
> > > this is a one-off hardware block for the specific SDM845 SoC.
> >
> > The compatible string used to be "qcom,qspi-v1".  ...but Rob Herring
> > requested [1] "an SoC specific compatible string".  While we could do
> > a compatible string like:
> >
> >   "qcom,sdm845-qspi", "qcom,qspi-v1".
> >
> > I'm curious if that buys us anything.  From all my previous experience
> > with device tree it is fine to name a compatible string for a
> > component based on the first SoC that used it.  If we later find that
> > this is also used in an "msm1234" we could always later do the
> > compatible string for that device as:
> >
> >   "qcom, msm1234-qspi", "qcom,sdm845-qspi"
> >
> > ...and we don't need to try to come up with a generic name.
> > Obviously, though, I'll cede to whatever Rob says here though.
> >
>
> It seems that everybody has misunderstood my email. Let me try to
> clarify.
>
> I'm not saying to replace the sdm845 qspi compatible with a generic one.
> I'm recommending that a generic one is added in addition to the SoC
> specific one. That way, we get to put the generic compatible string in
> the driver and not need to update the driver compatible string array
> each time a new SoC comes out with a new compatible string.
>
> If it turns out later that we need to handle some bug in that specific
> SoC compatible string then we're good to go and we can handle it by
> matching the more specific SoC version compatible.

I don't think I misunderstood.  I was suggesting that I believe that
the device tree way is to use the first SoC as the generic one.  In
other words to support sdm845 and msm1234, we do:

A)
on sdm845: "qcom,sdm845-qspi"
on msm1234 (later): "qcom, msm1234-qspi", "qcom,sdm845-qspi"

What you are suggesting (I think) is:

B)
on sdm845: "qcom,sdm845-qspi", "qcom,qspi-v1"
on msm1234 (later): "qcom, msm1234-qspi", "qcom,qspi-v1"

If Rob likes B) better then it's fine with me, it was just my
understanding that A) was the suggested way to do things (even if it
is decidedly non-symmetric).


NOTE: Even with A) there's no need to update the driver for msm1234
since it has the fallback to sdm845.

-Doug
