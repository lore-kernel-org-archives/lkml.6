Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9A5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5118920862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KOCVhsBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5118920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388884AbeKGOHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:07:13 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35615 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388424AbeKGOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:07:13 -0500
Received: by mail-yb1-f195.google.com with SMTP id z2-v6so6347386ybj.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 20:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hL28HXW30M7RjFZtG0lnuAG5WYEvZwiKm6NA/ZWDifs=;
        b=KOCVhsBpPWO3gLKHXX4zLgwtz35r3JtHhkmho9z92CLxj9dE/+Cubg14STvkn5bdKc
         BcY6uP45jA73buR0aoIVnru192dhJi7zT7rn+JE8WsVWJfqen89gsHI71Gdg5H1+45d+
         NWR0JfQDhJYVs7IKdTAQtvi29t8jyQvo+MSUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hL28HXW30M7RjFZtG0lnuAG5WYEvZwiKm6NA/ZWDifs=;
        b=H1v34ixq0Aai4NjZZQVsJrXOmsmRMoXXsIzor52wBWRAgn9+rSCDJhdkHoXPybDCsD
         qnLlhfXRRNs/lsmM0NdPyoC8XNcI8ybl/ClYyQWQNToiD24pPAsgsEppqcJ6Yk9YVqKl
         l2RuNQMl+5mlXh9WqTyOmgKmE79RIOdVxNtHgLS09JwxietZmqB/7qba0ch9IcmGcsgO
         SugJm/HJqFbJPL+1+kbbd3ALYRCCJQb80jSX34FXPG8D1wN43zozthJ7ECvxQ+E3K034
         YcDgrlu9/5OwzKjKAmPM2FrCn0WESW5BE14cY6kC5CJNEsF1lwZmWisuxNKVNt/1QY9T
         ow1Q==
X-Gm-Message-State: AGRZ1gJ3fnbuEGLcAIO9AkPqOlXLIq81l1g2tZG+ET5AKypQdmAqe7uE
        +eue3T76AoWW2cq3g7iDtv1UMV2yQvI=
X-Google-Smtp-Source: AJdET5cTp1XIFap+0T2cGvt6yXTu2t4ooyO04HUY0rTario1E/Rt7FEcIv7Xha0o9nBQ0gKtjf42ug==
X-Received: by 2002:a25:6d06:: with SMTP id i6-v6mr240054ybc.333.1541565512421;
        Tue, 06 Nov 2018 20:38:32 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id v129-v6sm2078885ywa.8.2018.11.06.20.38.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 20:38:31 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id u103-v6so4783852ybi.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 20:38:31 -0800 (PST)
X-Received: by 2002:a25:9a46:: with SMTP id r6-v6mr250702ybo.303.1541565510737;
 Tue, 06 Nov 2018 20:38:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.3cb9065dabdf5d455da508fb4109201e626d5ee7.1522168131.git-series.kieran.bingham@ideasonboard.com>
 <cae511f90085701e7093ce39dc8dabf8fc16b844.1522168131.git-series.kieran.bingham@ideasonboard.com>
 <CAAFQd5CQEhmuLbs0dmGfu66x1Xq1V_kOT0bV_DoPitkkOX5Q4A@mail.gmail.com> <4fa1b96d-912c-ec07-f08e-d8de164a0186@ideasonboard.com>
In-Reply-To: <4fa1b96d-912c-ec07-f08e-d8de164a0186@ideasonboard.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 7 Nov 2018 13:38:19 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CKuGRGevKRgqHjQ6nU=EXz720-yxS6uoe3CF-AY5+knQ@mail.gmail.com>
Message-ID: <CAAFQd5CKuGRGevKRgqHjQ6nU=EXz720-yxS6uoe3CF-AY5+knQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] media: uvcvideo: Move decode processing to process context
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        olivier.braun@stereolabs.com, troy.kisky@boundarydevices.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Wed, Nov 7, 2018 at 12:13 AM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Tomasz,
>
> On 07/08/2018 10:54, Tomasz Figa wrote:
> > Hi Kieran,
> >
> > On Wed, Mar 28, 2018 at 1:47 AM Kieran Bingham
> > <kieran.bingham@ideasonboard.com> wrote:
> > [snip]
> >> @@ -1544,25 +1594,29 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
> >>   */
> >>  static void uvc_uninit_video(struct uvc_streaming *stream, int free_buffers)
> >>  {
> >> -       struct urb *urb;
> >> -       unsigned int i;
> >> +       struct uvc_urb *uvc_urb;
> >>
> >>         uvc_video_stats_stop(stream);
> >>
> >> -       for (i = 0; i < UVC_URBS; ++i) {
> >> -               struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
> >> +       /*
> >> +        * We must poison the URBs rather than kill them to ensure that even
> >> +        * after the completion handler returns, any asynchronous workqueues
> >> +        * will be prevented from resubmitting the URBs
> >> +        */
> >> +       for_each_uvc_urb(uvc_urb, stream)
> >> +               usb_poison_urb(uvc_urb->urb);
> >>
> >> -               urb = uvc_urb->urb;
> >> -               if (urb == NULL)
> >> -                       continue;
> >> +       flush_workqueue(stream->async_wq);
> >>
> >> -               usb_kill_urb(urb);
> >> -               usb_free_urb(urb);
> >> +       for_each_uvc_urb(uvc_urb, stream) {
> >> +               usb_free_urb(uvc_urb->urb);
> >>                 uvc_urb->urb = NULL;
> >>         }
> >>
> >>         if (free_buffers)
> >>                 uvc_free_urb_buffers(stream);
> >> +
> >> +       destroy_workqueue(stream->async_wq);
> >
> > In our testing, this function ends up being called twice, if before
> > suspend the camera is streaming and if the camera disconnects between
> > suspend and resume. This is because uvc_video_suspend() calls this
> > function (with free_buffers = 0), but uvc_video_resume() wouldn't call
> > uvc_init_video() due to an earlier failure and uvc_v4l2_release()
> > would end up calling this function again, while the workqueue is
> > already destroyed.
> >
> > The following diff seems to take care of it:
>
> Thank you for this. After discussing with Laurent, I have gone with the
> approach of keeping the workqueue for the lifetime of the stream, rather
> than the lifetime of the streamon.
>

Sounds good to me. Thanks for heads up!

Best regards,
Tomasz
