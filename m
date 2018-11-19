Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A20A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A20A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbeKTHta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:49:30 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:50910 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeKTHt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:49:29 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 69F9044852;
        Mon, 19 Nov 2018 22:23:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id XNEa4uoKFOLA; Mon, 19 Nov 2018 22:23:53 +0100 (CET)
Date:   Tue, 20 Nov 2018 08:23:43 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119212343.yikfoxob7f4hio7h@yavin>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin>
 <20181119205518.btew3vxwgva4w3zh@brauner.io>
 <20181119211810.73ptfhnwdmkngfi4@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rb762nswxpssimwm"
Content-Disposition: inline
In-Reply-To: <20181119211810.73ptfhnwdmkngfi4@yavin>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rb762nswxpssimwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-20, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > On Tue, Nov 20, 2018 at 07:28:57AM +1100, Aleksa Sarai wrote:
> > > On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > > > +	if (info) {
> > > > +		ret =3D __copy_siginfo_from_user(sig, &kinfo, info);
> > > > +		if (unlikely(ret))
> > > > +			goto err;
> > > > +		/*
> > > > +		 * Not even root can pretend to send signals from the kernel.
> > > > +		 * Nor can they impersonate a kill()/tgkill(), which adds
> > > > +		 * source info.
> > > > +		 */
> > > > +		ret =3D -EPERM;
> > > > +		if ((kinfo.si_code >=3D 0 || kinfo.si_code =3D=3D SI_TKILL) &&
> > > > +		    (task_pid(current) !=3D pid))
> > > > +			goto err;
> > > > +	} else {
> > > > +		prepare_kill_siginfo(sig, &kinfo);
> > > > +	}
> > >=20
> > > I wonder whether we should also have a pidns restriction here, since
> > > currently it isn't possible for a container process using a pidns to
> > > signal processes outside its pidns. AFAICS, this isn't done through an
> > > explicit check -- it's a side-effect of processes in a pidns not being
> > > able to address non-descendant-pidns processes.
> > >=20
> > > But maybe it's reasonable to allow sending a procfd to a different pi=
dns
> > > and the same operations working on it? If we extend the procfd API to
> >=20
> > No, I don't think so. I really don't want any fancy semantics in here.
> > Fancy doesn't get merged and fancy is hard to maintain. So we should do
> > something like:
> >=20
> > if (proc_pid_ns() !=3D current_pid_ns)
> > 	return EINVAL
>=20
> This isn't quite sufficient. The key thing is that you have to be in an
> *ancestor* (or same) pidns, not the *same* pidns. Ideally you can re-use
> the check already in pidns_get_parent, and expose it. It would be
> something as trivial as:
>=20
> bool pidns_is_descendant(struct pid_namespace *ns,
>                          struct pid_namespace *ancestor)
> {
>     for (;;) {
>         if (!ns)
>             return false;
>         if (ns =3D=3D ancestor)
>             break;
>         ns =3D ns->parent;
>     }
>     return true;
> }
>=20
> And you can rewrite pidns_get_parent to use it. So you would instead be
> doing:
>=20
>     if (pidns_is_descendant(proc_pid_ns, task_active_pid_ns(current)))
>         return -EPERM;

Scratch the last bit, -EPERM is wrong here. I would argue that -EINVAL
is *somewhat* wrong because arguable the more semantically consistent
error (with kill(2)) would be -ESRCH -- but then you're mixing the "pid
is dead" and "pid is not visible to you" cases. I'm not sure what the
right errno would be here (I'm sure some of the LKML greybeards will
have a better clue.) :P

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--rb762nswxpssimwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvzKd8ACgkQSnvnv3De
m59vwg//cJxJ1nMuyOPnJIPLgcDzoKKpGr8gxqXTm732gERWhbgPbM/Jcv9JTRTm
yl4U7Np87GCmB17cMjbRY4wppS+37Al0qI8sfKBhedvDX7mR5Dbx80zd6B2dAy/r
pZG4HW1riazdzXjpq7+JbTFK0SxgBYIT/LXSYnz6eb04a3zubmigeqNgsLe/ZW7d
YeWEiWOnFo9r3abWACPz72EAEr3S6BNgaSCkFwO2baKJBIT2Hi2BfRLd8McXzIV1
QIPvsdIQ89DViqf8TN+7QD17AjRqk92vpCiJPJWl2jTgQ41PdTOsYnYwQ94DcLs+
NmFjVW4mIFPPfT66cKJi32tMNQ2qdFuNDkJEpP8A8btBYCXvCP6c+/+rDvCJeAwJ
w6I+OxifP+1AdkBBAN1JqSgQGOlteSggV+o18dqyN+0QhiJIU/+wsUKqOuVZDFim
rD0XiITUNbafBE7IZNNUj+7i/QFcXl44aSgOaj2Wb58Vmqg+hG56S9ZWKlYSryat
EYOd72ccktB+yhBLwzCnukkx3RTVsz9BJQUHdQDs/y+omb+yFSho6F15+PMhgxQd
3NLLKPrpF6LAFu05+EWkf/omGTm7gwDlZUszB/4URkLNPQV7Edl8e6n3qQStys2/
iUMP+mrN0Q4bitcJqan0DzGNnt48Sau+YYC0Rs+ZyVddhKx31P4=
=PI1p
-----END PGP SIGNATURE-----

--rb762nswxpssimwm--
