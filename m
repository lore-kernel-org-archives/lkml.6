Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5D9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B13020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S8lJ+QIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B13020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeIFL7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:59:52 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34962 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIFL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:59:52 -0400
Received: by mail-yb1-f196.google.com with SMTP id o17-v6so3752970yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 00:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nMvTPCEEPO4gDpUADidkTsjZUR9Y8z+zhHwqwM6Xxrs=;
        b=S8lJ+QISVo4tcWLlryQl15GAkSgT0+tcVayzntzxAm2aGmTsle0Qtrv3pcMmJxhhYG
         LxEDW6W3pI8R0Pza453c/d5VQf9quIXcGyJ5jBoJdsDxbhAkFr29TXi9bncwQZKhFa1U
         lSG/mipx/BWwzB0R6c0y3f8LmXI4HBbEuzoaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nMvTPCEEPO4gDpUADidkTsjZUR9Y8z+zhHwqwM6Xxrs=;
        b=KwZaFoPt1Q9lhrvwnX/uyqw9XwFb2LEnbBzHZ9riKYzoA6IO9u+Dy9frpPsQQJz3em
         SgeFcY/UYjU7ioOb4B50A08mCRYpgl4R8FOJHhncWDln5oO9MEdistWk1YkcBU4SK92D
         BT2lVYwMM4ks72ow6OfTz+XeBI2A6hN1YfGlOItXM7TYb/ox44U2qC0LzRV5IXxU7UXp
         nAPV7PT2/tYWTgG8cgDYAlv+6NzzYcZCAu1aRWHTdJkqd4fjPGF9P4lovOr7hTWC3E7+
         E+jR2a8AO8LExKZebhAOwfm6vzHewclbtMo345xXhnTU0E9RQS8XWjDXZ+5e6PtdP3Xw
         qxXQ==
X-Gm-Message-State: APzg51AFUpMGA+xyk+4AtzH4SltoyTiBfdULmhiZpO0cJIABaf5M4Odn
        itRmnt+dApQCkQ8UufY9C7GUUy3KRJc=
X-Google-Smtp-Source: ANB0VdacEyq3hNUL6nDR/cba/7vCQNrd3Hv+VK7xvzOTRa/O3frG/Db++6qbswaRa8eB2AAMVWXsXw==
X-Received: by 2002:a25:4e57:: with SMTP id c84-v6mr632883ybb.199.1536218747381;
        Thu, 06 Sep 2018 00:25:47 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id y128-v6sm1511582ywf.52.2018.09.06.00.25.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 00:25:46 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id l189-v6so3688706ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 00:25:45 -0700 (PDT)
X-Received: by 2002:a81:2804:: with SMTP id o4-v6mr679085ywo.342.1536218745540;
 Thu, 06 Sep 2018 00:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180828073424.30247-1-paul.kocialkowski@bootlin.com>
 <20180828073424.30247-5-paul.kocialkowski@bootlin.com> <5faf5eed-eb2c-f804-93e3-5a42f6204d99@xs4all.nl>
 <b7b3cb2320978d45acb34475d15abd7bf03da367.camel@paulk.fr> <461c6a0d-a346-b9da-b75e-4aab907054df@xs4all.nl>
In-Reply-To: <461c6a0d-a346-b9da-b75e-4aab907054df@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 6 Sep 2018 16:25:34 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cmc7uFhprsoTU6Gq19n3z2eiUfZZ2ZjDW4QWVWMDN6tg@mail.gmail.com>
Message-ID: <CAAFQd5Cmc7uFhprsoTU6Gq19n3z2eiUfZZ2ZjDW4QWVWMDN6tg@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] media: platform: Add Cedrus VPU decoder driver
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     contact@paulk.fr,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        thomas.petazzoni@bootlin.com, ayaka <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 4:01 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 09/05/2018 06:29 PM, Paul Kocialkowski wrote:
> > Hi and thanks for the review!
> >
> > Le lundi 03 septembre 2018 =C3=A0 11:11 +0200, Hans Verkuil a =C3=A9cri=
t :
> >> On 08/28/2018 09:34 AM, Paul Kocialkowski wrote:
> >>> +static int cedrus_request_validate(struct media_request *req)
> >>> +{
> >>> +   struct media_request_object *obj, *obj_safe;
> >>> +   struct v4l2_ctrl_handler *parent_hdl, *hdl;
> >>> +   struct cedrus_ctx *ctx =3D NULL;
> >>> +   struct v4l2_ctrl *ctrl_test;
> >>> +   unsigned int i;
> >>> +
> >>> +   list_for_each_entry_safe(obj, obj_safe, &req->objects, list) {
> >>
> >> You don't need to use the _safe variant during validation.
> >
> > Okay, I'll use the regular one then.
> >
> >>> +           struct vb2_buffer *vb;
> >>> +
> >>> +           if (vb2_request_object_is_buffer(obj)) {
> >>> +                   vb =3D container_of(obj, struct vb2_buffer, req_o=
bj);
> >>> +                   ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> >>> +
> >>> +                   break;
> >>> +           }
> >>> +   }
> >>
> >> Interesting question: what happens if more than one buffer is queued i=
n the
> >> request? This is allowed by the request API and in that case the assoc=
iated
> >> controls in the request apply to all queued buffers.
> >>
> >> Would this make sense at all for this driver? If not, then you need to
> >> check here if there is more than one buffer in the request and documen=
t in
> >> the spec that this is not allowed.
> >
> > Well, our driver was written with the (unformal) assumption that we
> > only deal with a pair of one output and one capture buffer. So I will
> > add a check for this at request validation time and document it in the
> > spec. Should that be part of the MPEG-2 PIXFMT documentation (and
> > duplicated for future formats we add support for)?
>
> Can you make a patch for vb2_request_has_buffers() in videobuf2-core.c
> renaming it to vb2_request_buffer_cnt() and returning the number of buffe=
rs
> in the request?
>
> Then you can call it here to check that you have only one buffer.
>
> And this has to be documented with the PIXFMT.
>
> Multiple buffers are certainly possible in non-codec scenarios (vim2m and
> vivid happily accept that), so this is an exception that should be
> documented and checked in the codec driver.

Hmm, isn't it still 1 buffer per 1 queue and just multiple queues
included in the request?

If we indeed allow multiple buffers for the same queue in a request,
we shouldn't restrict this on a per-driver basis. It's definitely not
a hardware limitation, since the driver could just do the same as if 2
requests with the same controls were given.

Best regards,
Tomasz
