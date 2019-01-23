Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D249C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299BE2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="k96/f6G2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfAWOfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:35:04 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:15318 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfAWOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548254099;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yJnRdupOAZFXzlPR7YQoD+/EPzdEL/IZ9rZjQvP1r+M=;
        b=k96/f6G2rv8Tnf7giC8IAMp6brZ2U8WUKFD9zhx1olGyLpf7S4XvO8xk/zZXfvTnGe
        uzQBxRXRjEU3Yo6z5qh0CjJGc+UsQbogKG/4G3WZJQdgna33EmDc4leZ3w5M+X9wJGXE
        DGH+LGdWflB5pQa7xO7HZxY1n3gWD2XIyxYx8842NLO1VZM1IG8U1EWN5Mz04xLJFn4y
        Co0jXzxbOYj99wiOSQdJ0YiTu/9P0zmn+hJVvuD2IOOPmWpx8xZ5Ezx9XSO8f5k1QPIp
        HcsiZ0BDB3Egl+QVf0Lc3EQEuSnI/LyhPO4uzOatpuCmhoutH10/Feq9/rYv/qsoUJkR
        5STg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkOivtz9BbcU3oIy/088u8A0IQPCQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:14eb:4db9:5107:55c4]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0NEYubJ4
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 23 Jan 2019 15:34:56 +0100 (CET)
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
Message-ID: <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de>
Date:   Wed, 23 Jan 2019 15:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I also compiled a kernel (zImage) for the X1000  from your Git 
'powerpc-dma.6-debug' (both patches) today.

It boots and the P.A. Semi Ethernet works!

I will test just the first patch tomorrow.

Thanks,
Christian


On 21 January 2019 at 3:38PM, Christian Zigotzky wrote:
> Hello Christoph,
>
> Thanks for your reply. I successfully compiled a kernel (uImage) for 
> the X5000 from your Git 'powerpc-dma.6-debug' (both patches) today.
>
> It detects the SATA hard disk drive and boots without any problems.
>

