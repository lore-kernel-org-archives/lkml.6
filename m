Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0AD2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="tisa1E30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfACT0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:26:31 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:21533 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfACT0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1546543586;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=pBQ+DDG+R8lz5PVBZOtvAtHEXP7LzY+0QhXhuCmy5sI=;
        b=tisa1E30UknaEvOhblVo1IE4SaQJY3eziFUjZwT94U3TfuWg6f4eNxc+p6U/Kvty4b
        qfRhMV6hbSNgOs+Bgd/sCERut3Mw5FB7vtpV3dd+aNLbO0WZVi1fYODXyp6nqsbchRqp
        fl9l4QkxblSSbSE/15/qenPszotStfEJrcATsy648oGz7TZSfnP5eKXJWu7M5xBdP6NM
        CzfOv0WlSB+sd80diu+6QH4RBxfIbZlCa9cf5UI3gjquVx7bwWtSHJd+oBYwfSZ9ll/1
        Y7TL6doz2nBt7kuEuBHLgS8BWeLltkh89b2wu3vCEsFA+iJKdjqiVEOThjbfyCjfmtGv
        /JKw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWcgjrpgx3EJD7auEH2ABQccQesTkMWARnsp4/2a"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:80a5:5375:1417:f8b6:a542:2ccf]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id u0679fv03JQGQ7n
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 3 Jan 2019 20:26:16 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20190103073622.GA24323@lst.de>
Date:   Thu, 3 Jan 2019 20:26:15 +0100
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de> <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de> <20181213091021.GA2106@lst.de> <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de> <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de> <20181213112511.GA4574@lst.de> <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de> <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de> <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de> <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de> <20190103073622.GA24323@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Happy new year for you too. Unfortunately we have some problems with the lat=
est DRM patches. They modified a lot and some graphics cards don=E2=80=99t w=
ork anymore. During the holidays we tried to figure out where the problems a=
re but without any success.

I will try to test your patches next week.

Cheers,
Christian

Sent from my iPhone

> On 3. Jan 2019, at 08:36, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Hi Christian,
>=20
> happy new year and I hope you had a few restful deays off.
>=20
> I've pushed a new tree to:
>=20
>   git://git.infradead.org/users/hch/misc.git powerpc-dma.6
>=20
> Gitweb:
>=20
>   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-=
dma.6
>=20
> Which has been rebased to the latests Linus tree, which has a lot of
> changes, and has also changed the patch split a bit to aid bisection.
>=20
> I think=20
>=20
>   http://git.infradead.org/users/hch/misc.git/commitdiff/c446404b041130fbd=
9d1772d184f24715cf2362f
>=20
> might be a good commit to re-start testing, then bisecting up to the
> last commit using git bisect.
