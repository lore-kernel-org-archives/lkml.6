Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2D3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0432E20833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0432E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeIZAka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:40:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZAk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:40:29 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED3B31077;
        Tue, 25 Sep 2018 18:31:40 +0000 (UTC)
Date:   Tue, 25 Sep 2018 20:31:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/21] platform: goldfish: pipe: Add DMA support to
 goldfish pipe
Message-ID: <20180925183138.GB21572@kroah.com>
References: <20180914175122.21036-1-rkir@google.com>
 <20180914175122.21036-6-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914175122.21036-6-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:51:07AM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> Goldfish DMA is an extension to the pipe device and is designed
> to facilitate high-speed RAM->RAM transfers from guest to host.
> 
> See uapi/linux/goldfish/goldfish_dma.h for more details.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  drivers/platform/goldfish/goldfish_pipe.c     | 312 +++++++++++++++++-
>  .../platform/goldfish/goldfish_pipe_qemu.h    |   2 +
>  include/uapi/linux/goldfish/goldfish_dma.h    |  84 +++++
>  3 files changed, 396 insertions(+), 2 deletions(-)
>  create mode 100644 include/uapi/linux/goldfish/goldfish_dma.h

A whole new api needs some others to review it becides just me.  Please
get some more signed off by on this.

Also, some minor comments:

> --- /dev/null
> +++ b/include/uapi/linux/goldfish/goldfish_dma.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

If you have a spdx line, you don't need the gpl boiler-plate text
either.

But, this is a uapi file, so gpl2 is not probably the license you want
here, right?  That should be fixed before you end up doing something
foolish with a userspace program that includes this :)

> +/* GOLDFISH DMA
> + *
> + * Goldfish DMA is an extension to the pipe device
> + * and is designed to facilitate high-speed RAM->RAM
> + * transfers from guest to host.
> + *
> + * Interface (guest side):
> + *
> + * The guest user calls goldfish_dma_alloc (ioctls)
> + * and then mmap() on a goldfish pipe fd,
> + * which means that it wants high-speed access to
> + * host-visible memory.
> + *
> + * The guest can then write into the pointer
> + * returned by mmap(), and these writes
> + * become immediately visible on the host without BQL
> + * or otherweise context switching.
> + *
> + * dma_alloc_coherent() is used to obtain contiguous
> + * physical memory regions, and we allocate and interact
> + * with this region on both guest and host through
> + * the following ioctls:
> + *
> + * - LOCK: lock the region for data access.
> + * - UNLOCK: unlock the region. This may also be done from the host
> + *   through the WAKE_ON_UNLOCK_DMA procedure.
> + * - CREATE_REGION: initialize size info for a dma region.
> + * - GETOFF: send physical address to guest drivers.
> + * - (UN)MAPHOST: uses goldfish_pipe_cmd to tell the host to
> + * (un)map to the guest physical address associated
> + * with the current dma context. This makes the physically
> + * contiguous memory (in)visible to the host.
> + *
> + * Guest userspace obtains a pointer to the DMA memory
> + * through mmap(), which also lazily allocates the memory
> + * with dma_alloc_coherent. (On last pipe close(), the region is freed).
> + * The mmaped() region can handle very high bandwidth
> + * transfers, and pipe operations can be used at the same
> + * time to handle synchronization and command communication.
> + */
> +
> +#define GOLDFISH_DMA_BUFFER_SIZE (32 * 1024 * 1024)
> +
> +struct goldfish_dma_ioctl_info {
> +	__u64 phys_begin;
> +	__u64 size;
> +};

Don't we have a dma userspace api?  What does virtio use?  What about
uio?  Why can't one of the existing interfaces work for you?

> +/* There is an ioctl associated with goldfish dma driver.
> + * Make it conflict with ioctls that are not likely to be used
> + * in the emulator.
> + * 'G'	00-3F	drivers/misc/sgi-gru/grulib.h	conflict!
> + * 'G'	00-0F	linux/gigaset_dev.h	conflict!

Causing known conflicts is not wise.

thanks,

greg k-h
