Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505B8C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8833213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EnVJO1e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8833213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390569AbeGKV5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:57:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41754 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbeGKV5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:57:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so1794420pgu.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2qgXwJBcwULc0BI0Bi1FAnDb0cW6a+ak7h5AZJe0+A=;
        b=EnVJO1e3DCF1BwcgZT8vr2mnb2MZ/BaGif5g2cVMxPaSQN81D7fI7vK+oHBKmWyybM
         bG/xmes1PN7fdNFberEpcUVft7E1Pnbk7qNHvThYgy7HAKQvY7KncoUmUuIjjDHZBFP5
         z8ETEZaUX28aUQtaIaI1itEPiQsQOrrrcieAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2qgXwJBcwULc0BI0Bi1FAnDb0cW6a+ak7h5AZJe0+A=;
        b=bhfIuZHno72KAGTwe1Bj1b56f45wmj3RikpR45TY9b3lIf9WhyvdlKJ2AyO3R7g5PZ
         0yfaXzNxMgVuTYvMFxZTHtWVpXkVwjteFQZxCgmDYoSvVOYBbXL2NVvDLm1b3zEONQfm
         qsRpjYM291Yv5pCznE2dV0G4qbmuUIrGwi+1o3n1KlBYavBp2v3QUq1NSOss3lW9ZXBZ
         /WQeiE68KBQAJz0NVm8nZ46hMtgAsxA6Xm2tf8awqV6QWjziig0b0PG1WxwLda12gqud
         0mJXDs8hYUpqnYPGuhkG0OmFYOT/yZsue/FqqZT3kxUnB07EoZVq9MEZ/QTxw6qSHRCM
         dKDQ==
X-Gm-Message-State: AOUpUlE4Y+UvaKO87U7B+da/arxsm7FBzALEmBoXlec8AI6i4zXt9pqi
        NvxDsGiD0QjVRgEH9xZJWSCbZg==
X-Google-Smtp-Source: AAOMgpc2tkep/9BEYn1kroFjQst4Tfz1JFAcM9ZrHFBcOahZZkTDv2L+FPaHME9Bk+hpiafdiuVHTQ==
X-Received: by 2002:a63:5c10:: with SMTP id q16-v6mr308381pgb.452.1531345891220;
        Wed, 11 Jul 2018 14:51:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id b66-v6sm4372367pgc.15.2018.07.11.14.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 14:51:30 -0700 (PDT)
Date:   Wed, 11 Jul 2018 14:51:29 -0700
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
Subject: Re: [PATCH v6 7/7] arm64: dts: sdm845: Add tsens nodes
Message-ID: <20180711215129.GT129942@google.com>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <65c39c405076627bd43ec94c211c6998191b9f16.1531136000.git.amit.kucheria@linaro.org>
 <CAD=FV=XpfJyd8hUT45+J=EVY1Bs28Mk7m2TBJy8J=HO63n2_qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=XpfJyd8hUT45+J=EVY1Bs28Mk7m2TBJy8J=HO63n2_qw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 11:44:13AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> > sensors. It uses version 2 of the TSENS IP, so use the fallback property to
> > allow more common code.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index cdaabeb..ba2899c 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -221,6 +221,22 @@
> >                         #interrupt-cells = <2>;
> >                 };
> >
> > +               tsens0: tsens@c263000 {
> 
> As per my comments in the bindings, nit that this should probably be
> "thermal-sensor" not "tsens", AKA:
> 
> tsens0: thermal-sensor@c263000 {
> 
> > +                       compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +                       reg = <0xc263000 0x1ff>, /* TM */
> > +                             <0xc222000 0x1ff>; /* SROT */
> > +                       #qcom,sensors = <13>;
> 
> As per my comment in the bindings and the code, I'm confused about the
> whole "#qcom,sensors" bit.  It's not documented and doesn't seem
> hooked up in the code either.
> 
> ...but if people have tested this, perhaps I'm confused.  How can
> things work if num_sensors is 0???

The mystery is resolved by:

commit 6d7c70d1cd6526dc79e3d3b3faae1c40c1681168
Author: Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Mon May 7 16:53:39 2018 -0700

    thermal: qcom: tsens: Allow number of sensors to come from DT

    For platforms that has multiple copies of the TSENS hardware block it's
    necessary to be able to specify the number of sensors per block in DeviceTree.

    Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
    Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Eduardo Valentin <edubezval@gmail.com>


I bumped into this during testing ;-)
