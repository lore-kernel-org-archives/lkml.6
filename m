Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D916AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B5D217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfBEVXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:23:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37673 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBEVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:23:12 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9E0F1805B6; Tue,  5 Feb 2019 22:23:02 +0100 (CET)
Date:   Tue, 5 Feb 2019 22:23:08 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / suspend: measure the time of filesystem syncing
Message-ID: <20190205212308.GA2816@amd>
References: <20190203052007.27392-1-harry.pan@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20190203052007.27392-1-harry.pan@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-02-03 13:20:07, Harry Pan wrote:
> This patch gives the reader an intuitive metric of the time cost by
> the kernel issuing a filesystem sync during suspend; although developer
> can guess by the timestamp of next log or enable the ftrace power event
> for manual calculation, this manner is easier to read and benefits the
> automatic script.

Do we really need this functionality?

As you explained, developers can already use next timestamp or
ftrace... and this is really not that interesting number.

								Pavel

> Signed-off-by: Harry Pan <harry.pan@intel.com>
> ---
>  kernel/power/suspend.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 0bd595a0b610..f3b7c64f2242 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -550,6 +550,8 @@ static void suspend_finish(void)
>  static int enter_state(suspend_state_t state)
>  {
>  	int error;
> +	ktime_t start, end, elapsed;
> +	unsigned int elapsed_msecs;
> =20
>  	trace_suspend_resume(TPS("suspend_enter"), state, true);
>  	if (state =3D=3D PM_SUSPEND_TO_IDLE) {
> @@ -570,9 +572,14 @@ static int enter_state(suspend_state_t state)
> =20
>  #ifndef CONFIG_SUSPEND_SKIP_SYNC
>  	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> +	start =3D ktime_get_boottime();
>  	pr_info("Syncing filesystems ... ");
>  	ksys_sync();
> -	pr_cont("done.\n");
> +	end =3D ktime_get_boottime();
> +	elapsed =3D ktime_sub(end, start);
> +	elapsed_msecs =3D ktime_to_ms(elapsed);
> +	pr_cont("(elapsed %d.%03d seconds) done.\n", elapsed_msecs / 1000,
> +		elapsed_msecs % 1000);
>  	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
>  #endif
> =20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxZ/rwACgkQMOfwapXb+vKxWQCffU49bj6+FkVTyZL3n0zebj5I
4vQAn2CajxkYlaWHbdifSUUeoQhe0y4+
=gDCM
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
