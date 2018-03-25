Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753808AbeCYRJm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 13:09:42 -0400
Received: from orthanc.universe-factory.net ([104.238.176.138]:32772 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753758AbeCYRJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 13:09:41 -0400
Subject: Re: [PATCH] ftrace: fix stddev calculation in function profiler
 (again)
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
References: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
 <b43d2270-dd11-0d42-7ba8-b647063dd0c1@universe-factory.net>
Message-ID: <41987dff-d05f-168f-2662-ddd69eed11dc@universe-factory.net>
Date: Sun, 25 Mar 2018 19:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b43d2270-dd11-0d42-7ba8-b647063dd0c1@universe-factory.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="q15pmqLmdL7Oc1MgbQD8WZkGld68p0wnD"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q15pmqLmdL7Oc1MgbQD8WZkGld68p0wnD
Content-Type: multipart/mixed; boundary="r3tWRYhNo8n8Qo5GrDBXfjn4eMIUUAoFw";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Message-ID: <41987dff-d05f-168f-2662-ddd69eed11dc@universe-factory.net>
Subject: Re: [PATCH] ftrace: fix stddev calculation in function profiler
 (again)
References: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
 <b43d2270-dd11-0d42-7ba8-b647063dd0c1@universe-factory.net>
In-Reply-To: <b43d2270-dd11-0d42-7ba8-b647063dd0c1@universe-factory.net>

--r3tWRYhNo8n8Qo5GrDBXfjn4eMIUUAoFw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/24/2018 11:03 PM, Matthias Schiffer wrote:
> On 03/24/2018 05:26 PM, Matthias Schiffer wrote:
>> It is well-known that it is not possible to accurately calculate varia=
nces
>> just by accumulating squared samples; in fact, such an approach can ev=
en
>> result in negative numbers. An earlier attempt to fix the calculation
>> referred to Welford's method, but did not implement it correctly, lead=
ing
>> to meeaningless output like the following:
>>
>>   nf_conntrack_proto_fini     50    373.523 us    7.470 us    32343159=
51 us
>>
>> Welford's method uses one do_div() in the tracing path; this cannot be=

>> avoided. The average time is added to struct ftrace_profile, so only a=

>> single division is required. I also considered the following alternati=
ves:
>>
>> 1) Only keeping the avg field and removing the aggregated time would
>> greatly lead to severe rounding errors in calculating the total time b=
ased
>> on counter and avg.
>>
>> 2) Calculating both the old and the new average in profile_graph_retur=
n()
>> instead of storing it in struct ftrace_profile would require a second
>> division.
>>
>> 3) I managed to transform Welford's equations in a way that uses the t=
otal
>> time instead of the average and requires only a single division.
>> Unfortunately, the divisor is counter^3 in this case, easily overflowi=
ng
>> even 64bit integers.
>>
>> Ruling out the above alternatives, I chose the present approach to fix=
 the
>> issue.
>>
>> Fixes: e330b3bcd831 ("tracing: Show sample std dev in function profili=
ng")
>> Fixes: 52d85d763086 ("ftrace: Fix stddev calculation in function profi=
ler")
>> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
>=20
>=20
> Hmm, in further testing, I'm seeing profile_graph_return() being called=

> without rec->counter getting incremented a lot, completely throwing off=
 the
> stddev calculation (and also slightly displacing the average). Is this
> expected?
>=20
> Should we possibly move the counter increment to profile_graph_return()=
 in
> the CONFIG_FUNCTION_GRAPH_TRACER case, or introduce a second counter fo=
r
> returns?
>=20
> Matthias

profile_graph_return() being called without rec->counter getting
incremented turned out to be another MIPS-specific bug, I'll send patch f=
or
that, too.


I have two more questions/issues regarding the generic code:

1) There is a small window when enabling the profiler where rec->counter
gets incremented, but profile_graph_return() does not record times yet. F=
or
functions that are called a lot, the effect is negligible, but for very
infrequent calls, the shown average time and variance are way off. Moving=

the rec->counter increment to profile_graph_return() when
CONFIG_FUNCTION_GRAPH_TRACER is enabled would fix this. Does this sound
reasonable?

2) I noticed that my patch does not handle rec->counter overflows correct=
ly
and will cause a zero division. I can think of two solutions for handling=

overflows that keep the avg / stddev fields meaningful:
- Reset time/avg/stddev to 0 on overflows
- Stop updating the record at 0xffffffff, avoiding the overflow

Matthias


>=20
>=20
>=20
>> ---
>>  kernel/trace/ftrace.c | 33 +++++++++++++++++++--------------
>>  1 file changed, 19 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index eac9ce2c57a2..16dce67b855a 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -460,7 +460,8 @@ struct ftrace_profile {
>>  	unsigned long			counter;
>>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>  	unsigned long long		time;
>> -	unsigned long long		time_squared;
>> +	unsigned long long		avg;
>> +	unsigned long long		stddev;
>>  #endif
>>  };
>> =20
>> @@ -580,7 +581,6 @@ static int function_stat_show(struct seq_file *m, =
void *v)
>>  	int ret =3D 0;
>>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>  	static struct trace_seq s;
>> -	unsigned long long avg;
>>  	unsigned long long stddev;
>>  #endif
>>  	mutex_lock(&ftrace_profile_lock);
>> @@ -592,9 +592,7 @@ static int function_stat_show(struct seq_file *m, =
void *v)
>>  	}
>> =20
>>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> -	avg =3D rec->time;
>> -	do_div(avg, rec->counter);
>> -	if (tracing_thresh && (avg < tracing_thresh))
>> +	if (tracing_thresh && (rec->avg < tracing_thresh))
>>  		goto out;
>>  #endif
>> =20
>> @@ -608,24 +606,19 @@ static int function_stat_show(struct seq_file *m=
, void *v)
>>  	if (rec->counter <=3D 1)
>>  		stddev =3D 0;
>>  	else {
>> -		/*
>> -		 * Apply Welford's method:
>> -		 * s^2 =3D 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
>> -		 */
>> -		stddev =3D rec->counter * rec->time_squared -
>> -			 rec->time * rec->time;
>> +		stddev =3D rec->stddev;
>> =20
>>  		/*
>>  		 * Divide only 1000 for ns^2 -> us^2 conversion.
>>  		 * trace_print_graph_duration will divide 1000 again.
>>  		 */
>> -		do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
>> +		do_div(stddev, 1000 * (rec->counter - 1));
>>  	}
>> =20
>>  	trace_seq_init(&s);
>>  	trace_print_graph_duration(rec->time, &s);
>>  	trace_seq_puts(&s, "    ");
>> -	trace_print_graph_duration(avg, &s);
>> +	trace_print_graph_duration(rec->avg, &s);
>>  	trace_seq_puts(&s, "    ");
>>  	trace_print_graph_duration(stddev, &s);
>>  	trace_print_seq(m, &s);
>> @@ -905,8 +898,20 @@ static void profile_graph_return(struct ftrace_gr=
aph_ret *trace)
>> =20
>>  	rec =3D ftrace_find_profiled_func(stat, trace->func);
>>  	if (rec) {
>> +		unsigned long long avg, delta1, delta2;
>> +
>>  		rec->time +=3D calltime;
>> -		rec->time_squared +=3D calltime * calltime;
>> +
>> +		/* Apply Welford's method */
>> +		delta1 =3D calltime - rec->avg;
>> +
>> +		avg =3D rec->time;
>> +		do_div(avg, rec->counter);
>> +		rec->avg =3D avg;
>> +
>> +		delta2 =3D calltime - rec->avg;
>> +
>> +		rec->stddev +=3D delta1 * delta2;
>>  	}
>> =20
>>   out:
>>
>=20
>=20



--r3tWRYhNo8n8Qo5GrDBXfjn4eMIUUAoFw--

--q15pmqLmdL7Oc1MgbQD8WZkGld68p0wnD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlq319MACgkQFu8/ZMsg
HZxTWhAAsLKg2Tjgxog8kka0I4aHy5fMN0rXOqWkL/fAQMnM0P5O9OgkOk0LyjX6
IFHyqFANUNv7J+bgpwW5awfI5DWFU0eR5Ijeu4hmZpppH/ASKFlyaYitid8QLOi6
Iq06DgbMQ43hvBdnFCNg9ZPDF45tKriiBIYiffSzPXNyzg3NhmdwZzEAZTmJCOq2
vM0TKIjWznfwer6k04UO7wWzDqA3D6IesirohYWQW9CwEFek22+X2rdCnjytyrYJ
NKDYxFJC7Pu2vlCK0MrRkpl/n1Nynw0+j1OTKWuMSyLAdpGeZd/njW0zum4m63TN
L7khkMi4CxCPQPXAg/5fxjxIsysgvzTjEKubnOigP4+pVDyD6I+ZRM5tht8Fk4JN
8TGt1+jfDa1b114KYZMeN7Hotf3achEuwg+BAJlELJxHjFU81jSx4dJhTvv9RdaO
K5net6mmLjlarWRsQ3Hb2PLu4xKcYCvgo7G9qLn3sHVoPLtKYyK5gdn7qqM2QIPm
PYp2S1Yu060z4jiyw6ZEdVKx8U4S911HPmc22GbjavPIAFPB6yY6dr09R1bHQCD8
LDq+7xSq98p/qm8OSTCtb7DTCgPqxtJgS5AMz/1dqgPQXAB4Ns/u83/Oc/HEWbFo
Jz6AIuvTF8fialdjQuZ63BTbNkt4MdJ3ziR3aXI3mmoJNsbmXr0=
=XC6Q
-----END PGP SIGNATURE-----

--q15pmqLmdL7Oc1MgbQD8WZkGld68p0wnD--
