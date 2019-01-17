Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33059C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDD420657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="L+nLVlUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfAQJVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:21:17 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:36248 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfAQJVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547716874;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=IYaHkj5lFuCS1o0NpM2A895kbFVDdTVOQs5mRSCoyk0=;
        b=L+nLVlUMiOAh/i3kZlFb4Nn7kPiNE1XVTF2g/X4bmjnxVGO1UuHQ9P/pmIFI/IKwaz
        b2o9ExOlCKaqfg/KKRyDGKw9scuHuxqpb5GLKNogwJnD8ukyh/gS4YYv/KQ92Op/Pvdh
        /VdDjXqegLZ1tjhhMW9BgHeDBi1b07bnapnHSSE8ECmCIyVJD94WsZThYtDoByhUbED+
        ndUuLfDQb34NWAq2I1YoXnPwbCMSI5sRmSfEe9URHU+vIvN7j2HfLCo3s3MUAf05r4B+
        j1JcP6fno8hxpm0d88sBZISSSR+kC4/wr5/geSCbfyCuQcvOKLWfR2j48eLwUHp7NUXU
        /xHg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkN2lRWMpIV4miMvSq1nazBhLEi"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:2d08:5cb1:24de:823]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0H9LC2Db
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 17 Jan 2019 10:21:12 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <23284859-bf0a-9cd5-a480-2a7fd7802056@xenosoft.de>
 <075f70e3-7a4a-732f-b501-05a1a8e3c853@xenosoft.de>
 <b04d08ea-61f9-3212-b9a3-ad79e3b8bd05@xenosoft.de>
 <21f72a6a-9095-7034-f169-95e876228b2a@xenosoft.de>
 <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de>
 <20190115133558.GA29225@lst.de>
 <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de>
 <20190115151732.GA2325@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de>
Date:   Thu, 17 Jan 2019 10:21:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115151732.GA2325@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I compiled the fixed '257002094bc5935dd63207a380d9698ab81f0775' 
(powerpc/dma: use the dma-direct allocator for coherent platforms) today.

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout 257002094bc5935dd63207a380d9698ab81f0775

Link to the Git: 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6 


env LANG=C make CROSS_COMPILE=powerpc-linux-gnu- ARCH=powerpc zImage

env LANG=C make CROSS_COMPILE=powerpc-linux-gnu- ARCH=powerpc uImage

The X1000 boots and the PASEMI onboard ethernet works!

Bad news for the X5000 (P5020 board). U-Boot loads the kernel and the 
dtb file. Then the kernel starts but it doesn't find any hard disks 
(partitions).

Cheers,
Christian


On 15 January 2019 at 4:17PM, Christoph Hellwig wrote:

So 257002094bc5935dd63207a380d9698ab81f0775 above is the fixed version
for the commit - this switched the ifdef in dma.c around that I had
inverted.  Can you try that one instead?  And then move on with the
commits after it in the updated powerpc-dma.6 branch - they are
identical to the original branch except for carrying this fix forward.
