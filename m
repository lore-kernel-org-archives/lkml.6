Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7055C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B7520862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="io5sm20O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B7520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeK0DB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:01:57 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33135 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeK0DB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:01:56 -0500
Received: by mail-yw1-f66.google.com with SMTP id q11so7770274ywa.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vmevvKkHGktpMcUCcOUxUXKw84LE0ckbwMcnxes624=;
        b=io5sm20OJu8Tm1hraLjDTWjiYjfwoQ0SvEhA4Kilg0knzn52z/UClmZ4EaaPLGbzUc
         P279CBV8Dtddz6VYMCfm/QpMT+xyh3KMJ+5ZApkK19U/1uWHx+Hji14+9k/pjZLx6mZN
         mpzN92B9xHGGzKrzQoa9yoF5WnfsMspr0LXkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vmevvKkHGktpMcUCcOUxUXKw84LE0ckbwMcnxes624=;
        b=TxaNvJ4e5Mlt4dMk5BF90UB8qHGv9JaGPh41ValF7mUBZoa8LRqaqPZ2XLHHYkvfGM
         Run22Y6gSRmm6ndQEqq3S6gsLDoehFGDquGKWuP6VBG5wTcBZQwpmqFLdcA75z/gju+7
         yDMrKwasO02azfhECA87ht4631vWSPlo2232/tpPaR3wmY9d/WmJFu/gW43hbVociXUw
         doKxrvUMkuuE8k99O3M6ol2vPv1OY5jJW0HVQYhXFlMm5JRDHjE2o0i8kEP/8X4urQ1v
         I+ekidLyv1+qtbTbLV1P1SZQF7jHWiPUtWBuUVdLZ623k22TfEDt9ep84FFyZ4XhBSYo
         3pgg==
X-Gm-Message-State: AGRZ1gJHKmqf0bbkpAFY4ZjcerCQvZNJq7M9lzcZphKs+H3M6I99yYSR
        vAgFV5lC8ePkI+/giv5J0i7MQQM3SvM=
X-Google-Smtp-Source: AJdET5cRe8Is7xWjuncKghbXCZvmgRPucW0fjFXTtbqzzH2Q6fG44bqOliQeWun2JCq9iR3j5HhE7g==
X-Received: by 2002:a81:3e27:: with SMTP id l39mr27757354ywa.89.1543248442488;
        Mon, 26 Nov 2018 08:07:22 -0800 (PST)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id e194sm198750ywa.85.2018.11.26.08.07.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:07:22 -0800 (PST)
Received: by mail-yw1-f47.google.com with SMTP id y194so7753975ywg.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:07:20 -0800 (PST)
X-Received: by 2002:a81:3dc4:: with SMTP id k187-v6mr29993044ywa.415.1543248439826;
 Mon, 26 Nov 2018 08:07:19 -0800 (PST)
MIME-Version: 1.0
References: <1543227173-2160-1-git-send-email-mgottam@codeaurora.org>
 <d74281c8-a177-12a3-9e72-7a7db3014943@xs4all.nl> <f6106d20-abee-979c-8ac1-6c9115e8373c@linaro.org>
 <57b28a7f-8c5c-22d2-2f89-e6d6ebdcb8a2@xs4all.nl> <CAAFQd5DJn-_y5dHySAB6_ed-syBOr3Ybo7KfsPLNd+0Z7X0N7g@mail.gmail.com>
 <2a8bbdf7-cec6-4bdf-5833-93d5014ddf89@xs4all.nl>
In-Reply-To: <2a8bbdf7-cec6-4bdf-5833-93d5014ddf89@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 27 Nov 2018 01:07:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BijN58EkxHmCPuJO1TnoTiB5CjoA5uuKHzi_1SD0iawQ@mail.gmail.com>
Message-ID: <CAAFQd5BijN58EkxHmCPuJO1TnoTiB5CjoA5uuKHzi_1SD0iawQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: venus: amend buffer size for bitstream plane
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        mgottam@codeaurora.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 1:00 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 11/26/2018 04:44 PM, Tomasz Figa wrote:
> > Hi Hans,
> >
> > On Tue, Nov 27, 2018 at 12:24 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>
> >> On 11/26/2018 03:57 PM, Stanimir Varbanov wrote:
> >>> Hi Hans,
> >>>
> >>> On 11/26/18 3:37 PM, Hans Verkuil wrote:
> >>>> On 11/26/2018 11:12 AM, Malathi Gottam wrote:
> >>>>> Accept the buffer size requested by client and compare it
> >>>>> against driver calculated size and set the maximum to
> >>>>> bitstream plane.
> >>>>>
> >>>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >>>>
> >>>> Sorry, this isn't allowed. It is the driver that sets the sizeimage value,
> >>>> never the other way around.
> >>>
> >>> I think for decoders (OUTPUT queue) and encoders (CAPTURE queue) we
> >>> allowed userspace to set sizeimage for buffers. See [1] Initialization
> >>> paragraph point 2:
> >>>
> >>>     ``sizeimage``
> >>>        desired size of ``CAPTURE`` buffers; the encoder may adjust it to
> >>>        match hardware requirements
> >>>
> >>> Similar patch we be needed for decoder as well.
> >>
> >> I may have missed that change since it wasn't present in v1 of the stateful
> >> encoder spec.
> >
> > It's been there from the very beginning, even before I started working
> > on it. Actually, even the early slides from Kamil mention the
> > application setting the buffer size for compressed streams:
> > https://events.static.linuxfound.org/images/stories/pdf/lceu2012_debski.pdf
> >
> >>
> >> Tomasz, what was the reason for this change? I vaguely remember some thread
> >> about this, but I forgot the details. Since this would be a departure of
> >> the current API this should be explained in more detail.
> >
> > The kernel is not the place to encode assumptions about optimal
> > bitstream chunk sizes. It depends on the use case and the application
> > should be able decide. It may for example want to use smaller buffers,
> > optimizing for the well compressible video streams and just reallocate
> > if bigger chunks are needed.
> >
> >>
> >> I don't really see the point of requiring userspace to fill this in. For
> >> stateful codecs it can just return some reasonable size. Possibly calculated
> >> using the provided width/height values or (if those are 0) some default value.
> >
> > How do we decide what's "reasonable"? Would it be reasonable for all
> > applications?
>
> In theory it should be the minimum size that the hardware supports. But it is
> silly to i.e. provide the size of one PAGE as the minimum. In practice you
> probably want to set sizeimage to something larger than that. Depending on
> the typical compression ratio perhaps 5 or 10% of what a raw YUV 4:2:0 frame
> would be.
>
> >
> >>
> >> Ditto for decoders.
> >>
> >> Stanimir, I certainly cannot merge this until this has been fully nailed down
> >> as it would be a departure from the current API.
> >
> > It would not be a departure, because I can see existing stateful
> > drivers behaving like that:
> > https://elixir.bootlin.com/linux/v4.20-rc4/source/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c#L1444
> > https://elixir.bootlin.com/linux/v4.20-rc4/source/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c#L469
>
> Yes, and that's out of spec. Clearly v4l2-compliance doesn't test for this.
> It should have been caught at least for the mtk driver.
>

Perhaps we should make it a part of the spec then?

Actually I'm not really sure if we can say that this is out of spec
There has been no clear spec for the stateful codecs for many years,
with drivers doing wildly whatever they like and applications ending
up relying on those quirks.

My spec actually attempts to incorporate what was decided on the
earlier summits, including what's in Kamil's slides, the drivers are
already doing and existing applications rely on. The sizeimage
handling is just a part of it.

> >
> > Also, Chromium has been setting the size on its own for long time
> > using its own heuristics.
> >
> >>
> >> And looking at the venus patch I do not see how it helps userspace.
> >>
> >> Regards,
> >>
> >>         Hans
> >>
> >>>
> >>>>
> >>>> If you need to allocate larger buffers, then use VIDIOC_CREATE_BUFS instead
> >>>> of VIDIOC_REQBUFS.
> >
> > CREATE_BUFS wouldn't work, because one needs to use TRY_FMT to obtain
> > a format for it and the format returned by it would have the sizeimage
> > as hardcoded in the driver...
>
> ???
>
> Userspace can change the sizeimage to whatever it wants before calling
> CREATE_BUFS as long as it is >= the sizeimage of the current format.
>
> If we want to allow smaller sizes, then I think that would not be
> unreasonable for stateful codecs. I actually think that drivers can
> already do this in queue_setup(), but the spec would have to be updated
> a bit.

Existing applications rely on REQBUFS honoring the size they set in
sizeimage, though...

Best regards,
Tomasz
