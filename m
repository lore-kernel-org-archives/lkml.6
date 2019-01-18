Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946ECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B442086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="mktDZBsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfARPGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:06:55 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:17190 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfARPGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547824012;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Q2NdmbAHINCN199W6d1Pw6kjfFiIuOgi21lP12GaV98=;
        b=mktDZBskO0FkjsxEOfSaatwJ6etzGgPnBzKFIMPUvzrASckJiADloQ86CJ/GkOWZlE
        vibTKeSp+tv1b02ebny1DJzOFfKs254Yy32p58usnVDl2z5Wk4/5QjGw6RykdJT+Jtmo
        o1upoOExdKV7wc2BKbKsjfQOKP1kJyBbQwcgOh2A1MYGi1qWUfmRdDrC/xMREXmaHTLX
        pmhYoeQP/Vt2vhMohOniGGiMrEk2zHMZL/JRfUc+Xh/2b0l/f3wO4OY43TAOWGZiSaVv
        KdF4G/WsBCH02NEAuODOWwHzGv0/QDPnKQ3sLQ3tUSjuB21pDeNr2hA9GXs+Jei7ccdt
        47rw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkG3XhC7INB4ZnqpLNoQOqb145tbQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:9cbf:d0e8:7fbb:717b]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0IF6oANI
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 18 Jan 2019 16:06:50 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
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
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de>
Date:   Fri, 18 Jan 2019 16:06:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118125500.GA15657@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

I was able to compile 257002094bc5935dd63207a380d9698ab81f0775 from your 
Git powerpc-dma.6-debug today.

Unfortunately I don't see any error messages (kernel ring buffer) and I 
don't have a RS232 serial null modem cable to get them.

Cheers,
Christian

