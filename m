Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCF4C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CAC216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gwtc+0rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CAC216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeHHFN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:13:29 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45359 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeHHFN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:13:29 -0400
Received: by mail-yw1-f68.google.com with SMTP id 139-v6so511144ywg.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 19:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BJPU1Soph7ctFMWqoVy96AlSlcHTiglJsix6QJ7CHA=;
        b=gwtc+0rwWRbUUp+1Gld/eJMh5IbpnD1FCYz+00uqjg4ahYDBDp+X8ABaB320EKLtBR
         ibsUWkqLUjl5YlBImC8HmBCDIbLJO/dFBay+JZkI4aDDZsHD1Y5ZAC4ql0Av+ctSKHQ3
         aXaux4x0l3T9EfhkVNIHzjyRRygWC5/UmXaEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BJPU1Soph7ctFMWqoVy96AlSlcHTiglJsix6QJ7CHA=;
        b=anEPoxVfDSJC16auge7UBtvGychNUlz0Hvg+DaT3XmgC5loMS5I9ZcjWQJptN0Y6uv
         BNI+/QXSA5rlahjWZ74GOcF7ojQ56scXgUSyYoYZsrxvX6R0ALxBze8kSMmJLpvWl+TU
         mzs5dXmpPIB95aoke4dk2vxfYwyzfpCjyKyOsKkVnwLEL+CiQmU+Arsz1ph0gGGsxna/
         UizbfE4rOEsnseFnYoHVgpswb3l7Ne8p0ymwYavgMZWBh5KTtt8hSweqS5BfoMUa9+vZ
         jyxvCZhJo7ynPZquga5x8UXrzbsYGiePG33W1+As9MYhIOu2tum3kf0rOOT8HMxKnNcf
         xzUg==
X-Gm-Message-State: AOUpUlG2+DTwQAd6/RmDgYyMzVT0rcA1lHAv1ys/vbPy8VgLULeQHvq6
        4vqZvGVovmuK22btNoCQcSC51Wo98DE=
X-Google-Smtp-Source: AA+uWPykZ5ixH0PqZQtFDi/04qTskNRzvg85pxK+vSr9tELxR7R355b4cPtp2G6z3i8EM6kECP5uMw==
X-Received: by 2002:a81:57c3:: with SMTP id l186-v6mr516083ywb.420.1533696963511;
        Tue, 07 Aug 2018 19:56:03 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id 141-v6sm1839782ywj.65.2018.08.07.19.56.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 19:56:02 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id s68-v6so534527ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 19:56:02 -0700 (PDT)
X-Received: by 2002:a25:20f:: with SMTP id 15-v6mr22706ybc.7.1533696962015;
 Tue, 07 Aug 2018 19:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <37a8faea-a226-2d52-36d4-f9df194623cc@xs4all.nl> <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
 <a6af3dc9-1d09-a414-ce31-bc1b3e69894f@xs4all.nl> <CAAFQd5AnC+hWy4QUGE-s+qgRvvgGC7rMhH6x8koTfYJzTLw8Cg@mail.gmail.com>
 <f0aa7c84-08e3-9b04-8d1b-95f741d6817b@xs4all.nl>
In-Reply-To: <f0aa7c84-08e3-9b04-8d1b-95f741d6817b@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 8 Aug 2018 11:55:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ACWO0FxzZdxf-N-GStCMOSWzxKxhcpCRUh=BqT7jLJWw@mail.gmail.com>
Message-ID: <CAAFQd5ACWO0FxzZdxf-N-GStCMOSWzxKxhcpCRUh=BqT7jLJWw@mail.gmail.com>
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
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 4:37 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 08/07/2018 09:05 AM, Tomasz Figa wrote:
> > On Thu, Jul 26, 2018 at 7:57 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>>> What if you set the format to 0x0 but the stream does not have meta data with
> >>>> the resolution? How does userspace know if 0x0 is allowed or not? If this is
> >>>> specific to the chosen coded pixel format, should be add a new flag for those
> >>>> formats indicating that the coded data contains resolution information?
> >>>
> >>> Yes, this would definitely be on a per-format basis. Not sure what you
> >>> mean by a flag, though? E.g. if the format is set to H264, then it's
> >>> bound to include resolution information. If the format doesn't include
> >>> it, then userspace is already aware of this fact, because it needs to
> >>> get this from some other source (e.g. container).
> >>>
> >>>>
> >>>> That way userspace knows if 0x0 can be used, and the driver can reject 0x0
> >>>> for formats that do not support it.
> >>>
> >>> As above, but I might be misunderstanding your suggestion.
> >>
> >> So my question is: is this tied to the pixel format, or should we make it
> >> explicit with a flag like V4L2_FMT_FLAG_CAN_DECODE_WXH.
> >>
> >> The advantage of a flag is that you don't need a switch on the format to
> >> know whether or not 0x0 is allowed. And the flag can just be set in
> >> v4l2-ioctls.c.
> >
> > As far as my understanding goes, what data is included in the stream
> > is definitely specified by format. For example, a H264 elementary
> > stream will always include those data as a part of SPS.
> >
> > However, having such flag internally, not exposed to userspace, could
> > indeed be useful to avoid all drivers have such switch. That wouldn't
> > belong to this documentation, though, since it would be just kernel
> > API.
>
> Why would you keep this internally only?
>

Well, either keep it internal or make it read-only for the user space,
since the behavior is already defined by selected pixel format.

> >>>> I wonder if we should make these min buffer controls required. It might be easier
> >>>> that way.
> >>>
> >>> Agreed. Although userspace is still free to ignore it, because REQBUFS
> >>> would do the right thing anyway.
> >>
> >> It's never been entirely clear to me what the purpose of those min buffers controls
> >> is. REQBUFS ensures that the number of buffers is at least the minimum needed to
> >> make the HW work. So why would you need these controls? It only makes sense if they
> >> return something different from REQBUFS.
> >>
> >
> > The purpose of those controls is to let the client allocate a number
> > of buffers bigger than minimum, without the need to allocate the
> > minimum number of buffers first (to just learn the number), free them
> > and then allocate a bigger number again.
>
> I don't feel this is particularly useful. One problem with the minimum number
> of buffers as used in the kernel is that it is often the minimum number of
> buffers required to make the hardware work, but it may not be optimal. E.g.
> quite a few capture drivers set the minimum to 2, which is enough for the
> hardware, but it will likely lead to dropped frames. You really need 3
> (one is being DMAed, one is queued and linked into the DMA engine and one is
> being processed by userspace).
>
> I would actually prefer this to be the recommended minimum number of buffers,
> which is >= the minimum REQBUFS uses.
>
> I.e., if you use this number and you have no special requirements, then you'll
> get good performance.

I guess we could make it so. It would make existing user space request
more buffers than it used to with the original meaning, but I guess it
shouldn't be a big problem.

>
> >
> >>>
> >>>>
> >>>>> +7.  If all the following conditions are met, the client may resume the
> >>>>> +    decoding instantly, by using :c:func:`VIDIOC_DECODER_CMD` with
> >>>>> +    ``V4L2_DEC_CMD_START`` command, as in case of resuming after the drain
> >>>>> +    sequence:
> >>>>> +
> >>>>> +    * ``sizeimage`` of new format is less than or equal to the size of
> >>>>> +      currently allocated buffers,
> >>>>> +
> >>>>> +    * the number of buffers currently allocated is greater than or equal to
> >>>>> +      the minimum number of buffers acquired in step 6.
> >>>>
> >>>> You might want to mention that if there are insufficient buffers, then
> >>>> VIDIOC_CREATE_BUFS can be used to add more buffers.
> >>>>
> >>>
> >>> This might be a bit tricky, since at least s5p-mfc and coda can only
> >>> work on a fixed buffer set and one would need to fully reinitialize
> >>> the decoding to add one more buffer, which would effectively be the
> >>> full resolution change sequence, as below, just with REQBUFS(0),
> >>> REQBUFS(N) replaced with CREATE_BUFS.
> >>
> >> What happens today in those drivers if you try to call CREATE_BUFS?
> >
> > s5p-mfc doesn't set the .vidioc_create_bufs pointer in its
> > v4l2_ioctl_ops, so I suppose that would be -ENOTTY?
>
> Correct for s5p-mfc.

As Philipp clarified, coda supports adding buffers on the fly. I
briefly looked at venus and mtk-vcodec and they seem to use m2m
implementation of CREATE_BUFS. Not sure if anyone tested that, though.
So the only hardware I know for sure cannot support this is s5p-mfc.

Best regards,
Tomasz
