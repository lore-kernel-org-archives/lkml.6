Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375E4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C4F20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C4F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeLCQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:42:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44805 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeLCQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:42:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so14458850qte.11;
        Mon, 03 Dec 2018 08:41:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHGO8hd8XcJOmBaPhU6GLIJfHmo66om3Ci7ukHhGM+E=;
        b=g4B/bWvQFTGdxwGEtriBd+TPCuH/KGo3s3pIBCeLbRCLU/w0OvKG5Dg5N4cbAXZs/0
         +TS7j3+B0RpPFm41tyhO+91eA0G5H/ukw/sZ+BZkbNGif6CM4MRM9oJ5GQpuiarsGJfu
         M6+wQtlDssQJsxXnNTW/55goOVu4TSMPlKgyfZL8nqCLJ5zN5DcsmPd+e/fFjLefcWzB
         kIK30VnrzQwuC8AyqZ2CCWLMUYHyRq/CaiKwNXOW6aaRY16yrfKF7wp7Qu+jAW/g09dB
         oWMHxCd8PAXz31wFIfiKil5GM5oY8I7Ff8/6faSUS38QbIy3i+CC723KxdzEy/ygb8Tf
         mm0Q==
X-Gm-Message-State: AA+aEWaIRnTgJWgq8OTKWmlwkwe4rgBANjs4QUdPEuXOS43ATROM8j3v
        U04HZse+aDJ2KHzDGs3VcUCdFMRAFFUKI8lqNpGc0S98
X-Google-Smtp-Source: AFSGD/UjyCS4Dl3o/qxrzkyN2234fvjxXp1wont92YE1Aiy0+TaKA1D1SWQcUXbsg25s2WcIEnqKu8tkx6CvsDz8oDU=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr15984333qvl.180.1543855317239;
 Mon, 03 Dec 2018 08:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20181202134538.GA18886@gfm-note> <CAK8P3a2of9sZ5BGCKshCjFkpt8q6s-KD-9XC4SGYP2Ppj7fjEw@mail.gmail.com>
 <c3d75256-bfdc-6f36-1e6e-ad4e5cd9b855@xs4all.nl>
In-Reply-To: <c3d75256-bfdc-6f36-1e6e-ad4e5cd9b855@xs4all.nl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Dec 2018 17:41:40 +0100
Message-ID: <CAK8P3a3uLxxTkTxvSZ8wqwRD5EKVWdimDuH8X6cHoWXdAGDJ+w@mail.gmail.com>
Subject: Re: [PATCH v4] media: vivid: Improve timestamping
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     gfmandaji@gmail.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 10:15 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 12/02/2018 09:43 PM, Arnd Bergmann wrote:
> > On Sun, Dec 2, 2018 at 2:47 PM Gabriel Francisco Mandaji
> > <gfmandaji@gmail.com> wrote:
> >
> >> @@ -667,10 +653,28 @@ static void vivid_overlay(struct vivid_dev *dev, struct vivid_buffer *buf)
> >>         }
> >>  }
> >>
> >> +static void vivid_cap_update_frame_period(struct vivid_dev *dev)
> >> +{
> >> +       u64 f_period;
> >> +
> >> +       f_period = (u64)dev->timeperframe_vid_cap.numerator * 1000000000;
> >> +       do_div(f_period, dev->timeperframe_vid_cap.denominator);
> >> +       if (dev->field_cap == V4L2_FIELD_ALTERNATE)
> >> +               do_div(f_period, 2);
> >> +       /*
> >> +        * If "End of Frame", then offset the exposure time by 0.9
> >> +        * of the frame period.
> >> +        */
> >> +       dev->cap_frame_eof_offset = f_period * 9;
> >> +       do_div(dev->cap_frame_eof_offset, 10);
> >> +       dev->cap_frame_period = f_period;
> >> +}
> >
> > Doing two or three do_div() operations is going to make this rather
> > expensive on 32-bit architectures, and it looks like this happens for
> > each frame?
> >
> > Since each one is a multiplication followed by a division, could this
> > be changed to using a different factor followed by a bit shift?
>
> The division by 2 can obviously be replaced by a shift, and the
> 'End of Frame' calculation can be simplified as well by multiplying by
> 7 and dividing by 8 (again a simple shift): this equals 0.875 which is
> close enough to 0.9 (so update the comment as well).

The first division

      f_period = (u64)dev->timeperframe_vid_cap.numerator * 1000000000;
      do_div(f_period, dev->timeperframe_vid_cap.denominator);

looks like it could be replaced with a fixed multiplication with a
precomputed 'u64 factor = div_u64(numerator * 100000000, denominator)

> It's all a bit overkill since this function isn't called very often,
> but these are easy changes to make.

Ah, I assumed it was called once per frame or more. If this is only done
during initalization, it doesn't matter.

        Arnd
