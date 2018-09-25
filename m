Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455E4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D096A20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jot6ZLu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D096A20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbeIYWKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:10:41 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45349 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbeIYWKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:10:41 -0400
Received: by mail-vk1-f193.google.com with SMTP id b78-v6so4944173vka.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3c8fcyjWGdHsezGCd53iQEAOLawC7EGHRRpjnsokAU=;
        b=Jot6ZLu3xwrahFB5PmHLo3UhWJx8pZvq1POzBsNqYwUrnDDTv/Fzfc1D1c+iF3GUaQ
         LJv7Q+U3Dp60lWgZSMD4Au+gcK8Z05d7IMOFSR6m+uIkOcA+WxSFZ8Y1kjX97wggeQnr
         JDk0XdqqWJhnQ6Mg5Jh0CEwY+Rcb4gjM1yFkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3c8fcyjWGdHsezGCd53iQEAOLawC7EGHRRpjnsokAU=;
        b=SZgQTwMo1toMU170Rr6whbUu14p35ZgO+A6m85ZH9A+ICsIqqwTJIV+ndxvpw31Vnp
         3SwBiCD3rH3WPRD6KFiwjS5LWkRWeUJzpz3qj+qhyhNUi5O4kSwnLir2uEeFtDxyS05B
         DDCdqz469jQ6cs5B83k9X5IVP9baIAW1AYbujw8EgmCdAGISVML9uu/P7dqHRz6/9wfv
         Qdzl/HPxIsdtKv5U3MDNMMofvztViewYhXYEqHkEY1tYTaC5VtghRX6zxqukcCs0Nwgz
         IBGSj9gMFOnAm1gzn/PQGqOaSrlYI3BRHxKlTvH6uawhBJZ7UldKzcW+h+5bsnwmTWKT
         Z31w==
X-Gm-Message-State: ABuFfohqjDBYQDohqPIPg4JbCubsPKlrcKy3CDrQU8PRiIrqZ+veEBAn
        IXxYT1VJSfHb1/RrnI+SRmM/ZSYSTRc=
X-Google-Smtp-Source: ACcGV62Q75tjHqjM55WXpT/qXrT872+E39d9Jg40d7BGg8hH8+hCtevMEqlp9iZxVq8PsddBtYXG5g==
X-Received: by 2002:a1f:92c4:: with SMTP id u187-v6mr504573vkd.72.1537891350636;
        Tue, 25 Sep 2018 09:02:30 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id e63-v6sm1902105vka.22.2018.09.25.09.02.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 09:02:29 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id e139-v6so4953852vkf.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:02:29 -0700 (PDT)
X-Received: by 2002:a1f:e86:: with SMTP id 128-v6mr513660vko.4.1537891349016;
 Tue, 25 Sep 2018 09:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
 <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
 <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
 <20180921185106.GJ20825@sirena.org.uk> <153767430006.119890.17210317555572798122@swboyd.mtv.corp.google.com>
 <CAD=FV=WbiAj4eZqo+BnjesF_3XfbeD1h-s1aEGVETaRTa545iQ@mail.gmail.com> <1537813423.7736.46.camel@impinj.com>
In-Reply-To: <1537813423.7736.46.camel@impinj.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Sep 2018 09:02:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJXEwej5+mF2-+R=VGZ2WOB1b0TzAByH36TL-Th_3Zzg@mail.gmail.com>
Message-ID: <CAD=FV=WJXEwej5+mF2-+R=VGZ2WOB1b0TzAByH36TL-Th_3Zzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        boris.brezillon@bootlin.com, linux-spi <linux-spi@vger.kernel.org>,
        ryandcase@chromium.org, Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Sep 24, 2018 at 11:23 AM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Mon, 2018-09-24 at 10:13 -0700, Doug Anderson wrote:
> > IIUC previous suggestions about just naming it based on the first SoC
> > was due to the difficulty of coming up with a good generic name to
> > give something.  For instance you definitely wouldn't want to name it
> > "qcom-qspi-sdm8xx" because you have no idea what future SoCs will be
> > numbered.
>
> And the hypothetical sdm899 might use a non-compatible device that uses
> a different driver, and that really makes "qcom-qspi-sdm8xx" look dumb.
>
> >
> > In the case here calling it "qcom,qspi-v1" is better than that and if
> > Rob gives the thumbs up then I won't object to it.  In general though
> > looking at other device tree bindings this doesn't seem like a thing
> > commonly done.  Perhaps if we decide it's useful here we should start
> > suggesting it everywhere...
>
> It would help if the programming model or IP core name or whatever this
> is using was mentioned in the public reference manual for the SoC.
> Then is a lot more clear that a number of different SoCs all have the
> same quad spi controller inside them.
>
> Usually it's not like that.  The RMs just say, "it's got a SPI master
> with these registers."  What SoCs use the same IP module, which
> different?  When did they make a new version?  The silicon vendors
> don't tell you this.  So any name we make up for the IP module likely
> doesn't match reality.

Note that Rob did recently give a positive review to a similar binding.  See:

https://lore.kernel.org/patchwork/patch/979432/

Specifically the text from that binding was:

+                  Qcom SoCs must contain, as below, SoC-specific compatibles
+                  along with "qcom,smmu-v2":
+                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
+                  "qcom,sdm845-smmu-v2", "qcom,smmu-v2".

Given Rob's positive review there, it seems like it would be fine to do:

  "qcom,sdm845-qspi", "qcom,qspi-v1".

NOTE: In our case we don't need the "-v1" in SoC-specific case since
there's only one Quad SPI driver there.  As I understand it the reason
we needed the -v2 in the SoC-specific case for the SMMU was that there
are two totally different SMMUs in SDM845.  You can see history in the
v15 patch <https://lore.kernel.org/patchwork/patch/977888/>


-Doug
