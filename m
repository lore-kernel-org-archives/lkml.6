Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C7EC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A97221775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mm+M0ZK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A97221775
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403834AbeHGR0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:26:02 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33380 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403820AbeHGR0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:26:01 -0400
Received: by mail-yb0-f193.google.com with SMTP id e84-v6so6745042ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CZB2Q55NQ+twxxdK3j1vTtBto0qVdx/PG36igdNilD8=;
        b=Mm+M0ZK3F05pZKCa+VmpRMP0naHeIWnmJknka6y/TGDzpfbr+EsL5jDqLLUEpYQQhS
         xyNtQ4TlTDkc+XPqh1L40TWftEzsIqdV0Nm9qnyV1QCXy/3o55QBlbDExkzZVK5BSo0P
         p5864q3c1ugs7XAGrOGksW9DRbDQ+il1AdIIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CZB2Q55NQ+twxxdK3j1vTtBto0qVdx/PG36igdNilD8=;
        b=aLi+onpE+DHFmCA8yf1oYeqgjF1s74fenNAYCHQcW3ZaSuTKO10BPLvZCjOzG134m8
         5smQJ9SNv17cFj/JRva9R0x+f7itNA9u/kv8O/SmxuKWr+/P08cIfNMOX2Okt5DrU21T
         UdlejLkhc7e4WbvrEmBrSqVaBPX9Wg3XlQ3DkjLPgAFSpOvNyH8hGyIjWCTcb7btUsc1
         hxiqMsc906aGQKS3nC+wUg06rY8wmCzp7Q8Gsssf0+O/wU0aklYY5FxAaL1/TSngQGRF
         faiubrgqE5XFB2orEQh2vPRYO6gwa6c3s7BzKVhBIWTVHN4XadLH4lgjKJSMlUqofG+u
         xYZg==
X-Gm-Message-State: AOUpUlF1CtnkzL5Fp6ab3Pj9SuwvKUGXCVAsA9RfKayouSEWGf5kEGSf
        bGSq0qrM9ylfQyZ9HuADpqhU1yX6xm8=
X-Google-Smtp-Source: AAOMgpdv4+0gGoFLan6j+vL8Rfz57tORwlkwQHEKeqxHala9MRsfoXjn8wenrtsFIzDy1oWt0DrG6A==
X-Received: by 2002:a25:9d0d:: with SMTP id i13-v6mr10010209ybp.104.1533654674166;
        Tue, 07 Aug 2018 08:11:14 -0700 (PDT)
Received: from mail-yb0-f170.google.com (mail-yb0-f170.google.com. [209.85.213.170])
        by smtp.gmail.com with ESMTPSA id 135-v6sm660091ywm.74.2018.08.07.08.11.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 08:11:12 -0700 (PDT)
Received: by mail-yb0-f170.google.com with SMTP id r3-v6so6738210ybo.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:11:12 -0700 (PDT)
X-Received: by 2002:a25:4b01:: with SMTP id y1-v6mr9674655yba.344.1533654671715;
 Tue, 07 Aug 2018 08:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <2251357.uoA9bQP17p@jernej-laptop> <5b8f8406620166903db35832489e0f2d314b4191.camel@bootlin.com>
 <2378753.ggmX2zm38T@jernej-laptop>
In-Reply-To: <2378753.ggmX2zm38T@jernej-laptop>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 8 Aug 2018 00:10:59 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AtRz3aP2DpFk46_5MuDcFxx594MBMeu73UaZvBuZOp+A@mail.gmail.com>
Message-ID: <CAAFQd5AtRz3aP2DpFk46_5MuDcFxx594MBMeu73UaZvBuZOp+A@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v6 4/8] media: platform: Add Cedrus VPU
 decoder driver
To:     jernej.skrabec@gmail.com
Cc:     linux-sunxi@googlegroups.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
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
        thomas.petazzoni@bootlin.com,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        ayaka <ayaka@soulik.info>, Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 12:05 AM Jernej =C5=A0krabec <jernej.skrabec@gmail.c=
om> wrote:
>
> Dne torek, 07. avgust 2018 ob 14:31:03 CEST je Paul Kocialkowski napisal(=
a):
> > Hi,
> >
> > On Fri, 2018-07-27 at 16:58 +0200, Jernej =C5=A0krabec wrote:
> > > Dne petek, 27. julij 2018 ob 16:03:41 CEST je Jernej =C5=A0krabec nap=
isal(a):
> > > > Hi!
> > > >
> > > > Dne sreda, 25. julij 2018 ob 12:02:52 CEST je Paul Kocialkowski
> napisal(a):
> > > > > This introduces the Cedrus VPU driver that supports the VPU found=
 in
> > > > > Allwinner SoCs, also known as Video Engine. It is implemented thr=
ough
> > > > > a v4l2 m2m decoder device and a media device (used for media
> > > > > requests).
> > > > > So far, it only supports MPEG2 decoding.
> > > > >
> > > > > Since this VPU is stateless, synchronization with media requests =
is
> > > > > required in order to ensure consistency between frame headers tha=
t
> > > > > contain metadata about the frame to process and the raw slice dat=
a
> > > > > that
> > > > > is used to generate the frame.
> > > > >
> > > > > This driver was made possible thanks to the long-standing effort
> > > > > carried out by the linux-sunxi community in the interest of rever=
se
> > > > > engineering, documenting and implementing support for Allwinner V=
PU.
> > > > >
> > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > ---
> > > >
> > > > <snip>
> > > >
> > > > > +void cedrus_dst_format_set(struct cedrus_dev *dev,
> > > > > +                          struct v4l2_pix_format_mplane *fmt)
> > > > > +{
> > > > > +       unsigned int width =3D fmt->width;
> > > > > +       unsigned int height =3D fmt->height;
> > > > > +       u32 chroma_size;
> > > > > +       u32 reg;
> > > > > +
> > > > > +       switch (fmt->pixelformat) {
> > > > > +       case V4L2_PIX_FMT_NV12:
> > > > > +               chroma_size =3D ALIGN(width, 32) * ALIGN(height /=
 2, 32);
> > > >
> > > > After some testing, it turns out that right aligment for untiled fo=
rmat
> > > > is
> > > > 16.
> > > >
> > > > > +
> > > > > +               reg =3D VE_PRIMARY_OUT_FMT_NV12 |
> > > > > +                     VE_SECONDARY_SPECIAL_OUT_FMT_NV12;
> > > > > +               cedrus_write(dev, VE_PRIMARY_OUT_FMT, reg);
> > > > > +
> > > > > +               reg =3D VE_CHROMA_BUF_LEN_SDRT(chroma_size / 2) |
> > > > > +                     VE_SECONDARY_OUT_FMT_SPECIAL;
> > > > > +               cedrus_write(dev, VE_CHROMA_BUF_LEN, reg);
> > > > > +
> > > > > +               reg =3D chroma_size / 2;
> > > > > +               cedrus_write(dev, VE_PRIMARY_CHROMA_BUF_LEN, reg)=
;
> > > > > +
> > > > > +               reg =3D VE_PRIMARY_FB_LINE_STRIDE_LUMA(ALIGN(widt=
h, 32)) |
> > > >
> > > > ^ that one should be aligned to 16
> > > >
> > > > > +                     VE_PRIMARY_FB_LINE_STRIDE_CHROMA(ALIGN(widt=
h / 2, 16));
> > >
> > > It seems that CHROMA has to be aligned to 8 ^
> >
> > I think the issue here is that the divider should be applied after the
> > alignment, not before, such as: ALIGN(width, 16) / 2, which also
> > provides a 8-aligned value.
> >
> > Feel free to let me know if that causes any particular issue!
>
> I think this is only semantics, it doesn't really matter if it is aligned=
 to
> 16 first and then divided by 2 or divided by 2 and then aligned to 8.

It depends if |width| is always expected to be aligned to 2. For
example, given |width| =3D 17,

ALIGN(17, 16) =3D 32, 32 / 2 =3D 16
17 / 2 =3D 8, ALIGN(8, 8) =3D 8

Best regards,
Tomasz
