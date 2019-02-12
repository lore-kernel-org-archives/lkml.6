Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678ADC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF2F222C8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="EdLf349J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbfBLTu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:50:27 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:16927 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbfBLTu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550001022;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=aUXr1fGv9JuKgZ63EUrQVCOsJ7eDcmZXM8Fg+HWeyds=;
        b=EdLf349J6udPXVvC2ApGV/8PTcdnD1odtBKIqWFnNpgzOWPyZEYaARLsnm4WNN933g
        5UukNMiLKy5Iv4ASFiEn/xwDxYqOjhsh6Gzvu71aIeO7B2Zifn6KCTxgwsREqYdVk4mw
        mroKRzx8+qpaoe4OnCvJ+7WcC/crb/PlYgho7avQhlyF7pHQaPbSJUXuyjePPylxgLr4
        q56j3oiH5O40Mhz7V1CnGkW1IZjbcs3tawa4BBcHUy1jSTw/xLK5A4IJdrbJXi2z/xlt
        DOrQnH+YaX+omQ1NDI48Td+te6jWWZdilQeKhxlr7RmMHqxQsOdIh9xQOfieL0l9T5+I
        AVCg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CldjiKRzWNYwK19ivDpIsfNmMN15w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:b071:4d43:dec6:a483]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv1CJoKRyh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 12 Feb 2019 20:50:20 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
 <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
 <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
 <20190208091818.GA23491@lst.de>
 <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de>
 <20190211073804.GA15841@lst.de>
 <820bfeb1-30c0-3d5a-54a2-c4f9a8c15b0e@xenosoft.de>
 <20190212152543.GA24061@lst.de>
 <47bff9d1-7001-4d92-4ad1-e24215b56555@xenosoft.de>
Message-ID: <f57e6d8f-d43f-e9f8-b092-e43f5019f86f@xenosoft.de>
Date:   Tue, 12 Feb 2019 20:50:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <47bff9d1-7001-4d92-4ad1-e24215b56555@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 February 2019 at 8:31PM, Christian Zigotzky wrote:
> On 12 February 2019 at 4:25PM, Christoph Hellwig wrote:
>> On Tue, Feb 12, 2019 at 01:42:56PM +0100, Christian Zigotzky wrote:
>>> On 11 February 2019 at 08:38AM, Christoph Hellwig wrote:
>>>> On Sun, Feb 10, 2019 at 01:00:20PM +0100, Christian Zigotzky wrote:
>>>>> I tested the whole series today. The kernels boot and the P.A. Semi
>>>>> Ethernet works! :-) Thanks a lot!
>>>>>
>>>>> I also tested it in a virtual e5500 QEMU machine today. 
>>>>> Unfortunately the
>>>>> kernel crashes.
>>>> This looks like a patch I fixed in mainline a while ago, but which
>>>> the powerpc tree didn't have yet.
>>>>
>>>> I've cherry picked this commit
>>>> ("swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit")
>>>>
>>>> and added it to the powerpc-dma.6 tree, please retry with that one.
>>>>
>>> Hello Christoph,
>>>
>>> Have you added it to the powerpc-dma.6 tree yet? The last commit was 
>>> 4 days
>>> ago.
>> I added it, but forgot to push it out.  It is there now, sorry:
>>
>> http://git.infradead.org/users/hch/misc.git/commitdiff/2cf0745b7420af4a3e871d5a970a45662dfae69c 
>>
>>
> Hi Christoph
>
> Many thanks! Your Git kernel works in a virtual e5500 machine now! :-)
>
> I think we have reached the end of testing! All things are working 
> with your DMA updates.
>
> I am looking forward to testing your DMA changes in the next merge 
> window again. :-)
>
> Cheers
> Christian
>
>
Edit: typo

