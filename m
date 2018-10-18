Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FB1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992F21477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hYrvkGYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6992F21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJRMbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:31:04 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42291 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeJRMbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:31:04 -0400
Received: by mail-yw1-f67.google.com with SMTP id a197-v6so11288518ywh.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 21:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZSwTv+XUMKcJR+cvGYCOtARHhGLWiPAZFlDPUtfuPc=;
        b=hYrvkGYbr32sxDFKZKgBGLbDNHk55eVJSshas2d/4fU1fwsP5iAyNURKbNiepBC/0J
         3PPMma7L/oMZAyVcFg8JPynYgvzh99kUGPfjmn5jYxvMTc4COHbMFKq3YXiIOcS8SVIL
         uic/rpHKFESfOIvBj3mCVTO213wYyvtFYdXmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZSwTv+XUMKcJR+cvGYCOtARHhGLWiPAZFlDPUtfuPc=;
        b=bqVZyz7uHv9Ism9Sd9T7LUg35cuCKsRtriDwMHKU4O0+05dPh8UbD8YxE/e4iFR8Uz
         Wn6E6KipIR+q8Ok8tblMDvmyolLz2bSEKon2rKYPiVKSptOYLy4I9BZmOTOAsue4o4bE
         PHGkpz35HM4ZkzeZxK1a6qFTVO76vRncSeWPoqLGuIF4CMrL9FNdYqteeVKmYygICZil
         Q+95UzO6IfHzwP7SlbnaBVXOekM7rLgdsMZIbjxIgzZnLWaQXnu+mES3jlyjvAlfdO86
         q4UF+OT2WHuCR2o3Yf3HJPVSlR3kpreiVtA51dMTVkCUfCh6vpdMx0Ib4VZsSEXjn/N6
         Ppdw==
X-Gm-Message-State: ABuFfojF1ZmWzpCqwDEc3yQNbMzxs2ZRiabQa9oV8TS4j3lQjpVObP5t
        SR3Qp3eCPRAgbMZDm1cTJ4gZXLz5s02u/w==
X-Google-Smtp-Source: ACcGV62PwU/dRRtD6kwRuvbrVH0KsU8AAH+0fyR6t00AXrlgO5WbeiBOO6Dd2nGTk8t13JxXzpK6bQ==
X-Received: by 2002:a81:c545:: with SMTP id o5-v6mr17231868ywj.102.1539837122174;
        Wed, 17 Oct 2018 21:32:02 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id y198-v6sm6119614ywy.64.2018.10.17.21.32.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 21:32:00 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 5-v6so11335202ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 21:32:00 -0700 (PDT)
X-Received: by 2002:a25:24c6:: with SMTP id k189-v6mr6595231ybk.373.1539837119869;
 Wed, 17 Oct 2018 21:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181017075242.21790-1-henryhsu@chromium.org> <13883852.6N9L7C0n48@avalon>
 <CAAFQd5B+4x4aSUywtdukwgUmQNQsQsbK4sjedNphwNFteaTscg@mail.gmail.com> <2355808.GKno8i6Ks9@avalon>
In-Reply-To: <2355808.GKno8i6Ks9@avalon>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 18 Oct 2018 13:31:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AL2CnnWLk+i133RRa36HTa0baFkezRhpTXf9YP0DSF1Q@mail.gmail.com>
Message-ID: <CAAFQd5AL2CnnWLk+i133RRa36HTa0baFkezRhpTXf9YP0DSF1Q@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Add boottime clock support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        gwendal@chromium.org, amstan@chromium.org
Cc:     Heng-Ruey Hsu <henryhsu@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 5:50 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Tomasz,
>
> On Wednesday, 17 October 2018 11:28:52 EEST Tomasz Figa wrote:
> > On Wed, Oct 17, 2018 at 5:02 PM Laurent Pinchart wrote:
> > > On Wednesday, 17 October 2018 10:52:42 EEST Heng-Ruey Hsu wrote:
> > >> Android requires camera timestamps to be reported with
> > >> CLOCK_BOOTTIME to sync timestamp with other sensor sources.
> > >
> > > What's the rationale behind this, why can't CLOCK_MONOTONIC work ? If the
> > > monotonic clock has shortcomings that make its use impossible for proper
> > > synchronization, then we should consider switching to CLOCK_BOOTTIME
> > > globally in V4L2, not in selected drivers only.
> >
> > CLOCK_BOOTTIME includes the time spent in suspend, while
> > CLOCK_MONOTONIC doesn't. I can imagine the former being much more
> > useful for anything that cares about the actual, long term, time
> > tracking. Especially important since suspend is a very common event on
> > Android and doesn't stop the time flow there, i.e. applications might
> > wake up the device to perform various tasks at necessary times.
>
> Sure, but this patch mentions timestamp synchronization with other sensors,
> and from that point of view, I'd like to know what is wrong with the monotonic
> clock if all devices use it.

AFAIK the sensors mentioned there are not camera sensors, but rather
things we normally put under IIO, e.g. accelerometers, gyroscopes and
so on. I'm not sure how IIO deals with timestamps, but Android seems
to operate in the CLOCK_BOTTIME domain. Let me add some IIO folks.

Gwendal, Alexandru, do you think you could shed some light on how we
handle IIO sensors timestamps across the kernel, Chrome OS and
Android?

>
> > Generally, I'd see a V4L2_BUF_FLAG_TIMESTAMP_BOOTTIME flag being added
> > and user space being given choice to select the time stamp base it
> > needs, perhaps by setting the flag in v4l2_buffer struct at QBUF time?
>
> I would indeed prefer a mechanism specified at the V4L2 API level, with an
> implementation in the V4L2 core, over a module parameter. If the goal is to
> use the boottime clock for synchronization purpose, we need to make sure that
> all drivers will support it correctly. Patching drivers one by one doesn't
> really scale.

Agreed.

Best regards,
Tomasz
