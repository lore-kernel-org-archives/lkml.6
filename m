Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932595AbeBLWNS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:13:18 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:53526 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932454AbeBLWNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:13:17 -0500
Subject: Re: [PATCH v2 5/5] ALSA: emu10k1: add a IOMMU workaround
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <13361c4f-6203-8d83-d6c3-1e150224be49@maciej.szmigiero.name>
 <s5hfu665ptx.wl-tiwai@suse.de>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <b146a1cb-a1c9-442c-149d-b0d2a017f719@maciej.szmigiero.name>
Date: Mon, 12 Feb 2018 23:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <s5hfu665ptx.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.2018 13:56, Takashi Iwai wrote:
> On Sat, 27 Jan 2018 15:42:59 +0100,
>  Maciej S. Szmigiero  wrote:
>>
>> The Audigy 2 CA0102 chip (but most likely others from the emu10k1 family,
>> too) has a problem that from time to time it likes to do few DMA reads a
>> bit beyond its normal allocation and gets very confused if these reads get
>> blocked by a IOMMU.
>>
>> For the first (reserved) page this happens multiple times at every
>> playback, for various synth pages it happens randomly, rarely for PCM
>> playback buffers and the page table memory itself.
>> All these reads seem to follow a similar pattern, observed read offsets
>> beyond the allocation end were 0x00, 0x40, 0x80 and 0xc0 (PCI cache line
>> multiples), so it looks like the device tries to accesses up to 256 extra
>> bytes.
>>
>> As a workaround let's widen these DMA allocations by an extra page if we
>> detect that the device is behind a non-passthrough IOMMU (the DMA memory
>> should be relatively plenty on IOMMU systems).
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> ---
>> Changes from v1: Apply this workaround also to PCM playback buffers since
>> it seems they are affected, too.
> 
> Instead of adjusting the allocation size in the caller side, how about
> adding a new helper to wrap around the call of snd_dma_alloc_pages()?
> 
> We may need a counterpart to free pages in synth, but it's a single
> place in __synth_free_pages(), so it can be open-coded with some
> proper comments, too.

I guess you mean adding a new wrapper to the ALSA core somewhere near
snd_dma_alloc_pages() (something named like
snd_dma_dev_alloc_pages_maybe_wider() ?).

Since snd_dma_alloc_pages() currently takes only a "struct device"
per-device parameter we wouldn't have a place to store a flag indicating
whether a device needs this workaround (or not) so we would need to
detect it every time this wrapper function gets called - in contrast,
in the current implementation this is done just once at the device
initialization time in snd_emu10k1_detect_iommu().

There are only 3 allocations that use snd_dma_alloc_pages() in this
driver that would use this new wrapper function, and each time the
overhead is just a two-line "if" block.
If one excludes synth, since it already uses a helper function to
compute these allocations lengths, that count lowers to only 2 places.

That's why I think a driver-local change here is enough.

Also, there is always a possibility to refactor the code into a common
helper if it turns out that there are other sound card with the same
problem.

> 
> thanks,
> 
> Takashi

Thanks,
Maciej
