Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A64C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2941721473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRo68ZCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2941721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeHTQ21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:28:27 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35926 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeHTQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:28:27 -0400
Received: by mail-yw1-f66.google.com with SMTP id w202-v6so693168yww.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CU3EIhKFe+YSOlxOco3MBEuI637t5pi9B1bUe4+o5t8=;
        b=iRo68ZCO7WnyWq4tcnAE4TRkorr4AB2zmAum/AgOFjx7TX8a5eHWWB6BVOCL5Q6pFm
         0Q8BRh+AQ7C/ZLLap0vYPSHTYHrgh7zAUWSx5hd2VPg8dWVmAozdo5DqzyMJsNuo/3D3
         2JZgFt4EYm6tRUjXOhHnvopbMNzv9e7+p3KOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CU3EIhKFe+YSOlxOco3MBEuI637t5pi9B1bUe4+o5t8=;
        b=EsmGRUBl6FfXzlXs8B/PZLkOGRoaZJT0o+I8sgjm9eJ432P3fZzUCn3RMRVpDD9ruQ
         cpL7y6M+iDZ0cYI83nopX6Mnb036SQ0Z6x07QZFGWrAZ2Qz6DeVJ7IfBYMPKHGWZbT9c
         s0hhdYqjmBR+kRlVBIcNBHWphjlhJJd+7RoZao6+GDHdDLhok9qtv2df8Cnoa9LdghSt
         WQJho47N25rBw21bpAYnft2XEayb3LHu2eqx4mvO/nYhuN10dUmF3Ykm+fhrc1OK3oru
         nF38sRELFk+geirw9QAAPqfCogchZqyGoGn5xCQC/CNuEbjKKGlrVUlZMWB/ZItOELCx
         uNJQ==
X-Gm-Message-State: AOUpUlHCuWT6KnOmrvtA8FeMWBpHsI3zMZSIM64h3zmAg8j8XKwYS+YB
        Oj3HUA4o08HokcnFQ5c+gMqLIEYgfNNuow==
X-Google-Smtp-Source: AA+uWPxW6FhU5YFjCFstkANX8m0xXSsPQc0y/ixcZ++RqfpNKwzy+6zAGNhj8FwUmTvDVACQgzSZZA==
X-Received: by 2002:a0d:c203:: with SMTP id e3-v6mr25681777ywd.103.1534770770537;
        Mon, 20 Aug 2018 06:12:50 -0700 (PDT)
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com. [209.85.213.178])
        by smtp.gmail.com with ESMTPSA id n187-v6sm6008391ywn.76.2018.08.20.06.12.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 06:12:48 -0700 (PDT)
Received: by mail-yb0-f178.google.com with SMTP id d4-v6so617963ybl.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 06:12:48 -0700 (PDT)
X-Received: by 2002:a5b:78f:: with SMTP id b15-v6mr23776465ybq.114.1534770767517;
 Mon, 20 Aug 2018 06:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <1534770242.5445.13.camel@pengutronix.de>
In-Reply-To: <1534770242.5445.13.camel@pengutronix.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 20 Aug 2018 22:12:35 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BBOh7nPZ70aaWiSuygGSOTiAQrOm0V9UPgFqqBgZf_LA@mail.gmail.com>
Message-ID: <CAAFQd5BBOh7nPZ70aaWiSuygGSOTiAQrOm0V9UPgFqqBgZf_LA@mail.gmail.com>
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

On Mon, Aug 20, 2018 at 10:04 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Tue, 2018-07-24 at 23:06 +0900, Tomasz Figa wrote:
> [...]
> > +Seek
> > +====
> > +
> > +Seek is controlled by the ``OUTPUT`` queue, as it is the source of
> > +bitstream data. ``CAPTURE`` queue remains unchanged/unaffected.
> > +
> > +1. Stop the ``OUTPUT`` queue to begin the seek sequence via
> > +   :c:func:`VIDIOC_STREAMOFF`.
> > +
> > +   * **Required fields:**
> > +
> > +     ``type``
> > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> > +
> > +   * The driver must drop all the pending ``OUTPUT`` buffers and they are
> > +     treated as returned to the client (following standard semantics).
> > +
> > +2. Restart the ``OUTPUT`` queue via :c:func:`VIDIOC_STREAMON`
> > +
> > +   * **Required fields:**
> > +
> > +     ``type``
> > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> > +
> > +   * The driver must be put in a state after seek and be ready to
> > +     accept new source bitstream buffers.
> > +
> > +3. Start queuing buffers to ``OUTPUT`` queue containing stream data after
> > +   the seek until a suitable resume point is found.
> > +
> > +   .. note::
> > +
> > +      There is no requirement to begin queuing stream starting exactly from
> > +      a resume point (e.g. SPS or a keyframe). The driver must handle any
> > +      data queued and must keep processing the queued buffers until it
> > +      finds a suitable resume point. While looking for a resume point, the
>
> I think the definition of a resume point is too vague in this place.
> Can the driver decide whether or not a keyframe without SPS is a
> suitable resume point? Or do drivers have to parse and store SPS/PPS if
> the hardware does not support resuming from a keyframe without sending
> SPS/PPS again?

The thing is that existing drivers implement and user space clients
rely on the behavior described above, so we cannot really change it
anymore.

Do we have hardware for which this wouldn't work to the point that the
driver couldn't even continue with a bunch of frames corrupted? If
only frame corruption is a problem, we can add a control to tell the
user space to seek to resume points and it can happen in an
incremental patch.

Best regards,
Tomasz
