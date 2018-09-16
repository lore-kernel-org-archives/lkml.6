Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B75AECE564
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01B72087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01B72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeIQB0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:26:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47036 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeIQB0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:26:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8183927DAE7
Received: by earth.universe (Postfix, from userid 1000)
        id C0DE73C0C45; Sun, 16 Sep 2018 13:08:36 +0200 (CEST)
Date:   Sun, 16 Sep 2018 13:08:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gpain@baylibre.com
Subject: Re: [PATCH v2 3/3] power: supply: cros: add property to detect
 connected ports
Message-ID: <20180916110836.3lu4jnsdphixkfka@earth.universe>
References: <20180810131349.3883-1-fparent@baylibre.com>
 <20180810131349.3883-4-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oswj5elxjckzkywq"
Content-Disposition: inline
In-Reply-To: <20180810131349.3883-4-fparent@baylibre.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oswj5elxjckzkywq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 10, 2018 at 03:13:49PM +0200, Fabien Parent wrote:
> When a port is connected but acting as a source, its 'online' and
> 'status' properties are identical to a port that is not connected. This
> makes it tedious for userspace to know for sure whether a port is
> connected or not.
>=20
> This commit adds a new property 'present' to reflect whether a port
> is connected or not.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---

I think it's better to just set use POWER_SUPPLY_STATUS_DISCHARGING
for USB_PD_PORT_POWER_SOURCE.

-- Sebastian

>=20
> V1 -> V2:
>   * No change
>=20
> ---
>  drivers/power/supply/cros_usbpd-charger.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index fe1502715e46..6307424f36ec 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -32,6 +32,7 @@ struct port_data {
>  	struct power_supply_desc psy_desc;
>  	int psy_usb_type;
>  	int psy_online;
> +	int psy_present;
>  	int psy_status;
>  	int psy_current_max;
>  	int psy_voltage_max_design;
> @@ -54,6 +55,7 @@ struct charger_data {
> =20
>  static enum power_supply_property cros_usbpd_charger_props[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> @@ -65,6 +67,7 @@ static enum power_supply_property cros_usbpd_charger_pr=
ops[] =3D {
> =20
>  static enum power_supply_property cros_usbpd_dedicated_charger_props[] =
=3D {
>  	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_PRESENT,
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
> @@ -205,18 +208,22 @@ static int cros_usbpd_charger_get_power_info(struct=
 port_data *port)
>  	case USB_PD_PORT_POWER_DISCONNECTED:
>  		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		port->psy_online =3D 0;
> +		port->psy_present =3D 0;
>  		break;
>  	case USB_PD_PORT_POWER_SOURCE:
>  		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		port->psy_online =3D 0;
> +		port->psy_present =3D 1;
>  		break;
>  	case USB_PD_PORT_POWER_SINK:
>  		port->psy_status =3D POWER_SUPPLY_STATUS_CHARGING;
>  		port->psy_online =3D 1;
> +		port->psy_present =3D 1;
>  		break;
>  	case USB_PD_PORT_POWER_SINK_NOT_CHARGING:
>  		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		port->psy_online =3D 1;
> +		port->psy_present =3D 1;
>  		break;
>  	default:
>  		dev_err(dev, "Unknown role %d\n", resp.role);
> @@ -363,6 +370,7 @@ static int cros_usbpd_charger_get_prop(struct power_s=
upply *psy,
>  		if (ec_device->mkbp_event_supported || port->psy_online)
>  			break;
>  		/* fall through */
> +	case POWER_SUPPLY_PROP_PRESENT:
>  	case POWER_SUPPLY_PROP_CURRENT_MAX:
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> @@ -381,6 +389,9 @@ static int cros_usbpd_charger_get_prop(struct power_s=
upply *psy,
>  	case POWER_SUPPLY_PROP_ONLINE:
>  		val->intval =3D port->psy_online;
>  		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D port->psy_present;
> +		break;
>  	case POWER_SUPPLY_PROP_STATUS:
>  		val->intval =3D port->psy_status;
>  		break;
> --=20
> 2.18.0
>=20

--oswj5elxjckzkywq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueObEACgkQ2O7X88g7
+pqZtA/+OedP3hkNeCb/M9BjX+RWzIA8dj4IdfEyI2ltcPVaniXmwZ4wqKJk/K8Y
ShErx8Ij+a9XW7jAJT4ENR2guzTADvbtNpKr1XDaijeiyqxjDRmaCHLuMKM3q+16
+WZq/oFw+fhqoXWKr2VXxhALiEXeciiSy1aUX6aCmLWNYur8pUP91piTFdRvi9sC
4hKwOdE29WXNrR7FnSi4/FnxKrJ9wMywL5GUIHBDDWGoNpaFn9/Spz18/8SXyqRB
R5Ap969B2nHmQ8ZQqipaMCaexWyVjj0OYtuJGkdyT5+ptDKfyOCz2xpxZkwfsEeW
7fga8i59hfb3sCfAJJ28jxcTU4SSrHFU1ve5hwz9I2DKqmHred5iCl1VQiWwFFBX
A7FhKnkLgfp1l1AmfDUUk2/yv0J5tQqXvKBVnWQwHdFNRwEy0IiD6vyOqi83MF48
0/u3N+sYgIDJgsIfe2tvrPOh6YXLV2MXkI4XX/sHTMEbj0cD3D9FfFI/bEQuGAbh
tg3aUKQZI4IUkRt131jvcTS7KxKK3hVhY3kSpmhuy5TN/Xt0Zp9eVVrNKAqxXuaX
pHL/bCjNj/GqJ2FhqbGczJIpecwlSnyOA6/ezNu85kJkkZR65yftNy08AR//lXJe
JUcTCX9xnZrjvd+OAUV9wH08doS5DfMbGFhxU9E0zC4FZUui/oo=
=jGjH
-----END PGP SIGNATURE-----

--oswj5elxjckzkywq--
