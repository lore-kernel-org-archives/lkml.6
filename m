Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1586C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A392021A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A392021A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbeHHWUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:20:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38312 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbeHHWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:20:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7E22C80649; Wed,  8 Aug 2018 21:58:57 +0200 (CEST)
Date:   Wed, 8 Aug 2018 21:58:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] x86/ACPI/cstate: Output AMD on APCI C1 FFH MWAIT AMD
 systems
Message-ID: <20180808195856.GA20912@amd>
References: <20180808174735.3114-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20180808174735.3114-1-prarit@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-08 13:47:35, Prarit Bhargava wrote:
> commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
> systems") allows use of FFH for ACPI C1 but tools like cpupower and turbo=
stat
> display INTEL for the cstate description.
>=20
> Output "AMD" for AMD systems with FFH for ACPI C1.

Um, is it good idea?

First, you are changing kernel API.

> @@ -107,9 +108,14 @@ static long acpi_processor_ffh_cstate_probe_cpu(void=
 *_cx)
>  			"Monitor-Mwait will be used to enter C-%d state\n",
>  			cx->type);
>  	}
> -	snprintf(cx->desc,
> -			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> -			cx->address);
> +	if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
> +		snprintf(cx->desc,
> +			 ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> +			 cx->address);
> +	else
> +		snprintf(cx->desc,
> +			 ACPI_CX_DESC_LEN, "ACPI FFH AMD MWAIT 0x%x",
> +			 cx->address);

Second, I read it as "Intel MWAIT" instruction is used. Yes, AMD cpu can
use Intel MWAIT, too...

Third, there are more CPU vendors out there.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltrS4AACgkQMOfwapXb+vLDrwCeJYO1w+nU9m4bD6TP14FGFpoD
aLoAnRLbyQZlEHBLyv645/5dv7JJNqM/
=S8gu
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
