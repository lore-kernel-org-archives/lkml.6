Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE299C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA2721A28
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q7QtVpAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA2721A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeHHSmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:42:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33252 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:41:59 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A25557;
        Wed,  8 Aug 2018 18:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533745293;
        bh=/3myg5xUrmSFzG9a/oPesvPjvFr3ieIotKsfToqE6xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7QtVpAEIw96gKYk348XdEpXNEbTPGk3qI4MtJ2iRYLEqU0cFgrMcj38H0x45ricN
         zlExzU5a97xF6rVAhbZRmtpYJ+S/cZxjp+kwtTgyumvZ9Yow2KO2EktDg0RNGigNJk
         5g1UB5Ke3xmpUV4jqJby8S6tSLoezPdtzZw1+aDk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Keiichi Watanabe <keiichiw@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        kieran.bingham@ideasonboard.com,
        Douglas Anderson <dianders@chromium.org>,
        ezequiel@collabora.com, matwey@sai.msu.ru
Subject: Re: [RFC PATCH v1] media: uvcvideo: Cache URB header data before processing
Date:   Wed, 08 Aug 2018 19:22:16 +0300
Message-ID: <1959555.Z0pJAWgXVZ@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <Pine.LNX.4.44L0.1808081015110.1466-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1808081015110.1466-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wednesday, 8 August 2018 17:20:21 EEST Alan Stern wrote:
> On Wed, 8 Aug 2018, Keiichi Watanabe wrote:
> > Hi Laurent, Kieran, Tomasz,
> > 
> > Thank you for reviews and suggestions.
> > I want to do additional measurements for improving the performance.
> > 
> > Let me clarify my understanding:
> > Currently, if the platform doesn't support coherent-DMA (e.g. ARM),
> > urb_buffer is allocated by usb_alloc_coherent with
> > URB_NO_TRANSFER_DMA_MAP flag instead of using kmalloc.
> 
> Not exactly.  You are mixing up allocation with mapping.  The speed of
> the allocation doesn't matter; all that matters is whether the memory
> is cached and when it gets mapped/unmapped.
> 
> > This is because we want to avoid frequent DMA mappings, which are
> > generally expensive. However, memories allocated in this way are not
> > cached.
> > 
> > So, we wonder if using usb_alloc_coherent is really fast.
> > In other words, we want to know which is better:
> > "No DMA mapping/Uncached memory" v.s. "Frequent DMA mapping/Cached
> > memory".

The second option should also be split in two:

- cached memory with DMA mapping/unmapping around each transfer
- cached memory with DMA mapping/unmapping at allocation/free time, and DMA 
sync around each transfer

The second option should in theory lead to at least slightly better 
performances, but tests with the pwc driver have reported contradictory 
results. I'd like to know whether that's also the case with the uvcvideo 
driver, and if so, why.

> There is no need to wonder.  "Frequent DMA mapping/Cached memory" is
> always faster than "No DMA mapping/Uncached memory".

Is it really, doesn't it depend on the CPU access pattern ?

> The only issue is that on some platform (such as x86) but not others,
> there is a third option: "No DMA mapping/Cached memory".  On platforms
> which support it, this is the fastest option.

-- 
Regards,

Laurent Pinchart



