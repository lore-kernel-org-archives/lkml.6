Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB7C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3B8218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="FOWgqOyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfAYNhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:37:42 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:29397 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfAYNhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548423457;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=UmGrSh3HW81+8ei0ZJ15vFrgG8Ck0j0HDo+KWJhWFtQ=;
        b=FOWgqOygrTKJ1HWz1YaiMLA92+9r2NNywCmup+UZIBciKfM5iBjvbrWGsjIR0jxw5F
        yrsT1YzAVB7SgNk0X/DIs9tRvrLoD61B6oIooRZV8TDx3+CF5K5CwQ1uLZ4dWHilHM/Y
        +mgfy/N026+fV29g11tE7+LRpP1yWnQCy0aUBB2s1qdIvtoeHLSiJ0HQaG6pE1TxfDOu
        hgLd6XqzGkX10796Tbv0NLUJ1Ne4q+RPwWOQvLPC28x1eOkLJY3oeBkQIbrjXMz1juSa
        Ss0iNWIGx7t4SKlZCWSsxluHSsCWYE7CfvqAkJqGwghnywAO0hTmGcxLI4ll2CqdLQWd
        Lt/g==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7Clbj+Y6aWfN4m/uBgDVMNZwSoB2jA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:d1fc:fd20:acd8:d691]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0PDbYp1h
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 25 Jan 2019 14:37:34 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de>
 <20190118112842.GA9115@lst.de>
 <a2ca0118-5915-8b1c-7cfa-71cb4b43eaa6@xenosoft.de>
 <20190118121810.GA13327@lst.de>
 <eceebeda-0e18-00f6-06e7-def2eb0aa961@xenosoft.de>
 <20190118125500.GA15657@lst.de>
 <e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de>
 <f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de>
 <b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de>
 <20190119130222.GA24346@lst.de> <20190119140452.GA25198@lst.de>
 <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
 <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de>
Message-ID: <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
Date:   Fri, 25 Jan 2019 14:37:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next step just with the first patch: 
5c532d07c2f3c3972104de505d06b8d85f403f06 (use powerpc zone selection)

git clone git://git.infradead.org/users/hch/misc.git -b 
powerpc-dma.6-debug a

git checkout 5c532d07c2f3c3972104de505d06b8d85f403f06

Link to the Git: 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6-debug

Results:

X5000: The kernel detects the SATA hard disk drive and boots without any 
problems.

X1000: The kernel boots and the P.A. Semi Ethernet works!

-- Christian


On 23 January 2019 at 3:34PM, Christian Zigotzky wrote:
> Hi Christoph,
>
> I also compiled a kernel (zImage) for the X1000  from your Git 
> 'powerpc-dma.6-debug' (both patches) today.
>
> It boots and the P.A. Semi Ethernet works!
>
> I will test just the first patch tomorrow.
>
> Thanks,
> Christian
>
>
> On 21 January 2019 at 3:38PM, Christian Zigotzky wrote:
>> Hello Christoph,
>>
>> Thanks for your reply. I successfully compiled a kernel (uImage) for 
>> the X5000 from your Git 'powerpc-dma.6-debug' (both patches) today.
>>
>> It detects the SATA hard disk drive and boots without any problems.
>>
>
>

