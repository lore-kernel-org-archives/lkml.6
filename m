Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD65C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90341214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AdtC8gje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90341214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJIO5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:57:12 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36912 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:57:12 -0400
Received: by mail-yw1-f68.google.com with SMTP id y14-v6so255526ywa.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaYvd92D6Zz0mDB4/LMP/Rj7mv41Gu0s0MCGsksr0dQ=;
        b=AdtC8gjeY5vOxPblVvpokGLa1fxsAoQo1i9ykmY2XShOx5UpE8QGMxitfx/dbtGg0W
         QAQBrdUI8LeoLuCbCkClLt5bzHYhuRyUKm+fjI3CwBE2G3jpFTRticP9TZpXRm4wXWYN
         zglO/smHIMhXp2IaI+vS9IBhevTVzMGxFVc8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaYvd92D6Zz0mDB4/LMP/Rj7mv41Gu0s0MCGsksr0dQ=;
        b=n03iNL1+IP5GPa29Im+j/PUG7sQy7rP1WbYr+1rHTkaLeAIbz42Ku6wj7sd+1us1FN
         b3x/4lx3z11bgKo5kssIdgGzORIvhCeMCAg8VXF6m8iP+LVgKGqcQ/SKACI1iRW8MEkD
         RpnzXsNo4Q4tfR9KRqkqLJs99G0bfcglSPRh2u9w4E3x8qp5XxXRRSRPs4fEWgX+F4vM
         pDLqlTyP3dyee6yQaZQOoW4zAb/mdXcrS8ccykEpbzIZL9+eB2ecL/MOsy/CX6FH+fIF
         43107SuTjNONrJtnokWYjnSZfBL3CFzO1rdixbW+tZqYZdaHk2l7852jinD52uiGzC+W
         WyIg==
X-Gm-Message-State: ABuFfojyj9C9FLxBnxlhCoqO2ASo20EBMs5HSSzTf701bS6rKpdzd/9u
        9dccqhIGeVk4A3my4kevKIh2KHKGMi2G7Q==
X-Google-Smtp-Source: ACcGV60KjcA9A8tjnkXgYvW8suNY+pwG/3tcC77pDS1SOQj6XfLIs8+68WrxgDV1cL4CjE0Z1mBq7A==
X-Received: by 2002:a81:48c5:: with SMTP id v188-v6mr15181456ywa.159.1539070895087;
        Tue, 09 Oct 2018 00:41:35 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id v34-v6sm16603775ywh.45.2018.10.09.00.41.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 00:41:34 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id j202-v6so241539ywa.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:41:33 -0700 (PDT)
X-Received: by 2002:a0d:fdc6:: with SMTP id n189-v6mr15143519ywf.443.1539070893476;
 Tue, 09 Oct 2018 00:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181004081119.102575-1-acourbot@chromium.org> <676a5e92-86c2-cf5a-9409-ef490ad8e828@xs4all.nl>
In-Reply-To: <676a5e92-86c2-cf5a-9409-ef490ad8e828@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Oct 2018 16:41:22 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AULSY9d0wHXBD227k-F_ER4f+=LkMnp8GOdV3uaCsyeA@mail.gmail.com>
Message-ID: <CAAFQd5AULSY9d0wHXBD227k-F_ER4f+=LkMnp8GOdV3uaCsyeA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] media: docs-rst: Document m2m stateless video
 decoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 8:02 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 10/04/2018 10:11 AM, Alexandre Courbot wrote:
> > This patch documents the protocol that user-space should follow when
> > communicating with stateless video decoders. It is based on the
> > following references:
> >
> > * The current protocol used by Chromium (converted from config store to
> >   request API)
> >
> > * The submitted Cedrus VPU driver
> >
> > As such, some things may not be entirely consistent with the current
> > state of drivers, so it would be great if all stakeholders could point
> > out these inconsistencies. :)
> >
> > This patch is supposed to be applied on top of the Request API V18 as
> > well as the memory-to-memory video decoder interface series by Tomasz
> > Figa.
> >
> > Changes since V1:
> >
> > * Applied fixes received as feedback,
> > * Moved controls descriptions to the extended controls file,
> > * Document reference frame management and referencing (need Hans' feedback on
> >   that).
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >  .../media/uapi/v4l/dev-stateless-decoder.rst  | 348 ++++++++++++++++++
> >  Documentation/media/uapi/v4l/devices.rst      |   1 +
> >  .../media/uapi/v4l/extended-controls.rst      |  25 ++
> >  .../media/uapi/v4l/pixfmt-compressed.rst      |  54 ++-
> >  4 files changed, 424 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/media/uapi/v4l/dev-stateless-decoder.rst
> >
> > diff --git a/Documentation/media/uapi/v4l/dev-stateless-decoder.rst b/Documentation/media/uapi/v4l/dev-stateless-decoder.rst
>
> <snip>
>
> > +Buffer management during decoding
> > +=================================
> > +Contrary to stateful decoder drivers, a stateless decoder driver does not
> > +perform any kind of buffer management. In particular, it guarantees that
> > +``CAPTURE`` buffers will be dequeued in the same order as they are queued. This
> > +allows user-space to know in advance which ``CAPTURE`` buffer will contain a
> > +given frame, and thus to use that buffer ID as the key to indicate a reference
> > +frame.
> > +
> > +This also means that user-space is fully responsible for not queuing a given
> > +``CAPTURE`` buffer for as long as it is used as a reference frame. Failure to do
> > +so will overwrite the reference frame's data while it is still in use, and
> > +result in visual corruption of future frames.
> > +
> > +Note that this applies to all types of buffers, and not only to
> > +``V4L2_MEMORY_MMAP`` ones, as drivers supporting ``V4L2_MEMORY_DMABUF`` will
> > +typically maintain a map of buffer IDs to DMABUF handles for reference frame
> > +management. Queueing a buffer will result in the map entry to be overwritten
> > +with the new DMABUF handle submitted in the :c:func:`VIDIOC_QBUF` ioctl.
>
> The more I think about this, the more I believe that relying on capture buffer
> indices is wrong. It's easy enough if there is a straightforward 1-1 relationship,
> but what if you have H264 slices as Nicolas mentioned and it becomes a N-1 relationship?
>
> Yes, you can still do this in userspace, but it becomes a lot more complicated.
>
> And what if in the future instead of having one capture buffer per decoded frame
> there will be multiple capture buffers per decoded frame, each with a single
> slice (for example)?

Is there any particular scenario you have in mind, where such case would happen?

>
> I would feel much happier if we used a 'cookie' to refer to buffers.

Hmm, how would this cookie work in a case of N OUTPUT -> 1 CAPTURE case?

Best regards,
Tomasz
