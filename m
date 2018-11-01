Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4A6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A6120831
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="C6SxzlUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A6120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeKAXGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:06:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47568 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKAXGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:06:24 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B3CD1A4A;
        Thu,  1 Nov 2018 15:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1541080996;
        bh=zaT1pmresa1QQmLvqr6CailAvuL3uXlAIjGx29RqMek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6SxzlUnda2Qhz/arc8iL7+YkqP7VTS/JWaQah/q+W72HS5YkKU5bt3zg4QRDI7d6
         Hdv0NTdfg8pKBDHdTfV9z+pm0ji/Dc2VmSIKmYLXfCzPOeM9pdd2iAyTseYBzFi+9k
         9Yj/LDiafBkklYg2Vl4bdBi2Z3EFalujGzTtJMEc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexandru M Stan <amstan@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
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
Subject: Re: [PATCH] media: uvcvideo: Add boottime clock support
Date:   Thu, 01 Nov 2018 16:03:22 +0200
Message-ID: <1610184.U7oo9Z4Yep@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAHNYxRwbSSp02Zr4a1z5gh0q6cHUUDnZCqRQU7QtP8LMe3Jp2A@mail.gmail.com>
References: <20181017075242.21790-1-henryhsu@chromium.org> <CAAFQd5AL2CnnWLk+i133RRa36HTa0baFkezRhpTXf9YP0DSF1Q@mail.gmail.com> <CAHNYxRwbSSp02Zr4a1z5gh0q6cHUUDnZCqRQU7QtP8LMe3Jp2A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandru,

On Thursday, 18 October 2018 20:28:06 EET Alexandru M Stan wrote:
> On Wed, Oct 17, 2018 at 9:31 PM, Tomasz Figa wrote:
> > On Thu, Oct 18, 2018 at 5:50 AM Laurent Pinchart wrote:
> >> On Wednesday, 17 October 2018 11:28:52 EEST Tomasz Figa wrote:
> >>> On Wed, Oct 17, 2018 at 5:02 PM Laurent Pinchart wrote:
> >>>> On Wednesday, 17 October 2018 10:52:42 EEST Heng-Ruey Hsu wrote:
> >>>>> Android requires camera timestamps to be reported with
> >>>>> CLOCK_BOOTTIME to sync timestamp with other sensor sources.
> >>>> 
> >>>> What's the rationale behind this, why can't CLOCK_MONOTONIC work ? If
> >>>> the monotonic clock has shortcomings that make its use impossible for
> >>>> proper synchronization, then we should consider switching to
> >>>> CLOCK_BOOTTIME globally in V4L2, not in selected drivers only.
> >>> 
> >>> CLOCK_BOOTTIME includes the time spent in suspend, while
> >>> CLOCK_MONOTONIC doesn't. I can imagine the former being much more
> >>> useful for anything that cares about the actual, long term, time
> >>> tracking. Especially important since suspend is a very common event on
> >>> Android and doesn't stop the time flow there, i.e. applications might
> >>> wake up the device to perform various tasks at necessary times.
> >> 
> >> Sure, but this patch mentions timestamp synchronization with other
> >> sensors, and from that point of view, I'd like to know what is wrong with
> >> the monotonic clock if all devices use it.
> > 
> > AFAIK the sensors mentioned there are not camera sensors, but rather
> > things we normally put under IIO, e.g. accelerometers, gyroscopes and
> > so on. I'm not sure how IIO deals with timestamps, but Android seems
> > to operate in the CLOCK_BOTTIME domain. Let me add some IIO folks.
> > 
> > Gwendal, Alexandru, do you think you could shed some light on how we
> > handle IIO sensors timestamps across the kernel, Chrome OS and
> > Android?
> 
> On our devices of interest have a specialized "sensor" that comes via
> IIO (from the EC, cros-ec-ring driver) that can be used to more
> accurately timestamp each frame (since it's recorded with very low
> jitter by a realtime-ish OS). In some high level userspace thing
> (specifically the Android Camera HAL) we try to pick the best
> timestamp from the IIO, whatever's closest to what the V4L stuff gives
> us.
> 
> I guess the Android convention is for sensor timestamps to be in
> CLOCK_BOOTTIME (maybe because it likes sleeping so much). There's
> probably no advantage to using one over the other, but the important
> thing is that they have to be the same, otherwise the closest match
> logic would fail.

That's my understanding too, I don't think CLOCK_BOOTTIME really brings much 
benefit in this case, but it's important than all timestamps use the same 
clock. The question is thus which clock we should select. Mainline mostly uses 
CLOCK_MONOTONIC, and Android CLOCK_BOOTTIME. Would you like to submit patches 
to switch Android to CLOCK_MONOTONIC ? :-)

-- 
Regards,

Laurent Pinchart



