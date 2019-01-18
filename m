Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDA4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E422087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="YTCEogNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfARMIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:08:01 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:35693 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfARMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547813276;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ckUeU+GiNomrM8ifDJKOrkGYJUtb+vUO09PrWNiwgac=;
        b=YTCEogNghvUNyl4HgkEX2d9k7Rj8Tf3BZujVuMPeeDwqnNl5J2ryZhKY2VdJDTZ1Fd
        FDx2iT7daLci2A5Wy7HY0sF/TkuJFTV/EewDkCVIJg5HBW+MzuyWbCMKsDCQjxf/Orss
        5hSuPN6Q12nvBaO7rCXECKTQ3TIpjkm6P5B5qp+ZWlTyw3BIo4eVeQSN9MXu905S/rXt
        Pz3ccB/oqboGdC+a4FDR5KBmZEoXgEA9GnHOORpBUx7EuLBI1FMxq+Lo2SWRjWV7BeuG
        bOPfg41PumX9vUUydcdrnwV0shCDnw0emPC4W13acHDDmh+qKlYVRT/BPW/UUAbuK87S
        PoGQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkO3W1t7/x3Ry2nhljiBv4wW5sxWQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:1cca:8712:d929:bc6d]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0IC7s9NT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 18 Jan 2019 13:07:54 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <075f70e3-7a4a-732f-b501-05a1a8e3c853@xenosoft.de>
 <b04d08ea-61f9-3212-b9a3-ad79e3b8bd05@xenosoft.de>
 <21f72a6a-9095-7034-f169-95e876228b2a@xenosoft.de>
 <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de>
 <20190115133558.GA29225@lst.de>
 <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de>
 <20190115151732.GA2325@lst.de>
 <e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de>
 <20190118083539.GA30479@lst.de>
 <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de>
 <20190118112842.GA9115@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <a2ca0118-5915-8b1c-7cfa-71cb4b43eaa6@xenosoft.de>
Date:   Fri, 18 Jan 2019 13:07:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118112842.GA9115@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout 257002094bc5935dd63207a380d9698ab81f0775


I get the following error message with your patch:

patching file a/kernel/dma/direct.c
Hunk #1 FAILED at 118.
Hunk #2 FAILED at 139.
2 out of 2 hunks FAILED -- saving rejects to file a/kernel/dma/direct.c.rej

-- Christian

On 18 January 2019 at 12:28PM, Christoph Hellwig wrote:
> On Fri, Jan 18, 2019 at 12:10:26PM +0100, Christian Zigotzky wrote:
>> For which commit?
> On top of 257002094bc5935dd63207a380d9698ab81f0775, that is the first
> one you identified as breaking the detection of the SATA disks.
>

