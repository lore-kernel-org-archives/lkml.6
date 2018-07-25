Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F46C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7342520843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Shq3/FAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7342520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeGYOrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:47:31 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39014 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeGYOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:47:31 -0400
Received: by mail-yw0-f194.google.com with SMTP id r184-v6so2853057ywg.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xoDt6cy2T5WyyNkUfyTtgcdzdSwDUsDnlAppuiyTyiY=;
        b=Shq3/FAjlmNXU0EEcCKXRv02AJZHlr4h79/F2LfGKVXqgMVvmBFBHVc8kSJpRL/xSg
         XJTCUyswZAkqD+/aK2Xu6DvwtFmyNeN0h54s7haHEmQv/Gw9Nm+Y28o7BYgXef8quvyI
         B79+NBuYFyVtbKrOTQb9ViITyKENrr9axrjFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xoDt6cy2T5WyyNkUfyTtgcdzdSwDUsDnlAppuiyTyiY=;
        b=j4v2g1PtWtWfkoLX1qF01W2peZg5ngPMlDT+0+eBqoUirGm0pChXC6KwBNU/rl12wx
         8tFC9CgXK/WFihDsoCn29x/I6Beiu566EaMsaJ5tu2Z5OiTIA3buiwXR7kbnM0SkZ+4R
         bHHPf869EPDP22n7ZEI+AjJ/r1XuOAjJKlDVIJhZAVE0pDRkF4oOLBsnoHArcONJ1oxo
         WB/ycvR0+vDySd9YjB/bXWDvX+LuUPNM5W51ymkAtB5E7Q476DVgT3Ym86xI8dJHFgVt
         4iimbtKeo5Aab86/mr+pND0RQzCcTD3Xb7GtCBCPC2Z9239gfO87GGu1DjfVagJLPEgr
         ca8g==
X-Gm-Message-State: AOUpUlE0EUIYgtTvDV3VIrmCCJd328dJgXSuPKVb8PP2h1GlxVPY1Dku
        SGuqRRScNeMUzE2K4t0CTy7lvWMRZH1Jbw==
X-Google-Smtp-Source: AAOMgpdGZY90SyM7cCmabOCVSuOpTvpAt5NpfcFv2ejwJi12ZW4qQnfbtvxrrswwAmljnPCT+cXhbQ==
X-Received: by 2002:a81:4990:: with SMTP id w138-v6mr10755180ywa.372.1532525747633;
        Wed, 25 Jul 2018 06:35:47 -0700 (PDT)
Received: from mail-yb0-f169.google.com (mail-yb0-f169.google.com. [209.85.213.169])
        by smtp.gmail.com with ESMTPSA id r69-v6sm6818828ywh.44.2018.07.25.06.35.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 06:35:46 -0700 (PDT)
Received: by mail-yb0-f169.google.com with SMTP id e84-v6so2986481ybb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 06:35:46 -0700 (PDT)
X-Received: by 2002:a25:207:: with SMTP id 7-v6mr11378997ybc.7.1532525745776;
 Wed, 25 Jul 2018 06:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <1532525286.4879.5.camel@pengutronix.de>
In-Reply-To: <1532525286.4879.5.camel@pengutronix.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 25 Jul 2018 22:35:34 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DJXucCFGUadNUiEboWLGrFF330KX9a4xJPONv6J4yidg@mail.gmail.com>
Message-ID: <CAAFQd5DJXucCFGUadNUiEboWLGrFF330KX9a4xJPONv6J4yidg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Document memory-to-memory video codec interfaces
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Wed, Jul 25, 2018 at 10:28 PM Philipp Zabel <p.zabel@pengutronix.de> wro=
te:
>
> Hi Tomasz,
>
> On Tue, 2018-07-24 at 23:06 +0900, Tomasz Figa wrote:
> > This series attempts to add the documentation of what was discussed
> > during Media Workshops at LinuxCon Europe 2012 in Barcelona and then
> > later Embedded Linux Conference Europe 2014 in D=C3=BCsseldorf and then
> > eventually written down by Pawel Osciak and tweaked a bit by Chrome OS
> > video team (but mostly in a cosmetic way or making the document more
> > precise), during the several years of Chrome OS using the APIs in
> > production.
> >
> > Note that most, if not all, of the API is already implemented in
> > existing mainline drivers, such as s5p-mfc or mtk-vcodec. Intention of
> > this series is just to formalize what we already have.
> >
> > It is an initial conversion from Google Docs to RST, so formatting is
> > likely to need some further polishing. It is also the first time for me
> > to create such long RST documention. I could not find any other instanc=
e
> > of similar userspace sequence specifications among our Media documents,
> > so I mostly followed what was there in the source. Feel free to suggest
> > a better format.
> >
> > Much of credits should go to Pawel Osciak, for writing most of the
> > original text of the initial RFC.
> >
> > Changes since RFC:
> > (https://lore.kernel.org/patchwork/project/lkml/list/?series=3D348588)
> >  - The number of changes is too big to list them all here. Thanks to
> >    a huge number of very useful comments from everyone (Philipp, Hans,
> >    Nicolas, Dave, Stanimir, Alexandre) we should have the interfaces mu=
ch
> >    more specified now. The issues collected since previous revisions an=
d
> >    answers leading to this revision are listed below.
>
> Thanks a lot for the update, and especially for the nice Q&A summary of
> the discussions so far.
>
> [...]
> > Decoder issues
> >
> [...]
> >   How should ENUM_FRAMESIZES be affected by profiles and levels?
> >
> >   Answer: Not in current specification - the logic is too complicated a=
nd
> >   it might make more sense to actually handle this in user space.  (In
> >   theory, level implies supported frame sizes + other factors.)
>
> For decoding I think it makes more sense to let the hardware decode them
> from the stream and present them as read-only controls, such as:
>
> 42a68012e67c ("media: coda: add read-only h.264 decoder profile/level
> controls")

To clarify, this point is only about the effect on ENUM_FRAMESIZES.
Profile and level controls are mentioned in capabilities enumeration,
but it may make sense to add optional steps of querying them in
Initialization sequence.

>
> if possible. For encoding, the coda firmware determines level from
> bitrate and coded resolution, itself, so I agree not making this part of
> the spec is a good idea for now.

Encoder controls are driver-specific in general, since the encoding
capabilities vary a lot, so I decided to just briefly mention the
general idea of encoding parameters in "Encoding parameter changes"
section. It could be a good idea to add a reference to the MPEG
control documentation there, though.

Best regards,
Tomasz
