Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C378DC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B32E2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfASK3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:29:22 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54917 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfASK3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:29:21 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5F0ACC0006;
        Sat, 19 Jan 2019 10:29:13 +0000 (UTC)
Date:   Sat, 19 Jan 2019 11:29:12 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <20190119102912.GA2647@hle-laptop.local>
References: <20190117224135.GC8100@hle-laptop.local>
 <20190118151941.GB187589@google.com>
 <20190118170801.GA4537@hle-laptop.local>
 <20190119015355.GA115342@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20190119015355.GA115342@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > as far as I understand this code, freezable_schedule() avoids blocking =
the
> > freezer during the schedule() call, but in the end try_to_freeze() is s=
till
> > called so the result is the same, right?
> > I wonder why wait_event_freezable is not calling freezable_schedule().
>=20
> It could be something subtle in my view. freezable_schedule() actually ma=
kes
> the freezer code not send a wake up to the sleeping task if a freeze happ=
ens,
> because the PF_FREEZER_SKIP flag is set, as you pointed.
>=20
> Whereas wait_event_freezable() which uses try_to_freeze() does not seem t=
o have
> this behavior and the task will enter the freezer. So I'm a bit skeptical=
 if
> your API will behave as expected (or at least consistently with other wait
> APIs).

oh right, now it is clear to me:

- schedule(); try_to_freeze()

schedule() is called and the task enters sleep. Since PF_FREEZER_SKIP is
not set, the task wakes up as soon as try_to_freeze_tasks() is called.
Right after waking up the task calls try_to_freeze() which freezes it.

- freezable_schedule()=20

schedule() is called and the task enters sleep. Since PF_FREEZER_SKIP is
set, the task does not wake up when try_to_freeze_tasks() is called. This
is not a problem, the task can't "do anything which isn't allowed for a
frozen task" while sleeping[0].=20

When the task wakes up (timeout, or whatever other reason) it calls
try_to_freeze() which freezes it if the freeze is still underway.

So if a freeze is triggered while the task is sleeping, a task executing
freezable_schedule() might or might not notice the freeze depending on how
long it sleeps. A task executing schedule(); try_to_freeze() will always
notice it.

I might be wrong on that, but freezable_schedule() just seems like a
performance improvement to me.

Now I fully agree with you that there should be a uniform definition of
"freezable" between wait_event_freezable and wait_event_freezable_hrtimeout.
This leaves me to the question: should I modify my definition of
wait_event_freezable_hrtimeout, or prepare a patch for wait_event_freezable=
 ?

If I am right with the performance thing, the latter might be worth
considering?

Either way, this will be fixed in the v2.

> > That being said, I am not sure that the try_to_freeze() call does anyth=
ing
> > in the vsoc case because there is no call to set_freezable() so the thr=
ead
> > still has PF_NOFREEZE...
>=20
> I traced this, and PF_NOFREEZE is not set by default for tasks.

Well, I did not check this in practice and might be confused somewhere but
the documentation[1] says "kernel threads are not freezable by default.
However, a kernel thread may clear PF_NOFREEZE for itself by calling
set_freezable()".

Looking at the kthreadd() definition it seems like new tasks have
PF_NOFREEZE set by default[2].

I'll take some time to check this in practice in the next days.

Anyways, thanks for your time !

regards,
 Hugo

[0] https://elixir.bootlin.com/linux/latest/source/include/linux/freezer.h#=
L103
[1] https://elixir.bootlin.com/linux/latest/source/Documentation/power/free=
zing-of-tasks.txt#L90
[2] https://elixir.bootlin.com/linux/latest/source/kernel/kthread.c#L569

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxC++8ACgkQZYVUZx9w
0DTHbwf8DQdawIVEQVNUyheP2WxzOVoEjNdB29OKYD/MvoV0Mn4O62FmDa4an/79
uvVAT8rTzVAJc82a7hUyUlHoaExOrEJw3rpDmr9f2oaShsd8VE0CIr7m5KsdjbVm
qkKMezoXK0m/P6MM6uBjhD9TZAMrLwSyd7giBdLo6eJY0PXZv+t15BONqP6yvvP8
3AZYNN/u3kbUN7cCBVZpLeKMdwf6EQWdXqQ6rLf88YioDcoT846vGk1yUXBr5wt/
GgT1z0rEF5QDJC9eu9j0bGl/RX/PfgFSf8Uzsy5S187MVubU21X5NRARuHoAFlAO
Doj+sFtGpKzDpiA7bqfdgi998xKSoA==
=fANt
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
