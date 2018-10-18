Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E77C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C7F21486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fqmkUVvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C7F21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeJSBaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:30:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38787 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJSBa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:30:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id u197-v6so24650904oif.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=drlSvie5l/iYPBNGt49LyAYrqRPCDcukZEtYDXR1Pzg=;
        b=fqmkUVvcdZ6NG5q2gtwX8LC2RXQxBjzXIVmG1gyu8jQRtokDIdme6dPcJY7UjiSL9c
         l9lQ+E1DWodqnidhLYK3O8XImZLrAOXzxBWUDfes6W7LORNXyw1FAruFce/uMGmBupzH
         LHUTFOcstq/k0s6hESkSuiveFzIsk3gOIjuPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=drlSvie5l/iYPBNGt49LyAYrqRPCDcukZEtYDXR1Pzg=;
        b=bDchSKTh3k6pxPEHdKdebVJ0OEKipe6NkA3GAF7nOyUl20XxQ4aO/ZR2kR43UMbxUg
         fqTfZJyKNH+HB4cXhtoGCQ+BU9ByMM7vwconOntc+Ae/LqJVaHL0vN9Z3+V7vqb6qwqN
         wJgOHyw6rzfqyJys5X/KQEAxikF4S99aKhWXR68lBV9Z85luhzK5QpB5szyglrNJu0/X
         aW89XrUN1ogz9JuWLo7i5VuYxT+1LcRH5L/a00BOzdY/ylu94IPmA0mJgvEPfikH+bBo
         WXuOK9xm+Z5MAlzL2Hr/FB5JmrQ4k6M7Tzr4zZfC8Kn5rtMYbBDQsBBMF3a+WwjzN1ZP
         9rlQ==
X-Gm-Message-State: ABuFfohmGGGk9ybKTk1/U0ipttu1tVRoaCuOjlmF1ZkTMXDT9T7OeQh2
        CxSyBhgo/EtfoQSqHcX14blGhRGVwbI=
X-Google-Smtp-Source: ACcGV60OEgKFNLrGPw4B7QPOniAr5zqnqG4kPJ+XbtDcrCEnTUl0xfd3b1Xfb5clsIQ6LVeDO5K/kg==
X-Received: by 2002:aca:b357:: with SMTP id c84-v6mr17511433oif.266.1539883710297;
        Thu, 18 Oct 2018 10:28:30 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id b3-v6sm8428223oih.0.2018.10.18.10.28.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 10:28:27 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id v69-v6so24695162oif.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:28:27 -0700 (PDT)
X-Received: by 2002:aca:aac7:: with SMTP id t190-v6mr17615860oie.218.1539883706578;
 Thu, 18 Oct 2018 10:28:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3406:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 10:28:06
 -0700 (PDT)
In-Reply-To: <CAAFQd5AL2CnnWLk+i133RRa36HTa0baFkezRhpTXf9YP0DSF1Q@mail.gmail.com>
References: <20181017075242.21790-1-henryhsu@chromium.org> <13883852.6N9L7C0n48@avalon>
 <CAAFQd5B+4x4aSUywtdukwgUmQNQsQsbK4sjedNphwNFteaTscg@mail.gmail.com>
 <2355808.GKno8i6Ks9@avalon> <CAAFQd5AL2CnnWLk+i133RRa36HTa0baFkezRhpTXf9YP0DSF1Q@mail.gmail.com>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Thu, 18 Oct 2018 10:28:06 -0700
X-Gmail-Original-Message-ID: <CAHNYxRwbSSp02Zr4a1z5gh0q6cHUUDnZCqRQU7QtP8LMe3Jp2A@mail.gmail.com>
Message-ID: <CAHNYxRwbSSp02Zr4a1z5gh0q6cHUUDnZCqRQU7QtP8LMe3Jp2A@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Add boottime clock support
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Heng-Ruey Hsu <henryhsu@chromium.org>,
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

On Wed, Oct 17, 2018 at 9:31 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Thu, Oct 18, 2018 at 5:50 AM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>
>> Hi Tomasz,
>>
>> On Wednesday, 17 October 2018 11:28:52 EEST Tomasz Figa wrote:
>> > On Wed, Oct 17, 2018 at 5:02 PM Laurent Pinchart wrote:
>> > > On Wednesday, 17 October 2018 10:52:42 EEST Heng-Ruey Hsu wrote:
>> > >> Android requires camera timestamps to be reported with
>> > >> CLOCK_BOOTTIME to sync timestamp with other sensor sources.
>> > >
>> > > What's the rationale behind this, why can't CLOCK_MONOTONIC work ? If the
>> > > monotonic clock has shortcomings that make its use impossible for proper
>> > > synchronization, then we should consider switching to CLOCK_BOOTTIME
>> > > globally in V4L2, not in selected drivers only.
>> >
>> > CLOCK_BOOTTIME includes the time spent in suspend, while
>> > CLOCK_MONOTONIC doesn't. I can imagine the former being much more
>> > useful for anything that cares about the actual, long term, time
>> > tracking. Especially important since suspend is a very common event on
>> > Android and doesn't stop the time flow there, i.e. applications might
>> > wake up the device to perform various tasks at necessary times.
>>
>> Sure, but this patch mentions timestamp synchronization with other sensors,
>> and from that point of view, I'd like to know what is wrong with the monotonic
>> clock if all devices use it.
>
> AFAIK the sensors mentioned there are not camera sensors, but rather
> things we normally put under IIO, e.g. accelerometers, gyroscopes and
> so on. I'm not sure how IIO deals with timestamps, but Android seems
> to operate in the CLOCK_BOTTIME domain. Let me add some IIO folks.
>
> Gwendal, Alexandru, do you think you could shed some light on how we
> handle IIO sensors timestamps across the kernel, Chrome OS and
> Android?

On our devices of interest have a specialized "sensor" that comes via
IIO (from the EC, cros-ec-ring driver) that can be used to more
accurately timestamp each frame (since it's recorded with very low
jitter by a realtime-ish OS). In some high level userspace thing
(specifically the Android Camera HAL) we try to pick the best
timestamp from the IIO, whatever's closest to what the V4L stuff gives
us.

I guess the Android convention is for sensor timestamps to be in
CLOCK_BOOTTIME (maybe because it likes sleeping so much). There's
probably no advantage to using one over the other, but the important
thing is that they have to be the same, otherwise the closest match
logic would fail.

Regards,
Alexandru Stan
