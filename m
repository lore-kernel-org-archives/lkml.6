Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEA42082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YkWRcE9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEA42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeK3Gls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:41:48 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38771 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK3Gls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:41:48 -0500
Received: by mail-yb1-f195.google.com with SMTP id u103-v6so1236351ybi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ai97ARWKU+PjADMSFtwAVEbP+Zg5UtYx2CeNAnQNAxE=;
        b=YkWRcE9drrWg1z5OE+zVOLxuf4zboSDAl1dPQFnq7AkWW5jSeUZgUKf9Roapj89hcJ
         +7Pa1gNuoPSljROExGdKzhT4kjTUwJfS33RaZwMIG41ufeXw0MqdHDsF7P6qSFG8/xfN
         rex6WxnOsUI0gFc/1JI6xIVBE/p37cj72iqhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ai97ARWKU+PjADMSFtwAVEbP+Zg5UtYx2CeNAnQNAxE=;
        b=HALFxEPpi4CM4fOXjwARFlhVcFS/mMGoJlL5jwuZbCOYFcOp2iLgZeHSWukF2cwJvc
         ABQCGZ3VaFbKqijLD+zKruCwL8kx6PovyH10A7jPTZDcVkfqmFfjjTFJSMQvRw/xudcS
         NRwLCHI5ENKZEvq7vJiYaZYt4kqQyyV+xKrUgi30ObAdFOlSnNHiHXPvWp8sC7nCOo5W
         LqMPepvUVkccp1wbU4mV5B20EnhtO4gqXaaAdRhtqEkWOenAykbqjl5NJM/W0nL94tar
         zAB8h61xyOnX8G0Kf5J4jsA0pqa4E1/rSt6JB9OsL9cV3APj4I6jBnl8MyA7/1PiirmT
         VUbA==
X-Gm-Message-State: AA+aEWZzIXPA0uOLu0M/2HlouguVauEkLNkcKOXwHV3i7MzVhdYO7Yqk
        t6OYeUvSdIT/Hk1D34KfNfGhGb8Rlwc=
X-Google-Smtp-Source: AFSGD/VF4wohh982+PJ89pGuD1DsYtd6nTqMjWfQ9U5ArdK3TsvpzJxN9DS/e81tt5hpGzgTS96Kxg==
X-Received: by 2002:a25:b31d:: with SMTP id l29-v6mr2644015ybj.270.1543520116915;
        Thu, 29 Nov 2018 11:35:16 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id c140sm1535924ywa.74.2018.11.29.11.35.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:35:15 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id d18-v6so1236664yba.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:35:15 -0800 (PST)
X-Received: by 2002:a25:b3c6:: with SMTP id x6-v6mr2603311ybf.508.1543520115083;
 Thu, 29 Nov 2018 11:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20181004133739.19086-1-mjourdan@baylibre.com> <491c3f33-b51b-89cb-09f0-b48949d61efb@xs4all.nl>
In-Reply-To: <491c3f33-b51b-89cb-09f0-b48949d61efb@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 29 Nov 2018 11:35:03 -0800
X-Gmail-Original-Message-ID: <CAAFQd5DqY7zRR9SePWDCL0erB4x0pkBP7x2enuVvdjmyX+ASBw@mail.gmail.com>
Message-ID: <CAAFQd5DqY7zRR9SePWDCL0erB4x0pkBP7x2enuVvdjmyX+ASBw@mail.gmail.com>
Subject: Re: [PATCH] media: videodev2: add V4L2_FMT_FLAG_NO_SOURCE_CHANGE
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mjourdan@baylibre.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 1:01 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 10/04/2018 03:37 PM, Maxime Jourdan wrote:
> > When a v4l2 driver exposes V4L2_EVENT_SOURCE_CHANGE, some (usually
> > OUTPUT) formats may not be able to trigger this event.
> >
> > Add a enum_fmt format flag to tag those specific formats.
>
> I think I missed (or forgot) some discussion about this since I have no
> idea why this flag is needed. What's the use-case?

As far as I remember, the hardware/firmware Maxime has been working
with can't handle resolution changes for some coded formats. Perhaps
we should explain that better in the commit message and documentation
of the flag, though. Maxime, could you refresh my memory with the
details?

Best regards,
Tomasz

>
> Regards,
>
>         Hans
>
> >
> > Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> > ---
> >  Documentation/media/uapi/v4l/vidioc-enum-fmt.rst | 5 +++++
> >  include/uapi/linux/videodev2.h                   | 5 +++--
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> > index 019c513df217..e0040b36ac43 100644
> > --- a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> > +++ b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> > @@ -116,6 +116,11 @@ one until ``EINVAL`` is returned.
> >        - This format is not native to the device but emulated through
> >       software (usually libv4l2), where possible try to use a native
> >       format instead for better performance.
> > +    * - ``V4L2_FMT_FLAG_NO_SOURCE_CHANGE``
> > +      - 0x0004
> > +      - The event ``V4L2_EVENT_SOURCE_CHANGE`` is not supported
> > +     for this format.
> > +
> >
> >
> >  Return Value
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 3a65951ca51e..a28acee1cb52 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -723,8 +723,9 @@ struct v4l2_fmtdesc {
> >       __u32               reserved[4];
> >  };
> >
> > -#define V4L2_FMT_FLAG_COMPRESSED 0x0001
> > -#define V4L2_FMT_FLAG_EMULATED   0x0002
> > +#define V4L2_FMT_FLAG_COMPRESSED     0x0001
> > +#define V4L2_FMT_FLAG_EMULATED               0x0002
> > +#define V4L2_FMT_FLAG_NO_SOURCE_CHANGE       0x0004
> >
> >       /* Frame Size and frame rate enumeration */
> >  /*
> >
>
