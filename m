Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C202C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFBD21A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nN+OXmzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFBD21A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeHFQUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:20:14 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40273 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeHFQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:20:14 -0400
Received: by mail-yw1-f66.google.com with SMTP id z143-v6so3632265ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFm3VfvlNpWxpRmwhR2MnOQ1f6VdRj1M60/+1qowZsQ=;
        b=nN+OXmzYwOwU2Mxg64SZhGKr5s/sLiw82BcYdgldtrvuyhcam5S5HfF5GKc4RgVOed
         zCBxcZj2Q58Ao5XAhm5+fXgkglRSGXWrvLY4yceIx68GVOaaMmvldAT16FGE1SL/n/cX
         lKtfnioHRR97odiBBK+A27lYz4IpOhV/tDumA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFm3VfvlNpWxpRmwhR2MnOQ1f6VdRj1M60/+1qowZsQ=;
        b=QpoQCZdsZttNKEJt2F3B1c5Rz2U2qVWjnnsRr8LrDqaAfBV2IYgrq9xS2W6h6o7cL7
         VrahfmIo+wWtxNUdKW3KEu50Xz5PbTqlueWo78rHLxe9pgNbh5Arqor9dk1CKE747DVM
         pAQcLnwc6dek7Ai4MfNbb/YiVSsq8Dopty/FF/b3yJWxIh1XmOHYhtmzd99nffz76FVo
         YPq8iHl/rN+FY12CNP+l784IoEqNy8mFF/KJkJu6wwrDNL/ya7vu2TrqQOYQcCraYxrp
         Lk6ZcTESNNNi0eOozRgMhSYz4jUkCNyA7BEoYVdIKWC2oFmQ9fOgvCPtBkL/IG2O0aiA
         ENiw==
X-Gm-Message-State: AOUpUlHNbKsuzcXJXJa4vwRxHiVocfEv40K6/RD7YeIbuyDrvNKfFOSE
        apaZzV1aqoeYvYOii5yI/8egVVsJXtQ=
X-Google-Smtp-Source: AAOMgpePXjpgtVYfBiwglNKeYuIfgvYUSnJ2Ao7+rGrJFgktsOiIU6RpaPMrqHkfz2OatW6Os3GfdA==
X-Received: by 2002:a0d:f481:: with SMTP id d123-v6mr7899837ywf.27.1533564655809;
        Mon, 06 Aug 2018 07:10:55 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id 134-v6sm7293476ywq.66.2018.08.06.07.10.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 07:10:54 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id z143-v6so3632210ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 07:10:53 -0700 (PDT)
X-Received: by 2002:a0d:e7c1:: with SMTP id q184-v6mr7627190ywe.435.1533564653465;
 Mon, 06 Aug 2018 07:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <20180725100256.22833-5-paul.kocialkowski@bootlin.com> <b45a8a89-1313-7a08-206d-b93017724754@xs4all.nl>
 <dba0f9496b393c76f355398018b14ae06b2b18c9.camel@bootlin.com>
In-Reply-To: <dba0f9496b393c76f355398018b14ae06b2b18c9.camel@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 6 Aug 2018 23:10:40 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DgFDFupACthsz1iLpAeYRtUtEfzQC1E5XZQ6gPZAYi1Q@mail.gmail.com>
Message-ID: <CAAFQd5DgFDFupACthsz1iLpAeYRtUtEfzQC1E5XZQ6gPZAYi1Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] media: platform: Add Cedrus VPU decoder driver
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alexandre Courbot <acourbot@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        thomas.petazzoni@bootlin.com, linux-sunxi@googlegroups.com,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        ayaka <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Aug 6, 2018 at 10:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi Hans and thanks for the review!
>
> On Sat, 2018-08-04 at 14:18 +0200, Hans Verkuil wrote:
> > Hi Paul,
> >
> > See below for my review comments. Mostly small fry, the main issue I found is
> > that there is no support for VIDIOC_DECODER_CMD. That's the proper way of
> > stopping a decoder. Don't rely on the deprecated allow_zero_bytesused field.
>
> Mhh, it looks like this was kept around by negligence, but we do expect
> that streamoff stops the decoder, not a zero bytesused field.
>
> Is it still required to implement the V4L2_DEC_CMD_STOP
> VIDIOC_DECODER_CMD in that case? I read in the doc that this ioctl
> should be optional.

If I understand correctly that this decoder is stateless, there should
be no need for any special flush sequence, since a 1:1 relation
between OUTPUT and CAPTURE buffers is expected, which means that
userspace can just stop queuing new OUTPUT buffers and keep dequeuing
CAPTURE buffers until it matches all OUTPUT buffers queued before.

By the way, I guess we will also need some documentation for the
stateless codec interface. Do you or Maxime (who sent the H264 part)
have any plans to work on it? We have some internal documents, which
should be convertible to rst using pandoc, but we might need some help
with updating to latest request API and further editing. Alexandre
(moved from Cc to To) is going to be looking into this.

Best regards,
Tomasz
