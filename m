Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A307C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26282054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26282054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeJXPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:18:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45516 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJXPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:18:04 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BFC1D807D7; Wed, 24 Oct 2018 08:51:16 +0200 (CEST)
Date:   Wed, 24 Oct 2018 08:51:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nickhu <nickhu@andestech.com>
Cc:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de, deanbo422@gmail.com, rjw@rjwysocki.net,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        zong@andestech.com, linux-pm@vger.kernel.org,
        alankao@andestech.com, green.hu@gmail.com
Subject: Re: [PATCH 1/1] nds32: Power management for nds32
Message-ID: <20181024065117.GA18779@amd>
References: <cover.1540349342.git.nickhu@andestech.com>
 <ccc18702a8d93c0a31e46f53c498b6d34c9c17e1.1540349342.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <ccc18702a8d93c0a31e46f53c498b6d34c9c17e1.1540349342.git.nickhu@andestech.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-24 11:40:07, Nickhu wrote:
> There are three sleep states in nds32:
> 	suspend to idle,
> 	suspend to standby,
> 	suspend to ram
>=20
> In suspend to ram, we use the 'standby' instruction to emulate
> power management device to hang the system util wakeup source
> send wakeup events to break the loop.
>=20
> First, we push the general purpose registers and system registers
> to stack. Second, we translate stack pointer to physical address
> and store to memory to save the stack pointer. Third, after write
> back and invalid the cache we hang in 'standby' intruction.
> When wakeup source trigger wake up events, the loop will be break
> and resume the system.
>=20
> Signed-off-by: Nickhu <nickhu@andestech.com>

Is "Nickhu" complete name?

> diff --git a/arch/nds32/kernel/pm.c b/arch/nds32/kernel/pm.c
> new file mode 100644
> index 000000000000..e1eaf3bac709
> --- /dev/null
> +++ b/arch/nds32/kernel/pm.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2008-2017 Andes Technology Corporation
> +
> +/*
> + * nds32 Power Management Routines
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License.
> + *
> + *  Abstract:
> + *
> + *    This program is for nds32 power management routines.
> + *
> + */

I'd get rid of "abstract" here, repeating GPL twice and "nds32 power
management routines" twice does not make much sense either.

> @@ -0,0 +1,129 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2017 Andes Technology Corporation */
> +
> +#include<asm/memory.h>

Missing space.

> +static int nointc_set_wake(struct irq_data *data, unsigned int on)
> +{
> +	unsigned long int_mask =3D __nds32__mfsr(NDS32_SR_INT_MASK);
> +	static bool is_bit_1[NR_IRQS] =3D {false};
> +	u32 bit =3D 1 << data->hwirq;
> +
> +	if (on) {
> +		if (int_mask & bit)
> +			is_bit_1[data->hwirq] =3D true;
> +		else
> +			is_bit_1[data->hwirq] =3D false;
> +
> +		int_mask |=3D bit;
> +		wake_mask |=3D bit;
> +	} else {
> +		if (!is_bit_1[data->hwirq])
> +			int_mask &=3D ~bit;
> +
> +		wake_mask &=3D ~bit;
> +		is_bit_1[data->hwirq] =3D false;
> +	}

Can we get rid of "is_bit_1" array here, and use normal bit operations
on another variable here?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQFmUACgkQMOfwapXb+vKtKgCgqujodsnnEp000PGVRDbR4LHy
iO0AnjEkvFReScr9wQvjGwSsmVf+UHL3
=Vddh
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
