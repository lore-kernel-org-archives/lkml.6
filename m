Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E372FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0CD214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="FKKMG3LO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0CD214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeLEKEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:04:44 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:36928 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbeLEJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544003048;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Us0Y6iG1zqYJFobUUSTAv7ZQZM1Eimv3YTkHhrcbeVI=;
        b=FKKMG3LOp6BniIlEhS5Sw7MCBTxYvG47JkpH+qIHzt/PwiJYozMLz7kOy1zcXC6aNY
        HIfNQtjbcc0Qh8hySP3TVUjUz/GwHfSKB8ie9W1ZTs7rm8+xWQ0P31s39C7XCCcBjGQk
        xFv/ODzDjmepxhGwz4c8WTr8jdniVI+jzgAfoAqo1lvoHYXzKx8Uk0kzyxQmLummM4/E
        XAGZe533nCXayqvDaPsNyuCaDtl26fpXprdLK4h2h424jVRAr11AM0oO0UxAjLNFj4Ss
        XzTGah7d8cSpjuI3Dgg1+6rN84QamEf2Eabs3cA4Stti7cPT3fATV6/Cap8S+q/C54oq
        P7ig==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkJh/ARs/ll0LP9pYXILmPj+77/lQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:6972:d6c3:ba77:3810]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uB59i6eZb
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 5 Dec 2018 10:44:06 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <87zhttfonk.fsf@concordia.ellerman.id.au>
 <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
 <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
 <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
 <20181204142426.GA2743@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
Date:   Wed, 5 Dec 2018 10:44:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204142426.GA2743@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 December 2018 at 3:24PM, Christoph Hellwig wrote:
> On Tue, Dec 04, 2018 at 10:53:39AM +0100, Christian Zigotzky wrote:
>> I don't know why this kernel doesn't recognize the hard disks connected to
>> my physical P5020 board and why the onboard ethernet on my PASEMI board
>> doesn't work. (dma_direct_map_page: overflow)
> Do you know if this actually works for the baseline before my patches?
> E.g. with commit 721c01ba8b46ddb5355bd6e6b3bbfdabfdf01e97 ?
>
Hi Christoph,

Thanks for your reply. I undid all dma mapping commits with the 
following command:

git checkout 721c01ba8b46ddb5355bd6e6b3bbfdabfdf01e97

After that I compiled the kernels with this code for my P5020 board 
(Cyrus) and for my PASEMI board (Nemo) today.

Result: PASEMI onboard ethernet works again and the P5020 board boots.

It seems the dma mapping commits are the problem.

@All
Could you please test Christoph's kernel on your PASEMI and NXP boards? 
Download:

'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'

Thanks,
Christian

