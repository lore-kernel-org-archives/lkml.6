Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756587AbeDFOCv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:02:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:62677 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbeDFOCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:02:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="30630502"
Subject: Re: x86/dma conversion for v4.17-rc1 breaks sound / sst-acpi (commit
 6e4bf5867783)
To: Mark Brown <broonie@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: hch@lst.de, thomas.lendacky@amd.com, tglx@linutronix.de,
        dwmw2@infradead.org, joro@8bytes.org, jdmason@kudzu.us,
        konrad.wilk@oracle.com, torvalds@linux-foundation.org, mulix@mulix.org,
        peterz@infradead.org, iommu@lists.linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, Vinod Koul <vinod.koul@intel.com>
References: <20180405205657.GA1788@light.dominikbrodowski.net>
 <20180406011418.GE12349@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <700ea637-3c58-5cbf-a7ac-fc242172acd9@linux.intel.com>
Date: Fri, 6 Apr 2018 09:02:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406011418.GE12349@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2018 08:14 PM, Mark Brown wrote:
> On Thu, Apr 05, 2018 at 10:56:57PM +0200, Dominik Brodowski wrote:
>> Christoph,
>>
>> unfortunately, commit 6e4bf5867783 breaks sound on my Dell XPS13, see the
>> dmesg diff between fec777c385b6 and 6e4bf5867783:
> Adding Vinod and Pierre from Intel in case they have any ideas here.
> Which model of XPS13 is this (2015?)?
No clear idea, but this patch is odd. It claims to replace a dma_ops 
structure by an equivalent one but the
callbacks for alloc/free are different.

-void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-                    dma_addr_t *dma_handle, gfp_t flags,
-                    unsigned long attrs)
-{
-    void *vaddr;
-
-    /*
-     * Don't print a warning when the first allocation attempt fails.
-     * swiotlb_alloc_coherent() will print a warning when the DMA
-     * memory allocation ultimately failed.
-     */
-    flags |= __GFP_NOWARN;
-
-    vaddr = dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
-    if (vaddr)
-        return vaddr;
-
-    return swiotlb_alloc_coherent(hwdev, size, dma_handle, flags);
-}
-
-void x86_swiotlb_free_coherent(struct device *dev, size_t size,
-                      void *vaddr, dma_addr_t dma_addr,
-                      unsigned long attrs)
-{
-    if (is_swiotlb_buffer(dma_to_phys(dev, dma_addr)))
-        swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-    else
-        dma_direct_free(dev, size, vaddr, dma_addr, attrs);
-}

>
>> -sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
>> -haswell-pcm-audio haswell-pcm-audio: Direct firmware load for intel/IntcPP01.bin failed with error -2
>> -haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP01.bin not available(-2)
>> -haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
>> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mapping ok
>> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapping ok
>> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapping ok
>> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapping ok
>> -broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mapping ok
>> -input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwell-audio/sound/card1/input15
>> +broadwell-audio broadwell-audio: ASoC: CPU DAI System Pin not registered
>> So it seems that sst-acpi is unhappy with this patch. Any ideas?
>> Thanks,
>> 	Dominik
