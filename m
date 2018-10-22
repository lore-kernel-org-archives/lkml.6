Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D2FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45D420779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FGj78Un5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45D420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJVOWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:22:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36140 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJVOWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:22:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id x4so37426779otg.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wd6jE26doBFelt4H3GIBwwfL6g98WVcmEsmDCFDGPOo=;
        b=FGj78Un58ealkp/T5Q3Ivrr6N+QMMHe62/7W/az6qC2/OHX+wKERRX/cok9aId8WHo
         f0DGoQOaG+kh7tGBH717m4YuKpdBm4okcWFpn2/v0Wl8dpQWgBeMlogNhiizVroPo7LD
         fiDXODZzshXdlq59m3Enql4ONXuXQcp9Q6EQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wd6jE26doBFelt4H3GIBwwfL6g98WVcmEsmDCFDGPOo=;
        b=kMx7yDnTNRqK6QdwvUExmx2/sNSQNh3EVwpMht+S+cBALW6q4IomdiTH6v8lHvyKTm
         PIcVoCOkQJ3BcDULQ06Jf7fqe9p2ghKdwtP1WMPzrpEC5pGzqMDb+zArxnpkoC6Yw8Je
         arT/QpqE6qZvAG3vWkRggk2KHZSnRGJm2r7YyU6p6dDy508CbRqzOH5tSGc0nbYSnc8D
         EktbPN2n8DJz2+W8sdDMOiggMdEb0xgAuIMGK+eriWQ3kiG2wsfHlx8A6WBWvnuN5xU7
         1o3MgOihaG9oWd0WPlSVvHIQkmBP96z1q3mjiIdK0GqwnhbyYaRL5hAI1Po1AIL4BBYA
         6Hfg==
X-Gm-Message-State: ABuFfohsygtnrBcpLMbXtUapmZGuCKXwwUfkloWGmaCEuyqft0xMk1tC
        DwAiNdFKSL+9cLeDjBi+QfPqS5SqZqv8BTfr
X-Google-Smtp-Source: ACcGV605i067lE2q5KYtCMzvO0pCkmROyiH9+N18SrMbyEaWLXlvvHLUJEISVlkG9SRKxdtJmZLEiw==
X-Received: by 2002:a9d:d52:: with SMTP id 76mr29740646oti.326.1540188310261;
        Sun, 21 Oct 2018 23:05:10 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id n129-v6sm9232613oif.23.2018.10.21.23.05.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 23:05:09 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id k9so38833350otl.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 23:05:09 -0700 (PDT)
X-Received: by 2002:a9d:56ef:: with SMTP id b44mr29686307otj.214.1540188308945;
 Sun, 21 Oct 2018 23:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181019080928.208446-1-acourbot@chromium.org> <9375d854-2be5-4f69-2516-a3349fa5b50d@xs4all.nl>
In-Reply-To: <9375d854-2be5-4f69-2516-a3349fa5b50d@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 22 Oct 2018 15:04:57 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVt4WEEd+83UTPJcqUHZ6ss=TDU5C_kbTQhGqT0fWcYPQ@mail.gmail.com>
Message-ID: <CAPBb6MVt4WEEd+83UTPJcqUHZ6ss=TDU5C_kbTQhGqT0fWcYPQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3] media: docs-rst: Document m2m stateless video
 decoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Tomasz Figa <tfiga@chromium.org>,
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

On Fri, Oct 19, 2018 at 5:44 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 10/19/18 10:09, Alexandre Courbot wrote:
> > Thanks everyone for the feedback on v2! I have not replied to all the
> > individual emails but hope this v3 will address some of the problems
> > raised and become a continuation point for the topics still in
> > discussion (probably during the ELCE Media Summit).
> >
> > This patch documents the protocol that user-space should follow when
> > communicating with stateless video decoders. It is based on the
> > following references:
> >
> > * The current protocol used by Chromium (converted from config store to
> >   request API)
> >
> > * The submitted Cedrus VPU driver
> >
> > As such, some things may not be entirely consistent with the current
> > state of drivers, so it would be great if all stakeholders could point
> > out these inconsistencies. :)
> >
> > This patch is supposed to be applied on top of the Request API V18 as
> > well as the memory-to-memory video decoder interface series by Tomasz
> > Figa.
> >
> > Changes since v2:
> >
> > * Specify that the frame header controls should be set prior to
> >   enumerating the CAPTURE queue, instead of the profile which as Paul
> >   and Tomasz pointed out is not enough to know which raw formats will be
> >   usable.
> > * Change V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAM to
> >   V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS.
> > * Various rewording and rephrasing
> >
> > Two points being currently discussed have not been changed in this
> > revision due to lack of better idea. Of course this is open to change:
> >
> > * The restriction of having to send full frames for each input buffer is
> >   kept as-is. As Hans pointed, we currently have a hard limit of 32
> >   buffers per queue, and it may be non-trivial to lift. Also some codecs
> >   (at least Venus AFAIK) do have this restriction in hardware, so unless
> >   we want to do some buffer-rearranging in-kernel, it is probably better
> >   to keep the default behavior as-is. Finally, relaxing the rule should
> >   be easy enough if we add one extra control to query whether the
> >   hardware can work with slice units, as opposed to frame units.
>
> Makes sense, as long as the restriction can be lifted in the future.

Lifting this limitation once we support more than 32 buffers should
not be an issue. Just add a new capability control and process things
in slice units. Right now we have hardware that can only work with
whole frames (venus) but I suspect that some slice-only hardware must
exist, so it may actually become a necessity at some point (lest
drivers do some splitting themselves).

>
> > * The other hot topic is the use of capture buffer indexes in order to
> >   reference frames. I understand the concerns, but I doesn't seem like
> >   we have come with a better proposal so far - and since capture buffers
> >   are essentially well, frames, using their buffer index to directly
> >   reference them doesn't sound too inappropriate to me. There is also
> >   the restriction that drivers must return capture buffers in queue
> >   order. Do we have any concrete example where this scenario would not
> >   work?
>
> I'll start a separate discussion thread for this to avoid polluting the
> review of this documentation.

Thanks! Following up there.
