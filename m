Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2414DC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66182054F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66182054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJ2Gx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 02:53:59 -0400
Received: from sauhun.de ([88.99.104.3]:57952 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeJ2Gx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 02:53:59 -0400
Received: from localhost (unknown [87.113.172.131])
        by pokefinder.org (Postfix) with ESMTPSA id 855694A1CAD;
        Sun, 28 Oct 2018 23:08:00 +0100 (CET)
Date:   Sun, 28 Oct 2018 22:08:00 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] i2c: uniphier-f: fix occasional timeout error
Message-ID: <20181028220759.GC1882@kunai>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
 <1539658909-26691-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <1539658909-26691-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 12:01:48PM +0900, Masahiro Yamada wrote:
> Currently, a timeout error could happen at a repeated START condition.
>=20
> For a (non-repeated) START condition, the controller starts sending
> data when the UNIPHIER_FI2C_CR_STA bit is set. However, for a repeated
> START condition, the hardware starts running when the slave address is
> written to the TX FIFO - the write to the UNIPHIER_FI2C_CR register is
> actually unneeded.
>=20
> Because the hardware is already running before the IRQ is enabled for
> a repeated START, the driver may miss the IRQ event. In most cases,
> this problem does not show up since modern CPUs are much faster than
> the I2C transfer. However, it is still possible that a context switch
> happens after the controller starts, but before the IRQ register is
> set up.
>=20
> To fix this,
>=20
>  - Do not write UNIPHIER_FI2C_CR for repeated START conditions.
>=20
>  - Enable IRQ *before* writing the slave address to the TX FIFO.
>=20
>  - Disable IRQ for the current CPU while queuing up the TX FIFO;
>    If the CPU is interrupted by some task, the interrupt handler
>    might be invoked due to the empty TX FIFO before completing the
>    setup.
>=20
> Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driv=
er")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!


--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWMz8ACgkQFA3kzBSg
Kbb4CRAAlbWEMkwhwkSEVYQ0agoI0dekQGE2wmtMrttLYheXWwwJSrrVzcGNM9BJ
4gayx6WTWGq7vClDVQrS6eTLxZo4JDib3DqUQAyY/fI3HALs5ED1ju77hzKTODpS
i1qMX+oyLEWLUusdPY5JfVw0FT7kJ7/fodR8aaVhzhIp8VfSV/Bn4ozsXc/KJIBU
NVi77LgLpfoUWwoRtOr5k2ZLjRPiHLxNniQUjwnJu8Q0mIvNt8T3WJxQZYmUnCVD
eGn8M6Z96MRlnoqQ9LYCiPrTVbQrvHV/dTAwtwh3Hqsis0D2sgljE9QjpscIAoNf
oHO+ayS3XGtVp0gMY3J8AOweGPIbLLlJS+l3U33WG018uXWvnyAl3fWNklmTFGLX
vnMKtifnpwOgnsdd0/EEkawrQoik/8sQCi5B/fw7g4wF/iP7UnT6UP4Ch0sJG/JO
ZRXMNx1jqPUCDhRxmhyBUYFJ153EwgYXTq3BrQLkZ6eRCHF/qEiYMrWpDyHYG/S2
tvpnd2Oj7DEfm7CnOPQaS4FtfcLybiukqozsxG0erDhwaN9ytRKA5l0Y673OpgQY
g/Xygun4iD1OUgbQCsi2+9u2SrfKGV6WPVIXQmGtlNKuVAv4BQwXa9AFGZD11pl8
RCVrnIp1e+cukXA6A+VvfQdDHjcB4Gyl+bkQyD+udf00m01jOzg=
=my3U
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
