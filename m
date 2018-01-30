Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeA3GiB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 01:38:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54702 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeA3Gh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 01:37:59 -0500
X-Google-Smtp-Source: AH8x227CPyQXPAY9awV0MhUlkgaQRyZna0wsia4R6tJWADYa7AUrtdYv53VVXVQSV6K5HEyFqxMjkA==
X-ME-Sender: <xms:wxJwWgPKSgS_Qg0j0KcOafvcWKhzFgC77Ur_lSDnZOgAzcRdJErIYQ>
Date: Tue, 30 Jan 2018 14:40:57 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "zhangheng (AC)" <heng.z@huawei.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "lianglihao@huawei.com" <lianglihao@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Chenhaibo (Haibo, OS Lab)" <hb.chen@huawei.com>,
        "lihao.liang@gmail.com" <lihao.liang@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 01/16] prcu: Add PRCU implementation
Message-ID: <20180130064057.bzswn6qkz2wlv776@tardis>
References: <1516694381-20333-1-git-send-email-lianglihao@huawei.com>
 <1516694381-20333-2-git-send-email-lianglihao@huawei.com>
 <20180125061618.GU3741@linux.vnet.ibm.com>
 <20180125073033.4rl7bun62newplb3@tardis>
 <3FF961283AE1E144A2F945F1AD5573FD014DF00C@dggeml508-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jnryumahsnq5dvay"
Content-Disposition: inline
In-Reply-To: <3FF961283AE1E144A2F945F1AD5573FD014DF00C@dggeml508-mbx.china.huawei.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jnryumahsnq5dvay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 05:34:03AM +0000, zhangheng (AC) wrote:
[...]
> >> > +static void prcu_handler(void *info) {
> >> > +	struct prcu_local_struct *local;
> >> > +
> >> > +	local =3D this_cpu_ptr(&prcu_local);
> >> > +	if (!local->locked)
> >
> >And I think a smp_mb() is needed here, because in the following case:
> >
> >	CPU 0				          CPU 1
> >	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >	{X is initially 0}
> >
> >	WRITE_ONCE(X, 1);
> >
> >	                      prcu_read_unlock(void):
> >	                      if (locked) {
> >	  				              synchronize_prcu(void):
> >					                ...
> >					                <send IPI to CPU 0>
> >	local->locked--;
> >	                      # switch to IPI
> > WRITE_ONCE(local->version,....)
> >	  				            <read CPU 0 version to be latest>
> >					              <return>
> >
> >					              r1 =3D READ_ONCE(X);
> >
> >r1 could be 0, which breaks RCU guarantees.
> >
>=20
> Thank you.
> As I know,
> it guarantees that the interrupt to be handled after all write instructio=
ns issued before have complete in x86 arch.
> So the smp_mb is meaningless in x86 arch.

Sure. x86 is TSO, and we are talking about reordering of two stores
here, and that can not happen on TSO.

> But I am not sure whether other archs guarantee this feature. If not, we =
do need a smp_mb here.
>=20

I think most of the weak memory model don't have this gaurantee, so you
need a smp_mb() or use smp_store_release().

> >> > +		WRITE_ONCE(local->version, atomic64_read(&prcu->global_version));
> >> > +}
> >> > +
> >> > +void synchronize_prcu(void)
> >> > +{
> >> > +	int cpu;
> >> > +	cpumask_t cpus;
> >> > +	unsigned long long version;
> >> > +	struct prcu_local_struct *local;
> >> > +
> >> > +	version =3D atomic64_add_return(1, &prcu->global_version);
> >> > +	mutex_lock(&prcu->mtx);
> >> > +
> >> > +	local =3D get_cpu_ptr(&prcu_local);
> >> > +	local->version =3D version;
> >> > +	put_cpu_ptr(&prcu_local);
> >> > +
> >> > +	cpumask_clear(&cpus);
> >> > +	for_each_possible_cpu(cpu) {
> >> > +		local =3D per_cpu_ptr(&prcu_local, cpu);
> >> > +		if (!READ_ONCE(local->online))
> >> > +			continue;
> >> > +		if (READ_ONCE(local->version) < version) {
> >>=20
> >> On 32-bit systems, given that ->version is long long, you might see=20
> >> load tearing.  And on some 32-bit systems, the cmpxchg() in=20
> >> prcu_hander() might not build.
> >>=20
> >
> >/me curious about why an atomic64_t is used here for global version. I t=
hink maybe 32bit global version still suffices.
> >
> >Regards,
> >Boqun
>=20
> Because the synchronization latency is low, it can have higher gp frequen=
cy.
> It seems that 32bit can only correctly work for several years if there ar=
e 20+ gps per second.
>=20

Because PRCU doesn't handle gp number overflow? May I ask why this is
difficult? Currently RCU could tolerate counter wrap for grace period:

	https://lwn.net/Articles/652677/ (Details in "Parallelism facts of life")

Is there any subtle difference I'm missing?

Regards,
Boqun

> >
> >> Or is the idea that only prcu_handler() updates ->version?  But in=20
> >> that case, you wouldn't need the READ_ONCE() above.  What am I missing=
 here?
> >>=20
> >> > +			smp_call_function_single(cpu, prcu_handler, NULL, 0);
> >> > +			cpumask_set_cpu(cpu, &cpus);
> >> > +		}
> >> > +	}
> >> > +
> >> > +	for_each_cpu(cpu, &cpus) {
> >> > +		local =3D per_cpu_ptr(&prcu_local, cpu);
> >> > +		while (READ_ONCE(local->version) < version)
> >>=20
> >> This ->version read can also tear on some 32-bit systems, and this one=
=20
> >> most definitely can race with the prcu_handler() above.  Does the=20
> >> algorithm operate correctly in that case?  (It doesn't look that way=
=20
> >> to me, but I might be missing something.) Or are 32-bit systems exclud=
ed?
> >>=20
> >> > +			cpu_relax();
> >> > +	}
> >>=20
> >> I might be missing something, but I believe we need a memory barrier=
=20
> >> here on non-TSO systems.  Without that, couldn't we miss a preemption?
> >>=20
> >> > +
> >> > +	if (atomic_read(&prcu->active_ctr))
> >> > +		wait_event(prcu->wait_q, !atomic_read(&prcu->active_ctr));
> >> > +
> >> > +	mutex_unlock(&prcu->mtx);
> >> > +}
> >> > +EXPORT_SYMBOL(synchronize_prcu);
> >> > +
> >> > +void prcu_note_context_switch(void) {
> >> > +	struct prcu_local_struct *local;
> >> > +
> >> > +	local =3D get_cpu_ptr(&prcu_local);
> >> > +	if (local->locked) {
> >> > +		atomic_add(local->locked, &prcu->active_ctr);
> >> > +		local->locked =3D 0;
> >> > +	}
> >> > +	local->online =3D 0;
> >> > +	prcu_report(local);
> >> > +	put_cpu_ptr(&prcu_local);
> >> > +}
> >> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c index=20
> >> > 326d4f88..a308581b 100644
> >> > --- a/kernel/sched/core.c
> >> > +++ b/kernel/sched/core.c
> >> > @@ -15,6 +15,7 @@
> >> >  #include <linux/init_task.h>
> >> >  #include <linux/context_tracking.h>  #include=20
> >> > <linux/rcupdate_wait.h>
> >> > +#include <linux/prcu.h>
> >> >=20
> >> >  #include <linux/blkdev.h>
> >> >  #include <linux/kprobes.h>
> >> > @@ -3383,6 +3384,7 @@ static void __sched notrace __schedule(bool=20
> >> > preempt)
> >> >=20
> >> >  	local_irq_disable();
> >> >  	rcu_note_context_switch(preempt);
> >> > +	prcu_note_context_switch();
> >> >=20
> >> >  	/*
> >> >  	 * Make sure that signal_pending_state()->signal_pending() below
> >> > --
> >> > 2.14.1.729.g59c0ea183
> >> >=20
> >>=20
> >

--jnryumahsnq5dvay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlpwE3UACgkQSXnow7UH
+rgmcgf/dzKriuS+fPJvSeNfsrZmNzWLS4r816k0lEvUweRDO7bp9PLfQWS4i0IZ
tKdyO9Rubv1RVcWDlqbrGJ6bzgWMqe7GVEhZod6NJRbDg7gDynzmg2MsgzP9uxfA
CRH+MjlrGBA7tliU/CRe0nO5AcCFKGxZVmje8vIAmO8b0YSxgMEc3stpJzi5hR1Y
WMrwSQmh3BRRmndz8uNcXdzKRIrVwXaONgbWWp0F9TBRsL5+EOsBPqKxo0q2olBy
mRDXV3imok2644wQvSy/6NqYsk/rHYxJLkOnv+lXGqzK6mNN+q7uT0JoSGjtQ2Tq
4UAkae88YA97TcKLTPrFR675o/doJw==
=2X81
-----END PGP SIGNATURE-----

--jnryumahsnq5dvay--
