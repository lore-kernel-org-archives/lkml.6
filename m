Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04EBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588462086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pc6s3Rzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588462086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeK0CjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:39:07 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43355 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0CjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:39:07 -0500
Received: by mail-yw1-f68.google.com with SMTP id l200so7713396ywe.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 07:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKpXa6enJoVc/Y9wn+Z9lq9xRS1SsyykQNcMwAFP1MY=;
        b=Pc6s3RziJB3XneHpvE1b/XjuhObKZKiyMfCgghCG4UxnQVhUdrm7eZ4JhDwqLICujh
         T51IxZ+YtqcjZmpUXmMvlsfx1QEy0TIG9vMg3PDOj20pffBKfrKqMLXcfXpp512yK/6L
         U6lO+VQBzrzgKiSszbLeGoOfvx6zDSpP7JXY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKpXa6enJoVc/Y9wn+Z9lq9xRS1SsyykQNcMwAFP1MY=;
        b=Xg+I59CTinpaIATfvrC1QAFpP8pu9hMsDY/vUzBh7K25QwnUU8c15MJyu5Jdhql9Jo
         KTAGoszqnDS3FsaNAsKAIwI6SAWohfWTO8/P4bj/3YiFtRW7JIf64ErzYh2BM2QYe6Ls
         uiOZlNkp8dgTqJ8iZC9OJ5ZlCvGAw/hnWeW098/7xqVhax8+0Jazw3nSby8C7T+CioQ8
         0K3TLJDlmx7JOZjhNhoOl2R5itj//VuUbppqISP5zCWXiC67uRqraG9ywwA69V2hLXyD
         HFUQ4cYbGJCY2OWjgqzOkNVu6eMnHb00TNw+IuXyAfIb1Uru01x5n60CiNK1gCVYmUa/
         5bVg==
X-Gm-Message-State: AGRZ1gIfi5FpdVTOaOFdMxM+XZQ3MLweZTmL9e8oP7jHloCJRZVnpptL
        G0Ck2f8paXemMZ7yM27rxWXsTNKaTi8=
X-Google-Smtp-Source: AJdET5d6884UuP4J4hR0rmj/dPRCB/XIitBZZ+dXEizcRgJp1FMToPaHqgoUj7llXTAnjA7IioDmcg==
X-Received: by 2002:a81:764c:: with SMTP id j12-v6mr30135578ywk.338.1543247077060;
        Mon, 26 Nov 2018 07:44:37 -0800 (PST)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id v9sm1000910ywh.2.2018.11.26.07.44.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 07:44:36 -0800 (PST)
Received: by mail-yw1-f44.google.com with SMTP id l200so7713346ywe.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 07:44:35 -0800 (PST)
X-Received: by 2002:a0d:eb06:: with SMTP id u6mr14865714ywe.443.1543247075116;
 Mon, 26 Nov 2018 07:44:35 -0800 (PST)
MIME-Version: 1.0
References: <1543227173-2160-1-git-send-email-mgottam@codeaurora.org>
 <d74281c8-a177-12a3-9e72-7a7db3014943@xs4all.nl> <f6106d20-abee-979c-8ac1-6c9115e8373c@linaro.org>
 <57b28a7f-8c5c-22d2-2f89-e6d6ebdcb8a2@xs4all.nl>
In-Reply-To: <57b28a7f-8c5c-22d2-2f89-e6d6ebdcb8a2@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 27 Nov 2018 00:44:23 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DJn-_y5dHySAB6_ed-syBOr3Ybo7KfsPLNd+0Z7X0N7g@mail.gmail.com>
Message-ID: <CAAFQd5DJn-_y5dHySAB6_ed-syBOr3Ybo7KfsPLNd+0Z7X0N7g@mail.gmail.com>
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

Hi Hans,

On Tue, Nov 27, 2018 at 12:24 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 11/26/2018 03:57 PM, Stanimir Varbanov wrote:
> > Hi Hans,
> >
> > On 11/26/18 3:37 PM, Hans Verkuil wrote:
> >> On 11/26/2018 11:12 AM, Malathi Gottam wrote:
> >>> Accept the buffer size requested by client and compare it
> >>> against driver calculated size and set the maximum to
> >>> bitstream plane.
> >>>
> >>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >>
> >> Sorry, this isn't allowed. It is the driver that sets the sizeimage value,
> >> never the other way around.
> >
> > I think for decoders (OUTPUT queue) and encoders (CAPTURE queue) we
> > allowed userspace to set sizeimage for buffers. See [1] Initialization
> > paragraph point 2:
> >
> >     ``sizeimage``
> >        desired size of ``CAPTURE`` buffers; the encoder may adjust it to
> >        match hardware requirements
> >
> > Similar patch we be needed for decoder as well.
>
> I may have missed that change since it wasn't present in v1 of the stateful
> encoder spec.

It's been there from the very beginning, even before I started working
on it. Actually, even the early slides from Kamil mention the
application setting the buffer size for compressed streams:
https://events.static.linuxfound.org/images/stories/pdf/lceu2012_debski.pdf

>
> Tomasz, what was the reason for this change? I vaguely remember some thread
> about this, but I forgot the details. Since this would be a departure of
> the current API this should be explained in more detail.

The kernel is not the place to encode assumptions about optimal
bitstream chunk sizes. It depends on the use case and the application
should be able decide. It may for example want to use smaller buffers,
optimizing for the well compressible video streams and just reallocate
if bigger chunks are needed.

>
> I don't really see the point of requiring userspace to fill this in. For
> stateful codecs it can just return some reasonable size. Possibly calculated
> using the provided width/height values or (if those are 0) some default value.

How do we decide what's "reasonable"? Would it be reasonable for all
applications?

>
> Ditto for decoders.
>
> Stanimir, I certainly cannot merge this until this has been fully nailed down
> as it would be a departure from the current API.

It would not be a departure, because I can see existing stateful
drivers behaving like that:
https://elixir.bootlin.com/linux/v4.20-rc4/source/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c#L1444
https://elixir.bootlin.com/linux/v4.20-rc4/source/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c#L469

Also, Chromium has been setting the size on its own for long time
using its own heuristics.

>
> And looking at the venus patch I do not see how it helps userspace.
>
> Regards,
>
>         Hans
>
> >
> >>
> >> If you need to allocate larger buffers, then use VIDIOC_CREATE_BUFS instead
> >> of VIDIOC_REQBUFS.

CREATE_BUFS wouldn't work, because one needs to use TRY_FMT to obtain
a format for it and the format returned by it would have the sizeimage
as hardcoded in the driver...

Best regards,
Tomasz
