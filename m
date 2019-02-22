Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA27C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC3920700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfBVRyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:54:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58916 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:54:48 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 102C380328; Fri, 22 Feb 2019 18:54:38 +0100 (CET)
Date:   Fri, 22 Feb 2019 18:54:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] PM / sleep: measure the time of filesystem syncing
Message-ID: <20190222175444.GA8264@amd>
References: <20190220161840.994-1-harry.pan@intel.com>
 <20190222154904.6260-1-harry.pan@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20190222154904.6260-1-harry.pan@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-02-22 23:49:04, Harry Pan wrote:
> This patch gives the reader an intuitive metric of the time cost by
> the kernel issuing a filesystem sync during system sleep; although
> developer can guess by the timestamp of next log or enable the ftrace
> power event for manual calculation, this manner is easier to read and
> benefits the automatic script.
>=20
> v2: simplify the variables, apply the simplest form of ktime API.
> v3: reduce conditional compilation, rectify profiling in better syntax
> v4: avoid interposition, profile on hibernation, rectify printk format
> v5: introduce sync helper shared by suspend, hibernate, and snapshot
>=20
> Signed-off-by: Harry Pan <harry.pan@intel.com>
> ---
>  include/linux/suspend.h  |  3 +++
>  kernel/power/hibernate.c |  5 +----
>  kernel/power/main.c      | 15 +++++++++++++++
>  kernel/power/suspend.c   | 13 +++++--------
>  kernel/power/user.c      |  5 +----
>  5 files changed, 25 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 3f529ad9a9d2..6b3ea9ea6a9e 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -425,6 +425,7 @@ void restore_processor_state(void);
>  /* kernel/power/main.c */
>  extern int register_pm_notifier(struct notifier_block *nb);
>  extern int unregister_pm_notifier(struct notifier_block *nb);
> +extern void ksys_sync_helper(void);
> =20
>  #define pm_notifier(fn, pri) {				\
>  	static struct notifier_block fn##_nb =3D			\
> @@ -462,6 +463,8 @@ static inline int unregister_pm_notifier(struct notif=
ier_block *nb)
>  	return 0;
>  }
> =20
> +static inline void ksys_sync_helper(void) {}
> +
>  #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
> =20
>  static inline bool pm_wakeup_pending(void) { return false; }
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index abef759de7c8..cc105ecd9c07 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -14,7 +14,6 @@
> =20
>  #include <linux/export.h>
>  #include <linux/suspend.h>
> -#include <linux/syscalls.h>
>  #include <linux/reboot.h>
>  #include <linux/string.h>
>  #include <linux/device.h>
> @@ -709,9 +708,7 @@ int hibernate(void)
>  		goto Exit;
>  	}
> =20
> -	pr_info("Syncing filesystems ... \n");
> -	ksys_sync();
> -	pr_info("done.\n");
> +	ksys_sync_helper();
> =20
>  	error =3D freeze_processes();
>  	if (error)
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 35b50823d83b..a08dcc743f31 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -16,6 +16,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/suspend.h>
> +#include <linux/syscalls.h>
> =20
>  #include "power.h"
> =20
> @@ -51,6 +52,20 @@ void unlock_system_sleep(void)
>  }
>  EXPORT_SYMBOL_GPL(unlock_system_sleep);
> =20
> +void ksys_sync_helper(void)
> +{
> +	ktime_t start;
> +	s64 elapsed_msecs;
> +
> +	start =3D ktime_get();
> +	ksys_sync();
> +	elapsed_msecs =3D ktime_to_ms(ktime_sub(ktime_get(), start));
> +	pr_info("Filesystems sync: %lld.%03lld seconds\n",
> +		elapsed_msecs / MSEC_PER_SEC,
> +		elapsed_msecs % MSEC_PER_SEC);
> +}

Sharing code is fine. Changing message, remove partial print before
long operation is not.

Adding timing is not, either. There are other ways to get that info.

NAK.
									Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxwN2QACgkQMOfwapXb+vJvBQCgkMRk0v/vPSFG3A+Sbq19oee0
8m8AnAsOmxyUQNmZVQPMn8p/jnaclXOJ
=myIT
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
