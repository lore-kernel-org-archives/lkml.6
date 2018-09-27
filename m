Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C219C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AC3216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AC3216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeI1EHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:07:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60385 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeI1EHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:07:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 20E9480892; Thu, 27 Sep 2018 23:47:00 +0200 (CEST)
Date:   Thu, 27 Sep 2018 23:46:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / core: Fix extra pm_runtime_enable on resume
Message-ID: <20180927214654.GA17346@amd>
References: <1537913455-43397-1-git-send-email-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <1537913455-43397-1-git-send-email-alcooperx@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-09-25 18:10:55, Al Cooper wrote:
> Matching pm_runtime_disable/pm_runtime_enable routines should be
> called for "direct_complete" devices during suspend/resume and there
> are cases where the pm_runtime_disable is skipped during suspend but
> pm_runtime_enable is still called during resume. This is a problem
> because the runtime enable state is really a counter and this can
> incorrectly enable pm_runtime when it should not be enabled. This
> happens for any direct_complete device doing an async suspend after
> the global variable "async_error" is set (which is set by any sync
> or async device's suspend error or early wake condition).
>=20
> This failure is very timing dependent but for testing and debug
> the following changes will make it happen more frequently.
> - Add an msleep(500) as the first line in async_suspend() in
>   drivers/base/power/main.c
> - Modify alarmtimer_suspend in kernel/time/alarmtimer.c to just
>   return -EBUSY
>=20
> To see the failure condition that's been fixed with this patch,
> enable dynamic debug for drivers/power/main.c and then run
> "rtcwake -s 2 -m standby" and grep for
> "skipping runtime enable during resume" messages.

Thanks for the patch...

Could / should we add some WARN_ONs to pm_runtime_{disable|enable} to
catch stuff like this?
								Pavel


> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/base/power/main.c | 21 +++++++++++++++++++--
>  include/linux/pm.h        |  1 +
>  2 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 3f68e2919dc5..2dc40662aae0 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -945,7 +945,13 @@ static int device_resume(struct device *dev, pm_mess=
age_t state, bool async)
> =20
>  	if (dev->power.direct_complete) {
>  		/* Match the pm_runtime_disable() in __device_suspend(). */
> -		pm_runtime_enable(dev);
> +		if (dev->power.pm_runtime_disabled) {
> +			pm_runtime_enable(dev);
> +			dev->power.pm_runtime_disabled =3D false;
> +		} else {
> +			pm_dev_dbg(dev, state,
> +				   "skipping runtime enable during ");
> +		}
>  		goto Complete;
>  	}
> =20
> @@ -1736,8 +1742,19 @@ static int __device_suspend(struct device *dev, pm=
_message_t state, bool async)
>  	if (dev->power.direct_complete) {
>  		if (pm_runtime_status_suspended(dev)) {
>  			pm_runtime_disable(dev);
> -			if (pm_runtime_status_suspended(dev))
> +			if (pm_runtime_status_suspended(dev)) {
> +				/*
> +				 * If any device's sync or async suspend fails
> +				 * and sets async_error, any async suspend for
> +				 * direct_complete devices after the failure
> +				 * will not execute the pm_runtime_disable
> +				 * above. This flag lets the async device's
> +				 * resume function (which is always run) know
> +				 * if a matching pm_runtime_enable is needed.
> +				 */
> +				dev->power.pm_runtime_disabled =3D true;
>  				goto Complete;
> +			}
> =20
>  			pm_runtime_enable(dev);
>  		}
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e723b78d8357..45738ad977fd 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -593,6 +593,7 @@ struct dev_pm_info {
>  	bool			is_late_suspended:1;
>  	bool			early_init:1;	/* Owned by the PM core */
>  	bool			direct_complete:1;	/* Owned by the PM core */
> +	unsigned int		pm_runtime_disabled:1;
>  	u32			driver_flags;
>  	spinlock_t		lock;
>  #ifdef CONFIG_PM_SLEEP

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlutT84ACgkQMOfwapXb+vIqNgCfT7SDfqeNpTsJUalVPOQvc9oU
cxsAoJpouWdyC+H3CrZkG3msOInZp9gc
=bIof
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
