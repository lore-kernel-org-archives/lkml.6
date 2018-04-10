Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeDJK65 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752723AbeDJK6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:58:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90E421745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Tue, 10 Apr 2018 12:58:41 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] battery: Add the ThinkPad battery status quirk
Message-ID: <20180410105841.ne26heazhwwqjx7v@earth.universe>
References: <20180410090643.GA26554@thinkpad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xdduhbagyxsnx5o6"
Content-Disposition: inline
In-Reply-To: <20180410090643.GA26554@thinkpad>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xdduhbagyxsnx5o6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 10, 2018 at 11:06:43AM +0200, Ognjen Galic wrote:
> The EC/ACPI firmware on Lenovo ThinkPads used to report a status
> of "Unknown" when the battery is between the charge start and charge
> stop thresholds. On Windows, it reports "Not Charging" so the quirk
> has been added to fix the "Unknown" state.
>=20
> The chosen new state when the battery is not charging is "Fully Charged"
> because a status of "Not Charging" breaks almost all applications in
> userspace that depend on upower, because upower in itself can't handle
> a state of "Not Charging", defaulting to "Unknown".
>=20
> When we report "Fully Charged" instead of "Unknown", the userspace handles
> everything just fine, displaying for example: "Fully Charged, 59%" in Xfc=
e.

This probably breaks dual-battery Thinkpads, that charges batteries
alternating (so one of them is "not charging" without being "fully
charged"). The correct fix is to teach upower the "not charging"
state. It exists since the existance of the power supply kernel API,
so missing support is a bug in UPower.

-- Sebastian

> This is a re-write of: https://patchwork.kernel.org/patch/10205359/
>=20
> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
> ---
>  drivers/acpi/battery.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index bdb24d63..cb4457a7 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -74,6 +74,7 @@ static async_cookie_t async_cookie;
>  static bool battery_driver_registered;
>  static int battery_bix_broken_package;
>  static int battery_notification_delay_ms;
> +static int battery_quirk_thinkpad_full;
>  static unsigned int cache_time =3D 1000;
>  module_param(cache_time, uint, 0644);
>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> @@ -233,7 +234,8 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
>  			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
>  		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> -		else if (acpi_battery_is_charged(battery))
> +		else if (acpi_battery_is_charged(battery) ||
> +				battery_quirk_thinkpad_full)
>  			val->intval =3D POWER_SUPPLY_STATUS_FULL;
>  		else
>  			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> @@ -1332,6 +1334,13 @@ battery_notification_delay_quirk(const struct dmi_=
system_id *d)
>  	return 0;
>  }
> =20
> +static int __init
> +battery_thinkpad_full_charged_quirk(const struct dmi_system_id *d)
> +{
> +	battery_quirk_thinkpad_full =3D 1;
> +	return 0;
> +}
> +
>  static const struct dmi_system_id bat_dmi_table[] __initconst =3D {
>  	{
>  		.callback =3D battery_bix_broken_package_quirk,
> @@ -1349,6 +1358,14 @@ static const struct dmi_system_id bat_dmi_table[] =
__initconst =3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
>  		},
>  	},
> +	{
> +		.callback =3D battery_thinkpad_full_charged_quirk,
> +		.ident =3D "Lenovo ThinkPad",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
> +		},
> +	},
>  	{},
>  };
> =20
> --=20
> 2.15.1
>=20

--xdduhbagyxsnx5o6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrMmN4ACgkQ2O7X88g7
+poLyA/+OLEsFtx0+jx271R1cjQPdfw0Z2TrubsgOJ7pSpak7d85SEYcSjZLh0/R
z6hx7nHHnFf5sRgTeYKR8zv+FvxxPmiPZQ2mm7a1KJXUXzcAMKPSJkCQLExWiC9S
2zs1eDbNHSbuW/Fx+Vxcs+iqr0c4g/OLWNx0axPMV9C4B0tPsom4fWYcJ7hQESmo
laUiQTq0GfnB68hx76rUb+Qho4JEBf6PK50uDGeTVZKsuekAPZn9F6BAiSkw41Xo
zvO2amLUSPfTRU0nZfMPWlNuxatEaJ2goP6f0JazNm2dkjvp64ku9lH+B7FpzYS4
dDJbT321NMXiBsnUgd9I5oO/n3LbG6Ufm+Y/Xs4FNt7RCQHlGSywLPsO4eFcFkXF
m3nQOOn0WMJapX7YShZmwccM+uJ0L3xx6tsmQ6pduyA0iShRD3oMtHGzewcXbeZM
T5RxRF7M+SHWqDJfCzk/ppPPgytnVIl7NsyQRYq0Guv+2cKKCSPlb0higxME9nxJ
ndZNbcwcPSIg4nbt+zPfPukCA4ypJPRnkj8pIHHbeAU8bgLvDTWxblp2kWOD4PLX
FeGry8sGh4YuKnHqZxTgwqdFgTZa6ABGE9w9/q9pORNIzQJPKoxpTc1N9uglr9qh
xY6wS7eedJFOedm9mFC8rqQgWx1nnCaz9A0nN/kEfy3xpz2u1Mg=
=lzwG
-----END PGP SIGNATURE-----

--xdduhbagyxsnx5o6--
