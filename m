Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92260ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CEE20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CEE20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbeGWT76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:59:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:35630 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2387970AbeGWT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:59:58 -0400
Received: (qmail 1416 invoked by uid 2102); 23 Jul 2018 14:57:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jul 2018 14:57:23 -0400
Date:   Mon, 23 Jul 2018 14:57:23 -0400 (EDT)
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
In-Reply-To: <CAJs94EZEqWEscECp7bsJ3DvqoU83_Y2WQ55jPaG4MyoG-hvLFQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1807231444150.1328-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, Matwey V. Kornilov wrote:

> I've tried to strategies:
> 
> 1) Use dma_unmap and dma_map inside the handler (I suppose this is
> similar to how USB core does when there is no URB_NO_TRANSFER_DMA_MAP)

Yes.

> 2) Use sync_cpu and sync_device inside the handler (and dma_map only
> once at memory allocation)
> 
> It is interesting that dma_unmap/dma_map pair leads to the lower
> overhead (+1us) than sync_cpu/sync_device (+2us) at x86_64 platform.
> At armv7l platform using dma_unmap/dma_map  leads to ~50 usec in the
> handler, and sync_cpu/sync_device - ~65 usec.
> 
> However, I am not sure is it mandatory to call
> dma_sync_single_for_device for FROM_DEVICE direction?

According to Documentation/DMA-API-HOWTO.txt, the CPU should not write 
to a DMA_FROM_DEVICE-mapped area, so dma_sync_single_for_device() is
not needed.

Alan Stern

