Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCXWD2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 18:03:28 -0400
Received: from orthanc.universe-factory.net ([104.238.176.138]:34814 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752167AbeCXWD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 18:03:27 -0400
Subject: Re: [PATCH] ftrace: fix stddev calculation in function profiler
 (again)
To: rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
References: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <b43d2270-dd11-0d42-7ba8-b647063dd0c1@universe-factory.net>
Date: Sat, 24 Mar 2018 23:03:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QIcSdTNdQbVUmkMYhAU2V7CSMryMLcVoU"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QIcSdTNdQbVUmkMYhAU2V7CSMryMLcVoU
Content-Type: multipart/mixed; boundary="gNe82BcB85CBDAM5Sw5K5mHqT6UTnAY85";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Message-ID: <b43d2270-dd11-0d42-7ba8-b647063dd0c1@universe-factory.net>
Subject: Re: [PATCH] ftrace: fix stddev calculation in function profiler
 (again)
References: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
In-Reply-To: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>

--gNe82BcB85CBDAM5Sw5K5mHqT6UTnAY85
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/24/2018 05:26 PM, Matthias Schiffer wrote:
> It is well-known that it is not possible to accurately calculate varian=
ces
> just by accumulating squared samples; in fact, such an approach can eve=
n
> result in negative numbers. An earlier attempt to fix the calculation
> referred to Welford's method, but did not implement it correctly, leadi=
ng
> to meeaningless output like the following:
>=20
>   nf_conntrack_proto_fini     50    373.523 us    7.470 us    323431595=
1 us
>=20
> Welford's method uses one do_div() in the tracing path; this cannot be
> avoided. The average time is added to struct ftrace_profile, so only a
> single division is required. I also considered the following alternativ=
es:
>=20
> 1) Only keeping the avg field and removing the aggregated time would
> greatly lead to severe rounding errors in calculating the total time ba=
sed
> on counter and avg.
>=20
> 2) Calculating both the old and the new average in profile_graph_return=
()
> instead of storing it in struct ftrace_profile would require a second
> division.
>=20
> 3) I managed to transform Welford's equations in a way that uses the to=
tal
> time instead of the average and requires only a single division.
> Unfortunately, the divisor is counter^3 in this case, easily overflowin=
g
> even 64bit integers.
>=20
> Ruling out the above alternatives, I chose the present approach to fix =
the
> issue.
>=20
> Fixes: e330b3bcd831 ("tracing: Show sample std dev in function profilin=
g")
> Fixes: 52d85d763086 ("ftrace: Fix stddev calculation in function profil=
er")
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>


Hmm, in further testing, I'm seeing profile_graph_return() being called
without rec->counter getting incremented a lot, completely throwing off t=
he
stddev calculation (and also slightly displacing the average). Is this
expected?

Should we possibly move the counter increment to profile_graph_return() i=
n
the CONFIG_FUNCTION_GRAPH_TRACER case, or introduce a second counter for
returns?

Matthias



> ---
>  kernel/trace/ftrace.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>=20
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index eac9ce2c57a2..16dce67b855a 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -460,7 +460,8 @@ struct ftrace_profile {
>  	unsigned long			counter;
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	unsigned long long		time;
> -	unsigned long long		time_squared;
> +	unsigned long long		avg;
> +	unsigned long long		stddev;
>  #endif
>  };
> =20
> @@ -580,7 +581,6 @@ static int function_stat_show(struct seq_file *m, v=
oid *v)
>  	int ret =3D 0;
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	static struct trace_seq s;
> -	unsigned long long avg;
>  	unsigned long long stddev;
>  #endif
>  	mutex_lock(&ftrace_profile_lock);
> @@ -592,9 +592,7 @@ static int function_stat_show(struct seq_file *m, v=
oid *v)
>  	}
> =20
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -	avg =3D rec->time;
> -	do_div(avg, rec->counter);
> -	if (tracing_thresh && (avg < tracing_thresh))
> +	if (tracing_thresh && (rec->avg < tracing_thresh))
>  		goto out;
>  #endif
> =20
> @@ -608,24 +606,19 @@ static int function_stat_show(struct seq_file *m,=
 void *v)
>  	if (rec->counter <=3D 1)
>  		stddev =3D 0;
>  	else {
> -		/*
> -		 * Apply Welford's method:
> -		 * s^2 =3D 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
> -		 */
> -		stddev =3D rec->counter * rec->time_squared -
> -			 rec->time * rec->time;
> +		stddev =3D rec->stddev;
> =20
>  		/*
>  		 * Divide only 1000 for ns^2 -> us^2 conversion.
>  		 * trace_print_graph_duration will divide 1000 again.
>  		 */
> -		do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
> +		do_div(stddev, 1000 * (rec->counter - 1));
>  	}
> =20
>  	trace_seq_init(&s);
>  	trace_print_graph_duration(rec->time, &s);
>  	trace_seq_puts(&s, "    ");
> -	trace_print_graph_duration(avg, &s);
> +	trace_print_graph_duration(rec->avg, &s);
>  	trace_seq_puts(&s, "    ");
>  	trace_print_graph_duration(stddev, &s);
>  	trace_print_seq(m, &s);
> @@ -905,8 +898,20 @@ static void profile_graph_return(struct ftrace_gra=
ph_ret *trace)
> =20
>  	rec =3D ftrace_find_profiled_func(stat, trace->func);
>  	if (rec) {
> +		unsigned long long avg, delta1, delta2;
> +
>  		rec->time +=3D calltime;
> -		rec->time_squared +=3D calltime * calltime;
> +
> +		/* Apply Welford's method */
> +		delta1 =3D calltime - rec->avg;
> +
> +		avg =3D rec->time;
> +		do_div(avg, rec->counter);
> +		rec->avg =3D avg;
> +
> +		delta2 =3D calltime - rec->avg;
> +
> +		rec->stddev +=3D delta1 * delta2;
>  	}
> =20
>   out:
>=20



--gNe82BcB85CBDAM5Sw5K5mHqT6UTnAY85--

--QIcSdTNdQbVUmkMYhAU2V7CSMryMLcVoU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlq2yywACgkQFu8/ZMsg
HZzUlQ//V+2NjGmqt0VsmuY8RnPrbRQ5KOb9/tQVL04Hs7Fz81KtSjPjEqzg7gJj
S8bTG/lcIGnIi3SDNITW1vDuA3SlSMO+sZ5cQStQ0le+uFJ/QkLv/AXMyCtDZHeX
mSsra6yMELuyHzA+j8KwseWuAKDih6ufM0d2B4deRHow4qzH7wgMCU/fNDHew5LH
JmezDPzSPJqRzFnrjDpUpfS5qNDTdx04PqyB22lBIwe6gvpzb4d/Q18YdhXVog6j
sOQEdHKKUhwmVcHjpMrTFcMuO1uDvQvk0NIRyTRE6bNaP6hLukasvjPPDexUiBKF
EUJ/faUkqZmutdUV/0o+/TzAkw8RuDcrGtlELS4L4b2u82XkGSu4WvfJPN9oAgCU
fcuKpJBO2apUkHDb3BPg6dtrkID28LhE6nHmQTVhcotrepUlOgJ3MeoPd6L9hb9b
7/qXU8JtMohapVPeodnHU6RLOoxaDVXF7+Po9GlQwsKDlJFsJvcDUt1s5a+Fkw/B
NYH2N4gko9HjyYPMsictFmz23/HQARQ3Gnw9ehX1wtBg3shyBX+Wz6foZVCZ4oeX
zd3UDi124IOu3ES+r0LBvVMKcuyRwCJ/iwQyCP/BBGVkSfjEAy6xYuOYnFW2PvI/
2lTwyPzTaExe5ETPQ5ZSxAUktDSh/bK+Ftxr8Yfe7bPmhKQ1snQ=
=70Z9
-----END PGP SIGNATURE-----

--QIcSdTNdQbVUmkMYhAU2V7CSMryMLcVoU--
