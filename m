Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeFCCMT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 22:12:19 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35825 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeFCCMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 22:12:18 -0400
X-Google-Smtp-Source: ADUXVKJEhVW1oq7aTW2gKcilqG1s+/D/zaTGegtUEpOcWe/qtFKpGct+X8A1nCE/i0RWRDdVZpwj5nQ6i3UkgD8b6tU=
MIME-Version: 1.0
In-Reply-To: <1d02b2e1-dd1c-af2a-e980-29aef4aa0c00@arm.com>
References: <c5765cf69bf222757463ba2653ac760b42b785e6.1527745258.git.baolin.wang@linaro.org>
 <1d02b2e1-dd1c-af2a-e980-29aef4aa0c00@arm.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Sun, 3 Jun 2018 10:12:17 +0800
Message-ID: <CAMz4kuLHigZJhk8E53v8k8DR59EARvC6CdkQ0+oAwTRjYKu=cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dma-coherent: Add one parameter to save available
 coherent memory
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 June 2018 at 01:25, Robin Murphy <robin.murphy@arm.com> wrote:
> On 31/05/18 06:55, Baolin Wang wrote:
>>
>> It is incorrect to use mem->size to valid if there are enough coherent
>> memory to allocate in __dma_alloc_from_coherent(), since some devices
>> may mark some occupied coherent memory by
>> dma_mark_declared_memory_occupied().
>>
>> So we can introduce one 'avail' parameter to save the available device
>> coherent memory, to valid if we have enough coherent memory for the device
>> to allocate.
>
>
> We already have dma_mem->size stored for other reasons, so there's little
> harm in using it for a rough sanity check to short-circuit the odd
> allocation which cannot possibly succeed, but adding machinery purely for
> the sake an ever-so-slightly more accurate, but still far from exhaustive,
> check doesn't really seem worth it.
>
> Even if size <= dma_mem->avail there's still no guarantee that the
> allocation will actually succeed, so what benefit does the explicit
> accounting provide?
>

Yes, it can not guarantee one successful allocation, but it can avoid
some redundant bitmap operation and reducing the preempt-disable time
if we have not enough memory by checking the actual available coherent
memory. By the way, I think we should also add check in
dma_mark_declared_memory_occupied() and __dma_mmap_from_coherent().

-- 
Baolin.wang
Best Regards
