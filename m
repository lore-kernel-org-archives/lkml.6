Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092FBC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE39B218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ojgZ+4lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfA0NNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 08:13:14 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:30862 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfA0NNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 08:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548594792;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=FMQ75Hy5BCOjUBN14zYaKiW4FJiuRF2jN5cnJ7YbwWQ=;
        b=ojgZ+4lE8n6GUekAQyji1unIMR2WqMS36ulXfccr3KQVRawhWB+TXRGBlpmsWqr68Q
        8bf3/8t9GDw7eMaoWJg2/UGOJoFKnJTXYyRMPSob0QInfi9SrgQycr5YN9qM3RYWPF1l
        b+2NNbWbQkoY5/rGB/85U74GadjzyK10tBxNiyk1iVvlI6+QqdDzjDroy6658zk6RXws
        Vs37r9QmXOGzONmCcmzJVhwahf/UsTFdJBN3LGA8GmzkJ/ZK30pgvGvRc+lFUJnA/gGV
        Fx7ln4MTbDtbsfh2eG874xCsYRWXB93JY9VirQEzL0PrtaRIcy5fIAFlwUktpP9dqsUE
        +z3A==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkNjyLlwLU8/n0bu4gMtisxiLYr"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:21ae:8103:d1b3:1b6]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0RDD9xIo
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 27 Jan 2019 14:13:09 +0100 (CET)
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
 <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
Message-ID: <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
Date:   Sun, 27 Jan 2019 14:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

What shall I do next?

Cheers,
Christian


On 25 January 2019 at 2:37PM, Christian Zigotzky wrote:
> Next step just with the first patch: 
> 5c532d07c2f3c3972104de505d06b8d85f403f06 (use powerpc zone selection)
>
> git clone git://git.infradead.org/users/hch/misc.git -b 
> powerpc-dma.6-debug a
>
> git checkout 5c532d07c2f3c3972104de505d06b8d85f403f06
>
> Link to the Git: 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6-debug
>
> Results:
>
> X5000: The kernel detects the SATA hard disk drive and boots without 
> any problems.
>
> X1000: The kernel boots and the P.A. Semi Ethernet works!
>
> -- Christian
>
>
> On 23 January 2019 at 3:34PM, Christian Zigotzky wrote:
>> Hi Christoph,
>>
>> I also compiled a kernel (zImage) for the X1000  from your Git 
>> 'powerpc-dma.6-debug' (both patches) today.
>>
>> It boots and the P.A. Semi Ethernet works!
>>
>> I will test just the first patch tomorrow.
>>
>> Thanks,
>> Christian
>>
>>
>> On 21 January 2019 at 3:38PM, Christian Zigotzky wrote:
>>> Hello Christoph,
>>>
>>> Thanks for your reply. I successfully compiled a kernel (uImage) for 
>>> the X5000 from your Git 'powerpc-dma.6-debug' (both patches) today.
>>>
>>> It detects the SATA hard disk drive and boots without any problems.
>>>
>>
>>
>
>

