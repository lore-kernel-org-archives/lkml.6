Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AC4ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E70E20877
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wb8AnIO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E70E20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391263AbeIVAae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:30:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42968 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391184AbeIVAae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:30:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so6344430pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=aJg3mbLuMaDZipfaa9zO8WUvakVHAM/Ns2IURjBoX4s=;
        b=Wb8AnIO+YP3hKheDnFqRRU2DaBxIRzV86W4zXS4FpykrPaQmwkvUcqiMSz8ZvxlPlj
         nIA+PfUSbvnaQxHOaYLbqSNQ1dz1ROqizDS0tLQuQsjfX/V5fqgCiVKRrzLzTjoK0HcC
         5SGtTg78cNUSmNKVNAQlnpyV3+TrPAQ48Jq/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=aJg3mbLuMaDZipfaa9zO8WUvakVHAM/Ns2IURjBoX4s=;
        b=iSl7k8cn05dW/PvEANzXC6zq7FhuijqMVYGVy/fbQM1Gn5w9XatdQHLYzkMkopJgZX
         KpC4XLhqkoq7CxBe/rvV1GxYu/8FK/uW6NbVI1zky7HEG6Lekypvj22VEa6nPen+LzjE
         3t5zZFqZLENSwugI0XHaPjc1OHpV1yCzTFILkpnSm++in2Jlgvh72nHDdn4BS2azchQ0
         Y2oTYTT6xqWXs/uHd4nHvgQznbMZ6tyJY0ZQ+Cy4j8/zcwLJdwWlh9WrLxjS2ZrGj8VY
         DN6zOOeVFOLt0H7wuAZtD+gsGYaAKnrlA/cKPxnibi6X9ydRLAm2wXJgo0fRjs+7Ryc9
         haaA==
X-Gm-Message-State: APzg51Bg4P8v5fImD5JmJzfHqAiRdhreoxiGCSl7aAzu9awNl8G+ovZ4
        hTcQSTZOU1miokp4OK2cGQMhcw==
X-Google-Smtp-Source: ANB0VdZfIzOc2txX9qv5rfJUmm0rRJhxssBATwd/c5I5n3ic3j0UuAG1KLWbfL5KbKt7E0InHHLEWg==
X-Received: by 2002:a62:1605:: with SMTP id 5-v6mr47691256pfw.11.1537555225423;
        Fri, 21 Sep 2018 11:40:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id x82-v6sm49842957pfe.129.2018.09.21.11.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 11:40:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, ryandcase@chromium.org,
        boris.brezillon@bootlin.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
 <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
Message-ID: <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Fri, 21 Sep 2018 11:40:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-09-21 10:40:14)
> Hi,
> =

> On Fri, Sep 21, 2018 at 10:31 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Ryan Case (2018-09-20 15:40:54)
> > > diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi=
.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> > > new file mode 100644
> > > index 000000000000..ecfb1e2bd520
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> > > @@ -0,0 +1,36 @@
> > > +Qualcomm Quad Serial Peripheral Interface (QSPI)
> > > +
> > > +The QSPI controller allows SPI protocol communication in single, dua=
l, or quad
> > > +wire transmission modes for read/write access to slaves such as NOR =
flash.
> > > +
> > > +Required properties:
> > > +- compatible:  Should contain:
> > > +               "qcom,sdm845-qspi"
> >
> > Does someone have a more generic compatible string that can be added
> > here to indicate the type of quad SPI controller this is? I really doubt
> > this is a one-off hardware block for the specific SDM845 SoC.
> =

> The compatible string used to be "qcom,qspi-v1".  ...but Rob Herring
> requested [1] "an SoC specific compatible string".  While we could do
> a compatible string like:
> =

>   "qcom,sdm845-qspi", "qcom,qspi-v1".
> =

> I'm curious if that buys us anything.  From all my previous experience
> with device tree it is fine to name a compatible string for a
> component based on the first SoC that used it.  If we later find that
> this is also used in an "msm1234" we could always later do the
> compatible string for that device as:
> =

>   "qcom, msm1234-qspi", "qcom,sdm845-qspi"
> =

> ...and we don't need to try to come up with a generic name.
> Obviously, though, I'll cede to whatever Rob says here though.
> =


It seems that everybody has misunderstood my email. Let me try to
clarify.

I'm not saying to replace the sdm845 qspi compatible with a generic one.
I'm recommending that a generic one is added in addition to the SoC
specific one. That way, we get to put the generic compatible string in
the driver and not need to update the driver compatible string array
each time a new SoC comes out with a new compatible string.

If it turns out later that we need to handle some bug in that specific
SoC compatible string then we're good to go and we can handle it by
matching the more specific SoC version compatible.

