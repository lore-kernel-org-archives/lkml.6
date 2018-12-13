Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49702C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DF120870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="q0u4GJ+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DF120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeLMVxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:53:55 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:13353 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMVxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544738030;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ZKqclJmHoMKJBmhJti9Mhv0VswdREJZBNmEoAQY3cxc=;
        b=q0u4GJ+Mm2VlI1zhZtp/6ydPbWSohzhaWO9izmUWCLwUZFgfIYU4Si5evRKnXBpU/R
        e3/7l9eLN6KpBt2NJG8k1BFQFXwqxa2q1Z62P5hg5RVBgXFv1zEOdTQdNGu4VU5ayKUG
        swIwFWAd+llMatGMGgWzqcSsMWEjdumZtRHCSaP/YvwckyxaDNePtEIpUep01bSIuhqP
        Bq9bQLxwJw7sZ23NreW3xgbx40eLQ81nEM75x0LbPUwcK6J9fOMLnjqayKsTl6j2eZwg
        M7iqQSPLCMAvNzFZ+ALr/AQ9cUXNqvsizh/pz5x+UroRKmnexQ2gzvtkIBLjApiDtyho
        BF+Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkN3cZasVJIwxL1+pu11P25ZgVYiw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:2c23:64bc:d5e2:ce82]
        by smtp.strato.de (RZmta 44.8 AUTH)
        with ESMTPSA id e03c1euBDLrl4TC
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 13 Dec 2018 22:53:47 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
 <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
 <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
 <20181212141556.GA4801@lst.de>
 <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
 <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
 <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
 <20181213112511.GA4574@lst.de>
 <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
 <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
Message-ID: <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
Date:   Thu, 13 Dec 2018 22:53:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 December 2018 at 6:48PM, Christian Zigotzky wrote:
> On 13 December 2018 at 2:34PM, Christian Zigotzky wrote:
>> On 13 December 2018 at 12:25PM, Christoph Hellwig wrote:
>>> On Thu, Dec 13, 2018 at 12:19:26PM +0100, Christian Zigotzky wrote:
>>>> I tried it again but I get the following error message:
>>>>
>>>> MODPOST vmlinux.o
>>>> arch/powerpc/kernel/dma-iommu.o: In function 
>>>> `.dma_iommu_get_required_mask':
>>>> (.text+0x274): undefined reference to `.dma_direct_get_required_mask'
>>>> make: *** [vmlinux] Error 1
>>> Sorry, you need this one liner before all the patches posted last time:
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index d8819e3a1eb1..7e78c2798f2f 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -154,6 +154,7 @@ config PPC
>>>       select CLONE_BACKWARDS
>>>       select DCACHE_WORD_ACCESS        if PPC64 && CPU_LITTLE_ENDIAN
>>>       select DYNAMIC_FTRACE            if FUNCTION_TRACER
>>> +    select DMA_DIRECT_OPS
>>>       select EDAC_ATOMIC_SCRUB
>>>       select EDAC_SUPPORT
>>>       select GENERIC_ATOMIC64            if PPC32
>>>
>> Thanks. Result: PASEMI onboard ethernet works and the X5000 (P5020 
>> board) boots with the patch '0001-get_required_mask.patch'.
>>
>> -- Christian
>>
>>
> Next patch: '0002-swiotlb-dma_supported.patch' for the last good 
> commit (977706f9755d2d697aa6f45b4f9f0e07516efeda).
>
> The PASEMI onboard ethernet works and the X5000 (P5020 board) boots.
>
> -- Christian
>
>
Next patch: '0003-nommu-dma_supported.patch'

No problems with the PASEMI onboard ethernet and the P5020 board boots.

-- Christian

