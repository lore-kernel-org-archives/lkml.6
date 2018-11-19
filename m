Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A36FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA17F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA17F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbeKTHny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:43:54 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:44170 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730091AbeKTHny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:43:54 -0500
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 49AFE49042;
        Mon, 19 Nov 2018 22:18:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id iGMooPN9IemA; Mon, 19 Nov 2018 22:18:20 +0100 (CET)
Date:   Tue, 20 Nov 2018 08:18:10 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119211810.73ptfhnwdmkngfi4@yavin>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin>
 <20181119205518.btew3vxwgva4w3zh@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3flxpxlg56fx5hka"
Content-Disposition: inline
In-Reply-To: <20181119205518.btew3vxwgva4w3zh@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3flxpxlg56fx5hka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> On Tue, Nov 20, 2018 at 07:28:57AM +1100, Aleksa Sarai wrote:
> > On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > > +	if (info) {
> > > +		ret =3D __copy_siginfo_from_user(sig, &kinfo, info);
> > > +		if (unlikely(ret))
> > > +			goto err;
> > > +		/*
> > > +		 * Not even root can pretend to send signals from the kernel.
> > > +		 * Nor can they impersonate a kill()/tgkill(), which adds
> > > +		 * source info.
> > > +		 */
> > > +		ret =3D -EPERM;
> > > +		if ((kinfo.si_code >=3D 0 || kinfo.si_code =3D=3D SI_TKILL) &&
> > > +		    (task_pid(current) !=3D pid))
> > > +			goto err;
> > > +	} else {
> > > +		prepare_kill_siginfo(sig, &kinfo);
> > > +	}
> >=20
> > I wonder whether we should also have a pidns restriction here, since
> > currently it isn't possible for a container process using a pidns to
> > signal processes outside its pidns. AFAICS, this isn't done through an
> > explicit check -- it's a side-effect of processes in a pidns not being
> > able to address non-descendant-pidns processes.
> >=20
> > But maybe it's reasonable to allow sending a procfd to a different pidns
> > and the same operations working on it? If we extend the procfd API to
>=20
> No, I don't think so. I really don't want any fancy semantics in here.
> Fancy doesn't get merged and fancy is hard to maintain. So we should do
> something like:
>=20
> if (proc_pid_ns() !=3D current_pid_ns)
> 	return EINVAL

This isn't quite sufficient. The key thing is that you have to be in an
*ancestor* (or same) pidns, not the *same* pidns. Ideally you can re-use
the check already in pidns_get_parent, and expose it. It would be
something as trivial as:

bool pidns_is_descendant(struct pid_namespace *ns,
                         struct pid_namespace *ancestor)
{
    for (;;) {
        if (!ns)
            return false;
        if (ns =3D=3D ancestor)
            break;
        ns =3D ns->parent;
    }
    return true;
}

And you can rewrite pidns_get_parent to use it. So you would instead be
doing:

    if (pidns_is_descendant(proc_pid_ns, task_active_pid_ns(current)))
        return -EPERM;

(Or you can just copy the 5-line loop into procfd_signal -- though I
imagine we'll need this for all of the procfd_* APIs.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3flxpxlg56fx5hka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvzKI8ACgkQSnvnv3De
m58HKA//U69plvx4rY3bXQRVMmJc5vua9IDIuPdxTt30IqjvD3P2SRxKVSrajOdt
I9kmAZBjKlTQ9ILra2ZQZjIpEfEiWyrepEepPP/FjQMW0rZ3bxwV2owfZGBTWDOF
CSaYzPxBsGNz/CQS61dagWOlMyjrc/xREyzXaLNSPBva3fr/857Zc8lDUxDQvwHo
PuabCxC3vO/xadvW1Lbx5d/lRvbq6/b72TQweQxdhQRYFXuKJHMJwuhYe3ErRrY3
IQzEy9978cIqPduC/+reHUEhzcuNba0IZHGOr6sGG6wsZ/k4mcMbofvzY7qFWOul
aTWEhZbdKWKzz/1hhq5ohLCV/GA/XvarkTWazTqf9bJEhGWE7tfcwFAVSxDleTO1
QREoc6yEbMGncyPaadQeP8s16ctbyuxrY/SzG1q7ms8eKx1jivqYt2e0VXxFzIwx
ZQdcS8ynyJIjIoZ+2Cbm9mXEiJQiKU8Z7soTa+sMoFXhsmgjymFrQfZ6kQrwSPtM
3XGFp5RDD/oRc14cidvbGu9cEADmzc5P50hVGUQTn9WRK40vZoj5aDEg9RY6irWd
pdRrtaTfLt46Hw3caLxI7ilCB/j5wJSl8CklvJza4A93FTIVlPzwEssKCnmRBQ8c
L8Vdp/zEfdukRn1IWSR/ngsb+IvSiW2iJyRMo7gXp94U3QXiQ84=
=zDQm
-----END PGP SIGNATURE-----

--3flxpxlg56fx5hka--
