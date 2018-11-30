Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B71C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F81D20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="S7FtJrI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F81D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeLACj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:39:56 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:23779 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLACjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543591812;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=vx/O4RzewWVBbqwppz8CMgGXMMYyYUTfLOLIKfSFWz4=;
        b=S7FtJrI7bTTvGXLrfkQySDvlb2y/MZgEDQmN+R+4V4G6d2hywnyyjFEFdI6T5F1yEC
        +SbAaqQNxD1rd/4JfPccWiX47eeMSpp8Oi0YNyTI/9l5DETZZz3OnaUAAmUZmfd5GDrf
        094vARj7S3jn8GjCsZa5AjWQrbcUJQTjbzjfGO6iAfNuN/OUFUgNUD+xxNAqkerplCI/
        gcQC7lKy9qZI1NmnPd+LKBCBAw1rdX3TsBkubZaj/jyreuCm/oM2vjkVUkffZC2IKo7B
        LvHMeqmx+LMbXP6UqfKHFg4p0/O1HsxkqsZzz9ZzhhR8HOVP+iwVxok6eF9LcH225aDa
        wQDA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkOhtXRWqPjJ5MV2zvh/ExgOBPpsw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:1876:2ea1:f7b3:289d]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uAUFTeIEo
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 30 Nov 2018 16:29:40 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Darren Stevens <darren@stevens-zone.net>,
        Julian Margetson <runaway@candw.ms>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
 <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
Date:   Fri, 30 Nov 2018 16:29:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181130131056.GA5211@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

Thanks for your reply.

On 30 November 2018 at 2:10PM, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 01:23:20PM +0100, Christian Zigotzky wrote:
>> Yes, of course. I patched your Git kernel and after that I compiled it
>> again. U-Boot loads the kernel and the dtb file. Then the kernel starts but
>> it doesn't find any hard disks (partitions).
> Interesting.  Does it find the storage controller (what kind of
> storage does it use?).
It seems not. I don't see any infos about hard disks in the kernel ring 
buffer. The two serial ATA (SATA 2.0) controllers are integrated in the 
P5020 SoC and the hard disks are connected via SerDes lanes (PCIe) to 
the SoC. LANE 16 = SATA 0 and LANE 17 = SATA 1.
> For the PASEMI board can you test the attached patch?  Also are you
> using Compact Flash cards on that system?
Yes, we are using Compact Flash cards. The slot is wired to the CPU 
local bus. It works with your kernel. :-)

Where is the attached patch?

I downloaded the version 5 of your Git kernel and compiled it today. 
Unfortunately the PASEMI ethernet doesn't work.

Error message: pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0

@All
Could you please also test Christoph's kernel on your PASEMI and NXP boards? Download:

'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'

Thanks,
Christian

