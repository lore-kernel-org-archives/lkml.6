Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E63C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3246214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3246214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJJOtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:49:51 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:39756 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeJJOtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:49:50 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id ACD7640042;
        Wed, 10 Oct 2018 09:28:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id yUQvym-l3imW; Wed, 10 Oct 2018 09:28:54 +0200 (CEST)
Date:   Wed, 10 Oct 2018 18:28:43 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20181010072843.xnmqf7mktf25o4w7@ryuk>
References: <20181009065300.11053-1-cyphar@cyphar.com>
 <20181009065300.11053-3-cyphar@cyphar.com>
 <CALCETrUZAYw-g+75WAijS+fmRA_DrTahpv156WrxgYuX3KX2xw@mail.gmail.com>
 <20181010070747.byi2itbi4j42gynq@ryuk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jufqatfmvbsiyd6n"
Content-Disposition: inline
In-Reply-To: <20181010070747.byi2itbi4j42gynq@ryuk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jufqatfmvbsiyd6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-10, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-10-09, Andy Lutomirski <luto@kernel.org> wrote:
> > On Mon, Oct 8, 2018 at 11:53 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > * AT_NO_PROCLINK: Disallows ->get_link "symlink" jumping. This is a v=
ery
> > >   specific restriction, and it exists because /proc/$pid/fd/...
> > >   "symlinks" allow for access outside nd->root and pose risk to
> > >   container runtimes that don't want to be tricked into accessing a h=
ost
> > >   path (but do want to allow no-funny-business symlink resolution).
> >=20
> > Can you elaborate on the use case?
> >=20
> [...]
>   I think that AT_BENEATH allowing only proclinks that result in you
>   being under the root is something we might want in the future, but I
>   think there are some cases where you want to be _very_ sure you don't
>   follow a proclink (now or in the future).
> [...]

Sorry, just to clarify this point a bit more.

At the moment, "proclinks" are entirely disabled with AT_BENEATH. This
is a (hopefully) temporary measure until it's decided _how_ they should
be allowed. Personally I think we should allow them if they follow the
same requirement as ".." escapes (that __d_path can resolve them).

But then the question arises -- what if we're looking at a never-mounted
pseudo-filesystem dentry (see the ->d_dname code in d_path)? If we don't
allow it then we'd probably disallow quite a few cases where you'd want
to allow access (nsfs proclinks come immediately to mind).

*But* if we allow it then there's no real way to tell if the container
process has tricked us into opening something we shouldn't (like an open
file descriptor to a memfd or pipe related to some host service). Maybe
we should still allow them in that case because the likelihood of such a
case is very small (and allowing them would let you open nsfs links with
AT_BENEATH), but I'm not sure.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--jufqatfmvbsiyd6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlu9qioACgkQnhiqJn3b
jbSyDg/+LMMmGHTZOMgeGJsknecuEDVenV+aT22LckbtNEtwJea3hgbPHxoM46B0
FIoFw6I17Yx9+nqGKwp4BmyVfB2DPm4NE+UXvHufY2IoSioF7QY28+JOOL1VM+tB
1iGCh1QtOfML0Zech1eGlfjPf1GBTAEnVe8LJEL2EiKJYR4V2Jh3P4xuJyHg3I5N
eAa+tvc2pXaGVud52rTOW6p2jo5ugu75YdqvjJsP1wnvOBZTKT+EWeLfbUYhrWV+
U8wNbJvkCJ+C192p8lpb1XsTskzvAdo+OnUt9+wR6bi8MrGQtgAOwP5ENDmYjWdW
5+QwtSyBHofvvYOvOp6vMkIeaHB/SSVU+vzK5WgEnGKMFDz2jPNExSS1vGWzRWcg
KBVigjCftiR0TSBljohBURLav8IQpj6TVHcLRbhijYZ5ff93lvFtedzZ4rgpSo2T
NjnT2Ndx9cdAkeQdNN0nKxWt/4Q0qYOyTCf7LgNWtUlMcA8tSe1PefkhJekbnMqx
uzIO5xeQcu5aQ9fGtsSaDH1vjAdIUx932WhZXP65v8KE6hMSf4SxdMhwnCROyxTy
iJGMNZZGH83IxoUAWea3SIUTh7KaoPLiVGa7Z3htKIOcHEXL8XqQU0ux853ORzkw
URqPzwdLExqFsnKylYN5edCiiB954VfYomiy2KTKp74BFdcc6ts=
=SxBd
-----END PGP SIGNATURE-----

--jufqatfmvbsiyd6n--
