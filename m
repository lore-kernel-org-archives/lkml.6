Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4774EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC77120659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nq7/MK5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC77120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502843AbeKWULV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:11:21 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44346 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409027AbeKWULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:11:21 -0500
Received: by mail-yw1-f66.google.com with SMTP id h138-v6so2741271ywa.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 01:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJ9AY66oatY//0FSYk0pflgTHGCbGf500vlRsGWgRts=;
        b=Nq7/MK5mseDmQIWUT9zL9tEbSYaYPzYBN2c/i14CZDsJ1tn2XWabzr69j8oKVRlhkX
         O67sadttvB3zgRc4BeLoj5DAum6HYd0hezTzLpZmjX/JBab9BOO8cniUKOg8kIBz9or6
         Ap4xzL3mbP4aTNivXne8chnkkrbzSO9Ly4TEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJ9AY66oatY//0FSYk0pflgTHGCbGf500vlRsGWgRts=;
        b=RNsII9F9Swe780nTusoRC/ZNzgewSN14vAhmi2JAhkOEgQ+YMe3DaAheJOtKepY0Ii
         pJNly36QNn53wG9OQTIdMsYugasYEk14S0ItbqjLIzcGEE+W7GudqsaXPTcNBxkwQwkN
         VsPjlyWNWUb8oPEdAFCU7CG8940SvX0jf3aiySt2TKOQxJTy3UeqUH1lARGD554imsRn
         sYalm8dGPRFpthSPU6+BOsJDCsippigGLEgHi30zlw5kIOg/da/hRdqXKZN8GZg9OxAi
         rGkk1ehc4OZSOdLH3cHnJ5HcNyicQVigsX9LDM848Y6rf4PqpoABfUk4H2eUon0JujmD
         zIYQ==
X-Gm-Message-State: AGRZ1gL+EMKuuiznDN1Udz1Ad4v2vpm5L99t/ZfaMji8QpmzH7AVKkcO
        nC3rKz7CXzujyPTtV0bulM1/V1Jn/Os=
X-Google-Smtp-Source: AJdET5evNh4QdcyzVHJ+Ven4H1zUs8XQbeTE63+ThjwWmebH/r9xFP/rxie64u1xpZmvIb461WYNqA==
X-Received: by 2002:a81:af1f:: with SMTP id n31mr15059652ywh.383.1542965273434;
        Fri, 23 Nov 2018 01:27:53 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id a71sm10053317ywe.66.2018.11.23.01.27.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 01:27:53 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id z2-v6so4520873ybj.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 01:27:52 -0800 (PST)
X-Received: by 2002:a25:7ec4:: with SMTP id z187-v6mr14615973ybc.373.1542964938799;
 Fri, 23 Nov 2018 01:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-6-vivek.gautam@codeaurora.org> <20181121173803.GB9801@arm.com>
 <CAFp+6iELH7Mw3Ue2ksEyV+Ac8hG8--Ki69xrPCA4F-AcireRow@mail.gmail.com>
In-Reply-To: <CAFp+6iELH7Mw3Ue2ksEyV+Ac8hG8--Ki69xrPCA4F-AcireRow@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 23 Nov 2018 18:22:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B-bZR8dmjARb8L4oqgET2YAjXhexAO0GKAvU4JoVU=7g@mail.gmail.com>
Message-ID: <CAAFQd5B-bZR8dmjARb8L4oqgET2YAjXhexAO0GKAvU4JoVU=7g@mail.gmail.com>
Subject: Re: [RESEND PATCH v17 5/5] iommu/arm-smmu: Add support for
 qcom,smmu-v2 variant
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, thor.thayer@linux.intel.com,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, jcrouse@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek, Will,

On Fri, Nov 23, 2018 at 6:13 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Hi Will,
>
> On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > [+Thor]
> >
> > On Fri, Nov 16, 2018 at 04:54:30PM +0530, Vivek Gautam wrote:
> > > qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
> > > clock and power requirements.
> > > On msm8996, multiple cores, viz. mdss, video, etc. use this
> > > smmu. On sdm845, this smmu is used with gpu.
> > > Add bindings for the same.
> > >
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >  drivers/iommu/arm-smmu.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index 2098c3141f5f..d315ca637097 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -120,6 +120,7 @@ enum arm_smmu_implementation {
> > >       GENERIC_SMMU,
> > >       ARM_MMU500,
> > >       CAVIUM_SMMUV2,
> > > +     QCOM_SMMUV2,
> > >  };
> > >
> > >  struct arm_smmu_s2cr {
> > > @@ -2026,6 +2027,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> > >  ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> > >  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> > >
> > > +static const char * const qcom_smmuv2_clks[] = {
> > > +     "bus", "iface",
> > > +};
> > > +
> > > +static const struct arm_smmu_match_data qcom_smmuv2 = {
> > > +     .version = ARM_SMMU_V2,
> > > +     .model = QCOM_SMMUV2,
> > > +     .clks = qcom_smmuv2_clks,
> > > +     .num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
> > > +};
> >
> > These seems redundant if we go down the route proposed by Thor, where we
> > just pull all of the clocks out of the device-tree. In which case, why
> > do we need this match_data at all?
>
> Which is better? Driver relying solely on the device tree to tell
> which all clocks
> are required to be enabled,
> or, the driver deciding itself based on the platform's match data,
> that it should
> have X, Y, & Z clocks that should be supplied from the device tree.

The former would simplify the driver, but would also make it
impossible to spot mistakes in DT, which would ultimately surface out
as very hard to debug bugs (likely complete system lockups).

For qcom_smmuv2, I believe we're eventually going to end up with
platform-specific quirks anyway, so specifying the clocks too wouldn't
hurt. Given that, I'd recommend sticking to the latter, i.e. what this
patch does.

Best regards,
Tomasz
