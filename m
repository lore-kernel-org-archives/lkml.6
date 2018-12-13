Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E19BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A152075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A152075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbeLMWUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:20:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48114 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeLMWUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:20:04 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6CF258094D; Thu, 13 Dec 2018 23:19:57 +0100 (CET)
Date:   Thu, 13 Dec 2018 23:20:00 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        Sameer Nanda <snanda@chromium.org>, bleung@chromium.org,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com,
        kernel@collabora.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v3 1/2] power: supply: add input voltage limit property
Message-ID: <20181213222000.GA12302@amd>
References: <20181213120944.30967-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20181213120944.30967-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is part of the Pixel C's thermal management strategy to effectively
> limit the input power to 5V 3A when the screen is on. When the screen is
> on, the display, the CPU, and the GPU all contribute more heat to the
> system than while the screen is off, and we made a tradeoff to throttle
> the charger in order to give more of the thermal budget to those other
> components.
>=20
> So there's nothing fundamentally broken about the hardware that would
> cause the Pixel C to malfunction if we were charging at 9V or 12V instead
> of 5V when the screen is on, ie if userspace doesn't change this.
>=20
> What would happen is that you wouldn't meet Google's skin temperature
> targets on the system if the charger was allowed to run at 9V or 12V with
> the screen on.
>=20
> For folks hacking on Pixel Cs (which is now outside of Google's official
> support window for Android) and customizing their own kernel and userspace
> this would be acceptable, but we wanted to expose this feature in the
> power supply properties because the feature does exist in the Emedded
> Controller firmware of the Pixel C and all of Google's Chromebooks with
> USB-C made since 2015 in case someone running an up to date kernel wanted
> to limit the charging power for thermal or other reasons.
>=20
> This patch exposes a new property, similar to input current limit, to
> re-configure the maximum voltage from the external supply at runtime
> based on system-level knowledge or user input.

Could we get power input limit, instead?

That is what you really want, it is more generally useful, and it is
what current input limit should have been, in the first place...

Thanks,
									Pavel

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> ---
>=20
> Changes in v3:
> - Improve commit log and documentation with Benson comments.
>=20
> Changes in v2:
> - Document the new property in ABI/testing/sysfs-class-power.
> - Add the Reviewed-by Guenter Roeck tag.
>=20
>  Documentation/ABI/testing/sysfs-class-power | 15 +++++++++++++++
>  Documentation/power/power_supply_class.txt  |  2 ++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  4 files changed, 19 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 5e23e22dce1b..6dee5c105a28 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -335,6 +335,21 @@ Description:
>  		Access: Read, Write
>  		Valid values: Represented in microamps
> =20
> +What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
> +Date:		Nov 2018
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		This entry configures the incoming VBUS voltage limit currently
> +		set in the supply. Normally this is configured based on
> +		system-level knowledge or user input (e.g. This is part of the
> +		Pixel C's thermal management strategy to effectively limit the
> +		input power to 5V when the screen is on to meet Google's skin
> +		temperature targets). Note that this feature should not be
> +		used for safety critical things.
> +
> +		Access: Read, Write
> +		Valid values: Represented in microvolts
> +
>  What:		/sys/class/power_supply/<supply_name>/online,
>  Date:		May 2007
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/Documentation/power/power_supply_class.txt b/Documentation/p=
ower/power_supply_class.txt
> index 300d37896e51..7b4be615b4f8 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -137,6 +137,8 @@ power supply object.
> =20
>  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicat=
es
>  the current drawn from a charging source.
> +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger. Indicat=
es
> +the voltage limit from a charging source.
> =20
>  CHARGE_CONTROL_LIMIT - current charge control limit setting
>  CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index dce24f596160..5848742ebb59 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -275,6 +275,7 @@ static struct device_attribute power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(charge_control_limit),
>  	POWER_SUPPLY_ATTR(charge_control_limit_max),
>  	POWER_SUPPLY_ATTR(input_current_limit),
> +	POWER_SUPPLY_ATTR(input_voltage_limit),
>  	POWER_SUPPLY_ATTR(energy_full_design),
>  	POWER_SUPPLY_ATTR(energy_empty_design),
>  	POWER_SUPPLY_ATTR(energy_full),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index f80769175c56..608ba88e32ee 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -122,6 +122,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_FULL,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwS2xAACgkQMOfwapXb+vL80gCffJJ8LX+9Pw6LanOpLuhVUZ7J
t0MAnRevqHx9P9HdNZDaii0EL7TlWroI
=eJIb
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
