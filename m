Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34851208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I3ozVhSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34851208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeGKKIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:08:54 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33337 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeGKKIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:08:54 -0400
Received: by mail-yw0-f193.google.com with SMTP id c135-v6so8931984ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uoMqa+qvp1//HrVJ9XZy8u5iIj+bzy/OVoC42PzYT8=;
        b=I3ozVhSiqgpYIQChkDeoKad6cwkbgRjaI0+h7WW0hkQ4xhhqp37V2rAzvYVP4CchYw
         jMIgjHeHF/rb6LnRsByi9T6Bf1KgL45Qt8nTkkDRGf3akZlQt8qWw/qX44jumRL7HmJ6
         zx06LwZgI3NB8pm01YxH/qFj3SOuxPaF/umHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uoMqa+qvp1//HrVJ9XZy8u5iIj+bzy/OVoC42PzYT8=;
        b=Jl+4Cp9GksIqzqs2Oqq6Sd+adojXCCAF2ptGXoEcllvF0uC6+YTTx/p+1wcYoKEi98
         89BleUK/xZ+nKDp01wCB3836H8vY4Wjjk4OU+clj0JAHpLeEgeq9Vittzy5AgzNGdsfG
         yJgd7w8M1ybD6yy+X2CZAg9Qw987ZjDUQ3fgTc2Q/syJPXyaGx43+aYZuOna96Z/1sFC
         GOFmErZdP3WgSMVi1f8uP2ofIq0r0Tuz6kC+dUUR5E3ElIFNMQb4e3k+qk7SlIPsR9ct
         dqzSaItWrf2g3aEujKtidMBGuVbTeiNr+w8icZFCj0LEAsF/8KtAzokJyiUKXVU7DSN4
         NuuQ==
X-Gm-Message-State: APt69E1Blskm8Z4Xa6pK6stRw0+JEnmn7feMByBKY8AaN3GsL/KIPSnc
        1hU70UqnkvlBtG7n643fZsiKQf0paqA=
X-Google-Smtp-Source: AAOMgpeo3c6bUS3uHVBWJbreVZzAl0udLrGwL2QJI78SS7FBHmycmfdoroEJ3+/7b9E9flyz/JtRHw==
X-Received: by 2002:a81:2881:: with SMTP id o123-v6mr14002509ywo.6.1531303520701;
        Wed, 11 Jul 2018 03:05:20 -0700 (PDT)
Received: from mail-yb0-f182.google.com (mail-yb0-f182.google.com. [209.85.213.182])
        by smtp.gmail.com with ESMTPSA id c74-v6sm12507551ywh.17.2018.07.11.03.05.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 03:05:18 -0700 (PDT)
Received: by mail-yb0-f182.google.com with SMTP id r3-v6so9781947ybo.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:05:17 -0700 (PDT)
X-Received: by 2002:a25:207:: with SMTP id 7-v6mr14786222ybc.7.1531303517505;
 Wed, 11 Jul 2018 03:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-3-vivek.gautam@codeaurora.org> <1694664.FhRBrgajmF@aspire.rjw.lan>
In-Reply-To: <1694664.FhRBrgajmF@aspire.rjw.lan>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 11 Jul 2018 19:05:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5COVfXRBuq2ofHoOvNb+cMVmAFDaekh5KM4DBB1ZEf5pA@mail.gmail.com>
Message-ID: <CAAFQd5COVfXRBuq2ofHoOvNb+cMVmAFDaekh5KM4DBB1ZEf5pA@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        jcrouse@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Thanks for review.

On Wed, Jul 11, 2018 at 6:53 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Sunday, July 8, 2018 7:34:11 PM CEST Vivek Gautam wrote:
> > From: Sricharan R <sricharan@codeaurora.org>
> >
> > The smmu device probe/remove and add/remove master device callbacks
> > gets called when the smmu is not linked to its master, that is without
> > the context of the master device. So calling runtime apis in those places
> > separately.
> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > [vivek: Cleanup pm runtime calls]
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > ---
> >
> >  - Change since v11
> >    * Replaced pm_runtime_disable() with pm_runtime_force_suspend()
> >      to avoid warning about " Unpreparing enabled clock".
> >      Full warning text mentioned in cover patch.
> >
> >  drivers/iommu/arm-smmu.c | 92 +++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 84 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index a01d0dde21dd..09265e206e2d 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -268,6 +268,20 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
> >       { 0, NULL},
> >  };
> >
> > +static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> > +{
> > +     if (pm_runtime_enabled(smmu->dev))
>
> Why do you need the pm_runtime_enabled() checks here and below?
>
> pm_runtime_get_sync() and pm_runtime_put() should work just fine if
> runtime PM is not enabled.

Because pm_runtime_get_sync() acquires a spin lock, even if only for
the short time of checking if runtime PM is enabled and SMMU driver
maintainers didn't want any spin locks in certain IOMMU API code paths
on hardware implementations that don't need runtime PM, while we still
need to be able to control runtime PM there on hardware
implementations that need so.

Best regards,
Tomasz
