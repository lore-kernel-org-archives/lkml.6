Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932606AbeEHOgW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:36:22 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38729 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932323AbeEHOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:36:20 -0400
X-Google-Smtp-Source: AB8JxZq4MPoVxTZftctHBXE44AmeHOWXSC7FzdGDUZHUf7pWE2X2TasQgksoSzgnxmNsRh2KMw3r5e6dvxIOxHxw5VQ=
MIME-Version: 1.0
In-Reply-To: <53b13d76-16a1-0e0a-09e1-c917e5d49326@samsung.com>
References: <CGME20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1@eucas1p1.samsung.com>
 <2484918.HKVQc3yJkt@bear> <53b13d76-16a1-0e0a-09e1-c917e5d49326@samsung.com>
From: Frank Mori Hess <fmh6jj@gmail.com>
Date: Tue, 8 May 2018 10:36:18 -0400
Message-ID: <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 8, 2018 at 5:04 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Frank and Vinod,
>
> On 2018-04-28 23:50, Frank Mori Hess wrote:
>> This reverts commit 88987d2c7534a0269f567fb101e6d71a08f0f01d.
>>
>> The pl330.c pause implementation violates the dmaengine requirement
>> for no data loss, since it relies on the DMAKILL
>> instruction.  However, DMAKILL discards in-flight data from the
>> dma controller's fifo.  This is documented in the dma-330 manual
>> and I have observed it with hardware doing device-to-memory burst
>> transfers.  The discarded data may or may not show up in the
>> residue count, depending on timing (resulting in data corruption
>> effectively).
>>
>> Signed-off-by: Frank Mori Hess <fmh6jj@gmail.com>
>
> This revert completely breaks serial driver operation on almost all Exynos
> SoCs, because serial driver relies on having PAUSE feature and proper
> residue reporting from dma engine. Please drop it if possible.
>

It will cause the serial driver to not use the pl330.c driver for dma,
the serial driver will fall back on using the cpu.  This is
unfortunate, but the dma hardware simply does not support pause.  The
"nice" stop instruction DMAEND is not allowed to be inserted using the
debug instruction register.  The only possibility for implementing
pause would be to make the dma transfer do a DMAWFE (wait for event)
before every transfer.  Then you would need to devote another dma
thread to doing nothing but DMASEV (send event) to keep the transfer
going.  The pause could then DMAKILL the event-generating thread
rather than the transfer thread.  I don't know exactly what the
performance impact would be, but it couldn't be good.

The serial driver could be modified to still use dma for TX, since it
only needs pause for RX.  Also, if your serial hardware can report
exactly how many bytes it has sitting in its rx fifo, the serial
driver could be modified to use pause-less dma for RX.  This is
actually what I did for the custom serial hardware I'm using with a
dma-330, although our serial hardware has a very large rx fifo which
makes this scheme worthwhile.
