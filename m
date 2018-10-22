Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A402C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E062054F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T7JDZnHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E062054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJVO4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:56:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41002 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbeJVO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:56:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id l197-v6so31278110oib.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPbFgiy58hOBTN1FHO+RAzINTx4a2cCMybvBkbon/ys=;
        b=T7JDZnHrX6+2rGVclpWdh76qsVAymeNMNBoS1ul5IVxjtyW3N1RFyG8S5g2hsBIgDu
         Mi7buMR5FS8Mnc7DVgeLUCjA89tKQTfmGygYXBY95HB58vbrL3DEKBT72cuZMj9qBFW1
         BY5BHWBBdvYFrjRc9x/cG/baS87Y4k0FWh3jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPbFgiy58hOBTN1FHO+RAzINTx4a2cCMybvBkbon/ys=;
        b=cnTk9usotRWnGcpNfw63p5Db9HGoziDbDj90Pod8FPNJoA4qc0Ym9h4H6W97J44m+m
         21BwAiUmZvailFl7FLF3wnGWmhEX9XaqXeuVKcf5YEf4fQsUJtArTM4nAMiT79Y6O3dY
         bluVqkUrV8FhZHPpNAEAQFqoYznf8MatpxYRIEkgEI2blmwkBzm3sYdfKNY3ZYHzFPYW
         MJWx75Vi3sAIz8bl3S+YS3Y3dxxKbOI+6FwPnktaDbm84JmqOKwo1Pm29PM+btCvmOti
         kfiRRMaKnv6Rkumhj4U2b0VCBBePuwlFw01fqx+h3nhd3fIjscVmNJaCI8ho5Oc/r5L7
         B5Zw==
X-Gm-Message-State: ABuFfog96Q9TEPpOMbOWcSaM+b8PxJ1E+Yh4EXEHHNp9oKg4VclodUMg
        ZJRFUdBhK26qV9yPGhIIZwxE6SCYp6AFzhe8
X-Google-Smtp-Source: ACcGV62oGmu6MdzFM+DmWKWwRY0Aoj+PQXjQpsRvKaS2NoDwjUGCQ1MG6OWJoG4lULC5Jlqnub4euQ==
X-Received: by 2002:aca:3341:: with SMTP id z62-v6mr9372693oiz.347.1540190376148;
        Sun, 21 Oct 2018 23:39:36 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id 14sm11764374otk.49.2018.10.21.23.39.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 23:39:35 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id j68-v6so31305995oib.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:39:35 -0700 (PDT)
X-Received: by 2002:aca:a89:: with SMTP id k9-v6mr24050736oiy.297.1540190374653;
 Sun, 21 Oct 2018 23:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181019080928.208446-1-acourbot@chromium.org>
 <9375d854-2be5-4f69-2516-a3349fa5b50d@xs4all.nl> <CAPBb6MVt4WEEd+83UTPJcqUHZ6ss=TDU5C_kbTQhGqT0fWcYPQ@mail.gmail.com>
 <CAAFQd5B2i+kpP7rpvCGuAGRV13Crxk61Xk23XBoR_CEZte3ARg@mail.gmail.com>
In-Reply-To: <CAAFQd5B2i+kpP7rpvCGuAGRV13Crxk61Xk23XBoR_CEZte3ARg@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 22 Oct 2018 15:39:23 +0900
X-Gmail-Original-Message-ID: <CAPBb6MV0QEbHFbj0v+ttGWik1TRY32zXTe5kfp6PiU2h-nstjw@mail.gmail.com>
Message-ID: <CAPBb6MV0QEbHFbj0v+ttGWik1TRY32zXTe5kfp6PiU2h-nstjw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] media: docs-rst: Document m2m stateless video
 decoder interface
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 3:22 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Mon, Oct 22, 2018 at 3:05 PM Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> > On Fri, Oct 19, 2018 at 5:44 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > >
> > > On 10/19/18 10:09, Alexandre Courbot wrote:
> > > > Thanks everyone for the feedback on v2! I have not replied to all the
> > > > individual emails but hope this v3 will address some of the problems
> > > > raised and become a continuation point for the topics still in
> > > > discussion (probably during the ELCE Media Summit).
> > > >
> > > > This patch documents the protocol that user-space should follow when
> > > > communicating with stateless video decoders. It is based on the
> > > > following references:
> > > >
> > > > * The current protocol used by Chromium (converted from config store to
> > > >   request API)
> > > >
> > > > * The submitted Cedrus VPU driver
> > > >
> > > > As such, some things may not be entirely consistent with the current
> > > > state of drivers, so it would be great if all stakeholders could point
> > > > out these inconsistencies. :)
> > > >
> > > > This patch is supposed to be applied on top of the Request API V18 as
> > > > well as the memory-to-memory video decoder interface series by Tomasz
> > > > Figa.
> > > >
> > > > Changes since v2:
> > > >
> > > > * Specify that the frame header controls should be set prior to
> > > >   enumerating the CAPTURE queue, instead of the profile which as Paul
> > > >   and Tomasz pointed out is not enough to know which raw formats will be
> > > >   usable.
> > > > * Change V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM to
> > > >   V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS.
> > > > * Various rewording and rephrasing
> > > >
> > > > Two points being currently discussed have not been changed in this
> > > > revision due to lack of better idea. Of course this is open to change:
> > > >
> > > > * The restriction of having to send full frames for each input buffer is
> > > >   kept as-is. As Hans pointed, we currently have a hard limit of 32
> > > >   buffers per queue, and it may be non-trivial to lift. Also some codecs
> > > >   (at least Venus AFAIK) do have this restriction in hardware, so unless
> > > >   we want to do some buffer-rearranging in-kernel, it is probably better
> > > >   to keep the default behavior as-is. Finally, relaxing the rule should
> > > >   be easy enough if we add one extra control to query whether the
> > > >   hardware can work with slice units, as opposed to frame units.
> > >
> > > Makes sense, as long as the restriction can be lifted in the future.
> >
> > Lifting this limitation once we support more than 32 buffers should
> > not be an issue. Just add a new capability control and process things
> > in slice units. Right now we have hardware that can only work with
> > whole frames (venus)
>
> Note that venus is a stateful hardware and the restriction might just
> come from the firmware.

Right, and it most certainly does indeed. Yet firmwares are not always
easy to get updated by vendors, so we may have to deal with it anyway.

>
> > but I suspect that some slice-only hardware must
> > exist, so it may actually become a necessity at some point (lest
> > drivers do some splitting themselves).
> >
>
> The drivers could do it trivially, because the UAPI will include the
> array of slices, with offsets and sizes. It would just run the same
> OUTPUT buffer multiple time, once for each slice.

Alignment issues notwithstanding. :)
