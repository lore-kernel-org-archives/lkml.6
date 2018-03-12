Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeCLIwY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:52:24 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38766 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbeCLIwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:52:20 -0400
X-Google-Smtp-Source: AG47ELtZfIgkY5e2wUNum/LXllW89bTnDLfssmNoJ/8OAf5BfBfti92/prvyGN73vYcC78LpLUr+Dw==
X-ME-Sender: <xms:vz-mWmXuqXJ-1DCo8K65MoWul_ctw23GuKOl8MEkXPy9tIaw7lQxqQ>
Date: Mon, 12 Mar 2018 16:56:00 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        Alan Stern <stern@rowland.harvard.edu>, will.deacon@arm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com, mingo@kernel.org,
        mpe@ellerman.id.au, oleg@redhat.com, benh@kernel.crashing.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: smp_mb__after_spinlock requirement too strong?
Message-ID: <20180312085600.aczjkpn73axzs2sb@tardis>
References: <CAJDTihwMgUqjK6YL2M_WZY4VBaifVYgNvdZOF_fNrnk_p27Kvw@mail.gmail.com>
 <20180312054412.yqyde34ly3kjoajj@tardis>
 <CAJDTihxxhy7zmhTJ-ky4wvMby_o9y8UOcs9R1dABN7NccekAiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lwj64r2euudstwu4"
Content-Disposition: inline
In-Reply-To: <CAJDTihxxhy7zmhTJ-ky4wvMby_o9y8UOcs9R1dABN7NccekAiQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lwj64r2euudstwu4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 04:18:00PM +0800, =E7=84=A6=E6=99=93=E5=86=AC wrote:
> >> Peter pointed out in this patch https://patchwork.kernel.org/patch/977=
1921/
> >> that the spinning-lock used at __schedule() should be RCsc to ensure
> >> visibility of writes prior to __schedule when the task is to be migrat=
ed to
> >> another CPU.
> >>
> >> And this is emphasized at the comment of the newly introduced
> >> smp_mb__after_spinlock(),
> >>
> >>  * This barrier must provide two things:
> >>  *
> >>  *   - it must guarantee a STORE before the spin_lock() is ordered aga=
inst a
> >>  *     LOAD after it, see the comments at its two usage sites.
> >>  *
> >>  *   - it must ensure the critical section is RCsc.
> >>  *
> >>  * The latter is important for cases where we observe values written b=
y other
> >>  * CPUs in spin-loops, without barriers, while being subject to schedu=
ling.
> >>  *
> >>  * CPU0         CPU1            CPU2
> >>  *
> >>  *          for (;;) {
> >>  *            if (READ_ONCE(X))
> >>  *              break;
> >>  *          }
> >>  * X=3D1
> >>  *          <sched-out>
> >>  *                      <sched-in>
> >>  *                      r =3D X;
> >>  *
> >>  * without transitivity it could be that CPU1 observes X!=3D0 breaks t=
he loop,
> >>  * we get migrated and CPU2 sees X=3D=3D0.
> >>
> >> which is used at,
> >>
> >> __schedule(bool preempt) {
> >>     ...
> >>     rq_lock(rq, &rf);
> >>     smp_mb__after_spinlock();
> >>     ...
> >> }
> >> .
> >>
> >> If I didn't miss something, I found this kind of visibility is __not__
> >> necessarily
> >> depends on the spinning-lock at __schedule being RCsc.
> >>
> >> In fact, as for runnable task A, the migration would be,
> >>
> >>  CPU0         CPU1            CPU2
> >>
> >> <ACCESS before schedule out A>
> >>
> >> lock(rq0)
> >> schedule out A
> >> unock(rq0)
> >>
> >>               lock(rq0)
> >>               remove A from rq0
> >>               unlock(rq0)
> >>
> >>               lock(rq2)
> >>               add A into rq2
> >>               unlock(rq2)
> >>                                         lock(rq2)
> >>                                         schedule in A
> >>                                         unlock(rq2)
> >>
> >>                                         <ACCESS after schedule in A>
> >>
> >> <ACCESS before schedule out A> happens-before
> >> unlock(rq0) happends-before
> >> lock(rq0) happends-before
> >> unlock(rq2) happens-before
> >> lock(rq2) happens-before
> >> <ACCESS after schedule in A>
> >>
> >
> > But without RCsc lock, you cannot guarantee that a write propagates to
> > CPU 0 and CPU 2 at the same time, so the same write may propagate to
> > CPU0 before <ACCESS before schedule out A> but propagate to CPU 2 after
> > <ACCESS after scheduler in A>. So..
> >
> > Regards,
> > Boqun
>=20
> Thank you for pointing out this case, Boqun.
> But this is just one special case that acquire-release chains promise us.
>=20

Ah.. right, because of A-Cumulative.

> A=3DB=3D0 as initial
>=20
>   CPU0                CPU1                CPU2                CPU3
>  write A=3D1
>                            read A=3D1
>                            write B=3D1
>                            release X
>                                                  acquire X
>                                                  read A=3D?
>                                                  release Y
>=20
>     acquire Y
>=20
>     read B=3D?
>=20
> assurance 1: CPU3 will surely see B=3D1 writing by CPU1, and
> assurance 2: CPU2 will also see A=3D1 writing by CPU0 as a special case
>=20
> The second assurance is both in theory and implemented by real hardware.
>=20
> As for theory, the C++11 memory model, which is a potential formal model
> for kernel memory model as
> http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/p0124r4.html
> descripes, states that:
>=20
> If a value computation A of an atomic object M happens before a value
> computation B of M, and A takes its value from a side effect X on M, then
> the value computed by B shall either be the value stored by X or the value
> stored by a side effect Y on M, where Y follows X in the modification
> order of M.
>=20
> at
> $1.10 rule 18, on page 14
> http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4296.pdf
>=20
> As for real hardware, Luc provided detailed test and explanation on
> ARM and POWER in 5.1 Cumulative Barriers for WRC  on page 19
> in this paper:
>=20
> A Tutorial Introduction to the ARM and POWER Relaxed Memory Models
> https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test7.pdf
>=20
> So, I think we may remove RCsc from smp_mb__after_spinlock which is
> really confusing.
>=20

So I think the purpose of smp_mb__after_spinlock() is to provide RCsc
locks, it's just the comments before that may be misleading. We want
RCsc locks in schedule code because we want writes in different critical
section are ordered even outside the critical sections, for case like:

	CPU 0		CPU 1		CPU 2

	{A =3D0 , B =3D 0}
	lock(rq0);
	write A=3D1;
	unlock(rq0);

			lock(rq0);
			read A=3D1;
			write B=3D2;
			unlock(rq0);

					read B=3D2;
					smp_rmb();
					read A=3D1;

I think we need to fix the comments rather than loose the requirement.
Peter?

Regards,
Boqun

> Best Regards,
> Trol
>=20
> >
> >> And for stopped tasks,
> >>
> >>  CPU0         CPU1            CPU2
> >>
> >> <ACCESS before schedule out A>
> >>
> >> lock(rq0)
> >> schedule out A
> >> remove A from rq0
> >> store-release(A->on_cpu)
> >> unock(rq0)
> >>
> >>               load_acquire(A->on_cpu)
> >>               set_task_cpu(A, 2)
> >>
> >>               lock(rq2)
> >>               add A into rq2
> >>               unlock(rq2)
> >>
> >>                                         lock(rq2)
> >>                                         schedule in A
> >>                                         unlock(rq2)
> >>
> >>                                         <ACCESS after schedule in A>
> >>
> >> <ACCESS before schedule out A> happens-before
> >> store-release(A->on_cpu)  happens-before
> >> load_acquire(A->on_cpu)  happens-before
> >> unlock(rq2) happens-before
> >> lock(rq2) happens-before
> >> <ACCESS after schedule in A>
> >>
> >> So, I think the only requirement to smp_mb__after_spinlock is
> >> to guarantee a STORE before the spin_lock() is ordered
> >> against a LOAD after it. So we could remove the RCsc requirement
> >> to allow more efficient implementation.
> >>
> >> Did I miss something or this RCsc requirement does not really matter?

--lwj64r2euudstwu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqmQJ0ACgkQSXnow7UH
+rg8RwgAnSFCdriWAMFnxMZwYCxsiirdmKfwiJk5bwGpYg7RD0B8drkCUsdBwnSm
YbTSQcNB+0djhCnZ5u3T2NM5W3xn7b1pcdzMuQjopY5KDgh0xVhf9npBM40z9Oos
JxM5xgtZ0VsU6dybqcM2zNyWKWv/YbDisL+otgWev185/78RBMcjfpVtFoq9SlST
xgYH7/+8KeJXJhuOIqBB3w1WHCzqnCUxSXM992TIf25hDIHMiUOGCZS4WBjlwLRf
gnk9L+/G9Zm9dB9ObMb/66AZyXt79J3qvxWwjzGoAFZkeLreTKG4Ki7yGPbV1VOK
VXD2+8LyXDBO4l33JddsjxWUWOM64w==
=E2BK
-----END PGP SIGNATURE-----

--lwj64r2euudstwu4--
