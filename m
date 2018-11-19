Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5413C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B223A2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B223A2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbeKTHvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:51:07 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:40756 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbeKTHvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:51:07 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id D8CC8A24DF;
        Mon, 19 Nov 2018 22:25:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id nSyCXggi8Ycz; Mon, 19 Nov 2018 22:25:28 +0100 (CET)
Date:   Tue, 20 Nov 2018 08:25:19 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119212519.yqh7qldznqwct3dv@yavin>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin>
 <20181119205518.btew3vxwgva4w3zh@brauner.io>
 <20181119211810.73ptfhnwdmkngfi4@yavin>
 <20181119212126.u2nkijmula6wcfqi@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zpidgantrji2nrnp"
Content-Disposition: inline
In-Reply-To: <20181119212126.u2nkijmula6wcfqi@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zpidgantrji2nrnp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> On Tue, Nov 20, 2018 at 08:18:10AM +1100, Aleksa Sarai wrote:
> > On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > > On Tue, Nov 20, 2018 at 07:28:57AM +1100, Aleksa Sarai wrote:
> > > > On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > > > > +	if (info) {
> > > > > +		ret =3D __copy_siginfo_from_user(sig, &kinfo, info);
> > > > > +		if (unlikely(ret))
> > > > > +			goto err;
> > > > > +		/*
> > > > > +		 * Not even root can pretend to send signals from the kernel.
> > > > > +		 * Nor can they impersonate a kill()/tgkill(), which adds
> > > > > +		 * source info.
> > > > > +		 */
> > > > > +		ret =3D -EPERM;
> > > > > +		if ((kinfo.si_code >=3D 0 || kinfo.si_code =3D=3D SI_TKILL) &&
> > > > > +		    (task_pid(current) !=3D pid))
> > > > > +			goto err;
> > > > > +	} else {
> > > > > +		prepare_kill_siginfo(sig, &kinfo);
> > > > > +	}
> > > >=20
> > > > I wonder whether we should also have a pidns restriction here, since
> > > > currently it isn't possible for a container process using a pidns to
> > > > signal processes outside its pidns. AFAICS, this isn't done through=
 an
> > > > explicit check -- it's a side-effect of processes in a pidns not be=
ing
> > > > able to address non-descendant-pidns processes.
> > > >=20
> > > > But maybe it's reasonable to allow sending a procfd to a different =
pidns
> > > > and the same operations working on it? If we extend the procfd API =
to
> > >=20
> > > No, I don't think so. I really don't want any fancy semantics in here.
> > > Fancy doesn't get merged and fancy is hard to maintain. So we should =
do
> > > something like:
> > >=20
> > > if (proc_pid_ns() !=3D current_pid_ns)
> > > 	return EINVAL
> >=20
> > This isn't quite sufficient. The key thing is that you have to be in an
> > *ancestor* (or same) pidns, not the *same* pidns. Ideally you can re-use
> > the check already in pidns_get_parent, and expose it. It would be
> > something as trivial as:
> >=20
> > bool pidns_is_descendant(struct pid_namespace *ns,
> >                          struct pid_namespace *ancestor)
> > {
> >     for (;;) {
> >         if (!ns)
> >             return false;
> >         if (ns =3D=3D ancestor)
> >             break;
> >         ns =3D ns->parent;
> >     }
> >     return true;
> > }
>=20
> That can be done without a loop by comparing the level counter for the
> two pid namespaces.

If so, we can refactor how pidns_get_parent() and family work. :P

But yes, I agree with doing the above check.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--zpidgantrji2nrnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvzKj4ACgkQSnvnv3De
m5+vyQ/9GOPT3/WkZ6fIioaCLZF1BAQUrF/fxKBg37g2IgUNZPQM0AQ7bj7JF0Up
kEdujH6PGyCgbvU3xPwPzcL1o/imFH4/007apqvo6zKfXKG5CpYVFlFa+AEVKX0w
FYjsv7MHvnM2xaVLnt9/0UWdckzg6G0jtpDPYoDNMjrRdzhppNVl39iJhfovZehe
4f7FA/jPncrsX+NWxlhhWvilkCE1M5c7C7jZI4Eye7SLVSvK/PdJqqzvaMkWx+up
J8Jt3wFyWIdKg2DYrwaoJuYmlVuVObydSEy/fswqlY/7S25Ddp3Le1zBFYj/o3p0
khnVBWf/KAwRe7Dkiv9XXuchMsMu6P8SfsmvWFLLbRV6HKzYS0JJU5blRabcEHuS
oboBw7LyK3vBmV34xpiXRw7LtI3Vm43zsLuc6WxBep8FeL0arCjTzdiMcu0f890q
qoxttlsZXG3FksoQFnxnzzQBUSEjL9GW1LtJ/Ldcyh4PbyC4B2mb84hEtzKVT9Xr
FIzRz1XHe4KoL2jfn+w09mena4lla6e9FGLyxavTAf0psObZwzF8kIKgn+gGQUjG
dVHFYNJpV1sfltcl+dG+x8Vl79IKgIaqwMRqqncxlbmNAFxn9PUsInVKGKY1C+O7
U1pBphPN85Yo3ciAKo4IRMR6AQMwCY4IUCjNgPtMHelZiVihZ7o=
=kRaK
-----END PGP SIGNATURE-----

--zpidgantrji2nrnp--
