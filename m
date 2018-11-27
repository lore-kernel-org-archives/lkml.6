Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AD8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046ED2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046ED2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeK0XYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:24:37 -0500
Received: from sauhun.de ([88.99.104.3]:58438 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeK0XYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:24:37 -0500
Received: from localhost (p54B33299.dip0.t-ipconnect.de [84.179.50.153])
        by pokefinder.org (Postfix) with ESMTPSA id EE5252E3542;
        Tue, 27 Nov 2018 13:26:49 +0100 (CET)
Date:   Tue, 27 Nov 2018 13:26:49 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>,
        Anders Berg <anders.berg@intel.com>
Subject: Re: [PATCH] i2c-axxia: properly handle master timeout
Message-ID: <20181127122649.GL1107@kunai>
References: <20181116132334.GA3951@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <20181116132334.GA3951@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 01:24:41PM +0000, Adamski, Krzysztof (Nokia - PL/Wr=
oclaw) wrote:
> According to Intel (R) Axxia TM Lionfish Communication Processor
> Peripheral Subsystem Hardware Reference Manual, the AXXIA I2C module
> have a programmable Master Wait Timer, which among others, checks the
> time between commands send in manual mode. When a timeout (25ms) passes,
> TSS bit is set in Master Interrupt Status register and a Stop command is
> issued by the hardware.
>=20
> The axxia_i2c_xfer(), does not properly handle this situation, however.
> For each message a separate axxia_i2c_xfer_msg() is called and this
> function incorrectly assumes that any interrupt might happen only when
> waiting for completion. This is mostly correct but there is one
> exception - a master timeout can trigger if enough time has passed
> between individual transfers. It will, by definition, happen between
> transfers when the interrupts are disabled by the code. If that happens,
> the hardware issues Stop command.
>=20
> The interrupt indicating timeout will not be triggered as soon as we
> enable them since the Master Interrupt Status is cleared when master
> mode is entered again (which happens before enabling irqs) meaning this
> error is lost and the transfer is continued even though the Stop was
> issued on the bus. The subsequent operations completes without error but
> a bogus value (0xFF in case of read) is read as the client device is
> confused because aborted transfer. No error is returned from
> master_xfer() making caller believe that a valid value was read.
>=20
> To fix the problem, the TSS bit (indicating timeout) in Master Interrupt
> Status register is checked before each transfer. If it is set, there was
> a timeout before this transfer and (as described above) the hardware
> already issued Stop command so the transaction should be aborted thus
> -ETIMEOUT is returned from the master_xfer() callback. In order to be
> sure no timeout was issued we can't just read the status just before
> starting new transaction as there will always be a small window of time
> (few CPU cycles at best) where this might still happen. For this reason
> we have to temporally disable the timer before checking for TSS bit.
> Disabling it will, however, clear the TSS bit so in order to preserve
> that information, we have to read it in ISR so we have to ensure that
> the TSS interrupt is not masked between transfers of one transaction.
> There is no need to call bus recovery or controller reinitialization if
> that happens so it's skipped.
>=20
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Applied to for-current, thanks!

Since you and/or Alexander are the ones doing functional changes to this
driver, would you be interested in maintaining it? This would ensure you
get notified when someone else has patches for it.


--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlv9OAkACgkQFA3kzBSg
KbaziBAArEZ0sGXu28wMRfuExuiJTBG/bbHH8uwVA/wpPNFT+fBZaHyOUAaBfGQr
P2E3qzfKb3BSP7diNIAVXYiMKw8ORSKePeQgSn03ltEZj1g4U/ucqmtslrytaQM/
KA20v96hJYLRS7BeDEw5AtLf/lB7xpes+MR5hwtVpjmwPrSz28tZPPfk48g+SDHF
3pMnfRNYLxgQFIxvm0wGzdb1i40RnbYpL+eKC0CVE3Gahl/ARDG6jjAH3WZM80Tm
ZziCO3w38ueN4EtXWzzD4MYgbPoh5Omv01Hal3bbZSELYk4v0KKItO7dXG6LnSbN
YkGHQhBcv4Nqbe0ETX64gMGsOJ/TV2gaIR01WIBXA6x+iVOXgnyxdKlqxrcrMebh
V6Y91VLhHIlXV3I0Xjf/RQ27PWkl4ar5rjWsU2Kp8hM6KDx8UMiOVchSVz0IRWD8
iDRJ7/n3c1j/Wx5sbUbZqqA9FcYIS2y402dCXjOJahhj8T+pHDjcQq/p22zn0pI9
2xbV8J8qISHmO18+NVUkT3aOpjjnWcJxGZz9mj1589RryDPzWX+vu9deQp0vKmf2
lnJi0pKxDKqiL9a7XJVRH6m3i6/4ip8qTkLtqia6/AwnN2GGxeV5elwNk9BIoAF8
Ylk/8FSsOKNzyEjjBWmfFVv1YtBY9bGcgsFhRB2k5VEdkEQCB2E=
=wGoM
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
