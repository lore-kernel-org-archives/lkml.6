Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEA0C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73EF20836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="eu3tFqGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfALSPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:15:02 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:14119 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfALSPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547316896;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=tDQUzQaf1uzOW0DjVmQndXv8Oqpitvt6CNmZOymKz/U=;
        b=eu3tFqGkZ/bYouA4YjalYXxASJIppveU9GsCm+1xoohnpa5zrMZyoctu9VZvSIQsDP
        mYX3I990UH4yYv89DwqnEo3kHHfvBfihDjr0JLPCUmDivFYS/5uOSw8oiZn5iNp4FaiF
        fi0gMkZSd/U6CnoCSfY2c8/GK2zt0YaTLgiffEzgN3T24REvzL0xhxE81Fl/UCTrLltr
        5MA4jMDhJG1ag0kR1uFUSknKNAJ+uMg+jmqHqDTCD1/PTSBBJ+1hPAX3k0xGGYQ9Klax
        Rvg1wO63gpLK6SvOZfC5gAFVKKD6ad7mNr7oDI3THxiW7Ne0mtby9CRDxJx7laTfmFjC
        Xq1Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7Claix48Lc7WSXlYG1+kJ2hq5wjkeA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:e5f2:6660:f2b8:db4f]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0CIEseqA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 12 Jan 2019 19:14:54 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
 <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
 <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
 <20181213112511.GA4574@lst.de>
 <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
 <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
 <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
 <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
 <20190103073622.GA24323@lst.de>
 <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <23284859-bf0a-9cd5-a480-2a7fd7802056@xenosoft.de>
Message-ID: <075f70e3-7a4a-732f-b501-05a1a8e3c853@xenosoft.de>
Date:   Sat, 12 Jan 2019 19:14:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <23284859-bf0a-9cd5-a480-2a7fd7802056@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next step: 4558b6e1ddf3dcf5a86d6a5d16c2ac1600c7df39 (swiotlb: remove 
swiotlb_dma_supported)

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout 4558b6e1ddf3dcf5a86d6a5d16c2ac1600c7df39

Output:

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

   git checkout -b <new-branch-name>

HEAD is now at 4558b6e... swiotlb: remove swiotlb_dma_supported

----

Link to the Git: 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6

Results: PASEMI onboard ethernet (X1000) works and the X5000 (P5020 
board) boots. I also successfully tested sound, hardware 3D 
acceleration, Bluetooth, network, booting with a label etc. The uImages 
work also in a virtual e5500 quad-core QEMU machine.

-- Christian


On 11 January 2019 at 03:10AM, Christian Zigotzky wrote:
> Next step: 891dcc1072f1fa27a83da920d88daff6ca08fc02 (powerpc/dma: 
> remove dma_nommu_dma_supported)
>
> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>
> git checkout 891dcc1072f1fa27a83da920d88daff6ca08fc02
>
> Output:
>
> Note: checking out '891dcc1072f1fa27a83da920d88daff6ca08fc02'.
>
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by performing another checkout.
>
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -b with the checkout command again. 
> Example:
>
> git checkout -b <new-branch-name>
>
> HEAD is now at 891dcc1... powerpc/dma: remove dma_nommu_dma_supported
>
> ---
>
> Link to the Git: 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>
> Results: PASEMI onboard ethernet works and the X5000 (P5020 board) 
> boots. I also successfully tested sound, hardware 3D acceleration, 
> Bluetooth, network, booting with a label etc. The uImages work also in 
> a virtual e5500 quad-core QEMU machine.
>
> -- Christian
>
>
> On 09 January 2019 at 10:31AM, Christian Zigotzky wrote:
>> Next step: a64e18ba191ba9102fb174f27d707485ffd9389c (powerpc/dma: 
>> remove dma_nommu_get_required_mask)
>>
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>
>> git checkout a64e18ba191ba9102fb174f27d707485ffd9389c
>>
>> Link to the Git: 
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>>
>> Results: PASEMI onboard ethernet works and the X5000 (P5020 board) 
>> boots. I also successfully tested sound, hardware 3D acceleration, 
>> Bluetooth, network, booting with a label etc. The uImages work also 
>> in a virtual e5500 quad-core QEMU machine.
>>
>> -- Christian
>>
>>
>> On 05 January 2019 at 5:03PM, Christian Zigotzky wrote:
>>> Next step: c446404b041130fbd9d1772d184f24715cf2362f (powerpc/dma: 
>>> remove dma_nommu_mmap_coherent)
>>>
>>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>>
>>> git checkout c446404b041130fbd9d1772d184f24715cf2362f
>>>
>>> Output:
>>>
>>> Note: checking out 'c446404b041130fbd9d1772d184f24715cf2362f'.
>>>
>>> You are in 'detached HEAD' state. You can look around, make 
>>> experimental
>>> changes and commit them, and you can discard any commits you make in 
>>> this
>>> state without impacting any branches by performing another checkout.
>>>
>>> If you want to create a new branch to retain commits you create, you 
>>> may
>>> do so (now or later) by using -b with the checkout command again. 
>>> Example:
>>>
>>>   git checkout -b <new-branch-name>
>>>
>>> HEAD is now at c446404... powerpc/dma: remove dma_nommu_mmap_coherent
>>>
>>> -----
>>>
>>> Link to the Git: 
>>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>>>
>>> Result: PASEMI onboard ethernet works and the X5000 (P5020 board) 
>>> boots.
>>>
>>> -- Christian
>>>
>>
>>
>
>

