Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E710C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A8521480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZnamOM9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A8521480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeHVNSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:18:53 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44455 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeHVNSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:18:53 -0400
Received: by mail-yb0-f195.google.com with SMTP id l16-v6so442719ybk.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8prYhNMOmxr2ycjF9aVI5QZ2m9k9f+piYIS4OvF9K4=;
        b=ZnamOM9g7KhuNs0dYm4YtvyDEhG+e/nId7mTRVP0Hr9BuYJMdimC7dXLIDeOcHhm21
         psqvKzEN1CazvbxpUNdUYjdKJUAILVSOpDQ7YLVYH9sInDsUcM0sT9JdZK0xuxZ8dQ9w
         vuFH19aHad3h2hcQwK2UDeM1SYbO2xGZG7S8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8prYhNMOmxr2ycjF9aVI5QZ2m9k9f+piYIS4OvF9K4=;
        b=eMQQbybung127fBi6Vyz4H1fhompv4G3Yq/DaUdEFIIQNHdFQ6BngZXbDqQInpfuMf
         IWgkRAZDG5SKoqlcEQAlM0e0ujrqu2vHynhf48+jfNVOC/4tTFDZjnJivttMetOFkAvf
         XgPvHghR428+Hz8jAN8xO8jCLJ1PvHKZzreiE7pWzxDZA74sUTYyCCzaICKUtyBaHBVH
         jQ7sD9k9FQriav/kAOahzd26Zu+vRj4fcXhtXUoM7zCQSatJ9mddGXIzrTddzblI5C67
         XXHL4jeA1EMr8ihnvh6ZzrVmz/W024Lk/fRX8eYdbKeJT1Cew8FGgXl0AjW224AM13Yp
         F/jQ==
X-Gm-Message-State: AOUpUlGrfD/oCtrQ8YNYk9BEkqevrX+DaNsOe9whvVd7rAlAjAaTVg5d
        03890ZvtsiGabGvY5Jzu5C3bWU5lNuKPCA==
X-Google-Smtp-Source: AA+uWPwcVXt7HAq/NLaW/jBtYkBNWUUjn5bFlfwFE9cfWgZ87hWUdG2v6Lt+qvS2bHe5aAOF8OEbNw==
X-Received: by 2002:a25:cb54:: with SMTP id b81-v6mr29205632ybg.90.1534931681586;
        Wed, 22 Aug 2018 02:54:41 -0700 (PDT)
Received: from mail-yb0-f169.google.com (mail-yb0-f169.google.com. [209.85.213.169])
        by smtp.gmail.com with ESMTPSA id d6-v6sm476674ywa.85.2018.08.22.02.54.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:54:38 -0700 (PDT)
Received: by mail-yb0-f169.google.com with SMTP id z12-v6so446516ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:54:38 -0700 (PDT)
X-Received: by 2002:a25:9347:: with SMTP id g7-v6mr7822619ybo.293.1534931677558;
 Wed, 22 Aug 2018 02:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com> <80e1d9cb49c6df06843e49332685f2b401023292.camel@collabora.com>
 <20180822091557.gtnlgoebyv6yttzf@flea>
In-Reply-To: <20180822091557.gtnlgoebyv6yttzf@flea>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 22 Aug 2018 18:54:23 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ANvKF2+GEXQTnRsdYVzJTtBOhv7nFahV=2W-9_QXwY4g@mail.gmail.com>
Message-ID: <CAAFQd5ANvKF2+GEXQTnRsdYVzJTtBOhv7nFahV=2W-9_QXwY4g@mail.gmail.com>
Subject: Re: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        jenskuske@gmail.com, linux-sunxi@googlegroups.com,
        thomas.petazzoni@bootlin.com, groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 6:16 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Tue, Aug 21, 2018 at 01:58:38PM -0300, Ezequiel Garcia wrote:
> > On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > > From: Pawel Osciak <posciak@chromium.org>
> > >
> > > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > > Reviewed-by: Wu-cheng Li <wuchengli@chromium.org>
> > > Tested-by: Tomasz Figa <tfiga@chromium.org>
> > > [rebase44(groeck): include linux/types.h in v4l2-controls.h]
> > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > ---
> > >
> > [..]
> > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > > index 242a6bfa1440..4b4a1b25a0db 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -626,6 +626,7 @@ struct v4l2_pix_format {
> > >  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 with start codes */
> > >  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 without start codes */
> > >  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MVC */
> > > +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
> >
> > As pointed out by Tomasz, the Rockchip VPU driver expects start codes [1], so the userspace
> > should be aware of it. Perhaps we could document this pixel format better as:
> >
> > #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices with start codes */
>
> I'm not sure this is something we want to do at that point. libva
> doesn't give the start code, so this is only going to make the life of
> the sane controllers more difficult. And if you need to have the start
> code and parse it, then you're not so stateless anymore.

I might not remember correctly, but Rockchip decoder does some slice
parsing on its own (despite not doing any higher level parsing).
Probably that's why it needs those start codes.

I wonder if libva is the best reference here. It's been designed
almost entirely by Intel for Intel video hardware. We want something
that could work with a wide range of devices and avoid something like
a need to create a semi-stateless API few months later. In fact,
hardware from another vendor, we're working with, also does parsing of
slice headers internally. Moreover, we have some weird
kind-of-stateful decoders, which cannot fully deal with bitstream on
its own, e.g. cannot parse formats, cannot handle resolution changes,
need H264 bitstream NALUs split into separate buffers, etc.

As I suggested some time ago, having the full bitstream in the buffer,
with offsets of particular units included in respective controls,
would be the most scalable thing. If really needed, we could add flags
telling the driver that particular units are present, so one's
implementation of libva could put only raw slice data in the buffers.
But perhaps it's libva which needs some amendment?

Best regards,
Tomasz
