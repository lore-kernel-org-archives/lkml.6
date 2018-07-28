Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E7BC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29D120873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29D120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeG1PkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 11:40:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51888 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeG1PkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 11:40:02 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 33F2F80631; Sat, 28 Jul 2018 16:13:20 +0200 (CEST)
Date:   Sat, 28 Jul 2018 16:13:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
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
Message-ID: <20180728141314.GA25264@amd>
References: <20180602124408.8430-1-mathieu.desnoyers@efficios.com>
 <20180727220115.GA18879@amd>
 <1210024721.6363.1532785744879.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <1210024721.6363.1532785744879.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Documentation-wise, I have posted a rseq man page rfc here:
>=20
> https://lkml.kernel.org/r/20180616195803.29877-1-mathieu.desnoyers@effici=
os.com
>=20
> comments are welcome!

Thanks for pointer.

+Restartable sequences are atomic with respect to preemption (making
it
+atomic with respect to other threads running on the same CPU), as
well
+as signal delivery (user-space execution contexts nested over the
same
+thread).

So the threads are protected against sigkill when running the
restartable sequence?

+Restartable sequences must not perform system calls. Doing so may
result
+in termination of the process by a segmentation fault.
+

"may result"? It would be nice to always catch that.

+Optimistic cache of the CPU number on which the current thread is
+running. Its value is guaranteed to always be a possible CPU number,
+even when rseq is not initialized. The value it contains should
always
+be confirmed by reading the cpu_id field.

I'm not sure what "optimistic cache" is...

+Flags indicating the restart behavior for the current thread. This is
+mainly used for debugging purposes. Can be either:
+.IP \[bu]
+RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
+.IP \[bu]
+RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
+.IP \[bu]

Flags tell me there may be more then one, but "can be either" tells me
just one flag is allowed.

+.B Structure alignment
+This structure is aligned on multiples of 32 bytes.
+.TP
+.B Structure size
+This structure has a fixed size of 32 bytes.
+.B Structure alignment
+This structure is aligned on multiples of 32 bytes.
+.TP
+.B Structure size
+This structure has a fixed size of 32 bytes.

I believe we normally say "is aligned on 32-bytes boundary". (Will not
this need to be bigger on machines with bigger cache sizes?)

above it says:

+.B Structure size
+This structure is extensible. Its size is passed as parameter to the
+rseq system call.

I'm reading source, so maybe it refers to different structure.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltcefoACgkQMOfwapXb+vJUxACgvJkskvyIwm98sFUTK748vE2Q
Su8An15aDqGiainn2gu9BBI2kWCxoxMa
=B49Q
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
