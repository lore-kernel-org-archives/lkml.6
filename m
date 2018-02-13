Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966047AbeBMXEZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:04:25 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:52408 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965942AbeBMXEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:04:24 -0500
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v2 5/5] ALSA: emu10k1: add a IOMMU workaround
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <13361c4f-6203-8d83-d6c3-1e150224be49@maciej.szmigiero.name>
 <s5hfu665ptx.wl-tiwai@suse.de>
 <b146a1cb-a1c9-442c-149d-b0d2a017f719@maciej.szmigiero.name>
 <s5hlgfx4h6m.wl-tiwai@suse.de>
Message-ID: <18d5ec58-08b6-b334-bcf6-8b8a06a15795@maciej.szmigiero.name>
Date: Wed, 14 Feb 2018 00:04:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <s5hlgfx4h6m.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2018 06:00, Takashi Iwai wrote:
> On Mon, 12 Feb 2018 23:13:13 +0100,
> Maciej S. Szmigiero wrote:
>>
>> On 12.02.2018 13:56, Takashi Iwai wrote:
>>> On Sat, 27 Jan 2018 15:42:59 +0100,
>>>  Maciej S. Szmigiero  wrote:
>>>>
>>>> The Audigy 2 CA0102 chip (but most likely others from the emu10k1 family,
>>>> too) has a problem that from time to time it likes to do few DMA reads a
>>>> bit beyond its normal allocation and gets very confused if these reads get
>>>> blocked by a IOMMU.
>>>>
>>>> For the first (reserved) page this happens multiple times at every
>>>> playback, for various synth pages it happens randomly, rarely for PCM
>>>> playback buffers and the page table memory itself.
>>>> All these reads seem to follow a similar pattern, observed read offsets
>>>> beyond the allocation end were 0x00, 0x40, 0x80 and 0xc0 (PCI cache line
>>>> multiples), so it looks like the device tries to accesses up to 256 extra
>>>> bytes.
>>>>
>>>> As a workaround let's widen these DMA allocations by an extra page if we
>>>> detect that the device is behind a non-passthrough IOMMU (the DMA memory
>>>> should be relatively plenty on IOMMU systems).
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>>>> ---
>>>> Changes from v1: Apply this workaround also to PCM playback buffers since
>>>> it seems they are affected, too.
>>>
>>> Instead of adjusting the allocation size in the caller side, how about
>>> adding a new helper to wrap around the call of snd_dma_alloc_pages()?
>>>
>>> We may need a counterpart to free pages in synth, but it's a single
>>> place in __synth_free_pages(), so it can be open-coded with some
>>> proper comments, too.
>>
>> I guess you mean adding a new wrapper to the ALSA core somewhere near
>> snd_dma_alloc_pages() (something named like
>> snd_dma_dev_alloc_pages_maybe_wider() ?).
> 
> Well, not a common code but emu10k1 specific, something like
> 
> int snd_emu10k1_alloc_pages_maybe_wider(emu, size, res)
> {
> 	if (emu->iommu_workaround)
> 		size += PAGE_SIZE;
> 	return snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
> 			snd_dma_pci_data(emu->pci), size, res);
> }

Okay, I have added a function like the one above to the driver and
used it instead to make the relevant allocations.

> Also, I wonder what if PAGE_SIZE is over 4k.  In that case, we don't
> necessarily need to increase the size, if the allocated size is larger
> than the requested one?  But iommu_workaround is likely only about
> x86, so we don't need to care about it much, I guess.

For completeness, I have added a check to the allocation function
described above whether rounding the allocation size up to the nearest
page size already covers the necessary extra memory space.

> 
> Takashi
> 

Maciej
