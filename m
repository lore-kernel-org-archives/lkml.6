Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA00C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 04:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B45020644
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 04:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FH8uCpEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B45020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeJVNO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 09:14:58 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:32784 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeJVNO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 09:14:57 -0400
Received: by mail-yw1-f66.google.com with SMTP id m127-v6so15508267ywb.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 21:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6hoVb/RrJtfl7XscJrZtG25e6I69cJUZR09fIkSRmc=;
        b=FH8uCpEp4up5lmFvd51wKTyYleOc5vt4vPCmPp3hEdHS0RZjX6ObEkwxByVNLtL9mM
         op91p1MeV4dmOpCN6wQaWXysmhj4KOP5fNWQ2VIr31QHQQTOEDCsQn0i4WzTy4lVJH4J
         UX8FGrnPMlFz6FbmYN7FE4e9mZSlKbxzZbklQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6hoVb/RrJtfl7XscJrZtG25e6I69cJUZR09fIkSRmc=;
        b=G2PRkgHz8meaP47nwSYE7Afvt4y5zlciwft2caOBRtyrf5+lYOx+R72K8z/C1XpQhr
         CeTReJ9/q+HzUVuj2CX3UnDwAsgQ8RIuYB9UDzJasmN8d6a3Dkwguecwc+J9kqdsXyym
         KQkY5E1zApCbzbR2WPTyfeDrRfADfupGSJtBXPuQH39zy0Yi2UeRpl0JryOdAfP5uCPh
         1xpAV9yEErZdBkRbXuycFn9DRHhUvao7qPQDA/7zOY0X4um97GhSraGQwVPE2qxl4AQD
         +m69y2igZgXuLyuPKZ2Im1/CVg472iN7mJeUh/OsZvau1N9p2fZRl188hSP4BMJPWGHM
         ENrg==
X-Gm-Message-State: ABuFfoihC40bYVEXhYmkFh7JSMggyf9/2RAhwVibGYPvOZUs/ovVzlrY
        qVPtwT449HWfcl/yy3fofAHpEUQZQiA=
X-Google-Smtp-Source: ACcGV62JXK0N48z4xwcB4IG+b8dxg0U4UVPpbyCuC9IXWm6b5A19hRN0wuNk/5OCACeGWY681XOcZA==
X-Received: by 2002:a81:6b42:: with SMTP id g63-v6mr3252391ywc.280.1540184283375;
        Sun, 21 Oct 2018 21:58:03 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id n186-v6sm10189482ywn.16.2018.10.21.21.58.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 21:58:03 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id j202-v6so15486649ywa.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 21:58:03 -0700 (PDT)
X-Received: by 2002:a81:350c:: with SMTP id c12-v6mr11402839ywa.342.1540183843529;
 Sun, 21 Oct 2018 21:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-3-tfiga@chromium.org>
 <4168da98-fa01-ea2f-8162-385501e666be@xs4all.nl> <CAAFQd5BqtKFeJniNaqahi9h_zKR+rPrWUiyx004Z=MWDj7q++w@mail.gmail.com>
 <CAAFQd5Djur9y+=UHTx9ZSx310p2ShCsBTqsEA1UHCMoawuDscA@mail.gmail.com> <7b8b56e7-1617-5de6-9fa9-a10897a8f2f1@xs4all.nl>
In-Reply-To: <7b8b56e7-1617-5de6-9fa9-a10897a8f2f1@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 22 Oct 2018 13:50:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BRxmMpH9J0tZLD7=9Be+dUggym9-5ctV4536YbHedESQ@mail.gmail.com>
Message-ID: <CAAFQd5BRxmMpH9J0tZLD7=9Be+dUggym9-5ctV4536YbHedESQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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

On Tue, Oct 16, 2018 at 10:50 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 10/16/18 09:36, Tomasz Figa wrote:
> > On Tue, Aug 7, 2018 at 3:54 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >>>> +   * The driver must expose following selection targets on ``OUTPUT``:
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_CROP_BOUNDS``
> >>>> +         maximum crop bounds within the source buffer supported by the
> >>>> +         encoder
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_CROP_DEFAULT``
> >>>> +         suggested cropping rectangle that covers the whole source picture
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_CROP``
> >>>> +         rectangle within the source buffer to be encoded into the
> >>>> +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_CROP_DEFAULT``
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
> >>>> +         maximum rectangle within the coded resolution, which the cropped
> >>>> +         source frame can be output into; always equal to (0, 0)x(width of
> >>>> +         ``V4L2_SEL_TGT_CROP``, height of ``V4L2_SEL_TGT_CROP``), if the
> >>>> +         hardware does not support compose/scaling
>
> Re-reading this I would rewrite this a bit:
>
> if the hardware does not support composition or scaling, then this is always
> equal to (0, 0)x(width of ``V4L2_SEL_TGT_CROP``, height of ``V4L2_SEL_TGT_CROP``).
>

Ack.

> >>>> +
> >>>> +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
> >>>> +         equal to ``V4L2_SEL_TGT_CROP``
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_COMPOSE``
> >>>> +         rectangle within the coded frame, which the cropped source frame
> >>>> +         is to be output into; defaults to
> >>>> +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on hardware without
> >>>> +         additional compose/scaling capabilities; resulting stream will
> >>>> +         have this rectangle encoded as the visible rectangle in its
> >>>> +         metadata
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_COMPOSE_PADDED``
> >>>> +         always equal to coded resolution of the stream, as selected by the
> >>>> +         encoder based on source resolution and crop/compose rectangles
> >>>
> >>> Are there codec drivers that support composition? I can't remember seeing any.
> >>>
> >>
> >> Hmm, I was convinced that MFC could scale and we just lacked support
> >> in the driver, but I checked the documentation and it doesn't seem to
> >> be able to do so. I guess we could drop the COMPOSE rectangles for
> >> now, until we find any hardware that can do scaling or composing on
> >> the fly.
> >>
> >
> > On the other hand, having them defined already wouldn't complicate
> > existing drivers too much either, because they would just handle all
> > of them in the same switch case, i.e.
> >
> > case V4L2_SEL_TGT_COMPOSE_BOUNDS:
> > case V4L2_SEL_TGT_COMPOSE_DEFAULT:
> > case V4L2_SEL_TGT_COMPOSE:
> > case V4L2_SEL_TGT_COMPOSE_PADDED:
> >      return visible_rectangle;
> >
> > That would need one change, though. We would define
> > V4L2_SEL_TGT_COMPOSE_DEFAULT to be equal to (0, 0)x(width of
> > V4L2_SEL_TGT_CROP - 1, height of ``V4L2_SEL_TGT_CROP - 1), which
>
> " - 1"? Where does that come from?
>
> Usually rectangles are specified as widthxheight@left,top.
>

Yeah, the notation I used was quite unfortunate. How about just making
it fully verbose?

         if the hardware does not support
         composition or scaling, then this is always equal to the rectangle of
         width and height matching ``V4L2_SEL_TGT_CROP`` and located at (0, 0)

> > makes more sense than current definition, since it would bypass any
> > compose/scaling by default.
>
> I have no problem with drivers optionally implementing these rectangles,
> even if they don't do scaling or composition. The question is, should it
> be required for decoders? If there is a good reason, then I'm OK with it.

There is no particular reason to do it for existing drivers. I'm
personally not a big fan of making things optional, since you never
know when something becomes required and then you run into problems
with user space compatibility. In this case the cost of having those
rectangles defined is really low and they will be useful to handle
encoders and decoders with scaling/compose ability in the future.

I have no strong opinion though.

Best regards,
Tomasz
