Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4CCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22660206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="cm9A//JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22660206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeK2XLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:11:10 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:35653 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeK2XLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543493157;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=1d8dDcOXQakLxZx9h0WPUGsP4J980v3eg/KbaQPeYXs=;
        b=cm9A//JQKJHrXqu0KhPlcMk8A7BWlRST3BvZAgOJjCbdl1YkF5tz2KLGqLjrBdUdDJ
        vqA9f2/k/e7PUOjkQRBIUK+XdDDpc38u9iTpTHtQK46EjgAYrkgG3iW2nSk38cqtW6fo
        li9rD5Xbk0agE2vrS498+GYCvKm2Eud8203Dq2pS6dgGTu92VgJwXn6iV6Lt2I9cRaDm
        zhZQgwFxwskHA9pOAjaMXH18d4vXsWEHWt7GlSSc/zqm7S1OlsSqVAnOw9TBVJ4T/w87
        4nJIP3hdEHNpkJ3+oo0JnEMMt5LrPc25BlldvNgvP8PeAJeLoOnRPcvf65BJgdI0nhFK
        2qtA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkIi451DZe29TrPMHVmP0k4v8Fd"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:750c:580c:e34a:e81]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uATC5NBiB
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 29 Nov 2018 13:05:23 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
Date:   Thu, 29 Nov 2018 13:05:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <87zhttfonk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
> Christoph Hellwig <hch@lst.de> writes:
>
>> Any comments?  I'd like to at least get the ball moving on the easy
>> bits.
> Nothing specific yet.
>
> I'm a bit worried it might break one of the many old obscure platforms
> we have that aren't well tested.
>
> There's not much we can do about that, but I'll just try and test it on
> everything I can find.
>
> Is the plan that you take these via the dma-mapping tree or that they go
> via powerpc?
>
> cheers
>
Hi All,

I compiled a test kernel from the following Git today.

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4

Command: git clone git://git.infradead.org/users/hch/misc.git -b 
powerpc-dma.4 a

Unfortunately I get some DMA error messages and the PASEMI ethernet 
doesn't work anymore.

[  367.627623] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627631] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627639] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627647] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627655] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627686] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.628418] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.628505] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.628592] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.629324] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.629417] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.629495] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.629589] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0

[  430.424732]pasemi_mac: rcmdsta error: 0x04ef3001

I tested this kernel with the Nemo board (CPU: PWRficient PA6T-1682M). 
The PASEMI ethernet works with the RC4 of kernel 4.20.

Cheers,
Christian
