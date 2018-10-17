Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B53BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F032E21470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U9PNRp9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F032E21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeJREro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:47:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56054 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeJRErn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:47:43 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 921131277;
        Wed, 17 Oct 2018 22:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539809415;
        bh=QnlgGMCqq24KUZW/VhCAXjMzG/GkznVndEilws0ccsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9PNRp9P21UY4F45JG9i/9EWkmGqMItgP/QwwTR5Czaru6VEtXZbO9jnhQkZE2NQT
         x/Zcf73JHC/66/JwsJa3k5wdR+FnA3buSLdgNtxk/TlLZ7cCFOcXp+9n+UEOwkvWzT
         BFR48d9N5N2yFWOv3qJXWODApN4t/I6VU/oTPsnE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Heng-Ruey Hsu <henryhsu@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>
Subject: Re: [PATCH] media: uvcvideo: Add boottime clock support
Date:   Wed, 17 Oct 2018 23:50:25 +0300
Message-ID: <2355808.GKno8i6Ks9@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAAFQd5B+4x4aSUywtdukwgUmQNQsQsbK4sjedNphwNFteaTscg@mail.gmail.com>
References: <20181017075242.21790-1-henryhsu@chromium.org> <13883852.6N9L7C0n48@avalon> <CAAFQd5B+4x4aSUywtdukwgUmQNQsQsbK4sjedNphwNFteaTscg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Wednesday, 17 October 2018 11:28:52 EEST Tomasz Figa wrote:
> On Wed, Oct 17, 2018 at 5:02 PM Laurent Pinchart wrote:
> > On Wednesday, 17 October 2018 10:52:42 EEST Heng-Ruey Hsu wrote:
> >> Android requires camera timestamps to be reported with
> >> CLOCK_BOOTTIME to sync timestamp with other sensor sources.
> > 
> > What's the rationale behind this, why can't CLOCK_MONOTONIC work ? If the
> > monotonic clock has shortcomings that make its use impossible for proper
> > synchronization, then we should consider switching to CLOCK_BOOTTIME
> > globally in V4L2, not in selected drivers only.
> 
> CLOCK_BOOTTIME includes the time spent in suspend, while
> CLOCK_MONOTONIC doesn't. I can imagine the former being much more
> useful for anything that cares about the actual, long term, time
> tracking. Especially important since suspend is a very common event on
> Android and doesn't stop the time flow there, i.e. applications might
> wake up the device to perform various tasks at necessary times.

Sure, but this patch mentions timestamp synchronization with other sensors, 
and from that point of view, I'd like to know what is wrong with the monotonic 
clock if all devices use it.

> Generally, I'd see a V4L2_BUF_FLAG_TIMESTAMP_BOOTTIME flag being added
> and user space being given choice to select the time stamp base it
> needs, perhaps by setting the flag in v4l2_buffer struct at QBUF time?

I would indeed prefer a mechanism specified at the V4L2 API level, with an 
implementation in the V4L2 core, over a module parameter. If the goal is to 
use the boottime clock for synchronization purpose, we need to make sure that 
all drivers will support it correctly. Patching drivers one by one doesn't 
really scale.

-- 
Regards,

Laurent Pinchart



