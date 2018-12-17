Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1771C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A42214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbeLQWbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:31:25 -0500
Received: from sauhun.de ([88.99.104.3]:41640 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731302AbeLQWbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:31:25 -0500
Received: from localhost (p54B3357B.dip0.t-ipconnect.de [84.179.53.123])
        by pokefinder.org (Postfix) with ESMTPSA id BC7E62E3656;
        Mon, 17 Dec 2018 23:31:22 +0100 (CET)
Date:   Mon, 17 Dec 2018 23:31:22 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH v2] i2c: axxia: support sequence command mode
Message-ID: <20181217223122.ye5as5dn5f7rm2a4@ninjato>
References: <20181211200435.abk3jdsmltz7c26w@ninjato>
 <20181213120926.GA10479@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5cfywihpu4wl3i6q"
Content-Disposition: inline
In-Reply-To: <20181213120926.GA10479@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5cfywihpu4wl3i6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 12:09:38PM +0000, Adamski, Krzysztof (Nokia - PL/Wr=
oclaw) wrote:
> In order to comply with SMBus specification, the Axxia I=C2=B2C module wi=
ll
> abort the multi message transfer if the delay between finishing sending
> one message and starting another is longer than 25ms. Unfortunately it
> isn't that hard to trigger this situation on a busy system. In order to
> fix this problem, we should make sure hardware does whole transaction
> without waiting for software to fill some data.
>=20
> Fortunately, in addition to Manual mode that is currently used by the
> driver to perform I=C2=B2C transfers, the module supports also so called
> Sequence mode. In this mode, the module automatically performs
> predefined sequence of operations - it sends a slave address, transmits
> specified number of bytes from the FIFO, changes transfer direction,
> resends the slave address and then reads specified number of bytes to
> FIFO. While very inflexible, this does fit a most common case of multi
> message transfer - the one where you first write a register number you
> want to read and then read it.
>=20
> To use this mode effectively, a number of conditions must be met to
> ensure the transaction does fit the predefined sequence. In case this is
> not the case, a fallback to manual mode is used.
>=20
> The initialization of this mode is very similar to Manual mode. The most
> notable difference is different bit in the Master Interrupt Status
> designating finishing of transaction. Also some of the errors, like TSS,
> cannot happen in this mode.
>=20
> While it is possible to support transactions requesting a read of any
> size (RFL interrupt will be generated when FIFO size is not enough) the
> TFL interrupt is not available in this mode, thus the write part of the
> transaction cannot exceed FIFO_SIZE (8).
>=20
> Note that in case of a NAK during transaction, the NA/ND status bits
> will be set before STOP command is generated, triggering an interrupt
> while the controller is still busy. Current solution for this problem is
> to actively wait for this command to stop before leaving xfer callback.
>=20
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>

Fixed this 'checkpatch --strict' warning:

CHECK: braces {} should be used on all arms of this statement
#201: FILE: drivers/i2c/busses/i2c-axxia.c:422:

=2E.. and applied to for-next, thanks!


--5cfywihpu4wl3i6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwYI7oACgkQFA3kzBSg
KbZnOg//fknrJkrD8oAQjJXYZWDOT+dRPDoXmYCuMydzDz4h+SWVXZBQwJOZ3W7K
B7QlvKQhMl17s+l7AjraJ6+9nZVOtxGye+3L8jLc/CNB0c1pR6siJ1+ju8ZKJVG+
LxwDsSozGK4Cb+mDTwe41fsuWqmYeEPlaBkqCY8o8K2t6YxyKY70Y0yyujTitJ7/
NJp5uLEZDy1cIonhHEWf43mWB4dYBEe+iGaAxGDfYs6IBLSDXxUblTpa6HSQB11a
xa+D7DEOB+7E2ZnxODf9SQmAH0raTclTW07wE+6DpipKrSqHAY2sW1EZZNF6pwaA
gjPhyirYlin0TFHmBxjvFNoli50HOYdpCA2YQDcdSyBrkrUtwCy9z8eJ9cDzB9tm
nVfwidOj6NhbKokFGpa7p2mUU/353lWybIMkuCzplUOJAIBHwmpfmyYi66chGLwO
HR9ufr9IxlFnH9+OitpsRWPag5R/Q5jH4kua8MbSQzdAFJ4XESvCk2l2mofGNeq8
Z052sjVBnfbJuHv4iRdIwzlFw+HdR09bS1q0ztQglKYcHxfmw5Nld+Ik22q5tk6r
A/bNlUfQNGx+sJKNT1Bs9YGwdbw9fkSjtkLHAKLzO3dNxrq3L90bVXsBGC0ggyn9
GxIPRxMi21TLRt7FqCZf7M7kToyv/2OdWw484m4QoHRBIV76mqM=
=3MFY
-----END PGP SIGNATURE-----

--5cfywihpu4wl3i6q--
