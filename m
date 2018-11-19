Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B32CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AA42080F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="GqlOySVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AA42080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeKSTAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:00:16 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:17216 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeKSTAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1542616633;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=4rp0IOcMRXkarWXTJM0fuZsUjRA4O3qB2gXsLUSZgMY=;
        b=GqlOySVnJHlrh1yplzP+l8BbXA+NsiKgGGJslAs0SfLnAD6MnOfd0HS71UuOwmdV/C
        SzIQTLjQnl5JojpwdNIsuHDEq+8jjiJyLQocO5k5jNqYdkHhW8RmnyypQ1qydKOhA0Ke
        mg+xMfV3E6iaYmYPbswPhzUUXvVuBBvm5e4k81xcFls0eL1/BE+TkzybwXXlSxpEQkmu
        dF7//yVH1XluMFWEayWij92rhPfDYnnqWT0NT5xpzfVLtdjHJE8hefJR6gDD1qORoeHT
        lcK5Rin+hYTm/3fAY1/oPf5iWqJ0VYJjbTtJ3BOPsqluART558w+SXXxt4anm7Xa3zG5
        QkNA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/zowDCvpOU="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.4 DYNA|AUTH)
        with ESMTPSA id c01a4cuAJ8b7Anh
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 19 Nov 2018 09:37:07 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/5] gnss: sirf: power on logic for devices without wakeup signal
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20181118215801.12280-3-andreas@kemnade.info>
Date:   Mon, 19 Nov 2018 09:37:06 +0100
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <55CBD60B-B1CC-46DE-99D8-980D1239E5FF@goldelico.com>
References: <20181118215801.12280-1-andreas@kemnade.info> <20181118215801.12280-3-andreas@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 18.11.2018 um 22:57 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> Some Wi2Wi devices do not have a wakeup output, so device state can
> only be indirectly detected by looking whether there is communitcation
> over the serial lines.
> Additionally it checks for the initial state of the device during
> probing to ensure it is off.
> Timeout values need to be increased, because the reaction on serial =
line
> is slower and are in line  with previous patches by
> Neil Brown <neilb@suse.de> and  H. Nikolaus Schaller =
<hns@goldelico.com>.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> drivers/gnss/sirf.c | 97 =
+++++++++++++++++++++++++++++++++++------------------
> 1 file changed, 65 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index b5efbb062316..6a0e5c0a2d62 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -22,8 +22,8 @@
>=20
> #define SIRF_BOOT_DELAY			500
> #define SIRF_ON_OFF_PULSE_TIME		100
> -#define SIRF_ACTIVATE_TIMEOUT		200
> -#define SIRF_HIBERNATE_TIMEOUT		200
> +#define SIRF_ACTIVATE_TIMEOUT		1000
> +#define SIRF_HIBERNATE_TIMEOUT		1000
>=20
> struct sirf_data {
> 	struct gnss_device *gdev;
> @@ -45,26 +45,14 @@ static int sirf_open(struct gnss_device *gdev)
> 	int ret;
>=20
> 	data->opened =3D true;
> -	ret =3D serdev_device_open(serdev);
> -	if (ret)
> -		return ret;
> -
> -	serdev_device_set_baudrate(serdev, data->speed);
> -	serdev_device_set_flow_control(serdev, false);
>=20
> 	ret =3D pm_runtime_get_sync(&serdev->dev);
> 	if (ret < 0) {
> 		dev_err(&gdev->dev, "failed to runtime resume: %d\n", =
ret);
> 		pm_runtime_put_noidle(&serdev->dev);
> 		data->opened =3D false;
> -		goto err_close;
> 	}
>=20
> -	return 0;
> -
> -err_close:
> -	serdev_device_close(serdev);
> -
> 	return ret;
> }
>=20
> @@ -73,8 +61,6 @@ static void sirf_close(struct gnss_device *gdev)
> 	struct sirf_data *data =3D gnss_get_drvdata(gdev);
> 	struct serdev_device *serdev =3D data->serdev;
>=20
> -	serdev_device_close(serdev);
> -
> 	pm_runtime_put(&serdev->dev);
> 	data->opened =3D false;
> }
> @@ -109,6 +95,11 @@ static int sirf_receive_buf(struct serdev_device =
*serdev,
> 	struct sirf_data *data =3D serdev_device_get_drvdata(serdev);
> 	struct gnss_device *gdev =3D data->gdev;
>=20
> +	if ((!data->wakeup) && (!data->active)) {
> +		data->active =3D 1;
> +		wake_up_interruptible(&data->power_wait);
> +	}
> +
> 	/*
> 	 * we might come here everytime when runtime is resumed
> 	 * and data is received. Two cases are possible
> @@ -149,6 +140,25 @@ static int sirf_wait_for_power_state(struct =
sirf_data *data, bool active,
> {
> 	int ret;
>=20
> +	/* no wakeup pin, success condition is that
> +	 * no byte comes in in the period
> +	 */
> +	if ((!data->wakeup) && (!active) && (data->active)) {
> +		/* some bytes might come, so sleep a bit first */
> +		msleep(timeout);
> +		data->active =3D false;
> +		ret =3D =
wait_event_interruptible_timeout(data->power_wait,
> +			data->active =3D=3D true, =
msecs_to_jiffies(timeout));
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		/* we are still getting woken up -> timeout */
> +		if (ret > 0)
> +			return -ETIMEDOUT;
> +		return 0;
> +	}
> +
> 	ret =3D wait_event_interruptible_timeout(data->power_wait,
> 			data->active =3D=3D active, =
msecs_to_jiffies(timeout));
> 	if (ret < 0)
> @@ -203,21 +213,48 @@ static int sirf_set_active(struct sirf_data =
*data, bool active)
> static int sirf_runtime_suspend(struct device *dev)
> {
> 	struct sirf_data *data =3D dev_get_drvdata(dev);
> +	int ret;
>=20
> 	if (!data->on_off)
> 		return regulator_disable(data->vcc);
> +	ret =3D sirf_set_active(data, false);
>=20
> -	return sirf_set_active(data, false);
> +	if (ret)
> +		dev_err(dev, "failed to deactivate");
> +
> +	/* we should close it anyways, so the following receptions
> +	 * will not run into the empty
> +	 */
> +	serdev_device_close(data->serdev);
> +	return 0;
> }
>=20
> static int sirf_runtime_resume(struct device *dev)
> {
> +	int ret;
> 	struct sirf_data *data =3D dev_get_drvdata(dev);
> +	ret =3D serdev_device_open(data->serdev);
> +	if (ret)
> +		return ret;
>=20
> -	if (!data->on_off)
> -		return regulator_enable(data->vcc);
> +	serdev_device_set_baudrate(data->serdev, data->speed);
> +	serdev_device_set_flow_control(data->serdev, false);
> +
> +	if (!data->on_off) {
> +		ret =3D regulator_enable(data->vcc);
> +		if (ret)
> +			goto err_close_serdev;
> +	}
> +	ret =3D sirf_set_active(data, true);
> +
> +	if (!ret)
> +		return 0;
>=20
> -	return sirf_set_active(data, true);
> +	if (!data->on_off)
> +		regulator_disable(data->vcc);
> +err_close_serdev:
> +	serdev_device_close(data->serdev);
> +	return ret;
> }
>=20
> static int __maybe_unused sirf_suspend(struct device *dev)
> @@ -311,18 +348,6 @@ static int sirf_probe(struct serdev_device =
*serdev)
> 	if (data->on_off) {
> 		data->wakeup =3D devm_gpiod_get_optional(dev, =
"sirf,wakeup",
> 				GPIOD_IN);
> -		if (IS_ERR(data->wakeup))
> -			goto err_put_device;
> -
> -		/*
> -		 * Configurations where WAKEUP has been left not =
connected,
> -		 * are currently not supported.
> -		 */
> -		if (!data->wakeup) {
> -			dev_err(dev, "no wakeup gpio specified\n");
> -			ret =3D -ENODEV;
> -			goto err_put_device;
> -		}
> 	}
>=20
> 	if (data->wakeup) {
> @@ -352,6 +377,13 @@ static int sirf_probe(struct serdev_device =
*serdev)
> 	if (IS_ENABLED(CONFIG_PM)) {
> 		pm_runtime_set_suspended(dev);	/* clear runtime_error =
flag */
> 		pm_runtime_enable(dev);
> +		/* device might be enabled at boot, so lets first enable =
it,
> +		 * then disable it to bring it into a clear state
> +		 */

That is an interesting trick to solve the "device is powered on but =
kernel does
not know" problem.

The assumption to make your trick work is that there is nobody besides =
the
running kernel who can turn on/off the device so that after this =
operation,
the kernel can simply track the power state in a boolean flag.

Since the power control gpio is grabbed by this driver, it can't be =
exported
to user-space and hence I think we can take this assumption for granted.

> +		ret =3D pm_runtime_get_sync(dev);
> +		if (ret)
> +			goto err_disable_rpm;
> +		pm_runtime_put(dev);
> 	} else {
> 		ret =3D sirf_runtime_resume(dev);
> 		if (ret < 0)
> @@ -401,6 +433,7 @@ static const struct of_device_id sirf_of_match[] =3D=
 {
> 	{ .compatible =3D "linx,r4" },
> 	{ .compatible =3D "wi2wi,w2sg0008i" },
> 	{ .compatible =3D "wi2wi,w2sg0084i" },
> +	{ .compatible =3D "wi2wi,w2sg0004" },
> 	{},
> };
> MODULE_DEVICE_TABLE(of, sirf_of_match);
> --=20
> 2.11.0
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel

BR,
Nikolaus

