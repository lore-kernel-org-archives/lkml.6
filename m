Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B18C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9082184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="LEGTgjPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfA2PDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:03:42 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:34146 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfA2PDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548774215;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=54BYA5R8WWU/JT6uen3I6PSN41rOBysT9ibhJ3C66mE=;
        b=LEGTgjPDj+uqN/ZTYe+VfKg+E5czafCq5fCPFeZHlHPtwgNeJ9ra4J2o0co+Mrvhw5
        iZent/CjqJ2qxsHOPd7MBxxaNXMvbM/w3EcFTWJduJJmo7MTYRZyFj5uAM0jDdZZhDD+
        gQdPR3/bF0DLVjnTEdtsaL20ccJhBSnX/WDqCxDMle7H2qmkgOg1bXROjhez+qj0/u+s
        Ipud+B/1mY3BJxF5y0mLGBk55jPOCGgWcsMv51D+NZBI1TgLEsWVHDuHECIQT4axb9zw
        Q5lWhKD3sdOPq9B/L98HYbgNwDg3Ef+qRvHtAM6UZAzNpNe3Slwl69wf3bQ/5GZ1nR0b
        CQtA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkMj7d8MwbIAsOkSwoB8cVrNHNchA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:31f7:8c35:dc40:528c]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0TF3XAMu
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 29 Jan 2019 16:03:33 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de>
 <f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de>
 <b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de>
 <20190119130222.GA24346@lst.de> <20190119140452.GA25198@lst.de>
 <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
 <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de>
 <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
 <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
 <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de>
 <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
Message-ID: <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
Date:   Tue, 29 Jan 2019 16:03:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I compiled kernels for the X5000 and X1000 from your new branch 
'powerpc-dma.6-debug.2' today. The kernels boot and the P.A. Semi 
Ethernet works!

Cheers,
Christian


On 28 January 2019 at 5:52PM, Christian Zigotzky wrote:
> Thanks a lot! I will test it tomorrow.
>
> — Christian
>
> Sent from my iPhone
>
>> On 28. Jan 2019, at 17:22, Christoph Hellwig <hch@lst.de> wrote:
>>
>>> On Mon, Jan 28, 2019 at 08:04:22AM +0100, Christoph Hellwig wrote:
>>>> On Sun, Jan 27, 2019 at 02:13:09PM +0100, Christian Zigotzky wrote:
>>>> Christoph,
>>>>
>>>> What shall I do next?
>>> I'll need to figure out what went wrong with the new zone selection
>>> on powerpc and give you another branch to test.
>> Can you try the new powerpc-dma.6-debug.2 branch:
>>
>>     git://git.infradead.org/users/hch/misc.git powerpc-dma.6-debug.2
>>
>> Gitweb:
>>
>>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6-debug.2
>

