Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C33FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6A4206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OXA8K7bt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6A4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeIJI0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:26:53 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41236 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeIJI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:26:53 -0400
Received: by mail-yw1-f66.google.com with SMTP id q129-v6so7350660ywg.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 20:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+coeGVmDd/qtnalfNXmUNK2ofGpnOtfPUFXqaO04+fU=;
        b=OXA8K7btg+U/KqqOufL2Xea3TsfYcJCm3x6lbqXKe8bmqqPK7AmTypFL9AQ2ccTHV9
         hyDdEe/gY/OFGepjOY/jdWpGWX2AbM27wD+Z03D5a+HLofBx4SmQhs3b38blQ+aD4ZED
         CBoubzNqASHI2TuCwsYl0WiY6yerLNIlQTOnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+coeGVmDd/qtnalfNXmUNK2ofGpnOtfPUFXqaO04+fU=;
        b=Yz9fHZdBWcpFrppFDXBHJHIklASaI8a+HnJJ7WBUfvJsLb9jmknHb3Qf9yF/SF/Qj2
         9ZwG6GKDQ4qMtiZtR3Y26+XsQpcQtZys2deje4QCSlka7qNS4owSEriRcvQsTC6NhVme
         YuRuqCid51myXi4Nl8gc+kqMSKR73B0ZZc8y/rSgwfPax6gEZFalRCt1r7xsD7W1vtmG
         cLOdsduxnxZouv8TEf9BZL3aJnHeH5baTWi/39dbMpiXvbsXzz+sPSm6Vvdktf2F2LAp
         K9W41SMnKdKuBFQOdgohdgGt1rNe6cmgrTMB2GLdy8B+RtFE1tUBlRszVOzL9+Wh1eNH
         qqFw==
X-Gm-Message-State: APzg51CvEWo4YzvOuD5/uaHBJJSFC4rWCd7GJIHG8eWThcn0x4w3jASV
        Fz7NqkBnTnkIz5bCh9FLtoo4SEzIBYA=
X-Google-Smtp-Source: ANB0VdZaKCavoszAD+L8wGCguFq6v8z1Z64Xdz6YSRRGaS2e5krkzcgarlGxGIqojtz6QdVp0U7cBg==
X-Received: by 2002:a81:7b08:: with SMTP id w8-v6mr9368147ywc.249.1536550498629;
        Sun, 09 Sep 2018 20:34:58 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id f5-v6sm5116059ywd.53.2018.09.09.20.34.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 20:34:57 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id y134-v6so7364993ywg.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 20:34:57 -0700 (PDT)
X-Received: by 2002:a81:6ec5:: with SMTP id j188-v6mr8887284ywc.92.1536550497025;
 Sun, 09 Sep 2018 20:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-3-tfiga@chromium.org>
 <19062a24c3aa2cb9e0410cf2884b4589e44c263b.camel@collabora.com>
In-Reply-To: <19062a24c3aa2cb9e0410cf2884b4589e44c263b.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 10 Sep 2018 12:34:45 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A2xskpHpm8XqWoNKGt9As53Pft1NO32Ziys+PEJ2fh1A@mail.gmail.com>
Message-ID: <CAAFQd5A2xskpHpm8XqWoNKGt9As53Pft1NO32Ziys+PEJ2fh1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Ezequiel Garcia <ezequiel@collabora.com>
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 5:17 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> On Tue, 2018-07-24 at 23:06 +0900, Tomasz Figa wrote:
[snip]
> > +Querying capabilities
> > +=====================
> > +
> > +1. To enumerate the set of coded formats supported by the driver, the
> > +   client may call :c:func:`VIDIOC_ENUM_FMT` on ``CAPTURE``.
> > +
> > +   * The driver must always return the full set of supported formats,
> > +     irrespective of the format set on the ``OUTPUT`` queue.
> > +
> > +2. To enumerate the set of supported raw formats, the client may call
> > +   :c:func:`VIDIOC_ENUM_FMT` on ``OUTPUT``.
> > +
> > +   * The driver must return only the formats supported for the format
> > +     currently active on ``CAPTURE``.
> > +
>
> Paul and I where discussing about the default active format on CAPTURE
> and OUTPUT queues. That is, the format that is active (if any) right
> after driver probes.
>
> Currently, the v4l2-compliance tool tests the default active format,
> by requiring drivers to support:
>
>     fmt = g_fmt()
>     s_fmt(fmt)
>
> Is this actually required? Should we also require this for stateful
> and stateless codecs? If yes, should it be documented?

The general V4L2 principle is that drivers must maintain some sane
default state right from when they are exposed to the userspace. I'd
try to stick to the common V4L2 semantics, unless there is a very good
reason not to do so.

Note that we actually diverged from it on CAPTURE state for stateful
decoders, because we return an error, if any format-related ioctl is
called on CAPTURE queue before OUTPUT queue is initialized with a
valid coded format, either explicitly by the client or implicitly via
bitstream parsing. The reason was backwards compatibility with clients
which don't handle source change events. If that wasn't the case, we
could have made the CAPTURE queue completely independent and have the
format there reset with source change event, whenever it becomes
invalid due to things like resolution change or speculative
initialization miss, which would make things much more symmetrical.

Best regards,
Tomasz
