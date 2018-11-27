Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E96FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26B82081B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NCigEd2F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CLFOQx0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26B82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeK0P4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 10:56:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeK0P4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 10:56:24 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D64660B11; Tue, 27 Nov 2018 04:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543294786;
        bh=cT/rEbtk10Dp/3bm/aMhSLIrwvlPlOdQNuo0EV7OZuI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NCigEd2FdE+PqrQMZUUs1FjgKobO7NRRvLmE2A8HWyv8IqZps/Q/o+hRFkkAecrow
         WqmUB+FGFsQrvgd/6LddjKHRlCRl0rO7frWsqeGMkJ4/k1nOzGu6PCSYc2ntvJ7Hw9
         Hnu8TxoLcUC8pjCBUupxYcfiTu3Dxa3mFOOtR1uE=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE7E76060A;
        Tue, 27 Nov 2018 04:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543294785;
        bh=cT/rEbtk10Dp/3bm/aMhSLIrwvlPlOdQNuo0EV7OZuI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CLFOQx0Z9kqrNPxixXlcGnhzrN3VOM3CAqXb+TtgjubeofFvv8udT7ZVg+F1ZCEiR
         Ga4k/beHG1AgLNn+k59b/7Q548QXk7SYDbFYrmNy2UhkQsB0GL6RLPjcBsDF6ivU7r
         9uVw4rEP+sVFpSi4vO/YFo9FLZk0M/4w4L51YzZA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE7E76060A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Mon, 26 Nov 2018 20:59:44 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Brian Starkey <Brian.Starkey@arm.com>
cc:     nd <nd@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Martijn Coenen <maco@android.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Arve Hjonnevag <arve@android.com>,
        linaro-mm-sig@lists.linaro.org, Laura Abbott <labbott@redhat.com>
Subject: Re: [RFC PATCH v2] android: ion: How to properly clean caches for
 uncached allocations
In-Reply-To: <20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain>
Message-ID: <alpine.DEB.2.10.1811262051310.9248@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com> <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com> <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com> <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
 <20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Brian Starkey wrote:

> Hi Liam,
> 
> I'm missing a bit of context here, but I did read the v1 thread.
> Please accept my apologies if I'm re-treading trodden ground.
> 
> I do know we're chasing nebulous ion "problems" on our end, which
> certainly seem to be related to what you're trying to fix here.
> 
> On Thu, Nov 01, 2018 at 03:15:06PM -0700, Liam Mark wrote:
> >Based on the suggestions from Laura I created a first draft for a change
> >which will attempt to ensure that uncached mappings are only applied to
> >ION memory who's cache lines have been cleaned.
> >It does this by providing cached mappings (for uncached ION allocations)
> >until the ION buffer is dma mapped and successfully cleaned, then it
> drops
> >the userspace mappings and when pages are accessed they are faulted back
> >in and uncached mappings are created.
> 
> If I understand right, there's no way to portably clean the cache of
> the kernel mapping before we map the pages into userspace. Is that
> right?
> 

Yes, it isn't always possible to clean the caches for an uncached mapping 
because a device is required by the DMA APIs to do cache maintenance and 
there isn't necessarily a device available (dma_buf_attach may not yet 
have been called).

> Alternatively, can we just make ion refuse to give userspace a
> non-cached mapping for pages which are mapped in the kernel as cached?

These pages will all be mapped as cached in the kernel for 64 bit (kernel 
logical addresses) so you would always be refusing to create a non-cached mapping.

> Would userspace using the dma-buf sync ioctl around its accesses do
> the "right thing" in that case?
> 

I don't think so, the dma-buf sync ioctl require a device to peform cache 
maintenance, but as mentioned above a device may not be available.

> Given that as you pointed out, the kernel does still have a cached
> mapping to these pages, trying to give the CPU a non-cached mapping of
> those same pages while preserving consistency seems fraught. Wouldn't
> it be better to make sure all CPU mappings are cached, and have CPU
> clients use the dma_buf_{begin,end}_cpu_access() hooks to get
> consistency where needed?
> 

It is fraught, but unfortunately you can't rely on 
dma_buf_{begin,end}_cpu_access() to do cache maintenance as these calls 
require a device, and a device is not always available.

> >
> >This change has the following potential disadvantages:
> >- It assumes that userpace clients won't attempt to access the buffer
> >while it is being mapped as we are removing the userpspace mappings at
> >this point (though it is okay for them to have it mapped)
> >- It assumes that kernel clients won't hold a kernel mapping to the
> buffer
> >(ie dma_buf_kmap) while it is being dma-mapped. What should we do if
> there
> >is a kernel mapping at the time of dma mapping, fail the mapping, warn?
> >- There may be a performance penalty as a result of having to fault in
> the
> >pages after removing the userspace mappings.
> 
> I wonder if the dma-buf sync ioctl might provide a way for userspace
> to opt-in to when the zap/fault happens. Zap on (DMA_BUF_SYNC_WRITE |
> DMA_BUF_SYNC_WRITE_END) and fault on (DMA_BUF_SYNC_READ |
> DMA_BUF_SYNC_START)
> 

Not sure I understand, can you elaborate. 
Are you also adding a requirment that ION pages can't be mmaped during a
call to dma_buf_map_attachment?

> >
> >It passes basic testing involving reading writing and reading from
> >uncached system heap allocations before and after dma mapping.
> >
> >Please let me know if this is heading in the right direction and if there
> >are any concerns.
> >
> >Signed-off-by: Liam Mark <lmark at codeaurora.org>
> >---
> > drivers/staging/android/ion/ion.c | 146
> +++++++++++++++++++++++++++++++++++++-
> > drivers/staging/android/ion/ion.h |   9 +++
> > 2 files changed, 152 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/staging/android/ion/ion.c
> b/drivers/staging/android/ion/ion.c
> >index 99073325b0c0..3dc0f5a265bf 100644
> >--- a/drivers/staging/android/ion/ion.c
> >+++ b/drivers/staging/android/ion/ion.c
> >@@ -96,6 +96,7 @@ static struct ion_buffer *ion_buffer_create(struct
> ion_heap *heap,
> > 	}
> >
> > 	INIT_LIST_HEAD(&buffer->attachments);
> >+	INIT_LIST_HEAD(&buffer->vmas);
> > 	mutex_init(&buffer->lock);
> > 	mutex_lock(&dev->buffer_lock);
> > 	ion_buffer_add(dev, buffer);
> >@@ -117,6 +118,7 @@ void ion_buffer_destroy(struct ion_buffer *buffer)
> > 		buffer->heap->ops->unmap_kernel(buffer->heap, buffer);
> > 	}
> > 	buffer->heap->ops->free(buffer);
> >+	vfree(buffer->pages);
> > 	kfree(buffer);
> > }
> >
> >@@ -245,11 +247,29 @@ static void ion_dma_buf_detatch(struct dma_buf
> *dmabuf,
> > 	kfree(a);
> > }
> >
> >+static bool ion_buffer_uncached_clean(struct ion_buffer *buffer)
> >+{
> >+	return buffer->uncached_clean;
> >+}
> 
> nit: The function name sounds like a verb to me - as in "calling this
> will clean the buffer". I feel ion_buffer_is_uncached_clean() would
> read better.
> 

Yes, that would be cleaner.

Liam


Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

