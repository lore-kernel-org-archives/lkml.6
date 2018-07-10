Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A790C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8DA208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="prxMonvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8DA208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeGJKB5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751235AbeGJKBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:01:55 -0400
Received: from mail.kernel.org (host-091-097-077-058.ewe-ip-backbone.de [91.97.77.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE51120877;
        Tue, 10 Jul 2018 10:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531216915;
        bh=Ml68ZiTrD127mPxmTON/knQCM0kE47DWQF+YvPCFCbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prxMonvlBF6Uw3f9fOiLs6R2wZvIJltkt93M3Oo62+aOZhyJIAM2F8rt4NPbJmgf1
         Nb1XzhkluRWy+AZj92ukeQ4tZFw7hwIi6PD4UZbUyMu4KURqRQjAGQowfsm5AiuK9O
         QpZqjNFtK9U3SDUeadvwz71ATCQwY6H0lYTD3OXE=
Date:   Tue, 10 Jul 2018 12:01:52 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4] driver core: add a debugfs entry to show deferred
 devices
Message-ID: <20180710100152.bb562zgbv7yimb7r@earth.universe>
References: <20180708133459.24883-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3nly5mrcv7g5p6mv"
Content-Disposition: inline
In-Reply-To: <20180708133459.24883-1-javierm@redhat.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3nly5mrcv7g5p6mv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 08, 2018 at 03:34:59PM +0200, Javier Martinez Canillas wrote:
> With Device Trees (DT), the dependencies of the devices are defined in the
> DT, then the drivers parse that information to lookup the needed resources
> that have as dependencies.
>=20
> Since drivers and devices are registered in a non-deterministic way, it is
> possible that a device that is a dependency has not been registered yet by
> the time that is looked up.
>=20
> In this case the driver that requires this dependency cannot probe and has
> to defer it. So the driver core adds it to a list of deferred devices that
> is iterated again every time that a new driver is probed successfully.
>=20
> For debugging purposes it may be useful to know what are the devices whose
> probe function was deferred. Add a debugfs entry showing that information.
>=20
>   $ cat /sys/kernel/debug/devices_deferred
>   48070000.i2c:twl@48:bci
>   musb-hdrc.0.auto
>   omapdrm.0
>=20
> This information could be obtained partially by enabling debugging, but it
> means that the kernel log has to be parsed and the probe deferral balanced
> with the successes. This can be error probe and has to be done in a ad-hoc
> manner by everyone who needs to debug these kind of issues.
>=20
> Since the information is already known by the kernel, just show it to make
> it easier to debug.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>=20
> Changes since RFC v1:
> - Remove unneeded ret variable from deferred_devs_show()
>=20
> Changes since RFC v2:
> - Use DEFINE_SHOW_ATTRIBUTE() macro.
> - Don't propagate debugfs_create_file() error.
> - Remove IS_ENABLED(CONFIG_DEBUG_FS) guards.
> - Drop RFC prefix.
>=20
> Changes since v1:
> - Better explain in the commit message why this patch is useful.
> - Rename deferred_devices entry to devices_deferred.
> - Add an exit function and remove the debugfs entry.
>=20
> Changes since v2:
> - Add Andy Shevchenko and Mark Brown Reviewed-by tag.
> - Rebase on top of Greg's driver-core-next branch.
>=20
> Changes since v3:
> - Fixed a build warning caused by a wrong conflict resolution on v3.
>=20
>=20
>  drivers/base/dd.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 6ea9c5cece7..e85705e8440 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -16,6 +16,7 @@
>   * Copyright (c) 2007-2009 Novell Inc.
>   */
> =20
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> @@ -53,6 +54,7 @@ static DEFINE_MUTEX(deferred_probe_mutex);
>  static LIST_HEAD(deferred_probe_pending_list);
>  static LIST_HEAD(deferred_probe_active_list);
>  static atomic_t deferred_trigger_count =3D ATOMIC_INIT(0);
> +static struct dentry *deferred_devices;
> =20
>  /*
>   * In some cases, like suspend to RAM or hibernation, It might be reason=
able
> @@ -199,6 +201,24 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
> =20
> +/*
> + * deferred_devs_show() - Show the devices in the deferred probe pending=
 list.
> + */
> +static int deferred_devs_show(struct seq_file *s, void *data)
> +{
> +	struct device_private *curr;
> +
> +	mutex_lock(&deferred_probe_mutex);
> +
> +	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> +		seq_printf(s, "%s\n", dev_name(curr->device));
> +
> +	mutex_unlock(&deferred_probe_mutex);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(deferred_devs);
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -208,6 +228,9 @@ void device_unblock_probing(void)
>   */
>  static int deferred_probe_initcall(void)
>  {
> +	deferred_devices =3D debugfs_create_file("devices_deferred", 0444, NULL,
> +					       NULL, &deferred_devs_fops);
> +
>  	driver_deferred_probe_enable =3D true;
>  	driver_deferred_probe_trigger();
>  	/* Sort as many dependencies as possible before exiting initcalls */
> @@ -216,6 +239,12 @@ static int deferred_probe_initcall(void)
>  }
>  late_initcall(deferred_probe_initcall);
> =20
> +static void __exit deferred_probe_exit(void)
> +{
> +	debugfs_remove_recursive(deferred_devices);
> +}
> +__exitcall(deferred_probe_exit);
> +
>  /**
>   * device_is_bound() - Check if device is bound to a driver
>   * @dev: device to check
> --=20
> 2.17.1
>=20

--3nly5mrcv7g5p6mv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltEhA0ACgkQ2O7X88g7
+pq+yw/+PjMci0Doge2pmOKN7WNSiztfnZdd9QB+v+LQH+SdF6WaoxVxr+R55Jve
ZCmBUevwm+1j6qtPLXDH8exUOGrNqs9c7LBq9Pmn2xwEmznPxnZLMVYOjGoCL8xk
jRbqwkf1xrteTgwPsC0uNu5/D3Ja1nVXl6wt3uhYec8rtO8UaVQbxAnggXmzBVIe
MqtOAdW+AMR5SaoyF2KGWW47L8agg8kq+rxTncBOKMh/F4FIHYVokwcRLMNuZjW8
t11BZXZyq9VKiGns+xWvVzRMD47bTaH/rq2N9jntS+pXWC7s1GDxxdEyJGuuAm2q
kkAkPhVQjTgZat46r+SsUQM40yp/4yNfsh8ykUDYNm8KRNZsE91i96qqjxz+Iuir
wb8EuDmASbhmXF4zaNn5slUnpYu3O9KPoFM9MncvhiCaq7YoR59hjxImaG72qHG4
pxv1zq6ukxcG6calLAfhW/O/ujar3fX8t/2h79936gjolkwUywsQz8rmc72ZPiHP
+z3JLRO9mwJ4aI29GjZDkra9RPZ1E9wIcR0on/TftU5iK5qDtvpHqa6ogxFro1WZ
IYHFUJp7Rji+KkyBvidT97mEwG2pFTa3g2N5k8hfkUBsK0h35FzbnykTy5qxDFAm
ttFkMcuqi5AAvmPqooToKxhEQmjYbyehnwRhGW5nJv+GHsUeYto=
=CEsB
-----END PGP SIGNATURE-----

--3nly5mrcv7g5p6mv--
