Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213FDC282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46B82087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="nvEhJIwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfA3Ekt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:40:49 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:20761 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbfA3Eks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548823244;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=wlCPd9t+ai37SuMMWwk22tHj2OiZPFG7JEALF32RN7Q=;
        b=nvEhJIwXkK0PgcdVzHysPvtJ1ghO5Ye6ipGpCvsvHNod4K0GClg8yxnBOTghLx00Sb
        D6V5AxToAGnExIKMMqITuEzyfFGdnP5dEn/sD79ZDkjiEMN0B3W3lGZoPfDWP14nxqt7
        YLx5/f1swNeyxin/xu1y318p5WzIlmh0PJpH5/QVQYCIL7n0Lsw0zU8vmJcqeSPvHImi
        LbYyaKKTxriPCHgR70iqqhWmHLx9ub0jHmWl5zErQn2dC4NWkaSDVZ2Y2ZXIonI7F20e
        hEg1t9jWyn5fmAK5E5GlegET6YExOZ7eNypGY3jDkHy52jP/a3kNFMPyB3kcpSn/NoQ7
        G7LQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWd5irpgkCKCilfXBXJD48yBI66ylK3+2uPIEi8="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:8081:5dd1:48c0:9ec:f37f:30cd]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv0U4ebCQ0
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 30 Jan 2019 05:40:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190129163415.GA14529@lst.de>
Date:   Wed, 30 Jan 2019 05:40:36 +0100
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
References: <20190119140452.GA25198@lst.de> <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de> <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de> <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de> <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de> <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de> <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de> <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de> <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks a lot for the updates. I will test the full branch tomorrow.

Cheers,
Christian

Sent from my iPhone

> On 29. Jan 2019, at 17:34, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Tue, Jan 29, 2019 at 05:14:11PM +0100, Christoph Hellwig wrote:
>>> On Tue, Jan 29, 2019 at 04:03:32PM +0100, Christian Zigotzky wrote:
>>> Hi Christoph,
>>>=20
>>> I compiled kernels for the X5000 and X1000 from your new branch=20
>>> 'powerpc-dma.6-debug.2' today. The kernels boot and the P.A. Semi Ethern=
et=20
>>> works!
>>=20
>> Thanks for testing!  I'll prepare a new series that adds the other
>> patches on top of this one.
>=20
> And that was easier than I thought - we just had a few patches left
> in powerpc-dma.6, so I've rebased that branch on top of
> powerpc-dma.6-debug.2:
>=20
>    git://git.infradead.org/users/hch/misc.git powerpc-dma.6
>=20
> Gitweb:
>=20
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc=
-dma.6
>=20
> I hope the other patches are simple enough, so just testing the full
> branch checkout should be fine for now.
