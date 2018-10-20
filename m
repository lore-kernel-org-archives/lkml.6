Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E5EC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 10:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1443921521
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 10:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ITPue7gH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1443921521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJTSeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 14:34:36 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34147 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeJTSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 14:34:35 -0400
Received: by mail-yb1-f195.google.com with SMTP id 184-v6so14270387ybg.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhpX4f9IquPfi/JWkvSofHU1xjzBa5f9b6VXogAlsFc=;
        b=ITPue7gHkoAIPd0Cn7ZHw08lqxLFNA4WaZYgGr9J6J20h88eAPIBllyPyqoBOS3a6E
         eSFe5ovZiJMaUobdKx4v8DPwIH+Ls1BYp7PcaOOoxqB95kIoW0VfrX8fSycwVMWTy11+
         KFg8iVsgAeLiHFKPi0Nsi5Q1eaiUlBBPgn/vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhpX4f9IquPfi/JWkvSofHU1xjzBa5f9b6VXogAlsFc=;
        b=E59MVU/RFW3z/8fqFHXoVWsPHH0A193TXKtBz+0kR9JupqzeDk1kxtPeuDjtKUko7l
         7MDYCAjTQrKgm65hXvB6ByjAC9k2a+tsqH6JlxnLiGud6bkWVZUTHCI6u2jRODoiIu1T
         6Ol/T8rxMdsaZAl3oKCyGrFRXTez+W1Gip9GVS6qDx+XJvZ1DKWuOR1OzmAO+s3FzyCp
         EHoGt6bdynmkPw3wa0440PbemKgNjGSU/Xg8gzVmyNRSWeRNBF/X/cFaqoOD2Mj2FyMc
         aMsppyE9l8Jv5lq6hlM4zqp9L9jo8YtmTrNsqZTXVCiMGtEkoDJcB2B0dXPhLg/obEWM
         b6jw==
X-Gm-Message-State: ABuFfohGKrVwse6A1ej256b6K1qU0pRdn8zRFYTm75mfFvnJur2q2toX
        omjvgkumqkYzvLyvnavwMfYXw0sfQo4=
X-Google-Smtp-Source: ACcGV62cS9CUZK7pWU2PaMWjOktaFkdaLiro4a+WjP0BegIjoZzOgGrAT0O4R4MZjkAgavDf8upuBw==
X-Received: by 2002:a5b:acd:: with SMTP id a13-v6mr14677226ybr.421.1540031077712;
        Sat, 20 Oct 2018 03:24:37 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 132-v6sm6271712ywt.2.2018.10.20.03.24.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 03:24:35 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id a197-v6so14155364ywh.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 03:24:34 -0700 (PDT)
X-Received: by 2002:a81:3d8d:: with SMTP id k135-v6mr25966997ywa.415.1540031074207;
 Sat, 20 Oct 2018 03:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <9696282.0ldyWdpzWo@avalon> <CAAFQd5Bb2v0iU6GAwOKtc-4kv1V+P_4Co7=OUYg77wfmKQQ=kA@mail.gmail.com>
In-Reply-To: <CAAFQd5Bb2v0iU6GAwOKtc-4kv1V+P_4Co7=OUYg77wfmKQQ=kA@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sat, 20 Oct 2018 19:24:20 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D=Lj2XzUMK1LpOXbK3nTdNCFKRkfj3yfpV9mguDkcvdw@mail.gmail.com>
Message-ID: <CAAFQd5D=Lj2XzUMK1LpOXbK3nTdNCFKRkfj3yfpV9mguDkcvdw@mail.gmail.com>
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
> > > +4. At this point, decoding is paused and the driver will accept, but not
> > > +   process any newly queued ``OUTPUT`` buffers until the client issues
> > > +   ``V4L2_DEC_CMD_START`` or restarts streaming on any queue.
> > > +
> > > +* Once the drain sequence is initiated, the client needs to drive it to
> > > +  completion, as described by the above steps, unless it aborts the process
> > > +  by issuing :c:func:`VIDIOC_STREAMOFF` on ``OUTPUT`` queue.  The client
> > > +  is not allowed to issue ``V4L2_DEC_CMD_START`` or ``V4L2_DEC_CMD_STOP``
> > > +  again while the drain sequence is in progress and they will fail with
> > > +  -EBUSY error code if attempted.
> >
> > While this seems OK to me, I think drivers will need help to implement all the
> > corner cases correctly without race conditions.
>
> We went through the possible list of corner cases and concluded that
> there is no use in handling them, especially considering how much they
> would complicate both the userspace and the drivers. Not even
> mentioning some hardware, like s5p-mfc, which actually has a dedicated
> flush operation, that needs to complete before the decoder can switch
> back to normal mode.

Actually I misread your comment.

Agreed that the decoder commands are a bit tricky to implement
properly. That's one of the reasons I decided to make the return
-EBUSY while an existing drain is in progress.

Do you have any particular simplification in mind that could avoid
some corner cases?

Best regards,
Tomasz
