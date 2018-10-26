Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E94C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4896620834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4896620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJZRlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:41:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36989 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:41:10 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 76A0B808B1; Fri, 26 Oct 2018 11:04:51 +0200 (CEST)
Date:   Fri, 26 Oct 2018 11:04:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 03/15] Input: i8042 - enable keyboard
 wakeups by default when s2idle is used
Message-ID: <20181026090452.GB20200@amd>
References: <20181022102026.40869-1-sashal@kernel.org>
 <20181022102026.40869-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <20181022102026.40869-3-sashal@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-10-22 06:20:14, Sasha Levin wrote:
> From: Daniel Drake <drake@endlessm.com>
>=20
> [ Upstream commit 684bec1092b6991ff2a7751e8a763898576eb5c2 ]
>=20
> Previously, on typical consumer laptops, pressing a key on the keyboard
> when the system is in suspend would cause it to wake up (default or
> unconditional behaviour). This happens because the EC generates a SCI
> interrupt in this scenario.
>=20
> That is no longer true on modern laptops based on Intel WhiskeyLake,
> including Acer Swift SF314-55G, Asus UX333FA, Asus UX433FN and Asus
> UX533FD. We confirmed with Asus EC engineers that the "Modern Standby"
> design has been modified so that the EC no longer generates a SCI
> in this case; the keyboard controller itself should be used for wakeup.
>=20
> In order to retain the standard behaviour of being able to use the
> keyboard to wake up the system, enable serio wakeups by default on
> platforms that are using s2idle.

Behaviour change, not a bugfix. Someone may like their laptop sleeping
after keypress, we should not change it in the middle of -stable
series.


>=20
> Link: https://lkml.kernel.org/r/CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cp=
ZUGE--w8bQ@mail.gmail.com
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/input/serio/i8042.c | 29 ++++++++++++++++++++---------
>  include/linux/suspend.h     |  2 ++
>  kernel/power/suspend.c      |  6 ++++++
>  3 files changed, 28 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 824f4c1c1f31..6462f1798fbb 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -1392,15 +1392,26 @@ static void __init i8042_register_ports(void)
>  	for (i =3D 0; i < I8042_NUM_PORTS; i++) {
>  		struct serio *serio =3D i8042_ports[i].serio;
> =20
> -		if (serio) {
> -			printk(KERN_INFO "serio: %s at %#lx,%#lx irq %d\n",
> -				serio->name,
> -				(unsigned long) I8042_DATA_REG,
> -				(unsigned long) I8042_COMMAND_REG,
> -				i8042_ports[i].irq);
> -			serio_register_port(serio);
> -			device_set_wakeup_capable(&serio->dev, true);
> -		}
> +		if (!serio)
> +			continue;
> +
> +		printk(KERN_INFO "serio: %s at %#lx,%#lx irq %d\n",
> +			serio->name,
> +			(unsigned long) I8042_DATA_REG,
> +			(unsigned long) I8042_COMMAND_REG,
> +			i8042_ports[i].irq);
> +		serio_register_port(serio);
> +		device_set_wakeup_capable(&serio->dev, true);
> +
> +		/*
> +		 * On platforms using suspend-to-idle, allow the keyboard to
> +		 * wake up the system from sleep by enabling keyboard wakeups
> +		 * by default.  This is consistent with keyboard wakeup
> +		 * behavior on many platforms using suspend-to-RAM (ACPI S3)
> +		 * by default.
> +		 */
> +		if (pm_suspend_via_s2idle() && i =3D=3D I8042_KBD_PORT_NO)
> +			device_set_wakeup_enable(&serio->dev, true);
>  	}
>  }
> =20
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 8544357d92d0..950b56d255ac 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -251,6 +251,7 @@ static inline bool idle_should_enter_s2idle(void)
>  	return unlikely(s2idle_state =3D=3D S2IDLE_STATE_ENTER);
>  }
> =20
> +extern bool pm_suspend_via_s2idle(void);
>  extern void __init pm_states_init(void);
>  extern void s2idle_set_ops(const struct platform_s2idle_ops *ops);
>  extern void s2idle_wake(void);
> @@ -282,6 +283,7 @@ static inline void pm_set_suspend_via_firmware(void) =
{}
>  static inline void pm_set_resume_via_firmware(void) {}
>  static inline bool pm_suspend_via_firmware(void) { return false; }
>  static inline bool pm_resume_via_firmware(void) { return false; }
> +static inline bool pm_suspend_via_s2idle(void) { return false; }
> =20
>  static inline void suspend_set_ops(const struct platform_suspend_ops *op=
s) {}
>  static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index c0bc2c89697a..405e80219fe4 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -62,6 +62,12 @@ static DECLARE_WAIT_QUEUE_HEAD(s2idle_wait_head);
>  enum s2idle_states __read_mostly s2idle_state;
>  static DEFINE_RAW_SPINLOCK(s2idle_lock);
> =20
> +bool pm_suspend_via_s2idle(void)
> +{
> +	return mem_sleep_current =3D=3D PM_SUSPEND_TO_IDLE;
> +}
> +EXPORT_SYMBOL_GPL(pm_suspend_via_s2idle);
> +
>  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
>  {
>  	lock_system_sleep();

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvS2LQACgkQMOfwapXb+vKb0gCgvYmCVZjfhvgxjkzG2tyir2F4
EQIAn0oMvfcUwpRoRfrjUgzoDZtR5va2
=NZdJ
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
