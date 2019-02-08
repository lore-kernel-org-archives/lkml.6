Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78893C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA752075D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="oF3Gg4gP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfBHK7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:59:35 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:21153 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549623573;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=5vM19Mse6Fg0iyC0wbkxDF21CFIQD2YJabqo5tMcP3Y=;
        b=oF3Gg4gPp0FIUgKdc5bcLiLHIUOzKDUhjxta++aL/064b3jbiWidlrLohsOCFKzxxf
        3n5cBwyubmjCajYHU26/uV7y31k860Ifay8pHwcwfB3fQU8gI6L0i3S67xTVXJvsKqjN
        QEAXUz3uJPh5SWN8l82ARuaqUuUPBZzk2Yy+MLKoBu0a4GKE+dqZ6unuGQoXYwGYYBQf
        PSWjiCxD6f/eGCF2pVZEBqO2+OChs7esnZ8kfnuNRRM9JzX1cww8XH3x0MjOZb9YDLGD
        BHkj6PpYr8FH28edmiSc/NaRXA0moOePxFewcasArnP1fkKD/XMDLD28nhKK5qMYpRsG
        +UKw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4Ql+BpvNtdS8exno1lfFcAX4Rep/HqzVAjBMh+akM"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:5097:f73f:b2d2:de7]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv18AxF5ae
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 8 Feb 2019 11:59:15 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190208091818.GA23491@lst.de>
Date:   Fri, 8 Feb 2019 11:59:14 +0100
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A289D18C-1239-4296-B58F-FFB0DF1D9C79@xenosoft.de>
References: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de> <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de> <20190204075616.GA5408@lst.de> <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de> <20190204123852.GA10428@lst.de> <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de> <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de> <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de> <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de> <20190208091818.GA23491@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I will test it.

=E2=80=94 Christian

Sent from my iPhone

> On 8. Feb 2019, at 10:18, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Fri, Feb 08, 2019 at 10:01:46AM +0100, Christian Zigotzky wrote:
>> Hi Christoph,
>>=20
>> Your new patch fixes the problems with the P.A. Semi Ethernet! :-)
>=20
> Thanks a lot once again for testing!
>=20
> Now can you test with this patch and the whole series?
>=20
> I've updated the powerpc-dma.6 branch to include this fix.
