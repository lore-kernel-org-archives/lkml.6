Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D9DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0FE20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Dqsn1Zay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0FE20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeK2DKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:10:02 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:36615 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2DKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:10:01 -0500
X-Greylist: delayed 708 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 22:10:00 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543421271;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=7xS2QcB97L9QI4n5R/5DRuYEud3Vh5VKc9tcNvItCtM=;
        b=Dqsn1ZayszGY5k4h967SS8hxLLStPdjSSGDinTl6xh2V2f0oq/Y7mx6oVvFBonPPy4
        IEZcjaS0HhXx3wmGlKOBajMDhbiU58dujubG+dvRvmq4hYEwndqt+40smnpfcHxvWD2+
        p98dLzfFnoU65rOqPwtP17wR6+HpmfWONwzO+mPlcLycbJmKqlJkqG+4IS2sqWeAQNPq
        8UYQwliwf1exS8zXYKMK2r3YH47mRmDbTlt/5cBYOhBxE+EbyEL4POCYpsicxVtZPdV3
        bpqSd7qOQFYeIM9STuzMxoq8xXIk+cVX20gwIU/dWstEmYzOsa0FATW4OaP3Lgd6SJJz
        3vhQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkIise/x75IsWntOVj9qPtpgydF"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:74d7:2770:613:8ba4]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uASFtU7KR
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 28 Nov 2018 16:55:30 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Date:   Wed, 28 Nov 2018 16:55:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <87zhttfonk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
> Nothing specific yet.
>
> I'm a bit worried it might break one of the many old obscure platforms
> we have that aren't well tested.
>
Please don't apply the new DMA mapping code if you don't be sure if it 
works on all supported PowerPC machines. Is the new DMA mapping code 
really necessary? It's not really nice, to rewrote code if the old code 
works perfect. We must not forget, that we work for the end users. Does 
the end user have advantages with this new code? Is it faster? The old 
code works without any problems. I am also worried about this code. How 
can I test this new DMA mapping code?

Thanks

