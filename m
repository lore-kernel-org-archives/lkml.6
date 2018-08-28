Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA52BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0A320659
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g3KohAWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0A320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeH1JnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:43:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50949 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeH1JnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:43:06 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so1008303ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G3K1+siUe7b2y/jyNiUK+wBFVCYerA4vW7QO5gHBrsc=;
        b=g3KohAWB9thaVaZYGs4IU8PrHt4cc7UHeeVBfdpvK3yKXVG89Rwwlk9Kh2FoBjwykc
         kHP722foQ2EOXSqeyRZjFZdwN0x3qtF5OQ9bc945VUNOShOdP9kW9pMt0BZgs/TxerxL
         FTHzEvoNKRVXANosPD2pUT8WKKLNgchfDRLRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G3K1+siUe7b2y/jyNiUK+wBFVCYerA4vW7QO5gHBrsc=;
        b=ixb9W4rSf4uyAwsTy0xrhUoD0fScp+LfCvbn3r/M8zcrezqfMgUymwnHKK9E+wI9ms
         hppCQjOtJgWdXpFhhO02JXa+NsV9ZG0KSS5Epn0JCi/UZbhretYqxxAn8wdCawzheFHQ
         aOeGnKLg+TxM+H5t6YXGvgeHELCHXJ0huIysUpepf4Zk84LVejqlQ7WL+fZ50B09eh8z
         6CfzMB0pT7Z+BEW37ozfu3WGBR9tMeuAImqOlDAkbmXhdhJ1WWnrgiZ8lg+2OkDGFYLj
         Q5TLsLCs3CoHFkT5rvERNzKy4wgYCM63aCCYhu2x+Kx86tKCXGGV8w6t6Cfwufv0f4XV
         LPHQ==
X-Gm-Message-State: APzg51AIemzxdGDnkZ54pZII4kncaoN3r2YPEXh4pi0b9vju84Y2tfaT
        j2PEMU9SyUo1qcWRPlM3X10oqXLVITi6lg==
X-Google-Smtp-Source: ANB0VdaLpJ3d0Rbm+xP8Ro6oTBeMP4WxbpK80OUpUyiO7EtUKRwRKsa0hoTZG9tdNh92wtvwembt0g==
X-Received: by 2002:a02:2424:: with SMTP id f36-v6mr20187jaa.35.1535435144232;
        Mon, 27 Aug 2018 22:45:44 -0700 (PDT)
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com. [209.85.214.49])
        by smtp.gmail.com with ESMTPSA id j199-v6sm205567itb.43.2018.08.27.22.45.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 22:45:42 -0700 (PDT)
Received: by mail-it0-f49.google.com with SMTP id x79-v6so1217198ita.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:45:42 -0700 (PDT)
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr9585jad.107.1535435141761;
 Mon, 27 Aug 2018 22:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-4-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MV1jjksgbSaCuUcY_ZbjfGeK-GaQ_+OZ7LWUv4ehA3dGQ@mail.gmail.com>
 <9e9417cf2fccfed4015f6893045e4f7f@codeaurora.org> <CAPBb6MX7EQvXfq_F+8b2FcqROpGY7ud4M6UyttGzoELsw=NJ=Q@mail.gmail.com>
 <002138192bcb3f7e6bf55e090d1b5328@codeaurora.org>
In-Reply-To: <002138192bcb3f7e6bf55e090d1b5328@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 28 Aug 2018 14:45:30 +0900
X-Gmail-Original-Message-ID: <CAPBb6MX_XR=vfjgnSn3eauW3C-yfu7a9JA3Psnk=0Aej3mtNBg@mail.gmail.com>
Message-ID: <CAPBb6MX_XR=vfjgnSn3eauW3C-yfu7a9JA3Psnk=0Aej3mtNBg@mail.gmail.com>
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

On Mon, Aug 27, 2018 at 9:49 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> On 2018-08-27 08:36, Alexandre Courbot wrote:
> > On Fri, Aug 24, 2018 at 9:26 PM Vikash Garodia
> > <vgarodia@codeaurora.org> wrote:
> >>
> >> Hi Alex,
> >>
> >> On 2018-08-24 13:09, Alexandre Courbot wrote:
> >> > On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia
> >> > <vgarodia@codeaurora.org> wrote:
> >>
> >> [snip]
> >>
> >> >> +struct video_firmware {
> >> >> +       struct device *dev;
> >> >> +       struct iommu_domain *iommu_domain;
> >> >> +};
> >> >> +
> >> >>  /**
> >> >>   * struct venus_core - holds core parameters valid for all instances
> >> >>   *
> >> >> @@ -98,6 +103,7 @@ struct venus_caps {
> >> >>   * @dev:               convenience struct device pointer
> >> >>   * @dev_dec:   convenience struct device pointer for decoder device
> >> >>   * @dev_enc:   convenience struct device pointer for encoder device
> >> >> + * @fw:                a struct for venus firmware info
> >> >>   * @no_tz:     a flag that suggests presence of trustzone
> >> >>   * @lock:      a lock for this strucure
> >> >>   * @instances: a list_head of all instances
> >> >> @@ -130,6 +136,7 @@ struct venus_core {
> >> >>         struct device *dev;
> >> >>         struct device *dev_dec;
> >> >>         struct device *dev_enc;
> >> >> +       struct video_firmware fw;
> >> >
> >> > Since struct video_firmware is only used here I think you can declare
> >> > it inline, i.e.
> >> >
> >> >     struct {
> >> >         struct device *dev;
> >> >         struct iommu_domain *iommu_domain;
> >> >     } fw;
> >> >
> >> > This structure is actually a good candidate to hold the firmware
> >> > memory area start address and size.
> >>
> >> I can make it inline.
> >> Memory area and size are common parameters populated
> >> locally while loading the firmware with or without tz. Firmware struct
> >> has
> >> info more specific to firmware device.
> >>
> >> [snip]
> >>
> >> >
> >> >> +{
> >> >> +       struct iommu_domain *iommu_dom;
> >> >> +       struct device *dev;
> >> >> +       int ret;
> >> >> +
> >> >> +       dev = core->fw.dev;
> >> >> +       if (!dev)
> >> >> +               return -EPROBE_DEFER;
> >> >> +
> >> >> +       iommu_dom = iommu_domain_alloc(&platform_bus_type);
> >> >> +       if (!iommu_dom) {
> >> >> +               dev_err(dev, "Failed to allocate iommu domain\n");
> >> >> +               return -ENOMEM;
> >> >> +       }
> >> >> +
> >> >> +       ret = iommu_attach_device(iommu_dom, dev);
> >> >> +       if (ret) {
> >> >> +               dev_err(dev, "could not attach device\n");
> >> >> +               goto err_attach;
> >> >> +       }
> >> >
> >> > I think like the above belongs more in venus_firmware_init()
> >> > (introduced in patch 4/4) than here. There is no reason to
> >> > detach/reattach the iommu if we stop the firmware.
> >>
> >> Consider the case when we want to reload the firmware during error
> >> recovery.
> >> Boot and shutdown will be needed in such case without the need to
> >> populate
> >> the firmware device again.
> >
> > Is there a need to reattach the iommu domain in case of an error?
>
> re-attach is not needed. We can have alloc/attach in init and
> detach/free in deinit.
> map/reset and unmap/reset can continue to remain in boot and shutdown
> calls. Let me
> know if this is good, i can repatch the series.

Yeah, the idea is to avoid repeating operations that do not need to be. Thanks!
