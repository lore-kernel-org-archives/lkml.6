Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CE8C2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC9B2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Kxkg6VdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfAUOip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:38:45 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:14246 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbfAUOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548081520;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=9aXyl3XX6X2NaqAV5Jbua+GONqAlosKe6poqf11l4ww=;
        b=Kxkg6VdQAcbjBrajIaoR++oi0rWkLXwm/AkcT5gjfMvlsmaGm7ds1tdc8sw7up3nKL
        gxsTZh43OrjwQhhFpJc9p9ZoIrPslYAqxAPEeaL25EhptIU8BJFxvSPzs12tD2xdADOZ
        Tt/ztANlY7eIR1uVmW0FpP71kY22uPLvg7TW7999Mw4QPwk4x9hrDecwwsl6ElBhu1xE
        0nU2f2my2KbBdm9R4mIGBFxlbvDgbQEkQzxgHSh7QYqxN+NMLkM1aefma0wdGujACW7h
        eHfSia+HquF7Rn/6MYCb28dl8bg4TUCEl6rJxrJ36P4Utk+K+lBTGb7uaxcWAOOh43YA
        VPEA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkOjx+xiVEQyUhLZzRcZ7jq/ONwjw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:11e9:3359:3c07:dcab]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0LEccO8n
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 21 Jan 2019 15:38:38 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
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
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
Date:   Mon, 21 Jan 2019 15:38:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119140452.GA25198@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

Thanks for your reply. I successfully compiled a kernel (uImage) for the 
X5000 from your Git 'powerpc-dma.6-debug' (both patches) today.

It detects the SATA hard disk drive and boots without any problems. I 
will test the first patch in next days.

Thanks for your help,

Christian


On 19 January 2019 at 3:04PM, Christoph Hellwig wrote:
> On Sat, Jan 19, 2019 at 02:02:22PM +0100, Christoph Hellwig wrote:
>> Interesting.  This suggest it is related to the use of ZONE_DMA by
>> the FSL SOCs that your board uses.  Let me investigate this a bit more.
> As a hack to check that theory I've pushed a new commit to the
> powerpc-dma.6-debug branch to use old powerpc GFP_DMA selection
> with the new dma direct code:
>
> http://git.infradead.org/users/hch/misc.git/commitdiff/5c532d07c2f3c3972104de505d06b8d85f403f06
>
> And another one that drops the addressability checks that powerpc
> never had:
>
> http://git.infradead.org/users/hch/misc.git/commitdiff/18e7629b38465ca98f8e7eed639123a13ac3b669
>
> Can you first test with both patches, and then just with the first
> in case that worked?
>
>

