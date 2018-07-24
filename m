Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF2C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFAB20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFAB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbeGXWDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:03:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46400 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388640AbeGXWDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:03:42 -0400
Received: (qmail 24302 invoked by uid 2102); 24 Jul 2018 16:55:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jul 2018 16:55:24 -0400
Date:   Tue, 24 Jul 2018 16:55:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
cc:     Tomasz Figa <tfiga@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steven Rostedt <rostedt@goodmis.org>, <mingo@redhat.com>,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        <keiichiw@chromium.org>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
In-Reply-To: <CAJs94EahjbkJRWKR=2QeD=tOMR=kznwXbQgTbKvSuTg4jBk1ew@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1807241652550.1311-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Matwey V. Kornilov wrote:

> 2018-07-23 21:57 GMT+03:00 Alan Stern <stern@rowland.harvard.edu>:
> > On Mon, 23 Jul 2018, Matwey V. Kornilov wrote:
> >
> >> I've tried to strategies:
> >>
> >> 1) Use dma_unmap and dma_map inside the handler (I suppose this is
> >> similar to how USB core does when there is no URB_NO_TRANSFER_DMA_MAP)
> >
> > Yes.
> >
> >> 2) Use sync_cpu and sync_device inside the handler (and dma_map only
> >> once at memory allocation)
> >>
> >> It is interesting that dma_unmap/dma_map pair leads to the lower
> >> overhead (+1us) than sync_cpu/sync_device (+2us) at x86_64 platform.
> >> At armv7l platform using dma_unmap/dma_map  leads to ~50 usec in the
> >> handler, and sync_cpu/sync_device - ~65 usec.
> >>
> >> However, I am not sure is it mandatory to call
> >> dma_sync_single_for_device for FROM_DEVICE direction?
> >
> > According to Documentation/DMA-API-HOWTO.txt, the CPU should not write
> > to a DMA_FROM_DEVICE-mapped area, so dma_sync_single_for_device() is
> > not needed.
> 
> Well, I measured the following at armv7l. The handler execution time
> (URB_NO_TRANSFER_DMA_MAP is used for all cases):
> 
> 1) coherent DMA: ~3000 usec (pwc is not functional)
> 2) explicit dma_unmap and dma_map in the handler: ~52 usec
> 3) explicit dma_sync_single_for_cpu (no dma_sync_single_for_device): ~56 usec
> 
> So, I suppose that unfortunately Tomasz suggestion doesn't work. There
> is no performance improvement when dma_sync_single is used.
> 
> At x86_64 the following happens:
> 
> 1) coherent DMA: ~2 usec
> 2) explicit dma_unmap and dma_map in the handler: ~3.5 usec
> 3) explicit dma_sync_single_for_cpu (no dma_sync_single_for_device): ~4 usec
> 
> So, whats to do next? Personally, I think that DMA streaming API
> introduces not so great overhead.
> Does anybody happy with turning to streaming DMA or I'll introduce
> module-level switch as Ezequiel suggested?

How about using the dma_unmap and dma_map calls in the USB core?  If 
they add the same overhead as putting them in the handler, I think it 
would be acceptable for x86_64.

It certainly is odd that the dma_sync_single APIs take longer than 
simply mapping and unmapping.

Alan Stern

