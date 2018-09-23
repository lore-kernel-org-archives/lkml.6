Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB7ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 03:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C685620C0A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 03:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="We3IhKWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C685620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeIWJk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 05:40:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46252 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeIWJk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 05:40:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id t20-v6so4204870ply.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 20:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=a8W8QpalLehtIpNxyJxBvUYytgQYATfpGtMk9JBjP4I=;
        b=We3IhKWyQsOMBGMLZdKLwgZb/3ximD7DcKUniEiCrIZmcvQSgQRRZk5t7qzsr63+FX
         YgCPy81PlZAJQq0xJPxmo8ENxoPIB2gqlT3gEasA0AYP5/+qKFoDgUVBKqexMDZ9CeF7
         vJ/rdv6kbBXkGPghJ04GzZ98E3AqDULNlq/9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=a8W8QpalLehtIpNxyJxBvUYytgQYATfpGtMk9JBjP4I=;
        b=TynNhkm6wiVUmI60IVrTRj2bUvACqEofM3CMQlkCo8AjJlxfoTQHeVJ8a7SLMYUZ4G
         /7nvqHidtBorrgBTTeqLpGa3cGSdS7GCCXhTN7EgRpRzP9eMaOrfcIPB+7jiZtr2Vt+e
         fPJWg0hW1cSU1HtcePxSczrnBIPOFNNAAsxOMaoGD9xVxNkYQU0XPROQkvPBpRGc3abw
         2zoiMZPpZjfse7WRkb4bgtfgDPfCgB2KlPNA+KmCwP4YwSzWJXscWHP5JT2mv4cSy30G
         HT5RkEXyUacAHD93/bcsNxL4UbcPVBxhBT6yfoRAvREWzQ83vbug3lRPKUAVLLfPhXW/
         LDxA==
X-Gm-Message-State: ABuFfojbzjgJtJIPU8pGqAi6E+5CK23rA3sPSoGgzZh7HbHi/pp4b0H4
        MDi30vSZIMjgQzY6fu38yOnQbKjkZMk=
X-Google-Smtp-Source: ACcGV62Tnr/K3u6Qe0CwUjqaiSy2Iq7nB7Kig4t7xxrTVSfRL0Y1cPVaaALKklZRIovp4VIflw4AJg==
X-Received: by 2002:a17:902:8542:: with SMTP id d2-v6mr4790785plo.285.1537674301443;
        Sat, 22 Sep 2018 20:45:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 5-v6sm69897pgt.83.2018.09.22.20.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 20:45:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180921185106.GJ20825@sirena.org.uk>
Cc:     Doug Anderson <dianders@chromium.org>, ryandcase@chromium.org,
        boris.brezillon@bootlin.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
 <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
 <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
 <20180921185106.GJ20825@sirena.org.uk>
Message-ID: <153767430006.119890.17210317555572798122@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Sat, 22 Sep 2018 20:45:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2018-09-21 11:51:06)
> On Fri, Sep 21, 2018 at 11:40:24AM -0700, Stephen Boyd wrote:
> =

> > It seems that everybody has misunderstood my email. Let me try to
> > clarify.
> =

> > I'm not saying to replace the sdm845 qspi compatible with a generic one.
> > I'm recommending that a generic one is added in addition to the SoC
> > specific one. That way, we get to put the generic compatible string in
> > the driver and not need to update the driver compatible string array
> > each time a new SoC comes out with a new compatible string.
> =

> > If it turns out later that we need to handle some bug in that specific
> > SoC compatible string then we're good to go and we can handle it by
> > matching the more specific SoC version compatible.
> =

> Right, the policy is generally not to have these strings at all.  IIRC
> the argument is that they tend to either become unclear as the marketing
> and technology changes.

Where is this policy documented? Is it on the list somewhere or written
in Documentation/devicetree/? From my read of Rob's comment in the
previous version of this patch, all that was asked was to add another
compatible string for the specific SoC.

I find the approach of picking the first SoC that the driver works on to
be obtuse. I don't want to be reading some SoC DTS and see another SoC
marketing number in the compatible string because it makes it confusing
to explain to someone that yes these different SoCs are related to each
other, but no, that SoC isn't this SoC. Sure it all works and everything
is technically fine, but my aesthetically pleasing alarms go off and I
don't see any particular downside to having two compatibles.

The upside is that things aren't confusing and drivers don't get
continual SoC churn updates because the compatible describes the SoC
(qcom,sdm845-qspi) and the programming model (qcom,qspi-v1).

