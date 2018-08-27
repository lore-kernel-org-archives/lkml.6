Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87497C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288E021531
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2sRq4nT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288E021531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeH0GvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:51:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50326 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeH0GvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:51:07 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so9192280ite.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 20:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ssnZssSsaWtLCXChnybVVOzxNsYSdN73+OhXcnqWT4=;
        b=G2sRq4nT5iuA4lCnfPnD+ojLBkhWw4302QEeX0tRY2aC2sPcVLj1FcNDbrmDBrljk8
         4tL/JYmuGhaDEk2WjRT8ohJHNjst1PMJmU9fbDkePAZzTMFxyu8YRsaShBOZ7MoFrdGl
         jFIuLfw904iP5LQLqz4Rdw2Gwvo6slk9mBRG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ssnZssSsaWtLCXChnybVVOzxNsYSdN73+OhXcnqWT4=;
        b=qveTkL4jMCtF2zLIlmmSW4xzLVzz4VWkd01vjJpE84q9N7XO3JZrF1EzcGQpcUjQu2
         0lEfVNMLd35BZIaBdNTVlXwxiGP8zfU/go30PFbEQFmlYww4hI9euGtQ32ENP6pqWSRh
         ZjgQrVPge5zluKqLVPpG/d9GZhxxiqNOAIf1d3HrZ2TSUlFKr8njgVcSqkYG6E82LtXB
         TE+IVQwnOdl9h5yWR84+oEozYj+6tqQ67j9hhdrZQ9s9pNdT/yldL0J6D0LoMQoi1HM7
         WWfkLneOSYhCEctwgB/yrxoHp7rQa3/imFowsU3Uxc0QlJChWMeMaZExdXU0tr0TIe9r
         W6yA==
X-Gm-Message-State: APzg51CrLiaha90Afh73kmFQvNe7Xu/GVxtCBjSYDafen2fBhvtD2xMD
        yvwZ1wBf+Dx0ESa0A3LDv8D63iV21FdEJQ==
X-Google-Smtp-Source: ANB0VdabS6L8KTEYvCoxdVsaWoNogT0Qd041GFBrkPC2/5S+yxRQjo9Ou+ap1YKWFpA5/J1DASTrMg==
X-Received: by 2002:a24:ed0c:: with SMTP id r12-v6mr5405916ith.37.1535339186928;
        Sun, 26 Aug 2018 20:06:26 -0700 (PDT)
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com. [209.85.214.50])
        by smtp.gmail.com with ESMTPSA id q19-v6sm5163546ith.1.2018.08.26.20.06.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 20:06:25 -0700 (PDT)
Received: by mail-it0-f50.google.com with SMTP id j81-v6so9192245ite.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 20:06:25 -0700 (PDT)
X-Received: by 2002:a24:b842:: with SMTP id m63-v6mr5267278ite.31.1535339185332;
 Sun, 26 Aug 2018 20:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-4-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MV1jjksgbSaCuUcY_ZbjfGeK-GaQ_+OZ7LWUv4ehA3dGQ@mail.gmail.com> <9e9417cf2fccfed4015f6893045e4f7f@codeaurora.org>
In-Reply-To: <9e9417cf2fccfed4015f6893045e4f7f@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 27 Aug 2018 12:06:14 +0900
X-Gmail-Original-Message-ID: <CAPBb6MX7EQvXfq_F+8b2FcqROpGY7ud4M6UyttGzoELsw=NJ=Q@mail.gmail.com>
Message-ID: <CAPBb6MX7EQvXfq_F+8b2FcqROpGY7ud4M6UyttGzoELsw=NJ=Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] venus: firmware: add no TZ boot and shutdown routine
To:     vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 9:26 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> Hi Alex,
>
> On 2018-08-24 13:09, Alexandre Courbot wrote:
> > On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia
> > <vgarodia@codeaurora.org> wrote:
>
> [snip]
>
> >> +struct video_firmware {
> >> +       struct device *dev;
> >> +       struct iommu_domain *iommu_domain;
> >> +};
> >> +
> >>  /**
> >>   * struct venus_core - holds core parameters valid for all instances
> >>   *
> >> @@ -98,6 +103,7 @@ struct venus_caps {
> >>   * @dev:               convenience struct device pointer
> >>   * @dev_dec:   convenience struct device pointer for decoder device
> >>   * @dev_enc:   convenience struct device pointer for encoder device
> >> + * @fw:                a struct for venus firmware info
> >>   * @no_tz:     a flag that suggests presence of trustzone
> >>   * @lock:      a lock for this strucure
> >>   * @instances: a list_head of all instances
> >> @@ -130,6 +136,7 @@ struct venus_core {
> >>         struct device *dev;
> >>         struct device *dev_dec;
> >>         struct device *dev_enc;
> >> +       struct video_firmware fw;
> >
> > Since struct video_firmware is only used here I think you can declare
> > it inline, i.e.
> >
> >     struct {
> >         struct device *dev;
> >         struct iommu_domain *iommu_domain;
> >     } fw;
> >
> > This structure is actually a good candidate to hold the firmware
> > memory area start address and size.
>
> I can make it inline.
> Memory area and size are common parameters populated
> locally while loading the firmware with or without tz. Firmware struct
> has
> info more specific to firmware device.
>
> [snip]
>
> >
> >> +{
> >> +       struct iommu_domain *iommu_dom;
> >> +       struct device *dev;
> >> +       int ret;
> >> +
> >> +       dev = core->fw.dev;
> >> +       if (!dev)
> >> +               return -EPROBE_DEFER;
> >> +
> >> +       iommu_dom = iommu_domain_alloc(&platform_bus_type);
> >> +       if (!iommu_dom) {
> >> +               dev_err(dev, "Failed to allocate iommu domain\n");
> >> +               return -ENOMEM;
> >> +       }
> >> +
> >> +       ret = iommu_attach_device(iommu_dom, dev);
> >> +       if (ret) {
> >> +               dev_err(dev, "could not attach device\n");
> >> +               goto err_attach;
> >> +       }
> >
> > I think like the above belongs more in venus_firmware_init()
> > (introduced in patch 4/4) than here. There is no reason to
> > detach/reattach the iommu if we stop the firmware.
>
> Consider the case when we want to reload the firmware during error
> recovery.
> Boot and shutdown will be needed in such case without the need to
> populate
> the firmware device again.

Is there a need to reattach the iommu domain in case of an error?
