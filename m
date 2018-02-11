Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeBKW5k (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 17:57:40 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:44835 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932160AbeBKW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 17:57:38 -0500
X-Google-Smtp-Source: AH8x2264s+cDNg9GKqEI6TFGp3JFm0181zTyyGOqJ25Opz9leZ111DO/U4HwVkRKt9YTMjMkz0v5Vg==
Date: Sun, 11 Feb 2018 23:57:35 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario.Limonciello@dell.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        dvhart@infradead.org, andy.shevchenko@gmail.com
Subject: Re: Dell SMBIOS initializing before backends are ready
Message-ID: <20180211225735.ql6gbi5oxpsnurkc@pali>
References: <8da25d14004a4bd6ac7415c5958bcfc8@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4nootal7f2ujdqhx"
Content-Disposition: inline
In-Reply-To: <8da25d14004a4bd6ac7415c5958bcfc8@ausx13mpc120.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4nootal7f2ujdqhx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 08 February 2018 18:23:23 Mario.Limonciello@dell.com wrote:
> After Paul's recent message regarding the odd wifi issue he had a=20
> comment I wanted to investigate:
>=20
> dell_smbios: "No dell-smbios drivers are loaded"
>=20
> Coming up early in boot.  This is a side effect of dell-smbios having two
> backend drivers that can be compiled as modules but no tie to force
> them to initialize before calls to dell_smbios_call.
>=20
> So I believe what is happening is dell_micmute_led_set is called from
> the HDA driver and calls dell_smbios_call early too.
>=20
> I haven't tried it on a platform with mic mute, but I suspect it might ca=
use
> the mic mute LED status to be wrong initially (but corrected later when=
=20
> toggled).
>=20
> Ideas that came to mind:
>=20
> 1) In dell_smbios_call if no backends loaded, explicitly do a symbol_requ=
est
> for both backends and run initialization at that time.
>=20
> If that works, that would also resolve if someone manually unloaded both
> backends but a kernel module still tried to perform a request.
>=20
> 2) Add a notifier chain for when the driver is ready (a backend is loaded)
> to all consumers of dell_smbios_call.  Don't let other modules call
> dell_smbios_call until notified.
> Don't let the HDA driver call dell_micmute_led_set either.
>=20
> 3) try_module_get during dell-smbios initialization for both the backends
>=20
> What's the correct way to address this?

I'm not really sure what is the best approach.

But in my opinion, if somebody call blocking function symbol_request()
then after function return, caller wants to use this symbol and expects
to be ready. Therefore I think that exported function
(dell_micmute_led_set) should probably ensure that everything is
initialized and after that continue... So maybe add "initialize & wait
until backends are ready" code into beginning of that function?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--4nootal7f2ujdqhx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWoDKXQAKCRCL8Mk9A+RD
Ul/JAKCWEu+aREZtzlPki5fyW+joy4CmowCeJjhjX32O/3/p2HNfQzKURWgSv9o=
=KXBJ
-----END PGP SIGNATURE-----

--4nootal7f2ujdqhx--
