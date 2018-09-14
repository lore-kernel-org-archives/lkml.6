Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFDFFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5092220882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5092220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeINVMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:12:15 -0400
Received: from sauhun.de ([88.99.104.3]:46162 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeINVMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:12:15 -0400
Received: from localhost (p54B33424.dip0.t-ipconnect.de [84.179.52.36])
        by pokefinder.org (Postfix) with ESMTPSA id 27E132C015D;
        Fri, 14 Sep 2018 17:57:07 +0200 (CEST)
Date:   Fri, 14 Sep 2018 17:57:06 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        linux-renesas-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] dma-mapping: clear dma_parms on teardown, too
Message-ID: <20180914155706.GA906@kunai>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
 <20180913151716.6333-4-wsa+renesas@sang-engineering.com>
 <874f7cd9-ac51-5968-de40-14a0addf9c96@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <874f7cd9-ac51-5968-de40-14a0addf9c96@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2018 at 02:23:51PM +0100, Robin Murphy wrote:
> On 13/09/18 16:17, Wolfram Sang wrote:
> > While sanitizig the pointer for dma_ops on teardown, do the same for
> > dma_parms, too. Rename the function to have a more generic name.
>=20
> Upon closer inspection, it looks like there are some cases (at least PCI =
and
> MFD) where dma_parms is installed by the parent/bus at device creation, a=
nd
> therefore remains valid and *would* be expected to persist across the chi=
ld
> device's driver unbinding and rebinding - seems this is more complex than=
 I
> first thought, sorry.

No problem. I am thankful I understand more details. So, the life cycle
of dma_parms is truly that of the device. Which means that the drivers
using devm_kzalloc in their probe, should ideally clear the pointer on
unbind. Otherwise, it is not possible to say if the non-NULL dma_parms
is intended or dangling. Which makes my initial dmam_set_dma_parms()
approach look not too bad, I'd think?

However, I don't want to push hard with this one. If you think this is
too academic, I'll just leave it for now...


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlub2k0ACgkQFA3kzBSg
KbZ0sRAAlqPAK/mkyLDkx5RBUJpzYe+XRAaNpF8cP8Kyw9BHyyekOpFVoBqjfNlo
Ohqjm1dkJTPh9buRXYdQexUQnquUSp6Ji7WQ96O1qNAlz5G8//cMD5zOt7K0ArlY
GUxHvhd7HBX8l/gqQ1uftoQCKRxJRVPtVuQn9MlLGCSScP29Kerj6aSFnFco0XUR
4GTnIcFG+OCcIFnRH57KpZw3iV8yeAIJpTvtfokb4a5Mugfb6BKqxtsqFKEIPJ0U
z643Yn3hRvuSxq64POTdqMLFsGL/Z1Gj12SOgobz09PFbiJ5Ts92JIy48cPVEdyp
N98Phn1y99/usBJWnXVjWmxgZPg4bHx8kU+hokOzmt9i87I4Hgm+9o36FsBCnMGJ
qkIrhADRfVAmrCnSR38Ti+YJFsqSfOrxqOFi6UQAW2yQC/leO5JCNFNANX8ZwHbg
n6Ng73pggrcwICZM1r3eQ8/U+xXcU8IJT+5QBW0XCXK33KZTyNZpvGXHxqaeSmXo
sdZB/FV6QwCTDuVwcfx6VJs6Czebv4YN41Uj/hal+JIyCYSAJgfA4s95EAHex8Ed
Kpv6cRNiodDtcxci9jTt+YWgNMMiQZkJnJZJZS7F7m7KLl10ljh5l4wg8TRNZdN0
ThEjQj5IjwBY1LxIFWoT68gCqk+W5wO/v6KJTtrJcMa1ax96fdo=
=ur+L
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
