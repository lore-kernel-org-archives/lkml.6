Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A1DC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A8A217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="bixB7zuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfBCQtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:49:07 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:13964 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfBCQtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549212544;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=B6q2ei1aHR9lzl0hOvwoWBIVmVDE9nFvmFewblIeLYs=;
        b=bixB7zuOhTATsaIoNYVyAvL80EbHiP68do1aQrBB0hTpHGo8r/0MVVtTNIRP5EfLPR
        UjrE52ihdpL7t+ey7mTpoWM5eiOcv2yVPmW++AF8VhCokjFQhQbM2aHXz/4LxrrX/Yd+
        UioiczPjm8Y9qzFhJiLN1kTItMKx5CB/W0MfucUUYC+KfWvVFurHUtplMfstM6DjOpUX
        iWgbRNpW/Q3d1u2zCLLzkwDJBkayqexU4ZAD9iTKL0F9yLUWhSF/IVLZAbONSJFuudbH
        O5IoqaOb0Saga6HI0hi4NdtLOJFgsQQ0b4sRP+SJKCDxuoosYEGDtvMUx0J0L3H7urEI
        GoRw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkH3W0cWmG9fyXgS4bddBxLVsnYjg=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:8c9a:b0b5:e3d3:9527]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv13Gn2cCf
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 3 Feb 2019 17:49:02 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
 <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
 <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de>
 <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
 <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
 <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de>
 <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
 <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
 <20190201080456.GA15456@lst.de>
 <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
Message-ID: <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
Date:   Sun, 3 Feb 2019 17:49:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, next step: b50f42f0fe12965ead395c76bcb6a14f00cdf65b (powerpc/dma: 
use the dma_direct mapping routines)

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout b50f42f0fe12965ead395c76bcb6a14f00cdf65b

Results: The X1000 and X5000 boot but unfortunately the P.A. Semi 
Ethernet doesn't work.

-- Christian


On 01 February 2019 at 5:54PM, Christian Zigotzky wrote:
> Hi Christoph,
>
> I will try it at the weekend.
>
> Thanks,
> Christian
>
> Sent from my iPhone
>
>> On 1. Feb 2019, at 09:04, Christoph Hellwig <hch@lst.de> wrote:
>>
>>> On Thu, Jan 31, 2019 at 01:48:26PM +0100, Christian Zigotzky wrote:
>>> Hi Christoph,
>>>
>>> I compiled kernels for the X5000 and X1000 from your branch 'powerpc-dma.6'
>>> today.
>>>
>>> Gitweb:
>>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>>>
>>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>>
>>> The X1000 and X5000 boot but unfortunately the P.A. Semi Ethernet doesn't
>>> work.
>> Oh.  Can you try with just the next one and then two patches applied
>> over the working setup?  That is first:
>>
>> http://git.infradead.org/users/hch/misc.git/commitdiff/b50f42f0fe12965ead395c76bcb6a14f00cdf65b
>>
>> then also with:
>>
>> http://git.infradead.org/users/hch/misc.git/commitdiff/21fe52470a483afbb1726741118abef8602dde4d


