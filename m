Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8A294C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38939208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38939208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755155AbeFNM2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:28:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60461 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754869AbeFNM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:28:02 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 48C1E803F4; Thu, 14 Jun 2018 14:28:00 +0200 (CEST)
Date:   Thu, 14 Jun 2018 14:27:59 +0200
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
Message-ID: <20180614122759.GB8798@amd>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
 <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com>
 <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com>
 <091061df-3482-8762-30e4-feaf3417be11@redhat.com>
 <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-06-12 12:31:24, Mathieu Desnoyers wrote:
> ----- On Jun 12, 2018, at 9:11 AM, Florian Weimer fweimer@redhat.com wrot=
e:
>=20
> > On 06/11/2018 10:04 PM, Mathieu Desnoyers wrote:
> >> ----- On Jun 11, 2018, at 3:55 PM, Florian Weimer fweimer@redhat.com w=
rote:
> >>=20
> >>> On 06/11/2018 09:49 PM, Mathieu Desnoyers wrote:
> >>>> It should be noted that there can be only one rseq TLS area register=
ed per
> >>>> thread,
> >>>> which can then be used by many libraries and by the executable, so t=
his is a
> >>>> process-wide (per-thread) resource that we need to manage carefully.
> >>>
> >>> Is it possible to resize the area after thread creation, perhaps even
> >>> from other threads?
> >>=20
> >> I'm not sure why we would want to resize it. The per-thread area is fi=
xed-size.
> >> Its layout is here: include/uapi/linux/rseq.h: struct rseq
> >=20
> > Looks I was mistaken and this is very similar to the robust mutex list.
> >=20
> > Should we treat it the same way?  Always allocate it for each new thread
> > and register it with the kernel?
>=20
> That would be an efficient way to do it, indeed. There is very little
> performance overhead to have rseq registered for all threads, whether or
> not they intend to run rseq critical sections.

People with slow / low memory machines would prefer not to see
overhead they don't need...

> I have a few possible approaches in mind (feel free to suggest other
> options):
>=20
> A) glibc exposes a strong __rseq_abi TLS symbol:
>=20
>    - should ideally *not* be global-dynamic for performance reasons,
>    - registration to kernel can either be handled explicitly by requiring
>      application or libraries to call an API, or implicitly at thread
>      creation,

=2E..so I'd prefer explicit API call.

> B) librseq.so exposes a strong __rseq_abi symbol:

Works for me.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsiX08ACgkQMOfwapXb+vIGNACeNy91T8kQ+NKZCXIfadQOsy0x
rt0AoKfCKvP0Nt149SG3III4J3k1d81V
=7Bff
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
