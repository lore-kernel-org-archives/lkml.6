Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FEEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B14214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jzLMR5pZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B14214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeHVREM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:04:12 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43171 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbeHVREL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:04:11 -0400
Received: by mail-yb0-f194.google.com with SMTP id k5-v6so657033ybo.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RvyikpohwyaNkoWBCwsLPqWT+jxDB7O1jRvfi/xyMOs=;
        b=jzLMR5pZLb/EEDDfbR+jS9qniqgGKO65cCROzCv37vk5eqKrwJNUSqplWnmSfzAV9R
         QpWyW1uzZeI0TMzxqN4+/C872HNDZAf2a1DCgEj5pA2ZQ7b7IKEiuflVS01K/wuULwpH
         j54awMJ/tj6RhktbgmXd/UxhUyudgvk+MSVaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RvyikpohwyaNkoWBCwsLPqWT+jxDB7O1jRvfi/xyMOs=;
        b=UAtC7DEOT+u+d7/nLyECK7QdLF8wnYLW2sqHVQXIn+ScSL2nVusOT/+iFRiuonioQb
         6RdSOJN8PBQ//VTFjbBMcxxJRV0c2XtjdnXCrLr5E0L5oKKbhKHNxlclsUlqMOWpke5I
         6lVbB2kyBr+EjzeJrL/Mbiu3FYfjTQZydbLQ+tKhaqsEvocTlHI5akpwJ7fgyIHbnyKQ
         IitEYu8Z1631duE2pI4sWm4rxwREwkiRvvS8FVpNHQ6Sy9B1HrrVPS2Nzm+neSypsjHR
         HBrdi0RqaDdq/n/6ArUv9TKLbxXHnU0AdKYYp2dy5aCJS9eZ8WSLXEgBnkXcC6mOvCG3
         VxsA==
X-Gm-Message-State: AOUpUlFqDuqNv6h1/SVMK91l3RxT9VVe250OucqpkqQ58kQFzPUrwHUC
        5UeutMq94QWmygPjJ/NtBNpb1bggIhghjw==
X-Google-Smtp-Source: AA+uWPybK9arokNsI3u/Gy/NBhmT7VQHRlsxab+y81EwUNcXIdhQfCPhw9io6XfvgA7Jo51HKwE8vw==
X-Received: by 2002:a25:ac51:: with SMTP id r17-v6mr30739169ybd.370.1534945153122;
        Wed, 22 Aug 2018 06:39:13 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id e134-v6sm1834058ywa.59.2018.08.22.06.39.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 06:39:12 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id j131-v6so630108ywc.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:39:11 -0700 (PDT)
X-Received: by 2002:a81:6ec5:: with SMTP id j188-v6mr60418ywc.92.1534945151180;
 Wed, 22 Aug 2018 06:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com> <80e1d9cb49c6df06843e49332685f2b401023292.camel@collabora.com>
 <d8a30e78e6a33db10360995d800f2c0d19acc500.camel@collabora.com> <53987ca7a536a21b2eb49626d777a9bf894d6910.camel@bootlin.com>
In-Reply-To: <53987ca7a536a21b2eb49626d777a9bf894d6910.camel@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 22 Aug 2018 22:38:58 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B68ArBgSj-Oso8=MzSrvVGB=h+MVO12qqgACmBrZtRkw@mail.gmail.com>
Message-ID: <CAAFQd5B68ArBgSj-Oso8=MzSrvVGB=h+MVO12qqgACmBrZtRkw@mail.gmail.com>
Subject: Re: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Pawel Osciak <posciak@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        jenskuske@gmail.com, linux-sunxi@googlegroups.com,
        thomas.petazzoni@bootlin.com, groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 10:07 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Tue, 2018-08-21 at 13:07 -0400, Nicolas Dufresne wrote:
> > Le mardi 21 ao=C3=BBt 2018 =C3=A0 13:58 -0300, Ezequiel Garcia a =C3=A9=
crit :
> > > On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > > > From: Pawel Osciak <posciak@chromium.org>
> > > >
> > > > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > > > Reviewed-by: Wu-cheng Li <wuchengli@chromium.org>
> > > > Tested-by: Tomasz Figa <tfiga@chromium.org>
> > > > [rebase44(groeck): include linux/types.h in v4l2-controls.h]
> > > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > ---
> > > >
> > >
> > > [..]
> > > > diff --git a/include/uapi/linux/videodev2.h
> > > > b/include/uapi/linux/videodev2.h
> > > > index 242a6bfa1440..4b4a1b25a0db 100644
> > > > --- a/include/uapi/linux/videodev2.h
> > > > +++ b/include/uapi/linux/videodev2.h
> > > > @@ -626,6 +626,7 @@ struct v4l2_pix_format {
> > > >  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /*
> > > > H264 with start codes */
> > > >  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /*
> > > > H264 without start codes */
> > > >  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /*
> > > > H264 MVC */
> > > > +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /*
> > > > H264 parsed slices */
> > >
> > > As pointed out by Tomasz, the Rockchip VPU driver expects start codes
> > > [1], so the userspace
> > > should be aware of it. Perhaps we could document this pixel format
> > > better as:
> > >
> > > #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /*
> > > H264 parsed slices with start codes */
> > >
> > > And introduce another pixel format:
> > >
> > > #define V4L2_PIX_FMT_H264_SLICE_NO_SC v4l2_fourcc(TODO) /* H264
> > > parsed slices without start codes */
> > >
> > > For cedrus to use, as it seems it doesn't need start codes.
> >
> > I must admit that this RK requirement is a bit weird for slice data.
> > Though, userspace wise, always adding start-code would be compatible,
> > as the driver can just offset to remove it.
>
> This would mean that the stateless API no longer takes parsed bitstream
> data but effectively the full bitstream, which defeats the purpose of
> the _SLICE pixel formats.
>

Not entirely. One of the purposes of the _SLICE pixel format was to
specify it in a way that adds a requirement of providing the required
controls by the client.

> > Another option, because I'm not fan of adding dedicated formats for
> > this, the RK driver could use data_offset (in mplane v4l2 buffers),
> > just write a start code there. I like this solution because I would not
> > be surprise if some drivers requires in fact an HW specific header,
> > that the driver can generate as needed.
>
> I like this idea, because it implies that the driver should deal with
> the specificities of the hardware, instead of making the blurrying the
> lines of stateless API for covering these cases.

The spec says

"Offset in bytes to video data in the plane. Drivers must set this
field when type refers to a capture stream, applications when it
refers to an output stream."

which would mean that user space would have to know to reserve some
bytes at the beginning for the driver to add the start code there. (Or
the driver memmove()ing the data forward when the buffer is queued,
assuming that there is enough space in the buffer, but it should
normally be the case.)

Sounds like a pixel format with full bitstream data and some offsets
to particular parts inside given inside a control might be the most
flexible and cleanest solution.

Best regards,
Tomasz
