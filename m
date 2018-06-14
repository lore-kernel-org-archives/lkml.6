Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AC474C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFF9208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFF9208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755250AbeFNN0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:26:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33469 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754967AbeFNN0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:26:00 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 942C2803F4; Thu, 14 Jun 2018 15:25:58 +0200 (CEST)
Date:   Thu, 14 Jun 2018 15:25:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fweimer@redhat.com>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Subject: Re: Restartable Sequences system call merged into Linux
Message-ID: <20180614132557.GA15201@amd>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
 <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com>
 <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com>
 <091061df-3482-8762-30e4-feaf3417be11@redhat.com>
 <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com>
 <20180614122759.GB8798@amd>
 <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> >>>> It should be noted that there can be only one rseq TLS area regis=
tered per
> >> >>>> thread,
> >> >>>> which can then be used by many libraries and by the executable, s=
o this is a
> >> >>>> process-wide (per-thread) resource that we need to manage careful=
ly.
> >> >>>
> >> >>> Is it possible to resize the area after thread creation, perhaps e=
ven
> >> >>> from other threads?
> >> >>=20
> >> >> I'm not sure why we would want to resize it. The per-thread area is=
 fixed-size.
> >> >> Its layout is here: include/uapi/linux/rseq.h: struct rseq
> >> >=20
> >> > Looks I was mistaken and this is very similar to the robust mutex li=
st.
> >> >=20
> >> > Should we treat it the same way?  Always allocate it for each new th=
read
> >> > and register it with the kernel?
> >>=20
> >> That would be an efficient way to do it, indeed. There is very little
> >> performance overhead to have rseq registered for all threads, whether =
or
> >> not they intend to run rseq critical sections.
> >=20
> > People with slow / low memory machines would prefer not to see
> > overhead they don't need...
>=20
> In terms of memory usage, if people don't want the extra few bytes of mem=
ory
> used by rseq in the kernel, they should use CONFIG_RSEQ=3Dn.
>=20
> In terms of overhead, let's have a closer look at what it means: when a t=
hread
> is registered to rseq, but does not enter rseq critical sections, only th=
is
> extra work is done by the kernel:
>=20
> - rseq_preempt(): on preemption, the scheduler sets the TIF_NOTIFY_RESUME=
 thread
>   flag, so rseq_handle_notify_resume() can check whether it's in a rseq c=
ritical
>   section when returning to user-space,
> - rseq_signal_deliver(): on signal delivery, rseq_handle_notify_resume() =
checks
>   whether it's in a rseq critical section,
> - rseq_migrate: on migration, the scheduler sets TIF_NOTIFY_RESUME as wel=
l,

Yes, this is not likely to be noticeable.

But the proposal wanted to add a syscall to thread creation, right?
And I believe that may be noticeable.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsibOUACgkQMOfwapXb+vLeIwCfVa9XGEB+bqxtfQ8k3dEBf7ay
e0sAn31Fa1rgVE0iix2TYFQzolrRzHKP
=tD/h
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
