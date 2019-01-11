Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FD5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7214A20675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfAKGJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:09:26 -0500
Received: from icp-osb-irony-out2.external.iinet.net.au ([203.59.1.155]:32885
        "EHLO icp-osb-irony-out2.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728042AbfAKGJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:09:25 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AEAADaMThc/zXSMGcNVxkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEHAQEBAQEBgVQBAQEBAQELAYJpgSmEAYN7khuZdTKERwKCRzcGDQE?=
 =?us-ascii?q?DAQEBAQEBAoEJhVYBAQEBAgEjFUEQCw0BCgICJgICVwYNCAEBgx4BgWgBEBe?=
 =?us-ascii?q?sS3GBLxqEFAGBE4RtgQuBc4lYgUA/gREngmuDBYFVgzCCVwKLUoRukTsJgQS?=
 =?us-ascii?q?BKoRsimMeiiwDh04tjlGILIUVgXgzGh+DQQiLFIVRYQmIAIJNAQE?=
X-IPAS-Result: =?us-ascii?q?A2AEAADaMThc/zXSMGcNVxkBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QEBgVQBAQEBAQELAYJpgSmEAYN7khuZdTKERwKCRzcGDQEDAQEBAQEBAoEJh?=
 =?us-ascii?q?VYBAQEBAgEjFUEQCw0BCgICJgICVwYNCAEBgx4BgWgBEBesS3GBLxqEFAGBE?=
 =?us-ascii?q?4RtgQuBc4lYgUA/gREngmuDBYFVgzCCVwKLUoRukTsJgQSBKoRsimMeiiwDh?=
 =?us-ascii?q?04tjlGILIUVgXgzGh+DQQiLFIVRYQmIAIJNAQE?=
X-IronPort-AV: E=Sophos;i="5.56,464,1539619200"; 
   d="scan'208";a="178029546"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out2.iinet.net.au with ESMTP; 11 Jan 2019 14:09:19 +0800
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
To:     Christoph Hellwig <hch@lst.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>, ashutosh.dixit@intel.com,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181214082515.14835-1-hch@lst.de>
 <20181214082515.14835-2-hch@lst.de>
 <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com>
 <20181214114719.GA3316@lst.de>
 <5ae55118-6858-9121-6b3e-9b19b41550ef@westnet.com.au>
 <20181217115931.GA6853@lst.de>
From:   Greg Ungerer <gregungerer@westnet.com.au>
Message-ID: <cde0e0cd-1eb7-77e2-cc65-939c94a76f4c@westnet.com.au>
Date:   Fri, 11 Jan 2019 16:09:19 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217115931.GA6853@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 17/12/18 9:59 pm, Christoph Hellwig wrote:
> On Sat, Dec 15, 2018 at 12:14:29AM +1000, Greg Ungerer wrote:
>> Yep, that is right. Certainly the MMU case is broken. Some noMMU cases work
>> by virtue of the SoC only having an instruction cache (the older V2 cores).
> 
> Is there a good an easy case to detect if a core has a cache?  Either
> runtime or in Kconfig?
> 
>> The MMU case is fixable, but I think it will mean changing away from
>> the fall-back virtual:physical 1:1 mapping it uses for the kernel address
>> space. So not completely trivial. Either that or a dedicated area of RAM
>> for coherent allocations that we can mark as non-cachable via the really
>> course grained and limited ACR registers - not really very appealing.
> 
> What about CF_PAGE_NOCACHE?  Reading arch/m68k/include/asm/mcf_pgtable.h
> suggest this would cause an uncached mapping, in which case something
> like this should work:
> 
> 	http://git.infradead.org/users/hch/misc.git/commitdiff/4b8711d436e8d56edbc5ca19aa2be639705bbfef

No, that won't work.

The current MMU setup for ColdFire relies on a quirk of the cache
control subsystem to map kernel mapping (actually all of RAM when
accessed in supervisor mode).

The effective address calculation by the CPU/MMU firstly checks
the RAMBAR access, then

 From the ColdFire 5475 Reference Manual (section 5.5.1):

   If virtual mode is enabled, any normal mode access that does not hit in the MMUBAR,
   RAMBARs, ROMBARs, or ACRs is considered a normal mode virtual address request and
   generates its access attributes from the MMU. For this case, the default CACR address attributes
   are not used.

The MMUBAR is the MMU control registers, the RAMBAR/ROMBAR are the
internal static RAM/ROM regions and the ACR are the cache control
registers. The code in arch/m68k/coldfire/head.S sets up the ACR
registers so that all of RAM is accessible and cached when in supervisor
mode. So kernel code and data accesses will hit this and use the
address for access. User pages won't hit this and will go through to
hit the MMU mappings.

The net out is we don't need page mappings or use TLB entries
for kernel code/data. The problem is we also can't map individual
regions as not cached for coherent allocations... The ACR mapping
means all-or-nothing.

This leads back to what I mentioned earlier about changing the
VM mapping to not use the ACR mapping method and actually page
mapping the kernel space. Not completely trivial and I expect
there will be a performance hit with the extra TLB pressure and
their setup/remapping overhead.


>> The noMMU case in general is probably limited to something like that same
>> type of dedicated RAM/ACR register mechamism.
>>
>> The most commonly used periperal with DMA is the FEC ethernet module,
>> and it has some "special" (used very loosely) cache flushing for
>> parts like the 532x family which probably makes it mostly work right.
>> There is a PCI bus on the 54xx family of parts, and I know general
>> ethernet cards on it (like e1000's) have problems I am sure are
>> related to the fact that coherent memory allocations aren't.
> 
> If we really just care about FEC we can just switch it do use
> DMA_ATTR_NON_CONSISTENT and do explicit cache flushing.  But as far
> as I can tell FEC only uses DMA coherent allocations for the TSO
> headers anyway, is TSO even used on this SOC?

The FEC is the most commonly used, but not the only. I test generic PCI
NICs on the PCI bus on the ColdFire 5475 - and a lot of those drivers
rely on coherent allocations.

Regards
Greg


