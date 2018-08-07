Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CCDC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43AA217BD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nFe9YxBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43AA217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbeHGJSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:18:47 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43637 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeHGJSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:18:46 -0400
Received: by mail-yb0-f194.google.com with SMTP id u7-v6so2242743ybu.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4YJ9NSwAF2Hye2HrPh4mUYnZ3wojuZ+4NjJ9VJ6uj4=;
        b=nFe9YxBYrQ45eYvenMH0ImI6gVMBEZON/yeYHxr4kyYpmsfTrzBMnVE568IK/9kDKe
         EEq/q+JFiF/iUTjSVBsk+/fBSHxKuKrhOBgt2ZjPXc7OqkiAUa44B/xg8LtUW5D5pDIM
         OxC8XhkV/gRoT7Yo2SVa+W5XxyR4p8f2Zp5xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4YJ9NSwAF2Hye2HrPh4mUYnZ3wojuZ+4NjJ9VJ6uj4=;
        b=cPUsT4o68e4cG0tpzWNzom3Nsh9LZDEzff9bm6+rlhmZB4rrsVC8jFqyMulh6qfCve
         XQ2D97MtNTBksPSzZBOZPnwm3Ov4cLPPS4B76HwEkpsFZ75yyiPPRe6WzPo24IW7gUcD
         5jwRmxEV8FelvUHG1WfwOoDw1pWjP5KlatMHXOtIqyJgs+HEV0sdW6IAEbn8XygDwXEc
         OvVco2qNpFbJa4LiCZttevCEPfva66xjc6AQha/GfV1eO1cUZmio+wAbI+kfOdI9T6mH
         wJuod+u7bYSTqg8SZgs6JsRMgdowNqF3MxERkyGII7BnEIgA2ZKfbSKohcj9I9DteQz9
         rrvw==
X-Gm-Message-State: AOUpUlF01mzlal3ncTs2BNFdeAzNQ1TlGwcxZn6plU9TiTch1wFC5yyl
        UgRguMPxYTJ/MvOxrkHe70L1VZUwG4U=
X-Google-Smtp-Source: AAOMgpcYw9ohtxmyB+fjPY1tkc//cViLsjeQ3aP12qhE8evv+xq9sU9hlyX1MLSc2TiFPRPHLVxURQ==
X-Received: by 2002:a25:af44:: with SMTP id c4-v6mr8341918ybj.73.1533625550427;
        Tue, 07 Aug 2018 00:05:50 -0700 (PDT)
Received: from mail-yb0-f174.google.com (mail-yb0-f174.google.com. [209.85.213.174])
        by smtp.gmail.com with ESMTPSA id w127-v6sm331772ywe.32.2018.08.07.00.05.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 00:05:50 -0700 (PDT)
Received: by mail-yb0-f174.google.com with SMTP id u7-v6so2242729ybu.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:05:50 -0700 (PDT)
X-Received: by 2002:a25:4b01:: with SMTP id y1-v6mr8838474yba.344.1533625549545;
 Tue, 07 Aug 2018 00:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <37a8faea-a226-2d52-36d4-f9df194623cc@xs4all.nl> <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
 <a6af3dc9-1d09-a414-ce31-bc1b3e69894f@xs4all.nl>
In-Reply-To: <a6af3dc9-1d09-a414-ce31-bc1b3e69894f@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 7 Aug 2018 16:05:38 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AnC+hWy4QUGE-s+qgRvvgGC7rMhH6x8koTfYJzTLw8Cg@mail.gmail.com>
Message-ID: <CAAFQd5AnC+hWy4QUGE-s+qgRvvgGC7rMhH6x8koTfYJzTLw8Cg@mail.gmail.com>
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

On Thu, Jul 26, 2018 at 7:57 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 26/07/18 12:20, Tomasz Figa wrote:
> > Hi Hans,
> >
> > On Wed, Jul 25, 2018 at 8:59 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>
> >> Hi Tomasz,
> >>
> >> Many, many thanks for working on this! It's a great document and when done
> >> it will be very useful indeed.
> >>
> >> Review comments follow...
> >
> > Thanks for review!
> >
> >>
> >> On 24/07/18 16:06, Tomasz Figa wrote:
>
> > [snip]
>
> >> Note that the v4l2_pix_format/S_FMT documentation needs to be updated as well
> >> since we never allowed 0x0 before.
> >
> > Is there any text that disallows this? I couldn't spot any. Generally
> > there are already drivers which return 0x0 for coded formats (s5p-mfc)
> > and it's not even strange, because in such case, the buffer contains
> > just a sequence of bytes, not a 2D picture.
>
> All non-m2m devices will always have non-zero width/height values. Only with
> m2m devices do we see this.
>
> This was probably never documented since before m2m appeared it was 'obvious'.
>
> This definitely needs to be documented, though.
>

Fair enough. Let me try to add a note there.

> >
> >> What if you set the format to 0x0 but the stream does not have meta data with
> >> the resolution? How does userspace know if 0x0 is allowed or not? If this is
> >> specific to the chosen coded pixel format, should be add a new flag for those
> >> formats indicating that the coded data contains resolution information?
> >
> > Yes, this would definitely be on a per-format basis. Not sure what you
> > mean by a flag, though? E.g. if the format is set to H264, then it's
> > bound to include resolution information. If the format doesn't include
> > it, then userspace is already aware of this fact, because it needs to
> > get this from some other source (e.g. container).
> >
> >>
> >> That way userspace knows if 0x0 can be used, and the driver can reject 0x0
> >> for formats that do not support it.
> >
> > As above, but I might be misunderstanding your suggestion.
>
> So my question is: is this tied to the pixel format, or should we make it
> explicit with a flag like V4L2_FMT_FLAG_CAN_DECODE_WXH.
>
> The advantage of a flag is that you don't need a switch on the format to
> know whether or not 0x0 is allowed. And the flag can just be set in
> v4l2-ioctls.c.

As far as my understanding goes, what data is included in the stream
is definitely specified by format. For example, a H264 elementary
stream will always include those data as a part of SPS.

However, having such flag internally, not exposed to userspace, could
indeed be useful to avoid all drivers have such switch. That wouldn't
belong to this documentation, though, since it would be just kernel
API.

>
> >>> +STREAMOFF-STREAMON sequence on it is intended solely for changing buffer
> >>> +sets.
> >>
> >> 'changing buffer sets': not clear what is meant by this. It's certainly not
> >> 'solely' since it can also be used to achieve an instantaneous seek.
> >>
> >
> > To be honest, I'm not sure whether there is even a need to include
> > this whole section. It's obvious that if you stop feeding a mem2mem
> > device, it will pause. Moreover, other sections imply various
> > behaviors triggered by STREAMOFF/STREAMON/DECODER_CMD/etc., so it
> > should be quite clear that they are different from a simple pause.
> > What do you think?
>
> Yes, I'd drop this last sentence ('Similarly...sets').
>

Ack.

> >>> +2.  After all buffers containing decoded frames from before the resolution
> >>> +    change point are ready to be dequeued on the ``CAPTURE`` queue, the
> >>> +    driver sends a ``V4L2_EVENT_SOURCE_CHANGE`` event for source change
> >>> +    type ``V4L2_EVENT_SRC_CH_RESOLUTION``.
> >>> +
> >>> +    * The last buffer from before the change must be marked with
> >>> +      :c:type:`v4l2_buffer` ``flags`` flag ``V4L2_BUF_FLAG_LAST`` as in the
> >>
> >> spurious 'as'?
> >>
> >
> > It should be:
> >
> >     * The last buffer from before the change must be marked with
> >       the ``V4L2_BUF_FLAG_LAST`` flag in :c:type:`v4l2_buffer` ``flags`` field,
> >       similarly to the
>
> Ah, OK. Now I get it.
>
> >> I wonder if we should make these min buffer controls required. It might be easier
> >> that way.
> >
> > Agreed. Although userspace is still free to ignore it, because REQBUFS
> > would do the right thing anyway.
>
> It's never been entirely clear to me what the purpose of those min buffers controls
> is. REQBUFS ensures that the number of buffers is at least the minimum needed to
> make the HW work. So why would you need these controls? It only makes sense if they
> return something different from REQBUFS.
>

The purpose of those controls is to let the client allocate a number
of buffers bigger than minimum, without the need to allocate the
minimum number of buffers first (to just learn the number), free them
and then allocate a bigger number again.

> >
> >>
> >>> +7.  If all the following conditions are met, the client may resume the
> >>> +    decoding instantly, by using :c:func:`VIDIOC_DECODER_CMD` with
> >>> +    ``V4L2_DEC_CMD_START`` command, as in case of resuming after the drain
> >>> +    sequence:
> >>> +
> >>> +    * ``sizeimage`` of new format is less than or equal to the size of
> >>> +      currently allocated buffers,
> >>> +
> >>> +    * the number of buffers currently allocated is greater than or equal to
> >>> +      the minimum number of buffers acquired in step 6.
> >>
> >> You might want to mention that if there are insufficient buffers, then
> >> VIDIOC_CREATE_BUFS can be used to add more buffers.
> >>
> >
> > This might be a bit tricky, since at least s5p-mfc and coda can only
> > work on a fixed buffer set and one would need to fully reinitialize
> > the decoding to add one more buffer, which would effectively be the
> > full resolution change sequence, as below, just with REQBUFS(0),
> > REQBUFS(N) replaced with CREATE_BUFS.
>
> What happens today in those drivers if you try to call CREATE_BUFS?

s5p-mfc doesn't set the .vidioc_create_bufs pointer in its
v4l2_ioctl_ops, so I suppose that would be -ENOTTY?

Best regards,
Tomasz
