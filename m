Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9C9ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888B5206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LtuBwOa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888B5206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbeGRAdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:33:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43731 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbeGRAdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:33:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id o7-v6so1146411plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JOTIg5S1DeMBuAH67JxisCJzy5BZttNGDq/CqfUtoSE=;
        b=LtuBwOa6vLmtebpU49IH86EvdCSg04Lkms+eMou7CqvLneiq9Yez1Lr73m9dRmcltY
         HbVlOpFLeVnCIRSmkcJRfm1AvbIz52jdW343S1soJKuBrCPpt0iBHChiduMVbALxmOrA
         obrD/jEasFdl7LEbkZaUEVqXuB2ZZXLjYILnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JOTIg5S1DeMBuAH67JxisCJzy5BZttNGDq/CqfUtoSE=;
        b=RlmFg8mNpVuS8k4SdsI6OlJ3J3H5QvAGj6IWOHfXwIabMqrWi8iao1jsL9ABB7Zl49
         YsIoWAoEtLu72uS/IoK6QsurNiXu5JzattojZ0+CQNfTlddYSxgrURMftsEhFP4xsaES
         KGIj5GIrUgLWN6UZnh16sF1tUAZBk3HHaKFocBrPYOhdqZAz0wIg8eMlD0kpx/XdstKv
         DqIG4kKidGJDCFr7WPl8hOseZMSDYQPfSGK2vwz67cnKQPoB67l+NYk8eDsOLQ44ZD93
         G8AW+aN0lGU5lhNFCMVuzNs094Jp/xxJt4ewt/Lk2DAYXKGmXSBrkB85lmkDYoMQCRSn
         f8eQ==
X-Gm-Message-State: AOUpUlFPAB9FqJchiN2yjG0wkHzBcmxiCDTB8skC+Rnh/u5i5Y4tPEJA
        nBuWsLiAh5cAY8oqw949FeQu3A==
X-Google-Smtp-Source: AAOMgpes4yI7KBRLQvG2cvYKqjJBU1RhniIf5ujehQBvjNqe4eZd5kFZmdOI8cTi3ZP+UaLj8efkcQ==
X-Received: by 2002:a17:902:8f86:: with SMTP id z6-v6mr3592750plo.38.1531871910882;
        Tue, 17 Jul 2018 16:58:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id r16-v6sm5002449pfe.173.2018.07.17.16.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 16:58:30 -0700 (PDT)
Date:   Tue, 17 Jul 2018 16:58:29 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 3/7] arm64: dts: msm8996: thermal: Initialise via DT
 and add second controller
Message-ID: <20180717235829.GF129942@google.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <f6cb99e6b805b0850b039e4f5d469e761d84f6d0.1531384019.git.amit.kucheria@linaro.org>
 <20180717234213.GD129942@google.com>
 <CAD=FV=WydRLs1pY_N+whP10qkqmu8tySPictRuxsLvrfdunFcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=WydRLs1pY_N+whP10qkqmu8tySPictRuxsLvrfdunFcg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:55:10PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jul 17, 2018 at 4:42 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > On Thu, Jul 12, 2018 at 02:09:04PM +0530, Amit Kucheria wrote:
> >> We also split up the regmap address space into two, for the TM and SROT
> >> registers. This was required to deal with different address offsets for the
> >> TM and SROT registers across different SoC families.
> >>
> >> 8996 has two TSENS IP blocks, initialise the second one too.
> >>
> >> Since tsens-common.c/init_common() currently only registers one address
> >> space, the order is important (TM before SROT). This is OK since the code
> >> doesn't really use the SROT functionality yet.
> >>
> >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 14 ++++++++++++--
> >>  1 file changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >> index 8c7f9ca..688e752 100644
> >> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >> @@ -459,9 +459,19 @@
> >>                       status = "disabled";
> >>               };
> >>
> >> -             tsens0: thermal-sensor@4a8000 {
> >> +             tsens0: thermal-sensor@4a9000 {
> >                                        ~~~~~~
> >
> > I suppose the address of the TM block is used here instead of the SROT
> > address (which is lower) since SROT functionality is currently not
> > used. Would/should this change if/when the driver uses SROT?
> 
> For device tree you're always supposed to use the address of the first
> "reg" listed as the unit address in the node name.  It doesn't matter
> if it's bigger or smaller as long as it's the first one listed.
> 
> The bindings indicate that the TM block should be listed as the first
> register.  This won't change even if you start using SROT.

Thanks for the clarification, there is always something more to learn!

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
