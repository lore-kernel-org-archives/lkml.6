Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2E3C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1155C213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E2gzTGal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1155C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJILjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 07:39:01 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43127 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeJILjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 07:39:01 -0400
Received: by mail-yw1-f67.google.com with SMTP id j75-v6so95178ywj.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 21:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsAM/EWKQJr5+ankh0xeabBlUfA8qsnXvJzTXaBqZxY=;
        b=E2gzTGalOHUUF3wxOz4HFtL4vS3MoXCYvyfOuf/LyYqLF2+2sk0Fq5JKO+iFd7fnK8
         kBaganRDy8If9ky6X0ptRjGM1QaZOOghtWXvXbrLR5X1crWHQZZoFeU39+yAKtjpM8bL
         itztvHtBeP/3Aim3hfxdOnJyAX9U28uEYtdQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsAM/EWKQJr5+ankh0xeabBlUfA8qsnXvJzTXaBqZxY=;
        b=QA2u/o25bzdvc87yldNRaVSgWzpmObwQ+q0EtomoqrBsHVXoQ5NGq+ZJubfxQBJteY
         5dBlTvfI2780Ixgy+BVnA6/VogM29E6Kx0Aqb2LAbDN3jFYEsiFsG2/6HI+SocYC7hd0
         9SZ2EPojEcaLQ2BV5j4ueaK8A/InlSk6Thw2f8uzKwfa2GJzt8/TlHa4xAkJWoHOj3bR
         E/KR07jA13pvyxL/hkZQj4KDqBi2vXGdqce/6ocJvlT2IlnbBAa7GUgeqBbDuWvT1uDJ
         ztQ0hZsrDfCYxlc8o6hojgKIGRT6EQNSYiw6/Q20KMPQKb3grgA3yZcfR/raNLFhE0jf
         qcxg==
X-Gm-Message-State: ABuFfoiFIQwuCvCT+4kbTHTmWYVOVNMoZ8Pt+G9HdMfykDD9DcE1ObDq
        DTAXvtKqdYyUGQtTuvQmfChdtkRfoUo=
X-Google-Smtp-Source: ACcGV62rQFCfcMEMKP1eN77fuLVPg6+KXdWl7JElvaYCugo8gkO+GZdC82a/+6nim1FQwkCtzk5Pgw==
X-Received: by 2002:a81:17d4:: with SMTP id 203-v6mr14465838ywx.423.1539059042621;
        Mon, 08 Oct 2018 21:24:02 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id u14-v6sm3824806ywg.46.2018.10.08.21.23.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 21:23:59 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id m127-v6so112277ywb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 21:23:59 -0700 (PDT)
X-Received: by 2002:a81:8144:: with SMTP id r65-v6mr11653652ywf.403.1539059038815;
 Mon, 08 Oct 2018 21:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <37a8faea-a226-2d52-36d4-f9df194623cc@xs4all.nl> <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
 <CAAFQd5Ba+8_wpCr2D2OUSRt-PbRUPk4MV1OxMzEetntL169fBA@mail.gmail.com> <1dc5fd0b-61f0-545a-fea6-bd90721e144b@xs4all.nl>
In-Reply-To: <1dc5fd0b-61f0-545a-fea6-bd90721e144b@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Oct 2018 13:23:47 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DKhed1M8X61VjBd0gXtJb-8qrz5ncPyppff5LmyoqO8w@mail.gmail.com>
Message-ID: <CAAFQd5DKhed1M8X61VjBd0gXtJb-8qrz5ncPyppff5LmyoqO8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 9:22 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 09/19/2018 12:17 PM, Tomasz Figa wrote:
> > Hi Hans,
> >
> > On Thu, Jul 26, 2018 at 7:20 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >>
> >> Hi Hans,
> >>
> >> On Wed, Jul 25, 2018 at 8:59 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>>
> >>> Hi Tomasz,
> >>>
> >>> Many, many thanks for working on this! It's a great document and when done
> >>> it will be very useful indeed.
> >>>
> >>> Review comments follow...
> >>
> >> Thanks for review!
> >>
> >>>
> >>> On 24/07/18 16:06, Tomasz Figa wrote:
> > [snip]
> >>>> +13. Allocate destination (raw format) buffers via :c:func:`VIDIOC_REQBUFS`
> >>>> +    on the ``CAPTURE`` queue.
> >>>> +
> >>>> +    * **Required fields:**
> >>>> +
> >>>> +      ``count``
> >>>> +          requested number of buffers to allocate; greater than zero
> >>>> +
> >>>> +      ``type``
> >>>> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> >>>> +
> >>>> +      ``memory``
> >>>> +          follows standard semantics
> >>>> +
> >>>> +    * **Return fields:**
> >>>> +
> >>>> +      ``count``
> >>>> +          adjusted to allocated number of buffers
> >>>> +
> >>>> +    * The driver must adjust count to minimum of required number of
> >>>> +      destination buffers for given format and stream configuration and the
> >>>> +      count passed. The client must check this value after the ioctl
> >>>> +      returns to get the number of buffers allocated.
> >>>> +
> >>>> +    .. note::
> >>>> +
> >>>> +       To allocate more than minimum number of buffers (for pipeline
> >>>> +       depth), use G_CTRL(``V4L2_CID_MIN_BUFFERS_FOR_CAPTURE``) to
> >>>> +       get minimum number of buffers required, and pass the obtained value
> >>>> +       plus the number of additional buffers needed in count to
> >>>> +       :c:func:`VIDIOC_REQBUFS`.
> >>>
> >>>
> >>> I think we should mention here the option of using VIDIOC_CREATE_BUFS in order
> >>> to allocate buffers larger than the current CAPTURE format in order to accommodate
> >>> future resolution changes.
> >>
> >> Ack.
> >>
> >
> > I'm about to add a paragraph to describe this, but there is one detail
> > to iron out.
> >
> > The VIDIOC_CREATE_BUFS ioctl accepts a v4l2_format struct. Userspace
> > needs to fill in this struct and the specs says that
> >
> >   "Usually this will be done using the VIDIOC_TRY_FMT or VIDIOC_G_FMT
> > ioctls to ensure that the requested format is supported by the
> > driver."
> >
> > However, in case of a decoder, those calls would fixup the format to
> > match the currently parsed stream, which would likely resolve to the
> > current coded resolution (~hardware alignment). How do we get a format
> > for the desired maximum resolution?
>
> You would call G_FMT to get the current format/resolution, then update
> width and height and call TRY_FMT.
>
> Although to be honest you can also just set pixelformat and width/height
> and zero everything else and call TRY_FMT directly, skipping the G_FMT
> ioctl.
>

Wouldn't TRY_FMT adjust the width and height back to match current stream?

Best regards,
Tomasz
