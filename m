Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1161EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C236E2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="qPVdOSTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfBDMOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:14:01 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:21496 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfBDMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549282436;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=XR2rLJAYU/hZNgFiDPi9cMSS22UeqMZYvAHXe2JGgQg=;
        b=qPVdOSTYNrzjY+mSv2jD229o18tBg6p8LCoOMuiuQi3uE/dTRsgZkuaiEkxJNL9RTR
        +a1FZ9aeZ8noS+qzEEiXi5mUI+fk9RmQbjzFV1N+uwjG/r1jjGF5CMshNTu3VzDd363f
        y9SezIyQvQjZ21O71i9eWwPMZZNGGkUYaynUrTC8kwB5p1Ruc3Ah1d7/B1nXpj+rkDES
        uY/PMhceGAZKRq2HWhbQva8EUXWyqkSGTVBBnDU53/r13iFIQpltHrvvjl4JVExOxIG5
        UkgEPUsB/1sItRGlaF4+zzkVar8EbGfRQxPEMz/8OKMy6WJcesQHSnnvHMwtn/AJBoCo
        zXsA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkN2lxaMsNEtm2M+aQCzX/y4aXO"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:2d84:d264:dc2:6095]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv14CDsgJt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 4 Feb 2019 13:13:54 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <20190128162256.GA11737@lst.de>
 <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
 <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
 <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de>
 <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
 <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
 <20190201080456.GA15456@lst.de>
 <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
Date:   Mon, 4 Feb 2019 13:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204075616.GA5408@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 February 2019 at 08:56AM, Christoph Hellwig wrote:
> On Sun, Feb 03, 2019 at 05:49:02PM +0100, Christian Zigotzky wrote:
>> OK, next step: b50f42f0fe12965ead395c76bcb6a14f00cdf65b (powerpc/dma: use
>> the dma_direct mapping routines)
>>
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>
>> git checkout b50f42f0fe12965ead395c76bcb6a14f00cdf65b
>>
>> Results: The X1000 and X5000 boot but unfortunately the P.A. Semi Ethernet
>> doesn't work.
> Are there any interesting messages in the boot log?  Can you send me
> the dmesg?
>
Here you are: http://www.xenosoft.de/dmesg_X1000_with_DMA_updates.txt

-- Christian

