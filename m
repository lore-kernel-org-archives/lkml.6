Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5ABC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA24213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfBJVpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 16:45:04 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:37909 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBJVpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 16:45:03 -0500
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 79927240004;
        Sun, 10 Feb 2019 21:45:00 +0000 (UTC)
Date:   Sun, 10 Feb 2019 22:45:00 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/nozomi: use pci_iomap instead of ioremap_nocache
Message-ID: <20190210214500.GB22758@behemoth.owl.eu.com.local>
References: <20190210171212.GA22758@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20190210171212.GA22758@behemoth.owl.eu.com.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Use pci_iomap instead of ioremap_nocache in nozomi_card_init(). This
> is a cleaner way to do PCI MMIO (performs additional checks) and
> allows to drop the manual call to pci_resource_start.
>=20
> pci_iomap relies on ioremap for MMIO and thus has uncached behavior.

there's still something unclear to me about dc->card_type being used as
size argument to ioremap_nocache().

dc->base_addr is the sum of all six io region lengths, not the size of
region 0 which we are trying to map here. Why not using the size of region
0 instead ?

If the goal is to map all six regions "at once", I'm not sure how this is
supposed to work. Is there any kind of guarantee that all six regions will
be adjacent?

If this is a bug then this patch "somehow" already adresses it since
pci_iomap calls pci_resource_len itself. Otherwise this patch is broken.

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxgm1QACgkQZYVUZx9w
0DRUzAf/eXMxyptRnl533KQxunRWWcdUaqYmlXqnnf27/hlz2GOwk/NoeMOLbAUc
PLGilVn53z6jgfJJYAAyCbJ07gw2rrYWDwPO4m3wHdH3t28Mvix0ZcQOhswosffk
hsIh2Is3WuYvt4Zr9wDvQ2tJTFDzETvkNh/zyCsi2Bpf8G26yjX9GMvLkmUOrcYU
polMj5eS8DsFM8vmevewaWSPv/cInVKWWuU1THOsmMvHRIcu12b2Ubdpbees3yiU
UJTHHa6f4DGa26MgCio6tK+3bV/0xr7nN3BLUehxBIpb5Rlbsk+ul4YOXyVySCbt
RWOtrLIHOEgJysa4xJ65hr3xOuKm8Q==
=zuNT
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
