Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EFBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DE621722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iUASwscm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DE621722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeHTRnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:43:50 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33023 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeHTRnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:43:49 -0400
Received: by mail-yw1-f68.google.com with SMTP id x67-v6so1807479ywg.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1V47I2PYZZFDGzCQAD/WcPYSRgtCT/44AnzCcvYq9Y=;
        b=iUASwscme7Eq0zsmF/wn6NsWMPmAzJpw7PKO7RmkWqViDW6p7ictHkukWn+wC97J4M
         TR02QCIfwWcWXbAiFmlYBwWjhElYXGG/EE9Vs+LpGNGKGP2Xl+FsULrTCAYcZA6nTPEi
         dU7fO9agpUJVcMgYYS1jWXJUoXuS+B8Duraf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1V47I2PYZZFDGzCQAD/WcPYSRgtCT/44AnzCcvYq9Y=;
        b=gJe5t+CPcgf/wu3Qpj8QgM+FEnV7YtCcHacs+SqmeOe6gWEctsAc/zpbYWHrQ3K9FY
         C61+7+wJaiJmZh5vX1unVtLhYoPlxE8CuaZIEIUdqGUFlLE5YBZ1h0aMitG8Bl58Cwtb
         O43+jPLizk8Jcia8zoIeaRnX3OZmSbZ2OZME66MpCaWSz2RyRQdpg/pmDxXEb4xDeEBX
         JZbfq2oP1xVPHFSe1M5D8qVj5z5vumHwUbIJVPTCshaFAlShn8b0/Dg/YRPicktDyatl
         dEK7vRPZ+SubjZkO0DeWHbHJ0GA4jSGWI7997pLLMX9PesB2aRhZcPSiGUkypBE87inW
         yBnA==
X-Gm-Message-State: AOUpUlE46+b7OYqQ4DoEf4AMVz63qoKqY0xst/mhCm48VRRjfNxSz9ZT
        kp3Z1tD2RPQrfdDdQUfEw4IiF3RDt+/Ecw==
X-Google-Smtp-Source: AA+uWPyJRqnqSWvhwSvXmmP4LEyKKv4tigznbAhFfarMzhwsHAk11mpWmtkaymh4IhPgktT5TH77Qg==
X-Received: by 2002:a81:25d8:: with SMTP id l207-v6mr6826534ywl.39.1534775277184;
        Mon, 20 Aug 2018 07:27:57 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id o128-v6sm4153779ywe.110.2018.08.20.07.27.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 07:27:57 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id z143-v6so6877782ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 07:27:56 -0700 (PDT)
X-Received: by 2002:a81:87c1:: with SMTP id x184-v6mr24360163ywf.342.1534775276135;
 Mon, 20 Aug 2018 07:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <1534770242.5445.13.camel@pengutronix.de> <CAAFQd5BBOh7nPZ70aaWiSuygGSOTiAQrOm0V9UPgFqqBgZf_LA@mail.gmail.com>
 <1534774398.5445.32.camel@pengutronix.de>
In-Reply-To: <1534774398.5445.32.camel@pengutronix.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 20 Aug 2018 23:27:44 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ACR7wQO7k6PfBg2rJEe81pQvnCzd2yp8AEkU+iLXQXPw@mail.gmail.com>
Message-ID: <CAAFQd5ACR7wQO7k6PfBg2rJEe81pQvnCzd2yp8AEkU+iLXQXPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com,
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

On Mon, Aug 20, 2018 at 11:13 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Tomasz,
>
> On Mon, 2018-08-20 at 22:12 +0900, Tomasz Figa wrote:
> > On Mon, Aug 20, 2018 at 10:04 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > >
> > > On Tue, 2018-07-24 at 23:06 +0900, Tomasz Figa wrote:
> > > [...]
> > > > +Seek
> > > > +====
> > > > +
> > > > +Seek is controlled by the ``OUTPUT`` queue, as it is the source of
> > > > +bitstream data. ``CAPTURE`` queue remains unchanged/unaffected.
> > > > +
> > > > +1. Stop the ``OUTPUT`` queue to begin the seek sequence via
> > > > +   :c:func:`VIDIOC_STREAMOFF`.
> > > > +
> > > > +   * **Required fields:**
> > > > +
> > > > +     ``type``
> > > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> > > > +
> > > > +   * The driver must drop all the pending ``OUTPUT`` buffers and they are
> > > > +     treated as returned to the client (following standard semantics).
> > > > +
> > > > +2. Restart the ``OUTPUT`` queue via :c:func:`VIDIOC_STREAMON`
> > > > +
> > > > +   * **Required fields:**
> > > > +
> > > > +     ``type``
> > > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> > > > +
> > > > +   * The driver must be put in a state after seek and be ready to
> > > > +     accept new source bitstream buffers.
> > > > +
> > > > +3. Start queuing buffers to ``OUTPUT`` queue containing stream data after
> > > > +   the seek until a suitable resume point is found.
> > > > +
> > > > +   .. note::
> > > > +
> > > > +      There is no requirement to begin queuing stream starting exactly from
> > > > +      a resume point (e.g. SPS or a keyframe). The driver must handle any
> > > > +      data queued and must keep processing the queued buffers until it
> > > > +      finds a suitable resume point. While looking for a resume point, the
> > >
> > > I think the definition of a resume point is too vague in this place.
> > > Can the driver decide whether or not a keyframe without SPS is a
> > > suitable resume point? Or do drivers have to parse and store SPS/PPS if
> > > the hardware does not support resuming from a keyframe without sending
> > > SPS/PPS again?
> >
> > The thing is that existing drivers implement and user space clients
> > rely on the behavior described above, so we cannot really change it
> > anymore.
>
> My point is that I'm not exactly sure what that behaviour is, given the
> description.
>
> Must a driver be able to resume from a keyframe even if userspace never
> pushes SPS/PPS again?
> If so, I think it should be mentioned more explicitly than just via an
> example in parentheses, to make it clear to all driver developers that
> this is a requirement that userspace is going to rely on.
>
> Or, if that is not the case, is a driver free to define "SPS only" as
> its "suitable resume point" and to discard all input including keyframes
> until the next SPS/PPS is pushed?
>
> It would be better to clearly define what a "suitable resume point" has
> to be per codec, and not let the drivers decide for themselves, if at
> all possible. Otherwise we'd need a away to inform userspace about the
> per-driver definition.

The intention here is that there is exactly no requirement for the
user space to seek to any kind of resume point and so there is no
point in defining such. The only requirement here is that the
hardware/driver keeps processing the source stream until it finds a
resume point suitable for it - if the hardware keeps SPS/PPS in its
state then just a keyframe; if it doesn't then SPS/PPS. Note that this
is a documentation of the user space API, not a driver implementation
guide. We may want to create the latter separately, though.

H264 is a bit special here, because one may still seek to a key frame,
but past the relevant SPS/PPS headers. In this case, there is no way
for the hardware to know that the SPS/PPS it has in its local state is
not the one that applies to the frame. It may be worth adding that
such case leads to undefined results, but must not cause crash nor a
fatal decode error.

What do you think?

>
> > Do we have hardware for which this wouldn't work to the point that the
> > driver couldn't even continue with a bunch of frames corrupted? If
> > only frame corruption is a problem, we can add a control to tell the
> > user space to seek to resume points and it can happen in an
> > incremental patch.
>
> The coda driver currently can't seek at all, it always stops and
> restarts the sequence. So depending on the above I might have to either
> find and store SPS/PPS in software, or figure out how to make the
> firmware flush the bitstream buffer and restart without actually
> stopping the sequence.
> I'm sure the hardware is capable of this, it's more a question of what
> behaviour is actually intended, and whether I have enough information
> about the firmware interface to implement it.

What happens if you just keep feeding it with next frames? If that
would result only in corrupted frames, I suppose the control (say
V4L2_CID_MPEG_VIDEO_NEEDS_SEEK_TO_RESUME_POINT) would solve the
problem?

Best regards,
Tomasz
