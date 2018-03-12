Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeCLFkc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 01:40:32 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50313 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeCLFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 01:40:31 -0400
X-Google-Smtp-Source: AG47ELuMrokx51NAkvnUlOuYD85PbYhA/iP3m3tzphN5dejm8k0P9gloEaj2qxE107KkABiTevLX/Q==
X-ME-Sender: <xms:yhKmWhp5j2WVwUEIBSuhvYYSQuw-ZImuIbvpWY12Huheip3KMT2jCw>
Date: Mon, 12 Mar 2018 13:44:12 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        stern@rowland.harvard.edu, will.deacon@arm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com, mingo@kernel.org,
        mpe@ellerman.id.au, oleg@redhat.com, benh@kernel.crashing.org,
        paulmck@linux.vnet.ibm.com
Subject: Re: smp_mb__after_spinlock requirement too strong?
Message-ID: <20180312054412.yqyde34ly3kjoajj@tardis>
References: <CAJDTihwMgUqjK6YL2M_WZY4VBaifVYgNvdZOF_fNrnk_p27Kvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wx2uzbtov5fnahj6"
Content-Disposition: inline
In-Reply-To: <CAJDTihwMgUqjK6YL2M_WZY4VBaifVYgNvdZOF_fNrnk_p27Kvw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wx2uzbtov5fnahj6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 11, 2018 at 03:55:41PM +0800, =E7=84=A6=E6=99=93=E5=86=AC wrote:
> Peter pointed out in this patch https://patchwork.kernel.org/patch/977192=
1/
> that the spinning-lock used at __schedule() should be RCsc to ensure
> visibility of writes prior to __schedule when the task is to be migrated =
to
> another CPU.
>=20
> And this is emphasized at the comment of the newly introduced
> smp_mb__after_spinlock(),
>=20
>  * This barrier must provide two things:
>  *
>  *   - it must guarantee a STORE before the spin_lock() is ordered agains=
t a
>  *     LOAD after it, see the comments at its two usage sites.
>  *
>  *   - it must ensure the critical section is RCsc.
>  *
>  * The latter is important for cases where we observe values written by o=
ther
>  * CPUs in spin-loops, without barriers, while being subject to schedulin=
g.
>  *
>  * CPU0         CPU1            CPU2
>  *
>  *          for (;;) {
>  *            if (READ_ONCE(X))
>  *              break;
>  *          }
>  * X=3D1
>  *          <sched-out>
>  *                      <sched-in>
>  *                      r =3D X;
>  *
>  * without transitivity it could be that CPU1 observes X!=3D0 breaks the =
loop,
>  * we get migrated and CPU2 sees X=3D=3D0.
>=20
> which is used at,
>=20
> __schedule(bool preempt) {
>     ...
>     rq_lock(rq, &rf);
>     smp_mb__after_spinlock();
>     ...
> }
> .
>=20
> If I didn't miss something, I found this kind of visibility is __not__
> necessarily
> depends on the spinning-lock at __schedule being RCsc.
>=20
> In fact, as for runnable task A, the migration would be,
>=20
>  CPU0         CPU1            CPU2
>=20
> <ACCESS before schedule out A>
>=20
> lock(rq0)
> schedule out A
> unock(rq0)
>=20
>               lock(rq0)
>               remove A from rq0
>               unlock(rq0)
>=20
>               lock(rq2)
>               add A into rq2
>               unlock(rq2)
>                                         lock(rq2)
>                                         schedule in A
>                                         unlock(rq2)
>=20
>                                         <ACCESS after schedule in A>
>=20
> <ACCESS before schedule out A> happens-before
> unlock(rq0) happends-before
> lock(rq0) happends-before
> unlock(rq2) happens-before
> lock(rq2) happens-before
> <ACCESS after schedule in A>
>=20

But without RCsc lock, you cannot guarantee that a write propagates to
CPU 0 and CPU 2 at the same time, so the same write may propagate to
CPU0 before <ACCESS before schedule out A> but propagate to CPU 2 after
<ACCESS after scheduler in A>. So..

Regards,
Boqun

> And for stopped tasks,
>=20
>  CPU0         CPU1            CPU2
>=20
> <ACCESS before schedule out A>
>=20
> lock(rq0)
> schedule out A
> remove A from rq0
> store-release(A->on_cpu)
> unock(rq0)
>=20
>               load_acquire(A->on_cpu)
>               set_task_cpu(A, 2)
>=20
>               lock(rq2)
>               add A into rq2
>               unlock(rq2)
>=20
>                                         lock(rq2)
>                                         schedule in A
>                                         unlock(rq2)
>=20
>                                         <ACCESS after schedule in A>
>=20
> <ACCESS before schedule out A> happens-before
> store-release(A->on_cpu)  happens-before
> load_acquire(A->on_cpu)  happens-before
> unlock(rq2) happens-before
> lock(rq2) happens-before
> <ACCESS after schedule in A>
>=20
> So, I think the only requirement to smp_mb__after_spinlock is
> to guarantee a STORE before the spin_lock() is ordered
> against a LOAD after it. So we could remove the RCsc requirement
> to allow more efficient implementation.
>=20
> Did I miss something or this RCsc requirement does not really matter?

--wx2uzbtov5fnahj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqmE6kACgkQSXnow7UH
+rhz1Qf+MZCXL32i+z/Ca2k1MnPGka+FMuw0hbksH5L0BZrPdjeRSTKLtU+Qvj56
4F9VrFmvqg9nb8H2aPXRKGOBcM4fLmUykbkl2ZllspBAU0ZYUJCuX5FLAp8gKd93
K/TKfxoAvmMc9HH7XCwp7/5UDoQPp9XRjwHCqhvipdf15RbJ5rZJeOIxkf4SYx/N
dyo8aSvwdz7Uk3VZ6nv1YSB0aB7Wd1PSQf1Ba1a3Jq6UTQENwc9OxV5BwWoDxe4I
RRi9Q4qB/+iExGpfmnnYQr26HUNYUHdT7cYeKvNcTEFf7bBXn7rhir5c4Kvlr8W0
i/A2vgh9lvaNxoejGLxUG3qwgYJuuw==
=M52O
-----END PGP SIGNATURE-----

--wx2uzbtov5fnahj6--
