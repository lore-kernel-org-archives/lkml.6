Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1B7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37582064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VinfOFxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37582064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeLJRcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:32:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42595 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeLJRcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:32:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so10378159lja.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/JBBDo5sPjXAxcwlSBWcL/J/58a10jVgtkZ0FWng78=;
        b=VinfOFxhF1tMpPR5v/jGPjR8NsOhAeK+tLGXwnOX3cLm9YQd0jOIyEzrkbwRAVhhj2
         yGe67viBeDwIJEX7MQyX5T8B93Lp2eJyVHV4Zlm/j7ep2xHDMWg962BW3f1+SvBw6Db5
         JH6Y4M95FnnrzhMqOigrSZy07l5z35GOhVRCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/JBBDo5sPjXAxcwlSBWcL/J/58a10jVgtkZ0FWng78=;
        b=JtFN3jiJ7ZCo+09iiDqnytnnBs7ET8pNDM7qxGQo+1hu6tIWQV/M53YZ8dpnerVnoG
         V0SK7zYmhnFqrC13MCiFYCzWQZIC5P7Y6CxtzRPImdW/wbFo6MoiWUBgdk/XAW95QqyG
         4L9W+BduROLlQUjaK/C5KoJJI9p7JfFr/jD2oAGGjITc4uAlIjFn7GQSqWiv/g/5LaYj
         888V1x9ftDidQyvEJpbyJOJEbvF/ywVUhfjdXfSYQ9auaCFf70IuHMiGvgbbnzM401Kl
         f3IVGCIf6Yifnd+iUvS5Ik0EHgey0cVZzOUis3T+40q3o58RAuJE6ZGy3Iyf6wjrpALm
         JEZw==
X-Gm-Message-State: AA+aEWaPoTrynTkgw9XYq5LqIqSXOX/XVNZdaSpi2Fw5G0RGd+7ZXwoo
        fn8hYW+9eCKGXqbDz75HvLGLJjiE3I0=
X-Google-Smtp-Source: AFSGD/URholrH7v7w1p/n8njkSGB4nkqMANpebMZP5HFL+CS/rZ+xVI4KnaT/U3nSZu1Hm4z0YFsmw==
X-Received: by 2002:a2e:1551:: with SMTP id 17-v6mr7576947ljv.68.1544463125977;
        Mon, 10 Dec 2018 09:32:05 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e14-v6sm2248785ljl.43.2018.12.10.09.32.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:32:04 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id l10so8612978lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:32:04 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr7697075lfa.135.1544463123575;
 Mon, 10 Dec 2018 09:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <20181030230624.61834-3-evgreen@chromium.org>
 <20181128012624.GB11128@ming.t460p> <CAE=gft7Fyq+Jb3ZG3PSTR=C0Wjt3uu57+H2bshM6Gu=_0W0YQw@mail.gmail.com>
 <20181205011059.GA17845@ming.t460p> <CAE=gft7K2OrN93c8TQ5ozOpXzXf5ZD-PNnVHWP9SbZXZqp2dHw@mail.gmail.com>
 <yq1va47pcqp.fsf@oracle.com>
In-Reply-To: <yq1va47pcqp.fsf@oracle.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 10 Dec 2018 09:31:27 -0800
X-Gmail-Original-Message-ID: <CAE=gft7ymeVu0chvCYWn8tw9ss_pZgyUHt=5sSdxfRenDD46Xw@mail.gmail.com>
Message-ID: <CAE=gft7ymeVu0chvCYWn8tw9ss_pZgyUHt=5sSdxfRenDD46Xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] loop: Better discard support for block devices
To:     martin.petersen@oracle.com
Cc:     ming.lei@redhat.com, axboe@kernel.dk,
        Gwendal Grignou <gwendal@chromium.org>, asavery@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 7:15 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Evan,
>
> > Ah, I see. But I think it's useful to reflect max_discard_sectors,
> > max_write_zeroes_sectors, discard_granularity, and discard_alignment
> > from the block device to the loop device. With the exception of
> > discard_alignment, these parameters are visible via sysfs,
>
> discard_alignment is visible in sysfs, just not in the queue directory
> since alignment can be different on a per-partition basis. So there is
> one discard_alignment at the root of each /sys/block/foo directory and
> one for each partition subdirectory. This mirrors the alignment_offset
> variable which indicates a partitions alignment wrt. the underlying
> physical block size.
>
> That said, there are not many devices that actually report a non-zero
> discard alignment so it's not as useful as the device manufacturers
> (that were looking for an implementation shortcut) envisioned.

Ah ok, thanks.

>
> > I'm not totally sure about discard_alignment, that seems to be useful
> > in cases of merging blk requests. So I can stop mirroring that one if
> > it's harmful or not helpful. But unless it's a nak, I'd really love to
> > keep most of the mirroring. In which case the bool doesn't do a whole
> > lot of simplifying.
>
> I think it's fine to export these. The block device topology was
> explicitly designed to be stackable like this.

Yeah, it seemed to fall in pretty naturally, which is why I was hoping
it might not be so controversial. Thanks Martin.
-Evan
