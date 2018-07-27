Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B87FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0AF20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0AF20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbeG0XZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:25:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60146 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389719AbeG0XZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:25:11 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2558B805F3; Sat, 28 Jul 2018 00:01:17 +0200 (CEST)
Date:   Sat, 28 Jul 2018 00:01:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.18 00/16] Restartable Sequences
Message-ID: <20180727220115.GA18879@amd>
References: <20180602124408.8430-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180602124408.8430-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> So for instance, this turns:
>=20
>   int cpu =3D rseq_per_cpu_lock(lock, target_cpu);
>   [...]
>   rseq_per_cpu_unlock(lock, cpu);
>=20
> into
>=20
>   int cpu =3D rseq_this_cpu_lock(lock);
>   [...]
>   rseq_per_cpu_unlock(lock, cpu);
>=20
> and:
>=20
>   per_cpu_list_push(list, node, target_cpu);
>   [...]
>   per_cpu_list_pop(list, node, target_cpu);
>=20
> into
>=20
>   this_cpu_list_push(list, node, &cpu);  /* cpu is an output parameter. */
>   [...]
>   node =3D this_cpu_list_pop(list, &cpu);  /* cpu is an output parameter.=
 */
>=20
> Eventually integrating cpu_opv or some alternative will allow passing
> the cpu number as parameter rather than requiring the algorithm to work
> on the current CPU.
>=20
> The second effect of not having the cpu_opv fallback is that
> line and instruction single-stepping with a debugger transforms rseq
> critical sections based on retry loops into never-ending loops.
> Debuggers need to use the __rseq_table section to skip those critical
> sections in order to correctly behave when single-stepping a thread
> which uses rseq in a retry loop. However, applications which use an
> alternative fallback method rather than retrying on rseq fast-path abort
> won't be affected by this kind of single-stepping issue.
>=20
> Thanks for your feedback!

Would it make sense to include Documentation/ patch? I guess at least
manpage describing the syscall will be needed....

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltblisACgkQMOfwapXb+vL/rgCfZ7Mkwq0orl7QcLXXpcrW0uDx
iagAnicESPLrBH66gbArogSx6wYmXBvs
=92pi
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
