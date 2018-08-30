Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F4CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99D62054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RZyf3DBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99D62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeH3NfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:35:23 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:40029 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeH3NfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:35:22 -0400
Received: by mail-yb0-f195.google.com with SMTP id f4-v6so3145023ybp.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 02:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YKs89KCBRjOhJ6kZ6HhzrYkouwY3ACEQLGR4lhrPH0=;
        b=RZyf3DBXUkWZ3PXUp248I616x8kSPYutIZvWNl+TI6RomijMnEYFs3kXYDWDrHR2yP
         6MKPWSquH+r6BM1C19OgidNc7ipLDwsiW+0hlShRoV27jF5bzPdikfUK9YEKWEgp2SuQ
         tchjJ2bBl1CQ1q2lP1E19Q+oRCQVLkx5pZ1/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YKs89KCBRjOhJ6kZ6HhzrYkouwY3ACEQLGR4lhrPH0=;
        b=ZWCApbZneUnXjuGxs7QIGYF7rdR7/rvjckbIDKwI8GlxQURSNlVVLzdGKw9fSAJELm
         CZ+0bf3Gx1NNZuQwYk+TlRmoKSenf2WvVNx4JwuamrjifRMSBDKdt7EUxIlKfnThRYuJ
         Fmgq66MTnosFTQw8+orIizzKlVNuZYX1OCTRFof5+FcnFBR7BM3oYda7tY1GKPveqolP
         t8otRZ2CnUO5YJbSuH1Xn+sJMipKu35kx5cJcdGbCGLeXa13gXh9qWDRdeQPqlEC21ij
         ccXVrkgWVutxEvEBbVfFumIF7fjck7gTF4jvlYYsTb7f8SUjND96YHwDoW2Cc6THE+cS
         hd7Q==
X-Gm-Message-State: APzg51BD5HhXX3p/u2vcDJ5E4/fhqfm1BMyp2jcDGUTLQiUmhhBjsUQl
        Lnxuoh5ofP83r3z+TU2gCDqS5J7Yery/Bg==
X-Google-Smtp-Source: ANB0VdZZV0mwqTCrGIq1QuxvdAXFeKgr2JGhIm3ADgn/5O9uHFLw86EyRs8V4agMo4sTcoRalQoNuQ==
X-Received: by 2002:a25:3002:: with SMTP id w2-v6mr5425167ybw.25.1535621647045;
        Thu, 30 Aug 2018 02:34:07 -0700 (PDT)
Received: from mail-yb0-f174.google.com (mail-yb0-f174.google.com. [209.85.213.174])
        by smtp.gmail.com with ESMTPSA id l127-v6sm2871241ywc.5.2018.08.30.02.34.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 02:34:05 -0700 (PDT)
Received: by mail-yb0-f174.google.com with SMTP id t10-v6so3154501ybb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 02:34:04 -0700 (PDT)
X-Received: by 2002:a25:b3ce:: with SMTP id x14-v6mr5135165ybf.508.1535621644146;
 Thu, 30 Aug 2018 02:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
 <20180827105551.16346-3-vivek.gautam@codeaurora.org> <CAFp+6iGbfHZQjG5oEVKhQ=4rOaaU=5ePykEuwMqYbPTryX6DnA@mail.gmail.com>
In-Reply-To: <CAFp+6iGbfHZQjG5oEVKhQ=4rOaaU=5ePykEuwMqYbPTryX6DnA@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 30 Aug 2018 18:33:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BrJppNSo8ETT6ywjuLEULk4nAvWDQEuNiMCvdddeUq1A@mail.gmail.com>
Message-ID: <CAAFQd5BrJppNSo8ETT6ywjuLEULk4nAvWDQEuNiMCvdddeUq1A@mail.gmail.com>
Subject: Re: [Patch v15 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 6:22 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> On Mon, Aug 27, 2018 at 4:27 PM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> >
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
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >
> > Changes since v14:
> >  - none.
> >
> >  drivers/iommu/arm-smmu.c | 101 +++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 93 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index a81224bc6637..23b4a60149b6 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
>
> [snip]
>
> > @@ -2131,6 +2188,26 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >         if (err)
> >                 return err;
> >
> > +       /*
> > +        * We want to avoid touching dev->power.lock in fastpaths unless
> > +        * it's really going to do something useful - pm_runtime_enabled()
> > +        * can serve as an ideal proxy for that decision. So, conditionally
> > +        * enable pm_runtime.
> > +        */
> > +       if (dev->pm_domain)
> > +               pm_runtime_enable(dev);
> > +
> > +       err = arm_smmu_rpm_get(smmu);
>
> We shouldn't be doing a runtime_get() yet, as this eventually calls
> arm_smmu_device_reset().
> arm_smmu_device_reset() should be called only after arm_smmu_device_cfg_probe().
> So, I plan to replace the pm_runtime_get/put() calls in probe() with
> simple clk_bulk_enable()
> to let the driver initialize smmu, and at the end of the probe we can
> disable the clocks and
> enable runtime pm over the device to let it take care of the device further-on.
>

We can avoid the explicit clock disable by just calling
pm_runtime_set_active() before pm_runtime_enable(), assuming that what
probe does is symmetrical with the suspend callback, which would be
called after the latter.

Best regards,
Tomasz
