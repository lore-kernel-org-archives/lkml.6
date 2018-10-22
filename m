Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12EBC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586F220644
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CapiZL2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586F220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJVOjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:39:46 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34219 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeJVOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:39:46 -0400
Received: by mail-yb1-f195.google.com with SMTP id n140-v6so837051yba.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OstAVuDEpivPIV9hXGb9UqRs+TZke7Mfv4BadOxYPt8=;
        b=CapiZL2XAl9qIDcmMXBVZiXDy3smIHECHkTkrYiFUtYCTbn1rFM3ykTSvLxnGezNMl
         /Y37RdLZL0gLjeMfXvZEZmIBs4eqYRsP48NRws5YFzQFKCpd8sH6GuoqarQ5OV0NPw7x
         egjfxqD0ViSG1uvw9WXH5k05N5mQeBC9OySkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OstAVuDEpivPIV9hXGb9UqRs+TZke7Mfv4BadOxYPt8=;
        b=aUup9Y7J89l8DLNuX0wMf63UA+QIBOA0ww1rEHjrdn8Sbn8WzyH7RI4B4g0bw/lPZr
         QelNMZ6/3S6RRgfX6RSJmMOBE1YsSwRl/BNmCM+d6ityYCocxmfHXAyoX928ncGUBqdZ
         FGmEEI0u2/WQ5whq1GVRyw1AiHgE6Y5Y2D8qrIBWKHbNN1APZPMKIwFZIc71tfF3iXuY
         mh7Rj3JNWb7jjUNyPTeyBpyRh9GW/dGsuXlbxunp2Qm6PKGtiLLrkAEGGihPgD1GP5OF
         ybZONwYJP2spxkNtAruKmDekHz/GI7KPki7cerGuEu8zrLGOXe8PT7BWE7wEj+ZpOjhG
         fKzg==
X-Gm-Message-State: ABuFfog9WZgzk3+z1lmOctsh8L/BrsLw/71pKw1+J0fUyQcXVuvoFBXb
        Setg/0TAL+sCWzx+BzYXF+qpL+p/NkE=
X-Google-Smtp-Source: ACcGV60J8nP07gfsEEkrCoHNCuW2biq6KocNvY4yCtWsuVQQjh6Uapr8ayYJ/f/xiVqRPNNVSAplhQ==
X-Received: by 2002:a25:be85:: with SMTP id i5-v6mr32409735ybk.138.1540189357808;
        Sun, 21 Oct 2018 23:22:37 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id k2-v6sm8671977ywh.52.2018.10.21.23.22.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 23:22:36 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id x5-v6so15685932ybl.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:22:36 -0700 (PDT)
X-Received: by 2002:a25:103:: with SMTP id 3-v6mr18577930ybb.114.1540189356338;
 Sun, 21 Oct 2018 23:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181019080928.208446-1-acourbot@chromium.org>
 <9375d854-2be5-4f69-2516-a3349fa5b50d@xs4all.nl> <CAPBb6MVt4WEEd+83UTPJcqUHZ6ss=TDU5C_kbTQhGqT0fWcYPQ@mail.gmail.com>
In-Reply-To: <CAPBb6MVt4WEEd+83UTPJcqUHZ6ss=TDU5C_kbTQhGqT0fWcYPQ@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 22 Oct 2018 15:22:25 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B2i+kpP7rpvCGuAGRV13Crxk61Xk23XBoR_CEZte3ARg@mail.gmail.com>
Message-ID: <CAAFQd5B2i+kpP7rpvCGuAGRV13Crxk61Xk23XBoR_CEZte3ARg@mail.gmail.com>
Subject: Re: [RFC PATCH v3] media: docs-rst: Document m2m stateless video
 decoder interface
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 3:05 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> On Fri, Oct 19, 2018 at 5:44 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > On 10/19/18 10:09, Alexandre Courbot wrote:
> > > Thanks everyone for the feedback on v2! I have not replied to all the
> > > individual emails but hope this v3 will address some of the problems
> > > raised and become a continuation point for the topics still in
> > > discussion (probably during the ELCE Media Summit).
> > >
> > > This patch documents the protocol that user-space should follow when
> > > communicating with stateless video decoders. It is based on the
> > > following references:
> > >
> > > * The current protocol used by Chromium (converted from config store to
> > >   request API)
> > >
> > > * The submitted Cedrus VPU driver
> > >
> > > As such, some things may not be entirely consistent with the current
> > > state of drivers, so it would be great if all stakeholders could point
> > > out these inconsistencies. :)
> > >
> > > This patch is supposed to be applied on top of the Request API V18 as
> > > well as the memory-to-memory video decoder interface series by Tomasz
> > > Figa.
> > >
> > > Changes since v2:
> > >
> > > * Specify that the frame header controls should be set prior to
> > >   enumerating the CAPTURE queue, instead of the profile which as Paul
> > >   and Tomasz pointed out is not enough to know which raw formats will be
> > >   usable.
> > > * Change V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM to
> > >   V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS.
> > > * Various rewording and rephrasing
> > >
> > > Two points being currently discussed have not been changed in this
> > > revision due to lack of better idea. Of course this is open to change:
> > >
> > > * The restriction of having to send full frames for each input buffer is
> > >   kept as-is. As Hans pointed, we currently have a hard limit of 32
> > >   buffers per queue, and it may be non-trivial to lift. Also some codecs
> > >   (at least Venus AFAIK) do have this restriction in hardware, so unless
> > >   we want to do some buffer-rearranging in-kernel, it is probably better
> > >   to keep the default behavior as-is. Finally, relaxing the rule should
> > >   be easy enough if we add one extra control to query whether the
> > >   hardware can work with slice units, as opposed to frame units.
> >
> > Makes sense, as long as the restriction can be lifted in the future.
>
> Lifting this limitation once we support more than 32 buffers should
> not be an issue. Just add a new capability control and process things
> in slice units. Right now we have hardware that can only work with
> whole frames (venus)

Note that venus is a stateful hardware and the restriction might just
come from the firmware.

> but I suspect that some slice-only hardware must
> exist, so it may actually become a necessity at some point (lest
> drivers do some splitting themselves).
>

The drivers could do it trivially, because the UAPI will include the
array of slices, with offsets and sizes. It would just run the same
OUTPUT buffer multiple time, once for each slice.

The primary use case I personally see for splitting slices into
multiple buffers would be lowering the latency, as Hans mentioned
earlier and we should be able to do it easily later.

Best regards,
Tomasz
