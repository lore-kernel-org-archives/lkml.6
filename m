Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1964ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09CC2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09CC2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbeITTja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:39:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45790 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbeITTja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:39:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id BA7D427D89E
Message-ID: <5b84e0e4f1b0cbfd3cf3e641c41f9fc50a74e6bf.camel@collabora.com>
Subject: Re: [PATCH v4 2/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Date:   Thu, 20 Sep 2018 10:55:43 -0300
In-Reply-To: <Pine.LNX.4.44L0.1808101019550.1425-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1808101019550.1425-100000@iolanthe.rowland.org>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, Laurent:

On Fri, 2018-08-10 at 10:27 -0400, Alan Stern wrote:
> On Fri, 10 Aug 2018, Laurent Pinchart wrote:
> 
> > > > Aren't you're missing a dma_sync_single_for_device() call before
> > > > submitting the URB ? IIRC that's required for correct operation of the DMA
> > > > mapping API on some platforms, depending on the cache architecture. The
> > > > additional sync can affect performances, so it would be useful to re-run
> > > > the perf test.
> > > 
> > > This was already discussed:
> > > 
> > > https://lkml.org/lkml/2018/7/23/1051
> > > 
> > > I rely on Alan's reply:
> > > 
> > > > According to Documentation/DMA-API-HOWTO.txt, the CPU should not write
> > > > to a DMA_FROM_DEVICE-mapped area, so dma_sync_single_for_device() is
> > > > not needed.
> > 
> > I fully agree that the CPU should not write to the buffer. However, I think 
> > the sync call is still needed. It's been a long time since I touched this 
> > area, but IIRC, some cache architectures (VIVT ?) require both cache clean 
> > before the transfer and cache invalidation after the transfer. On platforms 
> > where no cache management operation is needed before the transfer in the 
> > DMA_FROM_DEVICE direction, the dma_sync_*_for_device() calls should be no-ops 
> > (and if they're not, it's a bug of the DMA mapping implementation).
> 
> In general, I agree that the cache has to be clean before a transfer
> starts.  This means some sort of mapping operation (like
> dma_sync_*_for-device) is indeed required at some point between the
> allocation and the first transfer.
> 
> For subsequent transfers, however, the cache is already clean and it
> will remain clean because the CPU will not do any writes to the buffer.
> (Note: clean != empty.  Rather, clean == !dirty.)  Therefore transfers
> following the first should not need any dma_sync_*_for_device.
> 
> If you don't accept this reasoning then you should ask the people who 
> wrote DMA-API-HOWTO.txt.  They certainly will know more about this 
> issue than I do.
> 

Can either of you ack or nack this change? I'd like to see this merged,
or either re-worked, so we can merge it.

Thanks!
Eze 
