Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EA8C6783B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3235C20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="SA4/BJa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3235C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeLJPyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:54:12 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:35585 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeLJPyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544457248;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=k5FlvYtcZbSWgNfy/0RzHE9EWAGcRRevSBSK6Qhcyrc=;
        b=SA4/BJa6wvOIzPLwLdFiszo58WEHa11tKGMImayiTMqDTxCmU/cEOi9GiQ8+abEcF8
        YJLlak3sqNceTT8FvHAMr0T9KNmvAZyGun5Cu+VZpPELtl2SjEZ4tvpiROPY3pdpYCum
        bQ/6JbzpysMl7F6ULvY3zNEq4d74XPc6dEr1RFsA31/p/SoKQEUBCTCajRUWjrEX7Kcc
        cbt87gVOLjqzCwhg5QKHT1T4zo+2VkjyaAUZ2oo/GMBbLc+zcTdP6XR83FEdMX5lImt4
        Djc6KJGv2HxGoYwa6i9m9oeYVW3Qk7Luf11SgzPdLK1YErjcDYqviZqsXRBWGBwrgBi3
        eWVg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkHhsM1Qi/lCjFQQnjJrDVy2NR8hA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:887e:d9eb:b687:95ab]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uBAFs55if
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 10 Dec 2018 16:54:05 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
 <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
 <20181204142426.GA2743@lst.de>
 <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
 <20181205140550.GA27549@lst.de>
 <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
 <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
 <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
 <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
 <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
 <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de>
 <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
Message-ID: <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
Date:   Mon, 10 Dec 2018 16:54:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next step: 64ecd2c160bbef31465c4d34efc0f076a2aad4df (powerpc/dma: use 
phys_to_dma instead of get_dma_offset)

The P5020 board boots and the PASEMI onboard ethernet works.

-- Christian


On 09 December 2018 at 7:26PM, Christian Zigotzky wrote:
> Next step: c1bfcad4b0cf38ce5b00f7ad880d3a13484c123a (dma-mapping, 
> powerpc: simplify the arch dma_set_mask override)
>
> Result: No problems with the PASEMI onboard ethernet and with booting 
> the X5000 (P5020 board).
>
> -- Christian
>
>
> On 09 December 2018 at 3:20PM, Christian Zigotzky wrote:
>> Next step: 602307b034734ce77a05da4b99333a2eaf6b6482 (powerpc/fsl_pci: 
>> simplify fsl_pci_dma_set_mask)
>>
>> git checkout 602307b034734ce77a05da4b99333a2eaf6b6482
>>
>> The PASEMI onboard ethernet works and the X5000 boots.
>>
>> -- Christian
>>
>>
>> On 08 December 2018 at 2:47PM, Christian Zigotzky wrote:
>>> Next step: e15cd8173ef85e9cc3e2a9c7cc2982f5c1355615 (powerpc/dma: 
>>> fix an off-by-one in dma_capable)
>>>
>>> git checkout e15cd8173ef85e9cc3e2a9c7cc2982f5c1355615
>>>
>>> The PASEMI onboard ethernet also works with this commit and the 
>>> X5000 boots without any problems.
>>>
>>> -- Christian
>>>
>>>
>>> On 08 December 2018 at 11:29AM, Christian Zigotzky wrote:
>>>> Next step: 7ebc44c535f6bd726d553756d38b137acc718443 (powerpc/dma: 
>>>> remove max_direct_dma_addr)
>>>>
>>>> git checkout 7ebc44c535f6bd726d553756d38b137acc718443
>>>>
>>>> OK, the PASEMI onboard ethernet works and the P5020 board boots.
>>>>
>>>> -- Christian
>>>>
>>>>
>>>> On 07 December 2018 at 7:33PM, Christian Zigotzky wrote:
>>>>> Next step: 13c1fdec5682b6e13257277fa16aa31f342d167d (powerpc/dma: 
>>>>> move pci_dma_dev_setup_swiotlb to fsl_pci.c)
>>>>>
>>>>> git checkout 13c1fdec5682b6e13257277fa16aa31f342d167d
>>>>>
>>>>> Result: The PASEMI onboard ethernet works and the P5020 board boots.
>>>>>
>>>>> — Christian
>>>>
>>>>
>>>>
>>>
>>>
>>
>>
>
>

