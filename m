Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6494DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB3020890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB3020890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbeG3Unl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:43:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42919 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbeG3Unl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:43:41 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4F0D980673; Mon, 30 Jul 2018 21:07:16 +0200 (CEST)
Date:   Mon, 30 Jul 2018 21:07:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.18 00/16] Restartable Sequences
Message-ID: <20180730190715.GA29926@amd>
References: <20180602124408.8430-1-mathieu.desnoyers@efficios.com>
 <20180727220115.GA18879@amd>
 <1210024721.6363.1532785744879.JavaMail.zimbra@efficios.com>
 <20180728141314.GA25264@amd>
 <1005916991.7038.1532976120931.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <1005916991.7038.1532976120931.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Thanks for pointer.
> >=20
> > +Restartable sequences are atomic with respect to preemption (making
> > it
> > +atomic with respect to other threads running on the same CPU), as
> > well
> > +as signal delivery (user-space execution contexts nested over the
> > same
> > +thread).
> >=20
> > So the threads are protected against sigkill when running the
> > restartable sequence?
>=20
> In that scenario, SIGKILL _will_ be delivered, hence execution of the
> rseq critical section will never reach the commit instruction. This
> follows the guarantee provided that the rseq c.s. either executes
> completely "atomically" wrt preemption/signal delivery, *or* gets
> aborted. In this case, sigkill will reap the entire process, so

The text above does not mention abort -- so I was just making
sure. Maybe mentioning it would be good idea?

> > +Restartable sequences must not perform system calls. Doing so may
> > result
> > +in termination of the process by a segmentation fault.
> > +
> >=20
> > "may result"? It would be nice to always catch that.
>=20
> I would also like this, but unfortunately this check adds overhead to eve=
ry
> system call, therefore this is only enforced with CONFIG_DEBUG_RSEQ=3Dy b=
uilds.

Makes sense. (But this is probably bad place to talk about
CONFIG_DEBUG_RSEQ=3Dy. Too bad.)

> > +Optimistic cache of the CPU number on which the current thread is
> > +running. Its value is guaranteed to always be a possible CPU number,
> > +even when rseq is not initialized. The value it contains should
> > always
> > +be confirmed by reading the cpu_id field.
> >=20
> > I'm not sure what "optimistic cache" is...
>=20
> Perhaps we can find a better wording.
>=20
> It's "optimistic" in the sense that it's always guaranteed to hold a
> valid CPU number within the range [ 0 .. nr_possible_cpus - 1 ]. It can
> therefore be loaded by user-space and then used as an offset, without
> having to check whether it is within valid bounds compared to the number
> of possible CPUs in the system.
>=20
> This works even if the kernel on which the application runs on does not
> support rseq at all: the __rseq_abi->cpu_id_start field stays initialized=
 at
> 0, which is indeed a valid CPU number. It's therefore valid to use it as =
an
> offset in per-cpu data structures, and only validate whether it's actuall=
y the
> current CPU number by comparing it with the __rseq_abi->cpu_id field
> within the rseq critical section. If rseq is not available in the kernel,
> that cpu_id field stays initialized at -1, so the comparison always fails,
> as intended.
>=20
> It's then up to user-space to use a fall-back mechanism, considering that
> rseq is not available.
>=20
> Advice on improved wording would be welcome.

Ok, that makes sense, but I'd not understand it from the man
page. Perhaps your text should be put there?

> > +Flags indicating the restart behavior for the current thread. This is
> > +mainly used for debugging purposes. Can be either:
> > +.IP \[bu]
> > +RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
> > +.IP \[bu]
> > +RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
> > +.IP \[bu]
> >=20
> > Flags tell me there may be more then one, but "can be either" tells me
> > just one flag is allowed.
>=20
> Combining them is allowed. Will fix by saying: "Can be a combination of:".

Thanks.

> > +.B Structure alignment
> > +This structure is aligned on multiples of 32 bytes.
> > +.TP
> > +.B Structure size
> > +This structure has a fixed size of 32 bytes.
> > +.B Structure alignment
> > +This structure is aligned on multiples of 32 bytes.
> > +.TP
> > +.B Structure size
> > +This structure has a fixed size of 32 bytes.
> >=20
> > I believe we normally say "is aligned on 32-bytes boundary".
>=20
> OK will fix. I think it should then become:
>=20
> "is aligned on 32-byte boundary." (no plural for byte)

Thanks.

> > (Will not
> > this need to be bigger on machines with bigger cache sizes?)
> >=20
> > above it says:
> >=20
> > +.B Structure size
> > +This structure is extensible. Its size is passed as parameter to the
> > +rseq system call.
> >=20
> > I'm reading source, so maybe it refers to different structure.
>=20
> It can be aligned on a larger multiple. This requirement of 32 bytes
> is a minimum. Therefore, if we ever extend struct rseq, or if an
> architecture shows benefit from aligning struct rseq on larger boundaries,
> it is free to do so. It will still respect the requirement of alignment on
> 32 bytes boundaries.

Well, elsewhere it said "This structure has a fixed size of 32 bytes."
Now it says structure size is passed with every syscalls. Now I'm
confused (but maybe that's caused by reading source, not formatted
document).

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltfYeMACgkQMOfwapXb+vIsnQCgtl3iTr+OMCuaRc7czTu4nJHz
xV0An2eZzLsGaRdnwYI9e2oEloG41WJM
=Qcpq
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
