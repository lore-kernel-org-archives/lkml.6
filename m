Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A73C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F65320652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aLEZxw25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F65320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJOR6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:58:43 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36754 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOR6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:58:42 -0400
Received: by mail-yw1-f67.google.com with SMTP id e201-v6so7309983ywa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltSeLTifuW11G43C+EeaDED4E8SWxt+UFfxhiYAcMKM=;
        b=aLEZxw253Y/s0rkkJyBVg1Ovq3WhQkqA6NjUCUuAOcOuTlyFTCkRFQUQS5yE7jd8gB
         Fq0we8Rvm5wogEPXCQ5JMqfJu73clis330YjTykYa6cwYUhgavEutULfvpkZtYMg9UXG
         K88pyVT4ttK7LyFti8/CwfZ72QzWwk9uguuQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltSeLTifuW11G43C+EeaDED4E8SWxt+UFfxhiYAcMKM=;
        b=QqtlZEczJ+793dtK8P6hxVUYbEp7eK5L650nN/BuGPvL0euJlicroEiHOQ+xA8IB6w
         jKNHpP2JdI88kgKFRNsejKQGdEKp50ZJ7XsKUE6r8Ydly04ioukOfdn32H9AUDMjwfzC
         OkZ9vtTIFlckeOdJwSE6OMnwyZPORsw5IbRRCly1IL4wcPw0k4A8sgKK8XDAavagoOMI
         u1bHz3GDt9rYhi4l25iibkp27iQaaKNSScPfrpCg9A17nAaRmfC4JGgn/hctEE2TuWQ6
         WJ+JGShiuVSMWt7tSUDmWH7TiOnF4HRGx+tJgX8Gyd5XT/Katy8mj97xnOoy6mcJVEDe
         NN8Q==
X-Gm-Message-State: ABuFfogYU5MmkzogMnNu4BfWgfZhmGe5di7bOgV+Y0tMxusunnJwnvnb
        GcG8zBZE4zphL7ySsFlJp+V7xwtzTRY=
X-Google-Smtp-Source: ACcGV63+dPJ/Gk2VG1EqRGa2o9PT9m1W1+NLraE9i6JwjAWHpVmgqoQcGXobw56YzROI2/Bwn+5gXA==
X-Received: by 2002:a0d:d4c9:: with SMTP id w192-v6mr8569228ywd.211.1539598446325;
        Mon, 15 Oct 2018 03:14:06 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id y126-v6sm2753809ywe.26.2018.10.15.03.14.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:14:05 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id v1-v6so7308569ywv.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 03:14:04 -0700 (PDT)
X-Received: by 2002:a81:3d8d:: with SMTP id k135-v6mr8943563ywa.415.1539598444339;
 Mon, 15 Oct 2018 03:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <37a8faea-a226-2d52-36d4-f9df194623cc@xs4all.nl> <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
 <a6af3dc9-1d09-a414-ce31-bc1b3e69894f@xs4all.nl> <CAAFQd5AnC+hWy4QUGE-s+qgRvvgGC7rMhH6x8koTfYJzTLw8Cg@mail.gmail.com>
 <f0aa7c84-08e3-9b04-8d1b-95f741d6817b@xs4all.nl> <CAAFQd5ACWO0FxzZdxf-N-GStCMOSWzxKxhcpCRUh=BqT7jLJWw@mail.gmail.com>
In-Reply-To: <CAAFQd5ACWO0FxzZdxf-N-GStCMOSWzxKxhcpCRUh=BqT7jLJWw@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 15 Oct 2018 19:13:51 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ASZU-tSadEbE5NuD3aiNeZakPe-UT7oXdBxASqCpujWw@mail.gmail.com>
Message-ID: <CAAFQd5ASZU-tSadEbE5NuD3aiNeZakPe-UT7oXdBxASqCpujWw@mail.gmail.com>
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

On Wed, Aug 8, 2018 at 11:55 AM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Tue, Aug 7, 2018 at 4:37 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > On 08/07/2018 09:05 AM, Tomasz Figa wrote:
> > > On Thu, Jul 26, 2018 at 7:57 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > >>>> I wonder if we should make these min buffer controls required. It might be easier
> > >>>> that way.
> > >>>
> > >>> Agreed. Although userspace is still free to ignore it, because REQBUFS
> > >>> would do the right thing anyway.
> > >>
> > >> It's never been entirely clear to me what the purpose of those min buffers controls
> > >> is. REQBUFS ensures that the number of buffers is at least the minimum needed to
> > >> make the HW work. So why would you need these controls? It only makes sense if they
> > >> return something different from REQBUFS.
> > >>
> > >
> > > The purpose of those controls is to let the client allocate a number
> > > of buffers bigger than minimum, without the need to allocate the
> > > minimum number of buffers first (to just learn the number), free them
> > > and then allocate a bigger number again.
> >
> > I don't feel this is particularly useful. One problem with the minimum number
> > of buffers as used in the kernel is that it is often the minimum number of
> > buffers required to make the hardware work, but it may not be optimal. E.g.
> > quite a few capture drivers set the minimum to 2, which is enough for the
> > hardware, but it will likely lead to dropped frames. You really need 3
> > (one is being DMAed, one is queued and linked into the DMA engine and one is
> > being processed by userspace).
> >
> > I would actually prefer this to be the recommended minimum number of buffers,
> > which is >= the minimum REQBUFS uses.
> >
> > I.e., if you use this number and you have no special requirements, then you'll
> > get good performance.
>
> I guess we could make it so. It would make existing user space request
> more buffers than it used to with the original meaning, but I guess it
> shouldn't be a big problem.

I gave it a bit more thought and I feel like kernel is not the right
place to put any assumptions on what the userspace expects "good
performance" to be. Actually, having these controls return the minimum
number of buffers as REQBUFS would allocate makes it very well
specified - with this number you can only process frame by frame and
the number of buffers added by userspace defines exactly the queue
depth. It leaves no space for driver-specific quirks, because the
driver doesn't decide what's "good performance" anymore.

Best regards,
Tomasz
