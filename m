Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeCUOEa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:04:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49713 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCUOE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:04:27 -0400
Date: Wed, 21 Mar 2018 15:04:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, andrew.smirnov@gmail.com,
        akpm@linux-foundation.org, broonie@kernel.org, arnd@arndb.de,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI / PM: Use register_reboot_notifier() instead of
 pm_power_off_prepare
Message-ID: <20180321140422.GA10700@amd>
References: <7ff55372818461feed4b0550d5f88edce2cc7d41.1521631678.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <7ff55372818461feed4b0550d5f88edce2cc7d41.1521631678.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-03-21 19:30:16, Baolin Wang wrote:
> We can register one notifier through register_reboot_notifier() function =
to
> prepare to power off the system, then we can remove the 'pm_power_off_pre=
pare'
> hook in following patch.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Note: Please help to review carefully, since I have no platform to test
> this conversion.
>=20
> I saw there is another reboot notifier in this driver, I am not sure the
> orders between them. I can change the priority of notifier to keep their
> orders if it is necessary.

I don't understand why this is good idea... and you should really test
it. I'm sure you can find PC or notebook somewhere...
								Pavel

>  drivers/acpi/sleep.c |   22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 46cde091..b3de894 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -1229,14 +1229,24 @@ static void acpi_sleep_hibernate_setup(void)
>  static inline void acpi_sleep_hibernate_setup(void) {}
>  #endif /* !CONFIG_HIBERNATION */
> =20
> -static void acpi_power_off_prepare(void)
> +static int acpi_reboot_notify(struct notifier_block *this, unsigned long=
 code,
> +			      void *x)
>  {
> -	/* Prepare to power off the system */
> -	acpi_sleep_prepare(ACPI_STATE_S5);
> -	acpi_disable_all_gpes();
> -	acpi_os_wait_events_complete();
> +	if (code =3D=3D SYSTEM_POWER_OFF) {
> +		/* Prepare to power off the system */
> +		acpi_sleep_prepare(ACPI_STATE_S5);
> +		acpi_disable_all_gpes();
> +		acpi_os_wait_events_complete();
> +	}
> +
> +	return NOTIFY_DONE;
>  }
> =20
> +static struct notifier_block acpi_reboot_notifier =3D {
> +	.notifier_call	=3D acpi_reboot_notify,
> +	.priority	=3D 0,
> +};
> +
>  static void acpi_power_off(void)
>  {
>  	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
> @@ -1261,7 +1271,7 @@ int __init acpi_sleep_init(void)
> =20
>  	if (acpi_sleep_state_supported(ACPI_STATE_S5)) {
>  		sleep_states[ACPI_STATE_S5] =3D 1;
> -		pm_power_off_prepare =3D acpi_power_off_prepare;
> +		register_reboot_notifier(&acpi_reboot_notifier);
>  		pm_power_off =3D acpi_power_off;
>  	} else {
>  		acpi_no_s5 =3D true;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqyZmYACgkQMOfwapXb+vKPiwCghfQwm3ymuaDQlGMODFJv5DfW
MRUAn0xM9yJPKHv9cFUaFvS37B8w8/yx
=A/gx
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
