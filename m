Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFBCC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FAA20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E0826G05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FAA20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeJCRB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:01:29 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40360 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeJCRB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:01:28 -0400
Received: by mail-yb1-f194.google.com with SMTP id w7-v6so2110560ybm.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qxPeRh1ArtubcOopo+z6mn3QQCBDj0xcThv6iI3I/U=;
        b=E0826G05tIGJA+Ptva7lgdfQ0TxsJ/ii8MMeXASaSWWe7hyrSkec9s+SOTxReEH6AE
         Z7z9P7Nt+tZ/WQwcoh5AHzn//MXyJjSUYYgWrc8IJdiUQw8fwZR1WYBS+WI0QX9L29CJ
         MKkc84d/StnXIWahylqX/QTdfuQEneadF9Z3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qxPeRh1ArtubcOopo+z6mn3QQCBDj0xcThv6iI3I/U=;
        b=g+va5gmudfN4BnN78NngvonloxngjbY9tlhkcpo6dMyfaPhMOjKNsoJ+chw5fLq2ES
         JB8MRua3x8IppMe0ZOkKBfVcry0oWxXne1dO3dyLdAvTOLVxGnzqnNB7Y6HAysbQ3fth
         neRCM/H+gPUJ70PWdT90vSM6naVLqzH9rwaEDuHdomlSeJ4+JIUNvT4BC1vyt2QuadTl
         QhYzyE72XMwKuftqxDosijxRzv3/AcNWNgupZp2rE+7013dFVXa8hUQxEml7j+X2gGpy
         Mc6qmyXM5voOf0qfS5XMXcgQGygfDlBgxFtispTxEqS9+Ecw9DaZTtPr9YKzaFaOR7c3
         YaZQ==
X-Gm-Message-State: ABuFfojHgs83JXUxqqfD3tjFRdCtaGp+CKx2QwlZDuzwzzk+xPGrk6aL
        tfNiupVBbgw0gTwyQulAQkWgBkd1PyGm6A==
X-Google-Smtp-Source: ACcGV62Udrh2boDhgZUqM0qVBNvWzigUlEyB9plXY8UI8zdT9Myw1FJVCfKeZYAhZmjUiCHzPqRNMA==
X-Received: by 2002:a25:ec0e:: with SMTP id j14-v6mr336896ybh.450.1538561624627;
        Wed, 03 Oct 2018 03:13:44 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id c6-v6sm326200ywc.66.2018.10.03.03.13.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 03:13:42 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id m127-v6so2050961ywb.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 03:13:42 -0700 (PDT)
X-Received: by 2002:a81:470a:: with SMTP id u10-v6mr360918ywa.164.1538561622316;
 Wed, 03 Oct 2018 03:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180831074743.235010-1-acourbot@chromium.org>
 <b8a80df8-fd07-6820-3021-670c360ff306@xs4all.nl> <38b32d24-6957-4bee-9168-b3afbfcae083@xs4all.nl>
 <a5c47693-4d66-1afc-9053-45bbbbef9d7c@xs4all.nl> <CAPBb6MXrEPz7Z60zUp-m4pWUB7t9p1iFSqqp9s4Gjqj9i3v4sA@mail.gmail.com>
 <01f1723c-8fd0-8f34-0862-624d2bbf51e3@xs4all.nl> <CAPBb6MV_m9X6d2Jefk+CU+bxOq8Jnz6XcE++_qDfgQ8Jdd1FYQ@mail.gmail.com>
In-Reply-To: <CAPBb6MV_m9X6d2Jefk+CU+bxOq8Jnz6XcE++_qDfgQ8Jdd1FYQ@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 3 Oct 2018 19:13:30 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D7OGfMJks=mP-f3jEXCzwN6MVYNN5a8JFVJZvkF_wH+Q@mail.gmail.com>
Message-ID: <CAAFQd5D7OGfMJks=mP-f3jEXCzwN6MVYNN5a8JFVJZvkF_wH+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] media: docs-rst: Document m2m stateless video decoder interface
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
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

On Tue, Sep 18, 2018 at 5:02 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> Hi Hans, sorry for the late reply.
>
> On Tue, Sep 11, 2018 at 6:09 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > On 09/11/18 10:40, Alexandre Courbot wrote:
> > > On Mon, Sep 10, 2018 at 9:49 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > >>
> > >> On 09/10/2018 01:57 PM, Hans Verkuil wrote:
> > >>> On 09/10/2018 01:25 PM, Hans Verkuil wrote:
> > >>>>> +
> > >>>>> +Decoding
> > >>>>> +========
> > >>>>> +
> > >>>>> +For each frame, the client is responsible for submitting a request to which the
> > >>>>> +following is attached:
> > >>>>> +
> > >>>>> +* Exactly one frame worth of encoded data in a buffer submitted to the
> > >>>>> +  ``OUTPUT`` queue,
> > >>>>> +* All the controls relevant to the format being decoded (see below for details).
> > >>>>> +
> > >>>>> +``CAPTURE`` buffers must not be part of the request, but must be queued
> > >>>>> +independently. The driver will pick one of the queued ``CAPTURE`` buffers and
> > >>>>> +decode the frame into it. Although the client has no control over which
> > >>>>> +``CAPTURE`` buffer will be used with a given ``OUTPUT`` buffer, it is guaranteed
> > >>>>> +that ``CAPTURE`` buffers will be returned in decode order (i.e. the same order
> > >>>>> +as ``OUTPUT`` buffers were submitted), so it is trivial to associate a dequeued
> > >>>>> +``CAPTURE`` buffer to its originating request and ``OUTPUT`` buffer.
> > >>>>> +
> > >>>>> +If the request is submitted without an ``OUTPUT`` buffer or if one of the
> > >>>>> +required controls are missing, then :c:func:`MEDIA_REQUEST_IOC_QUEUE` will return
> > >>>>> +``-EINVAL``.
> > >>>>
> > >>>> Not entirely true: if buffers are missing, then ENOENT is returned. Missing required
> > >>>> controls or more than one OUTPUT buffer will result in EINVAL. This per the latest
> > >>>> Request API changes.
> > >>>>
> > >>>>  Decoding errors are signaled by the ``CAPTURE`` buffers being
> > >>>>> +dequeued carrying the ``V4L2_BUF_FLAG_ERROR`` flag.
> > >>>>
> > >>>> Add here that if the reference frame had an error, then all other frames that refer
> > >>>> to it should also set the ERROR flag. It is up to userspace to decide whether or
> > >>>> not to drop them (part of the frame might still be valid).
> > >>>>
> > >>>> I am not sure whether this should be documented, but there are some additional
> > >>>> restrictions w.r.t. reference frames:
> > >>>>
> > >>>> Since decoders need access to the decoded reference frames there are some corner
> > >>>> cases that need to be checked:
> > >>>>
> > >>>> 1) V4L2_MEMORY_USERPTR cannot be used for the capture queue: the driver does not
> > >>>>    know when a malloced but dequeued buffer is freed, so the reference frame
> > >>>>    could suddenly be gone.
> > >>>>
> > >>>> 2) V4L2_MEMORY_DMABUF can be used, but drivers should check that the dma buffer is
> > >>>>    still available AND increase the dmabuf refcount while it is used by the HW.
> > >>>>
> > >>>> 3) What to do if userspace has requeued a buffer containing a reference frame,
> > >>>>    and you want to decode a B/P-frame that refers to that buffer? We need to
> > >>>>    check against that: I think that when you queue a capture buffer whose index
> > >>>>    is used in a pending request as a reference frame, than that should fail with
> > >>>>    an error. And trying to queue a request referring to a buffer that has been
> > >>>>    requeued should also fail.
> > >>>>
> > >>>> We might need to add some support for this in v4l2-mem2mem.c or vb2.
> > >>>>
> > >>>> We will have similar (but not quite identical) issues with stateless encoders.
> > >>>
> > >>> Related to this is the question whether buffer indices that are used to refer
> > >>> to reference frames should refer to the capture or output queue.
> > >>>
> > >>> Using capture indices works if you never queue more than one request at a time:
> > >>> you know exactly what the capture buffer index is of the decoded I-frame, and
> > >>> you can use that in the following requests.
> > >>>
> > >>> But if multiple requests are queued, then you don't necessarily know to which
> > >>> capture buffer an I-frame will be decoded, so then you can't provide this index
> > >>> to following B/P-frames. This puts restrictions on userspace: you can only
> > >>> queue B/P-frames once you have decoded the I-frame. This might be perfectly
> > >>> acceptable, though.
> > >
> > > IIUC at the moment we are indeed using CAPTURE buffer indexes, e.g:
> > >
> > > .. flat-table:: struct v4l2_ctrl_mpeg2_slice_params
> > >   ..
> > >       - ``backward_ref_index``
> > >       - Index for the V4L2 buffer to use as backward reference, used
> > > with
> > >        B-coded and P-coded frames.
> > >
> > > So I wonder how is the user-space currently exercising Cedrus doing
> > > here? Waiting for each frame used as a reference to be dequeued?
> >
> > No, the assumption is (if I understand correctly) that userspace won't
> > touch the memory of the dequeued reference buffer so HW can just point
> > to it.
> >
> > Paul, please correct me if I am wrong.
> >
> > What does chromeOS do?
>
> At the moment Chrome OS (using the config store) queues the OUTPUT and
> CAPTURE buffers together, i.e. in the same request. The CAPTURE buffer
> is not tied to the request in any way, but what seems to matter here
> is the queue order. If drivers process CAPTURE drivers sequentially,
> then you can know which CAPTURE buffer will be used for the request.
>
> The corollary of that is that CAPTURE buffers cannot be re-queued
> until they are not referenced anymore, something the Chrome OS
> userspace also takes care of. Would it be a problem to make this the
> default expectation instead of having the kernel check and reorder
> CAPTURE buffers? The worst that can happen AFAICT is is frame
> corruption, and processing queued CAPTURE buffers sequentially would
> allow us to use the V4L2 buffer ID to reference frames. That's still
> the most intuitive way to do, using relative frame indexes (i.e. X
> frames ago) adds complexity and the potential for misuse and bugs.

+1

The stateless API delegates the reference frame management to the
client and I don't see why we should be protecting the client from
itself. In particular, as I suggested in another email, there can be
valid cases where requeuing CAPTURE buffers while still on the
reference list is okay.

Best regards,
Tomasz
