Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158A7C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73582087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="QNbj4pxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfASLw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 06:52:57 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:19063 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfASLw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 06:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547898774;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=vARq1cGS//INRMMLH9lnSOofzwKkiFX8otQWVQoOaRU=;
        b=QNbj4pxNCqN5PoOE2hcvj7FOPj5QDiGqqUUDHvIf3SL4Q+njsAQ35zTgT3vM5ePsIo
        Ki0QTdlp9jKPWyiOVAHMeWq/UoKpBVyWLWI+aTn3Dh4XZRIA4QeqZ7XId3/y5hqPjuCN
        sAHeqdJLJSK1rQhcgWCVydTbwM2bTLiG5uwV9fLVF4p/LpticCKJYL1fuY+xh9tDWV1w
        wlqxGM4oJEW3cqn9DgNcK5iJsjpjvf+aTodcwixKyDY9zT6rww2bb5mfxz2D4kDU4nzO
        DKW6b8ojIk8cNtTZkHI0ZQ/f7QlH2LSUUkp5zmakFO3OcuZ/MoDCXiZ8wN2xqaDJd4YP
        k9fw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkL2i4gEPjvTsV+g6fCctWoeoah8A=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:4dec:9113:8f36:c6c8]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0JBqrDGy
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 19 Jan 2019 12:52:53 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <20190115133558.GA29225@lst.de>
 <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de>
 <20190115151732.GA2325@lst.de>
 <e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de>
 <20190118083539.GA30479@lst.de>
 <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de>
 <20190118112842.GA9115@lst.de>
 <a2ca0118-5915-8b1c-7cfa-71cb4b43eaa6@xenosoft.de>
 <20190118121810.GA13327@lst.de>
 <eceebeda-0e18-00f6-06e7-def2eb0aa961@xenosoft.de>
 <20190118125500.GA15657@lst.de>
 <e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de>
 <f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de>
Message-ID: <b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de>
Date:   Sat, 19 Jan 2019 12:52:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I have found a small workaround. If I add 'mem=3500M' to the boot 
arguments then it detects the SATA hard disk and boots without any problems.

X5000> setenv bootargs root=/dev/sda2 console=ttyS0,115200 mem=3500M

Cheers,
Christian


On 19 January 2019 at 12:40PM, Christian Zigotzky wrote:
> Hi Christoph,
>
> I bought a USB null modem RS-232 serial cable today so I was able to 
> get some SATA error messages.
>
> Error messages:
>
> [   13.468538] fsl-sata ffe220000.sata: Sata FSL Platform/CSB Driver init
> [   13.475106] fsl-sata ffe220000.sata: failed to start port 0 
> (errno=-12)
> [   13.481736] fsl-sata ffe221000.sata: Sata FSL Platform/CSB Driver init
> [   13.488267] fsl-sata ffe221000.sata: failed to start port 0 
> (errno=-12)
>
> ---
>
> errno=-12 = Out of memory
>
> Please find attached the complete serial log.
>
> Cheers,
> Christian
>
>
> On 18 January 2019 at 4:06PM, Christian Zigotzky wrote:
>> Hello Christoph,
>>
>> I was able to compile 257002094bc5935dd63207a380d9698ab81f0775 from 
>> your Git powerpc-dma.6-debug today.
>>
>> Unfortunately I don't see any error messages (kernel ring buffer) and 
>> I don't have a RS232 serial null modem cable to get them.
>>
>> Cheers,
>> Christian
>>
>>
>

