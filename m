Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF64BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8BB21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TcJ/6s/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8BB21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJQQXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:23:42 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36205 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeJQQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:23:42 -0400
Received: by mail-yb1-f193.google.com with SMTP id 5-v6so10027018ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOr1UmBB9d8q1n7xYt7gDGs/6Chh1j7/sDGAwIoH7T0=;
        b=TcJ/6s/x+jDu7g2K4mveXfsbUz06MHr1JHj9c3qJ1i00ra+kVylNXHZ71M6ECAUDAi
         2l2Jms6U8ob+DSxP+jekl8wu8s2qtPE/3bKy3XgRi9Yb7Lxeilj6LNCbCDSnUvTynQup
         iNWbv1DBP5y7Eyaya41vZhutJ7GSiUlWtKPVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOr1UmBB9d8q1n7xYt7gDGs/6Chh1j7/sDGAwIoH7T0=;
        b=lEDBkRCq5RDjcUw4Wgli9RO4+floO5qxA1Hy8nJqMu9nP3SPvV9v7OGEgp1trUyol7
         4ygTO9YCPSnripf+oveZbQ++QSwzVQBsSaAkBPc5jUQA0g0JeXNi5pvbpIJv8F50tREa
         EKYY70ZlXNXdQOmV2KskmHuvV8IRbp+eOe2FBLJ6ed7j2m9Ub3eeTp2tQ7GDWTw8OCG1
         3K6imfG6mdSRP8mrwSNRF5VZhLgaYSAaCXNH9rhVJpGGqVCO2lPhIMKM+FBBfCmlJHkf
         /ouc4kmqil5QkZfZcyDGaw/VAZjn53joEQbHKB0J/wdulCjHX9VnaemfP+dWulGTEBhX
         JeiA==
X-Gm-Message-State: ABuFfoh6cunGZh6vFCF4wInev/Cez6RX9hQgyTip1fS0WJW4K0JpK6Pr
        Qsc9B/5tst9gChVpAw98A+KM+o9lbbM=
X-Google-Smtp-Source: ACcGV60DcgFD56PQwo1pJDRawnRBTMlsXtQ2eaYSWtCGHe6AUTw7kjq20qkLFikLITWDr/9s8AJhsA==
X-Received: by 2002:a25:ac4d:: with SMTP id r13-v6mr374132ybd.45.1539764946078;
        Wed, 17 Oct 2018 01:29:06 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id 138-v6sm4216840ywj.11.2018.10.17.01.29.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 01:29:04 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id l79-v6so10010470ywc.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 01:29:04 -0700 (PDT)
X-Received: by 2002:a81:3d8d:: with SMTP id k135-v6mr13943217ywa.415.1539764943845;
 Wed, 17 Oct 2018 01:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181017075242.21790-1-henryhsu@chromium.org> <13883852.6N9L7C0n48@avalon>
In-Reply-To: <13883852.6N9L7C0n48@avalon>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 17 Oct 2018 17:28:52 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B+4x4aSUywtdukwgUmQNQsQsbK4sjedNphwNFteaTscg@mail.gmail.com>
Message-ID: <CAAFQd5B+4x4aSUywtdukwgUmQNQsQsbK4sjedNphwNFteaTscg@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Add boottime clock support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Heng-Ruey Hsu <henryhsu@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Oct 17, 2018 at 5:02 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Heng-Ruey,
>
> Thank you for the patch.
>
> On Wednesday, 17 October 2018 10:52:42 EEST Heng-Ruey Hsu wrote:
> > Android requires camera timestamps to be reported with
> > CLOCK_BOOTTIME to sync timestamp with other sensor sources.
>
> What's the rationale behind this, why can't CLOCK_MONOTONIC work ? If the
> monotonic clock has shortcomings that make its use impossible for proper
> synchronization, then we should consider switching to CLOCK_BOOTTIME globally
> in V4L2, not in selected drivers only.
>

CLOCK_BOOTTIME includes the time spent in suspend, while
CLOCK_MONOTONIC doesn't. I can imagine the former being much more
useful for anything that cares about the actual, long term, time
tracking. Especially important since suspend is a very common event on
Android and doesn't stop the time flow there, i.e. applications might
wake up the device to perform various tasks at necessary times.

Generally, I'd see a V4L2_BUF_FLAG_TIMESTAMP_BOOTTIME flag being added
and user space being given choice to select the time stamp base it
needs, perhaps by setting the flag in v4l2_buffer struct at QBUF time?

Best regards,
Tomasz

> > Signed-off-by: Heng-Ruey Hsu <henryhsu@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 4 ++++
> >  drivers/media/usb/uvc/uvc_video.c  | 2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c
> > b/drivers/media/usb/uvc/uvc_driver.c index d46dc432456c..a9658f38c586
> > 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2287,6 +2287,8 @@ static int uvc_clock_param_get(char *buffer, const
> > struct kernel_param *kp) {
> >       if (uvc_clock_param == CLOCK_MONOTONIC)
> >               return sprintf(buffer, "CLOCK_MONOTONIC");
> > +     else if (uvc_clock_param == CLOCK_BOOTTIME)
> > +             return sprintf(buffer, "CLOCK_BOOTTIME");
> >       else
> >               return sprintf(buffer, "CLOCK_REALTIME");
> >  }
> > @@ -2298,6 +2300,8 @@ static int uvc_clock_param_set(const char *val, const
> > struct kernel_param *kp)
> >
> >       if (strcasecmp(val, "monotonic") == 0)
> >               uvc_clock_param = CLOCK_MONOTONIC;
> > +     else if (strcasecmp(val, "boottime") == 0)
> > +             uvc_clock_param = CLOCK_BOOTTIME;
> >       else if (strcasecmp(val, "realtime") == 0)
> >               uvc_clock_param = CLOCK_REALTIME;
> >       else
> > diff --git a/drivers/media/usb/uvc/uvc_video.c
> > b/drivers/media/usb/uvc/uvc_video.c index 86a99f461fd8..d4248d5cd9cd 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -425,6 +425,8 @@ static inline ktime_t uvc_video_get_time(void)
> >  {
> >       if (uvc_clock_param == CLOCK_MONOTONIC)
> >               return ktime_get();
> > +     else if (uvc_clock_param == CLOCK_BOOTTIME)
> > +             return ktime_get_boottime();
> >       else
> >               return ktime_get_real();
> >  }
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
