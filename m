Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4518C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFEE2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ZZwnSbNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFEE2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeLDJxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:53:44 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:27753 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543917222;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=fV6Oq88QW84WgDR4XQNS7Mjr7KzgOPfnxos1rNZEUog=;
        b=ZZwnSbNG/yYFEpVCab8W9hB69MOwJ0QNbpI3XqyTRT2j0Jr4sc3lwn/xcT9broOB0Q
        JJFwXLxuH3T/u4I0FM+AbcQVJ7TVf9nnv3NdbWexyFA5S9DRspBQDZ/eqHElDmqSqym3
        vWdXM134e17EksgimHPKZw8DHsfoTHqRQKYzR9IWvR/7tl1BoRGtx2qaMAnDqIWeLlop
        orpnX8gNv5H53sW+08FrYN9lDzPO4DTWfUW8t83YcRyF0ueN/e/yAjF6lvGipRzlErJ9
        hJUuOiEjMUKSCc/n/LUuhNe6Tt7aHrJYxF0VXSIwsgtfAflQFeJGdfke8rpWjWDiCL1r
        xAEQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkOjkRqsj0YvdYw8SBQvk+g3Fshzw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:1027:9d07:f327:cfc7]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uB49reYRW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 4 Dec 2018 10:53:40 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
 <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
Message-ID: <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
Date:   Tue, 4 Dec 2018 10:53:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 December 2018 at 08:31AM, Christian Zigotzky wrote:
> Hi All,
>
> Could you please test Christoph's kernel on your PASEMI and NXP 
> boards? Download:
>
> 'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'
>
> Thanks,
> Christian
>
I successfully tested this kernel on a virtual e5500 QEMU machine today.

Command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel 
uImage-dma -drive 
format=raw,file=MATE_PowerPC_Remix_2017_0.9.img,index=0,if=virtio -nic 
user,model=e1000 -append "rw root=/dev/vda" -device virtio-vga -device 
virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw es1370 -smp 4

QEMU version 3.1.0.

I don't know why this kernel doesn't recognize the hard disks connected 
to my physical P5020 board and why the onboard ethernet on my PASEMI 
board doesn't work. (dma_direct_map_page: overflow)

-- Christian

