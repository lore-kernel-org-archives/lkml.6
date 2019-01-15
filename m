Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C21EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78372063F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfAOCjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:39:18 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39421 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfAOCjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:39:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so1447263qtj.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 18:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPV5waa8vhG2OmIFrCe+tl2KDRgoPjfLoXs93T7qfME=;
        b=ERJbFPZhhdT19IPsdRci5MCdYvGR1mMtDoEISDbq5rJVpo3IC33ghDppkUDIATqfSS
         +N9yeT6hla9rWhCA8qfYTYkGHDB1Qi5tvTNHm7qs79jDO0x2YMCR+BBqiauAPotuPH1n
         Tod3LA6MhbEtyLCa4XEmkl+Ia3eSGSzAQpMxgrZ2GfT2hcx38Dg/qw5Fu71VtJGwm40z
         +Q/AP/r/db1okt5Eklfl4kskGdXvG5CqcVybwXvgBhusYtF7GKdxWh+8jLNUlLOH92hT
         g9vXKtW2KEB2H8hRjFzrVWvZnLX9Vbr2ZlCy2o1HvcHBxYQ+i2p+m+n7LguJ2KCstLdf
         glHw==
X-Gm-Message-State: AJcUukdYdov66TNGsJlAiAgHNxfF+OZmXxYY1LzUlmxc9BRK310BEmQN
        8QnzNs3PSdYGEiIUYeLCUAgC+ioLlvo=
X-Google-Smtp-Source: ALg8bN5gByUM/pU2lkavQt+O1VLEhG0vPhudKIzZkOiFbfA0QVh9T9p6UReGEzdt0st/ZkhETQjk6w==
X-Received: by 2002:a0c:b596:: with SMTP id g22mr1250591qve.88.1547519956614;
        Mon, 14 Jan 2019 18:39:16 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::fb21? ([2601:602:9800:dae6::fb21])
        by smtp.gmail.com with ESMTPSA id p72sm41864779qke.87.2019.01.14.18.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:39:15 -0800 (PST)
Subject: Re: [PATCH 00/14] Misc ION cleanups and adding unmapped heap
To:     "Andrew F. Davis" <afd@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190111180523.27862-1-afd@ti.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <3b0d05e1-d437-801b-1c41-97d55f9ac10f@redhat.com>
Date:   Mon, 14 Jan 2019 18:39:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111180523.27862-1-afd@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 10:05 AM, Andrew F. Davis wrote:
> Hello all,
> 
> This is a set of (hopefully) non-controversial cleanups for the ION
> framework and current set of heaps. These were found as I start to
> familiarize myself with the framework to help in whatever way I
> can in getting all this up to the standards needed for de-staging.
> 
> I would like to get some ideas of what is left to work on to get ION
> out of staging. Has there been some kind of agreement on what ION should
> eventually end up being? To me it looks like it is being whittled away at
> to it's most core functions. To me that is looking like being a DMA-BUF
> user-space front end, simply advertising available memory backings in a
> system and providing allocations as DMA-BUF handles. If this is the case
> then it looks close to being ready to me at least, but I would love to
> hear any other opinions and concerns.
> 

Yes, at this point the only functionality that people are really
depending on is the ability to allocate a dma_buf easily from userspace.

> Back to this patchset, the last patch may be a bit different than the
> others, it adds an unmapped heaps type and creation helper. I wanted to
> get this in to show off another heap type and maybe some issues we may
> have with the current ION framework. The unmapped heap is used when the
> backing memory should not (or cannot) be touched. Currently this kind
> of heap is used for firewalled secure memory that can be allocated like
> normal heap memory but only used by secure devices (OP-TEE, crypto HW,
> etc). It is basically just copied from the "carveout" heap type with the
> only difference being it is not mappable to userspace and we do not clear
> the memory (as we should not map it either). So should this really be a
> new heap type? Or maybe advertised as a carveout heap but with an
> additional allocation flag? Perhaps we do away with "types" altogether
> and just have flags, coherent/non-coherent, mapped/unmapped, etc.
> 
> Maybe more thinking will be needed afterall..
> 

So the cleanup looks okay (I need to finish reviewing) but I'm not a
fan of adding another heaptype without solving the problem of adding
some sort of devicetree binding or other method of allocating and
placing Ion heaps. That plus uncached buffers are one of the big
open problems that need to be solved for destaging Ion. See
https://lore.kernel.org/lkml/20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain/
for some background on that problem.

Thanks,
Laura

> Thanks,
> Andrew
> 
> Andrew F. Davis (14):
>    staging: android: ion: Add proper header information
>    staging: android: ion: Remove empty ion_ioctl_dir() function
>    staging: android: ion: Merge ion-ioctl.c into ion.c
>    staging: android: ion: Remove leftover comment
>    staging: android: ion: Remove struct ion_platform_heap
>    staging: android: ion: Fixup some white-space issues
>    staging: android: ion: Sync comment docs with struct ion_buffer
>    staging: android: ion: Remove base from ion_carveout_heap
>    staging: android: ion: Remove base from ion_chunk_heap
>    staging: android: ion: Remove unused headers
>    staging: android: ion: Allow heap name to be null
>    staging: android: ion: Declare helpers for carveout and chunk heaps
>    staging: android: ion: Do not sync CPU cache on map/unmap
>    staging: android: ion: Add UNMAPPED heap type and helper
> 
>   drivers/staging/android/ion/Kconfig           |  10 ++
>   drivers/staging/android/ion/Makefile          |   3 +-
>   drivers/staging/android/ion/ion-ioctl.c       |  98 --------------
>   drivers/staging/android/ion/ion.c             |  93 +++++++++++--
>   drivers/staging/android/ion/ion.h             |  87 ++++++++-----
>   .../staging/android/ion/ion_carveout_heap.c   |  19 +--
>   drivers/staging/android/ion/ion_chunk_heap.c  |  25 ++--
>   drivers/staging/android/ion/ion_cma_heap.c    |   6 +-
>   drivers/staging/android/ion/ion_heap.c        |   8 +-
>   drivers/staging/android/ion/ion_page_pool.c   |   2 +-
>   drivers/staging/android/ion/ion_system_heap.c |   8 +-
>   .../staging/android/ion/ion_unmapped_heap.c   | 123 ++++++++++++++++++
>   drivers/staging/android/uapi/ion.h            |   3 +
>   13 files changed, 307 insertions(+), 178 deletions(-)
>   delete mode 100644 drivers/staging/android/ion/ion-ioctl.c
>   create mode 100644 drivers/staging/android/ion/ion_unmapped_heap.c
> 

