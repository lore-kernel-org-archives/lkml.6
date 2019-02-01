Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D700AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EC021726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="i4GkrYz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfBAQys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:54:48 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:31824 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfBAQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549040085;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=LAbsLwu8sJW7WqnqGFFP5VTZ9qgQ8eLa2wTlFiB3aZY=;
        b=i4GkrYz4ErJTi8DqEq/4pxfxx853/0z7zFPJ+7ATI9OOcWCeCAE1rtt2XvSia/9xFq
        6ORSqMeyxrjnleppGFRsfbfdA+k535/r3WMAcm8vNCJuKVqeUopjH8x+Txz628H+Yciz
        /hQXt0SL33TiwsMbfqxy3YgbnpqKw4AWxp5ossRK3B+Smcx8Z4BbZtp2Kye5n9Da/DMR
        enHDX9VuQfXRO9USx+7V0GKjfiPMJg82BehNRr8XegGg8KaTSES5toaQ4ikdyL/hLdO8
        YqpCemNN9IVqMGX2K0KCAP/pQd2ETjPHTSrx4+Ijg87Ch9Y7VJ9x1Z6OmTMumRdHHJF4
        lOhA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b2dxirpixiJad29NQJbPwl29UVaHJ+MaNaC8Wwcm"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b001:72d0:7d2b:70c4:d703:bb47]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv11GscVPa
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 1 Feb 2019 17:54:38 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190201080456.GA15456@lst.de>
Date:   Fri, 1 Feb 2019 17:54:37 +0100
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
References: <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de> <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de> <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de> <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de> <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de> <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de> <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de> <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de> <20190201080456.GA15456@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I will try it at the weekend.

Thanks,
Christian

Sent from my iPhone

> On 1. Feb 2019, at 09:04, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Thu, Jan 31, 2019 at 01:48:26PM +0100, Christian Zigotzky wrote:
>> Hi Christoph,
>>=20
>> I compiled kernels for the X5000 and X1000 from your branch 'powerpc-dma.=
6'=20
>> today.
>>=20
>> Gitweb:=20
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-d=
ma.6
>>=20
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>=20
>> The X1000 and X5000 boot but unfortunately the P.A. Semi Ethernet doesn't=
=20
>> work.
>=20
> Oh.  Can you try with just the next one and then two patches applied
> over the working setup?  That is first:
>=20
> http://git.infradead.org/users/hch/misc.git/commitdiff/b50f42f0fe12965ead3=
95c76bcb6a14f00cdf65b
>=20
> then also with:
>=20
> http://git.infradead.org/users/hch/misc.git/commitdiff/21fe52470a483afbb17=
26741118abef8602dde4d
