Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450BDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1530C20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="GL+f6a3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfAON4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:56:40 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:14698 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfAON4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547560597;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=qjQYj2poIqFNPGRwB16+nYsywTx1PQvvhTI5rvcaBgI=;
        b=GL+f6a3zzqLQAUghO+T4vIv7rbtdbadDQoPzy1rbizXCzlK8eku7C1UitaT9uVt30r
        GiEALfcqKJgFp8vmNSwr1DZ26PhNq71tJwnyIt+JyYo6du1V2jvvofTwXOGnwEnfUNco
        gzcQShOIQSxbfa4eeSwU5GUBbtow9AhN8TgR10slVMKF2CAAGWGo855NIBk/Zy9VQzk4
        JTS5nazSIrwp0qJV3h8bTl+1tMYbZygsC4FERGbiH2/VCcQsOKMMAPJ3tFarAEvyohB5
        Vn+MkL0Yr3nwoJ0mBvYyKEP5x6FXbYP5pVRa3cbFxodqdJn3dvYyH3O4Jb4EdnnbIzC0
        tOlw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkNi0C2kzEbDQg0vrQvOCYvo/qC"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:25bb:7249:5b2a:1f0]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0FDuYsN4
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 15 Jan 2019 14:56:34 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
 <20190103073622.GA24323@lst.de>
 <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <23284859-bf0a-9cd5-a480-2a7fd7802056@xenosoft.de>
 <075f70e3-7a4a-732f-b501-05a1a8e3c853@xenosoft.de>
 <b04d08ea-61f9-3212-b9a3-ad79e3b8bd05@xenosoft.de>
 <21f72a6a-9095-7034-f169-95e876228b2a@xenosoft.de>
 <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de>
 <20190115133558.GA29225@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de>
Date:   Tue, 15 Jan 2019 14:56:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115133558.GA29225@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 January 2019 at 2:35PM, Christoph Hellwig wrote:
> On Tue, Jan 15, 2019 at 11:55:25AM +0100, Christian Zigotzky wrote:
>> Next step: 21074ef03c0816ae158721a78cabe9035938dddd (powerpc/dma: use the
>> generic direct mapping bypass)
>>
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>
>> git checkout 21074ef03c0816ae158721a78cabe9035938dddd
>>
>> I was able to compile the kernel for the AmigaOne X1000 (Nemo board with PA
>> Semi PA6T-1682M SoC). It boots but the PA Semi onboard ethernet doesn't
>> work.
> Thanks.  But we are exactly missing the steps that are relevant.  I've
> pushed a fixed up powerpc-dma.6 tree, which will only change starting from
> the first commit that didn't link.
>
> The first commit that changed from the old one is this one:
>
> http://git.infradead.org/users/hch/misc.git/commitdiff/257002094bc5935dd63207a380d9698ab81f0775
>
> which was that one that your compile failed on first.
>
> Thanks again for all your work!
>
Thank you! I tried the commit 240d7ecd7f6fa62e074e8a835e620047954f0b28 
(powerpc/dma: use the dma-direct allocator for coherent platforms) again.

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout 240d7ecd7f6fa62e074e8a835e620047954f0b28

I modified the 'dma.c' patch because of the undefined references to 
'__dma_nommu_free_coherent' and '__dma_nommu_alloc_coherent':

---

@@ -163,8 +99,13 @@ static inline void dma_nommu_sync_single(struct 
device *dev,
  #endif

  const struct dma_map_ops dma_nommu_ops = {
+       .alloc                          = dma_direct_alloc,
+       .free                           = dma_direct_free,
         .map_sg                         = dma_nommu_map_sg,
         .unmap_sg                       = dma_nommu_unmap_sg,
         .dma_supported                  = dma_direct_supported,

---

The X1000 boots and the PASEMI onboard ethernet works! X5000 (P5020 
board): U-Boot loads the kernel and the dtb file. Then the kernel starts 
but it doesn't find any hard disks (partitions).

-- Christian

