Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC01C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC262154D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="agzrra2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC262154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJTXuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 19:50:50 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39197 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeJTXuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 19:50:50 -0400
Received: by mail-yb1-f196.google.com with SMTP id j193-v6so3199033ybj.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjudrxXxvqsbj/szpVbkWeHhVtdGnETmnnagOvEJsJU=;
        b=agzrra2/ye1/bw8BbvAfXXkZtAc96bONszTLu7U7PfcKTa2KB+3buqsrOYdNI/ogZM
         OrsJje80YG3UNuQ/0RZLq68apkHeJQ0L7Omv7T/ebc7Y30HVIDs+szVJtszhGme15LNR
         A7H38HAKLsGVzVeOS+rdtG31+LbH621KwLsbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjudrxXxvqsbj/szpVbkWeHhVtdGnETmnnagOvEJsJU=;
        b=DZLe7pd5LFqmi3vzzzTuW1qTz/EyGnp3DJd1w8azyIIy5odGmQyq2G64mej7ulx38B
         h+NOeZuB66r6oZA2XoAvbGpkCiLiHUaUNRO66zlzXdWke5rXdxxhx0SoWEB5fGZpEGBC
         LPv5lFT9tOQuyHJq+tk/bteDhfp3dEICCZoyvn9keGiJYa0h+o3CzP47C3hiRK8b31lC
         tvIGuK0nlpLTNY3P/2UQuB5Uhstn8uGguWietvypmoiNfm/xu0ZPPgI+VwPZIiGb56q4
         ozRRYF5SGTZNriqsClWueFWwHESBT8HlfOzDXQP79ub62GTG15G/GuhwF8Rg/gOhJCxU
         wKGQ==
X-Gm-Message-State: ABuFfogJanmgxmVJoIdArKtnSACvjbO4yWZMgTxM3HkLBFMzZldCr7xq
        tdFIm/sEfTuFlHHuRzKBziI+ZgrKuTM=
X-Google-Smtp-Source: ACcGV62xJp//JRUSuZ9Z87XJvb1n35qSiOeZz39KMtulvnOsacGA/lde3PFj4nrIaX3fxKazxV0w6w==
X-Received: by 2002:a25:b083:: with SMTP id f3-v6mr5129249ybj.293.1540049997164;
        Sat, 20 Oct 2018 08:39:57 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id q1-v6sm7157877ywa.92.2018.10.20.08.39.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 08:39:55 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id k132-v6so3319029ybc.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 08:39:54 -0700 (PDT)
X-Received: by 2002:a25:24c6:: with SMTP id k189-v6mr15981307ybk.373.1540049994583;
 Sat, 20 Oct 2018 08:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <9696282.0ldyWdpzWo@avalon> <CAAFQd5Bb2v0iU6GAwOKtc-4kv1V+P_4Co7=OUYg77wfmKQQ=kA@mail.gmail.com>
In-Reply-To: <CAAFQd5Bb2v0iU6GAwOKtc-4kv1V+P_4Co7=OUYg77wfmKQQ=kA@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sun, 21 Oct 2018 00:39:42 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CdjZKEeZmowMKVLVKhiWPxEK2f7H+xNhhXAPn7O-S33g@mail.gmail.com>
Message-ID: <CAAFQd5CdjZKEeZmowMKVLVKhiWPxEK2f7H+xNhhXAPn7O-S33g@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
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
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 7:03 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Laurent,
>
> On Wed, Oct 17, 2018 at 10:34 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Tomasz,
> >
> > Thank you for the patch.
>
> Thanks for your comments! Please see my replies inline.
>
> >
> > On Tuesday, 24 July 2018 17:06:20 EEST Tomasz Figa wrote:
[snip]
> > > The driver must also set
> > > +     ``V4L2_BUF_FLAG_LAST`` in :c:type:`v4l2_buffer` ``flags`` field on the
> > > +     buffer on the ``CAPTURE`` queue containing the last frame (if any)
> > > +     produced as a result of processing the ``OUTPUT`` buffers queued
> > > +     before ``V4L2_DEC_CMD_STOP``. If no more frames are left to be
> > > +     returned at the point of handling ``V4L2_DEC_CMD_STOP``, the driver
> > > +     must return an empty buffer (with :c:type:`v4l2_buffer`
> > > +     ``bytesused`` = 0) as the last buffer with ``V4L2_BUF_FLAG_LAST`` set
> > > +     instead. Any attempts to dequeue more buffers beyond the buffer marked
> > > +     with ``V4L2_BUF_FLAG_LAST`` will result in a -EPIPE error from
> > > +     :c:func:`VIDIOC_DQBUF`.
> > > +
> > > +   * If the ``CAPTURE`` queue is NOT streaming, no action is necessary for
> > > +     ``CAPTURE`` queue and the driver must send a ``V4L2_EVENT_EOS``
> > > +     immediately after all ``OUTPUT`` buffers in question have been
> > > +     processed.
> >
> > What is the use case for this ? Can't we just return an error if decoder isn't
> > streaming ?
> >
>
> Actually this is wrong. We want the queued OUTPUT buffers to be
> processed and decoded, so if the CAPTURE queue is not yet set up
> (initialization sequence not completed yet), handling the
> initialization sequence first will be needed as a part of the drain
> sequence. I've updated the document with that.

I might want to take this back. The client could just drive the
initialization to completion on its own and start the drain sequence
after that. Let me think if it makes anything easier. For reference, I
don't see any compatibility constraint here, since the existing user
space already works like that.

Best regards,
Tomasz
