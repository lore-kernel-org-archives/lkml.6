Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B739208E7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="oUgPDNp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B739208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJBOOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:14:25 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:36531 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJBOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:14:23 -0400
Received: by mail-pl1-f179.google.com with SMTP id p5-v6so369324plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t9UE6PgYKgilfEqmoeKgbQAynXoXAYjvDL4j5fPk08I=;
        b=oUgPDNp0IDNEKBrcnXJka7bObKft5WdH2//wQF5hLHm3HI9NtSKrElo9aCq4jgvR/E
         V2qBvtKoaLgmXjEP6ypkAgZojFjwImsspAOaaZ2R8psAjTYVjihVKmAK1aQNgh5XnuAt
         z0SMsBpjqiLqJNgCIClXMAFS9sQZ3QOgglfx5TIDLKFfj36MxJZe5NSNkae2apDSh9HW
         myvrmCiq0ZUzlQVrylTZFMUGE6eWr12msPBeNwN+lARs/QCxDIfwKcBke6zWKEopiLF3
         tJ135Q5vijoYwPA1GI4HHu7lC7/pXXyWLg1rPWb84qTdPxGHse6HhSWcUEOhdWIscTm1
         8J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t9UE6PgYKgilfEqmoeKgbQAynXoXAYjvDL4j5fPk08I=;
        b=CI7pzvto7iX2lkIuJc0u/mg4yt6xWG7phzY32R2huwBOMblRsmYyG//rLT4G5o4Uom
         LmLZ32ixoN7QyIU3sQNbcYORLyjWgwxDZG/VHU8+j35zqFQWRfJfoXFCC+DUOkjbG9hx
         iFrvji2/htLk2p560VgToo38EmHOCJ+ZpI8Q3kVjsHIiGKPlJgGdvNQtyy+MfkjncfyR
         swsaUTKlXeQIzvQTMawWkGXosKV5Fao8w637zVqSyQO3y2K1tPYgNXeFpuzjgwI6U15s
         PD+oDDpsBzwSqjgkQ8yUbT1OfBda8o+gastuozmBT9TkjK13iqZwLmXQS98XLYN/xixX
         8sfg==
X-Gm-Message-State: ABuFfoiOROyyPhweuTk0DoRv9T8EvRgDrljrX/A12aZzDkz6C+1nkXrZ
        HjhSkGAoilqNmxyy1QWgMAqlYQ==
X-Google-Smtp-Source: ACcGV60FbTZgUshHvy8LODdKbNNFvn6UphCWjPZZV8qQJuGzIKw2g690T2NDRn0yTb6g0XZQiptjJQ==
X-Received: by 2002:a62:68c3:: with SMTP id d186-v6mr15026345pfc.70.1538465551463;
        Tue, 02 Oct 2018 00:32:31 -0700 (PDT)
Received: from ryuk ([220.240.25.129])
        by smtp.gmail.com with ESMTPSA id l16-v6sm11479017pfb.75.2018.10.02.00.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 00:32:30 -0700 (PDT)
Date:   Tue, 2 Oct 2018 17:32:20 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path
 resolution
Message-ID: <20181002073220.7mzndna4tdnxdvdt@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929131534.24472-1-cyphar@cyphar.com>
 <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
 <20181001054246.gfinmx3api7kjhmc@ryuk>
 <C89D720F-3CC4-4FA9-9CBB-E41A67360A6B@amacapital.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f5grxfjtcz5dvrfy"
Content-Disposition: inline
In-Reply-To: <C89D720F-3CC4-4FA9-9CBB-E41A67360A6B@amacapital.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5grxfjtcz5dvrfy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-01, Andy Lutomirski <luto@amacapital.net> wrote:
> >>> Currently most container runtimes try to do this resolution in
> >>> userspace[1], causing many potential race conditions. In addition, the
> >>> "obvious" alternative (actually performing a {ch,pivot_}root(2))
> >>> requires a fork+exec which is *very* costly if necessary for every
> >>> filesystem operation involving a container.
> >>=20
> >> Wait. fork() I understand, but why exec? And actually, you don't need
> >> a full fork() either, clone() lets you do this with some process parts
> >> shared. And then you also shouldn't need to use SCM_RIGHTS, just keep
> >> the file descriptor table shared. And why chroot()/pivot_root(),
> >> wouldn't you want to use setns()?
> >=20
> > You're right about this -- for C runtimes. In Go we cannot do a raw
> > clone() or fork() (if you do it manually with RawSyscall you'll end with
> > broken runtime state). So you're forced to do fork+exec (which then
> > means that you can't use CLONE_FILES and must use SCM_RIGHTS). Same goes
> > for CLONE_VFORK.
>=20
> I must admit that I=E2=80=99m not very sympathetic to the argument that =
=E2=80=9CGo=E2=80=99s
> runtime model is incompatible with the simpler solution.=E2=80=9D

Multi-threaded programs have a similar issue (though with Go it's much
worse). If you fork a multi-threaded C program then you can only safely
use AS-Safe glibc functions (those that are safe within a signal
handler). But if you're just doing three syscalls this shouldn't be as
big of a problem as Go where you can't even do said syscalls.

> Anyway, it occurs to me that the real problem is that setns() and
> chroot() are both overkill for this use case.

I agree. My diversion to Go was to explain why it was particularly bad
for cri-o/rkt/runc/Docker/etc.

> What=E2=80=99s needed is to start your walk from /proc/pid-in-container/r=
oot,
> with two twists:
>=20
> 1. Do the walk as though rooted at a directory. This is basically just
> your AT_THIS_ROOT, but the footgun is avoided because the dirfd you
> use is from a foreign namespace, and, except for symlinks to absolute
> paths, no amount of .. racing is going to escape the *namespace*.

This is quite clever and I'll admit I hadn't thought of this. This
definitely fixes the ".." issue, but as you've said it won't handle
absolute symlinks (which means userspace has the same races that we
currently have even if you assume that you have a container process
already running -- CVE-2018-15664 is one of many examples of this).

(AT_THIS_ROOT using /proc/$container/root would in principle fix all of
the mentioned issues -- but as I said before I'd like to see whether
hardening ".." would be enough to solve the escape problem.)

> 2. Avoid /proc. It=E2=80=99s not just the *links* =E2=80=94 you really do=
n=E2=80=99t want to
> walk into /proc/self. *Maybe* procfs is already careful enough when
> mounted in a namespace?

I just tried it and /proc/self gives you -ENOENT. I believe this is
because it does a check against the pid namespace that the procfs mount
has pinned.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--f5grxfjtcz5dvrfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluzHwEACgkQnhiqJn3b
jbQ5LRAAxGtWfDWV6hZtCxTiyzf5SiMxYXCzdM/1SmlYfclwu0o7Cvpcs2dHqwbo
EftRBczNj1uLzuI4Qov9gpM3Ey5Y1YwxAFzEEIlCvtKUIO+oekiAMd0gsarwxLLo
OPROl3596WbVsOyCXkhJ5hu2XtiU3h/T3gbMuqM9KbsFL9Bb8En607RI4BI3yhE/
d8iSrBv8zxhfxSoQLPlNNJHG5TKN3G1C0hb+puVHkzbb9l9R/gcSJMEQsfMdTs48
ZBVByLUKirntkbDKgw5aDg52n8hz2TUx35V7dQD2E366V3jzEWRtKViG193NOvSu
8v0NpyyDC3+GxDTO1gm0XKMEEC5Xb/wMlTvOU6xj1hLV7L3APPqUkuOG5TTdB1Id
hKwiK7H5RlbRo3FaIpkOJaU5eYH4Q6QGYw9+lKg1fk/FTvgB1y8HcYBFC+PKI++j
bZPB0MZEL0cCCWnDYROA7vrgFCk+AgY7pMCAowOrsjDDd4stZohpq2qDN0nKR7m1
BtciN5dAxNMHoEqn/Q1y5CapVHmLzQOUTYksUORO7tsDKyDMp7V3DnBJ8GWqVQYE
AfzhuRdsW50sf3lyGfLE+8wlhlXzIc9Mcvjk5UXt6XBL80OQAOQbUzdrqSUXUWkx
WHbkFyxKgu/1bjE1HKYxlyIF6cxoq11EIseP5igqtrgFE4kdV1U=
=pZFZ
-----END PGP SIGNATURE-----

--f5grxfjtcz5dvrfy--
