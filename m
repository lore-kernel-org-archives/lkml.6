Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE5CECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC0321480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TLS4dN1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC0321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbeIXXQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:16:31 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36752 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeIXXQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:16:31 -0400
Received: by mail-vs1-f67.google.com with SMTP id z19-v6so8694473vso.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTgciA8RdONUC8AqLkJ2zJch9XUdWUb0odUmi26Tw+M=;
        b=TLS4dN1dxklbTp37Gu8N5V1lH5WWAY0CYy+3Lf+vXrTsoekl85Is5pTB36LwCbSKxJ
         tONPcWNYiNJea40wtlFfv3rVyVAdalsWOneYVXdOQRpnbnBIWaBAKUy70sknZvSBunpR
         fw3A10pBk9/kL0eNLBsKLOZQVQrufvVuWE8/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTgciA8RdONUC8AqLkJ2zJch9XUdWUb0odUmi26Tw+M=;
        b=K9qLntS9J7F9dVsmNyvqavbtC9AoFJY+U+1jZf/0nlDtQUvtvbVVWiZLkjuEPaU7Xx
         yZzuQKBTzV3MnZ1LitCfmiEvCLDT9H6raCCHLINH96JrzNAHDlyyZ0c2qwB4SGoFs72m
         oSv3m+tvFfFmB/K4kgr8aRkgFcT8c0wOGq01HBeJdpqsczwCTwaZt6ZcmOJ9WGkKRx3u
         2J57tXBmQhP9iSYbGpp1RIPFshPVjA80tfYOBD6Zo9W3nEtW627bDJPYBC/Tl7pordrr
         KAVU1a3tssm8NkjHsNdNM93CvyNwMfG93oDmb3+JYDGLCSodBzNXwTQLzr25/D3bNUM/
         5x3Q==
X-Gm-Message-State: APzg51D5WHWg1qKB8lUdtmxEofBzBtlHIuCHNE0I/j862nOnuaha4Bu1
        /h1zg4mpbTW1wtq0Z6ubtqRReZD3FyQ=
X-Google-Smtp-Source: ANB0VdaVVfYWB4nWERic2Et6AHzRd6AobiMiWbV7EkR5Xm2lIN8eaEbleD9/1GYvshfdT6J4CXkxqQ==
X-Received: by 2002:a67:341a:: with SMTP id b26-v6mr1400948vsa.110.1537809202599;
        Mon, 24 Sep 2018 10:13:22 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id r138-v6sm5405679vke.35.2018.09.24.10.13.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:13:22 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id m13-v6so821263uak.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:13:20 -0700 (PDT)
X-Received: by 2002:a9f:31cd:: with SMTP id w13-v6mr1740638uad.86.1537809199900;
 Mon, 24 Sep 2018 10:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
 <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
 <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
 <20180921185106.GJ20825@sirena.org.uk> <153767430006.119890.17210317555572798122@swboyd.mtv.corp.google.com>
In-Reply-To: <153767430006.119890.17210317555572798122@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Sep 2018 10:13:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WbiAj4eZqo+BnjesF_3XfbeD1h-s1aEGVETaRTa545iQ@mail.gmail.com>
Message-ID: <CAD=FV=WbiAj4eZqo+BnjesF_3XfbeD1h-s1aEGVETaRTa545iQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ryandcase@chromium.org, boris.brezillon@bootlin.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Sep 22, 2018 at 8:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Mark Brown (2018-09-21 11:51:06)
> > On Fri, Sep 21, 2018 at 11:40:24AM -0700, Stephen Boyd wrote:
> >
> > > It seems that everybody has misunderstood my email. Let me try to
> > > clarify.
> >
> > > I'm not saying to replace the sdm845 qspi compatible with a generic one.
> > > I'm recommending that a generic one is added in addition to the SoC
> > > specific one. That way, we get to put the generic compatible string in
> > > the driver and not need to update the driver compatible string array
> > > each time a new SoC comes out with a new compatible string.
> >
> > > If it turns out later that we need to handle some bug in that specific
> > > SoC compatible string then we're good to go and we can handle it by
> > > matching the more specific SoC version compatible.
> >
> > Right, the policy is generally not to have these strings at all.  IIRC
> > the argument is that they tend to either become unclear as the marketing
> > and technology changes.
>
> Where is this policy documented? Is it on the list somewhere or written
> in Documentation/devicetree/?

I don't of it being documented anywhere, but it's what I've been told
before.  I spent a bit of time to find a specific example but I
couldn't.  As with a lot of device tree stuff it historically has been
a bunch of word-of-mouth type stuff.  It does look like people are
moving towards a more formal spec at
<https://github.com/devicetree-org/devicetree-specification/> but it
doesn't include this guideline.


> From my read of Rob's comment in the
> previous version of this patch, all that was asked was to add another
> compatible string for the specific SoC.
>
> I find the approach of picking the first SoC that the driver works on to
> be obtuse. I don't want to be reading some SoC DTS and see another SoC
> marketing number in the compatible string because it makes it confusing
> to explain to someone that yes these different SoCs are related to each
> other, but no, that SoC isn't this SoC. Sure it all works and everything
> is technically fine, but my aesthetically pleasing alarms go off and I
> don't see any particular downside to having two compatibles.
>
> The upside is that things aren't confusing and drivers don't get
> continual SoC churn updates because the compatible describes the SoC
> (qcom,sdm845-qspi) and the programming model (qcom,qspi-v1).

IIUC previous suggestions about just naming it based on the first SoC
was due to the difficulty of coming up with a good generic name to
give something.  For instance you definitely wouldn't want to name it
"qcom-qspi-sdm8xx" because you have no idea what future SoCs will be
numbered.

In the case here calling it "qcom,qspi-v1" is better than that and if
Rob gives the thumbs up then I won't object to it.  In general though
looking at other device tree bindings this doesn't seem like a thing
commonly done.  Perhaps if we decide it's useful here we should start
suggesting it everywhere...

-Doug



-Doug
