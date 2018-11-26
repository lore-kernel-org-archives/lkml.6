Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676A32086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rb0axXVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676A32086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeKZOzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:55:25 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:47075 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeKZOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:55:24 -0500
Received: by mail-yw1-f66.google.com with SMTP id t13so6982351ywe.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 20:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03xBP5Zo6fhGlHrKei9S4VyZR1WLSVlCMfyk+2rgtEs=;
        b=Rb0axXVjqqwBL75GRErfIUG4V6aO3vxUE84Wbo8LVtH+fScQydCRMilO2JMy8Ayjla
         aJn31UGf8HM2tGOxZXlOx9ZsZ57L9K8BXxy9oLI2/chvwNi5FYpX1KN6hNKNqZFqSf//
         a4dgJvV1u5wnhNZQY14ywpfQy+D2kTYwaxYCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03xBP5Zo6fhGlHrKei9S4VyZR1WLSVlCMfyk+2rgtEs=;
        b=jJj4+2ztGijeK0o13brJ3TW/Cnl0OvugHZpJdC9E/q1hnrIMU3jtQJYqwW8W3RKCjZ
         eYv8rs2rivOQj80iRqH+H0ZJs+dVHBp2DzLNNWf+W7fII0wHAHg5kpOS19Z81lZLLXJh
         65EocqBBmzw94NxOKEK8ydNJzZb+MV1EjSUoKKUxVwAOVBqBmoiIwFXHOa1H3dDQfZ2A
         IxwgtPFoLqVXsbA1IEnp7y/TZxWfqltvIr0GINXtgpH0wcRgUTa1Mg3IvODlG78oFC6K
         Twht99Y+TADWP5ZxzCpq6wADBxE62DGamBq2/Ooq/NK7mIhEXasjWHlTfh+xqLUwwNR7
         e8Gw==
X-Gm-Message-State: AGRZ1gIjjGMBds0QXBzrHyH2ibk6WBvpZvXTaLyK0Y9uB8OYQSNlf3EF
        Rh8doMX2FdLElo9EgQxPObXWo2vEB4w=
X-Google-Smtp-Source: AJdET5d1HuqhzNRaGDn+QtTjBT2xar2RNLVopUUdoOcQmZHzTQjP7MTNfT2ED02ZeDIdDcmzv6Ia2A==
X-Received: by 2002:a0d:f7c3:: with SMTP id h186-v6mr26234854ywf.449.1543204955660;
        Sun, 25 Nov 2018 20:02:35 -0800 (PST)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id k125-v6sm14520727ywd.102.2018.11.25.20.02.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 20:02:34 -0800 (PST)
Received: by mail-yw1-f42.google.com with SMTP id h138-v6so5185151ywa.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 20:02:33 -0800 (PST)
X-Received: by 2002:a81:ae19:: with SMTP id m25mr27424287ywh.342.1543204953454;
 Sun, 25 Nov 2018 20:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-6-vivek.gautam@codeaurora.org> <20181121173803.GB9801@arm.com>
 <CAFp+6iELH7Mw3Ue2ksEyV+Ac8hG8--Ki69xrPCA4F-AcireRow@mail.gmail.com>
 <CAAFQd5B-bZR8dmjARb8L4oqgET2YAjXhexAO0GKAvU4JoVU=7g@mail.gmail.com>
 <CAFp+6iFhBRJWGY4Hj30tWedGpEUcnkBJrOvffmbpD2m9QMZB3A@mail.gmail.com> <20181123183428.GD21183@arm.com>
In-Reply-To: <20181123183428.GD21183@arm.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 26 Nov 2018 13:02:22 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DG7+Dp60T4EujtPqdMUYbYwdLTd8rS7wshz1WJ_1=LbQ@mail.gmail.com>
Message-ID: <CAAFQd5DG7+Dp60T4EujtPqdMUYbYwdLTd8rS7wshz1WJ_1=LbQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v17 5/5] iommu/arm-smmu: Add support for
 qcom,smmu-v2 variant
To:     Will Deacon <will.deacon@arm.com>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        thor.thayer@linux.intel.com, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        sboyd@kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 3:34 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Nov 23, 2018 at 03:06:29PM +0530, Vivek Gautam wrote:
> > On Fri, Nov 23, 2018 at 2:52 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > > On Fri, Nov 23, 2018 at 6:13 PM Vivek Gautam
> > > <vivek.gautam@codeaurora.org> wrote:
> > > > On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com> wrote:
> > > > > On Fri, Nov 16, 2018 at 04:54:30PM +0530, Vivek Gautam wrote:
> > > > > > @@ -2026,6 +2027,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> > > > > >  ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> > > > > >  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> > > > > >
> > > > > > +static const char * const qcom_smmuv2_clks[] = {
> > > > > > +     "bus", "iface",
> > > > > > +};
> > > > > > +
> > > > > > +static const struct arm_smmu_match_data qcom_smmuv2 = {
> > > > > > +     .version = ARM_SMMU_V2,
> > > > > > +     .model = QCOM_SMMUV2,
> > > > > > +     .clks = qcom_smmuv2_clks,
> > > > > > +     .num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
> > > > > > +};
> > > > >
> > > > > These seems redundant if we go down the route proposed by Thor, where we
> > > > > just pull all of the clocks out of the device-tree. In which case, why
> > > > > do we need this match_data at all?
> > > >
> > > > Which is better? Driver relying solely on the device tree to tell
> > > > which all clocks
> > > > are required to be enabled,
> > > > or, the driver deciding itself based on the platform's match data,
> > > > that it should
> > > > have X, Y, & Z clocks that should be supplied from the device tree.
> > >
> > > The former would simplify the driver, but would also make it
> > > impossible to spot mistakes in DT, which would ultimately surface out
> > > as very hard to debug bugs (likely complete system lockups).
> >
> > Thanks.
> > Yea, this is how I understand things presently. Relying on device tree
> > puts the things out of driver's control.
>
> But it also has the undesirable effect of having to update the driver
> code whenever we want to add support for a new SMMU implementation. If
> we do this all in the DT, as Thor is trying to do, then older kernels
> will work well with new hardware.

Fair enough, if you're okay with that. Obviously one would still have
to change the DT bindings to list the exact set of clocks for the new
hardware variant, unless the convention changed recently.

Best regards,
Tomasz
