Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbeCFNid (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:38:33 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39663 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeCFNic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:38:32 -0500
X-Google-Smtp-Source: AG47ELufcuASyMo0hCkmKWjt72IeixCSanxXSPdccp9IfvFkKRChhRXFudRiUQr4XaPwmWGMCMFzzw==
X-ME-Sender: <xms:05meWgpuVSo62kJ0u1IU-gh4rqWbwEy39MGxq5n57Ms-UfHvzX-Hgg>
Date: Tue, 6 Mar 2018 21:42:05 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [RFC] rcu: Prevent expedite reporting within RCU read-side
 section
Message-ID: <20180306134205.lwmn3cgisnwkngcf@tardis>
References: <1520314318-30916-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pfxu7pqvkrvnrzvc"
Content-Disposition: inline
In-Reply-To: <1520314318-30916-1-git-send-email-byungchul.park@lge.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pfxu7pqvkrvnrzvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 02:31:58PM +0900, Byungchul Park wrote:
> Hello Paul and RCU folks,
>=20
> I am afraid I correctly understand and fix it. But I really wonder why
> sync_rcu_exp_handler() reports the quiescent state even in the case that
> current task is within a RCU read-side section. Do I miss something?
>=20
> If I correctly understand it and you agree with it, I can add more logic
> which make it more expedited by boosting current or making it urgent
> when we fail to report the quiescent state on the IPI.
>=20
> ----->8-----
> From 0b0191f506c19ce331a1fdb7c2c5a00fb23fbcf2 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul.park@lge.com>
> Date: Tue, 6 Mar 2018 13:54:41 +0900
> Subject: [RFC] rcu: Prevent expedite reporting within RCU read-side secti=
on
>=20
> We report the quiescent state for this cpu if it's out of RCU read-side
> section at the moment IPI was just fired during the expedite process.
>=20
> However, current code reports the quiescent state even in the case:
>=20
>    1) the current task is still within a RCU read-side section
>    2) the current task has been blocked within the RCU read-side section
>=20

If this happens, the task will queue itself in
rcu_preempt_note_context_switch() using rcu_preempt_ctxt_queue(). The gp
kthread will wait for this task to dequeue itself. IOW, we have other
mechanism to wait for this task other than bottom-up qs reporting tree.
So I think we are fine here.

Regards,
Boqun

> Since we don't get to the quiescent state yet in the case, we shouldn't
> report it but check it another time.
>=20
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/rcu/tree_exp.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 73e1d3d..cc69d14 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -731,13 +731,13 @@ static void sync_rcu_exp_handler(void *info)
>  	/*
>  	 * We are either exiting an RCU read-side critical section (negative
>  	 * values of t->rcu_read_lock_nesting) or are not in one at all
> -	 * (zero value of t->rcu_read_lock_nesting).  Or we are in an RCU
> -	 * read-side critical section that blocked before this expedited
> -	 * grace period started.  Either way, we can immediately report
> -	 * the quiescent state.
> +	 * (zero value of t->rcu_read_lock_nesting). We can immediately
> +	 * report the quiescent state.
>  	 */
> -	rdp =3D this_cpu_ptr(rsp->rda);
> -	rcu_report_exp_rdp(rsp, rdp, true);
> +	if (t->rcu_read_lock_nesting <=3D 0) {
> +		rdp =3D this_cpu_ptr(rsp->rda);
> +		rcu_report_exp_rdp(rsp, rdp, true);
> +	}
>  }
> =20
>  /**
> --=20
> 1.9.1
>=20

--pfxu7pqvkrvnrzvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqemn8ACgkQSXnow7UH
+rhg9Af8D2Gy9EriR85bXMNTebiYdi07gdNO3gFzL7MyscRHKzV1BZkRpDVTifg4
eoulZpXnJhTdSRYBVmjemv8KUQQ6jeUwodbVMfhfStWWB07BZHXzJ/JHzqNTl0oe
fOtuKnedHdNWLPTGEYXB1yQiCJx1Z4f8kstmLDFYvoZZtNNRgvjCsqBWqmY9o/1d
qVG+m2etRrNfFx1BJkAJz3Avck7PF1lHIJj9QgYX98i98orYEns/jE0jCbZXEQ1b
ZOmMNQvEQuem7vJCv+3+em12VVjTjUdkdp8jzl5D3xmoIEilHTItHXRQBM9C8bYl
v2gco+hAc/XwwwhghclI4LODV3OH4Q==
=b8kU
-----END PGP SIGNATURE-----

--pfxu7pqvkrvnrzvc--
