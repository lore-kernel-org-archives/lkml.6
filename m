Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7CBC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC00C20859
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC00C20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJMREA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:04:00 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:39492 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeJMREA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:04:00 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 1ADA64B2E7;
        Sat, 13 Oct 2018 11:27:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id xVVze7cyAvX3; Sat, 13 Oct 2018 11:27:24 +0200 (CEST)
Date:   Sat, 13 Oct 2018 20:27:02 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] namei: aggressively check for nd->root escape on
 ".." resolution
Message-ID: <20181013092702.mf4gjnq2cfqhkvah@ryuk>
References: <20181009070230.12884-1-cyphar@cyphar.com>
 <20181009070230.12884-4-cyphar@cyphar.com>
 <CAG48ez3Ae5b20g2UquekfBNaUw1tLt4nWy2pYm-LNRMbDVpHfA@mail.gmail.com>
 <20181009153728.2altaqxclntvyc7b@mikami>
 <20181013082210.GU32577@ZenIV.linux.org.uk>
 <20181013085326.gx6rvgqbbyuntfvv@ryuk>
 <20181013090432.GV32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tdpm54ekpnomwcqn"
Content-Disposition: inline
In-Reply-To: <20181013090432.GV32577@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tdpm54ekpnomwcqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-13, Al Viro <viro@ZenIV.linux.org.uk> wrote:
> On Sat, Oct 13, 2018 at 07:53:26PM +1100, Aleksa Sarai wrote:
>=20
> > I didn't know about path_is_under() -- I just checked and it appears to
> > not take &rename_lock? From my understanding, in order to protect
> > against the rename attack you need to take &rename_lock (or check
> > against &rename_lock at least and retry if it changed).
> >=20
> > I could definitely use path_is_under() if you prefer, though I think
> > that in this case we'd need to take &rename_lock (right?). Also is there
> > a speed issue with taking the write-side of a seqlock when we are just
> > reading -- is this more efficient than doing a retry like in __d_path?
>=20
> ???
>=20
> 1) it uses is_subdir(), which does deal with rename_lock

Oh -- complete brain-fart on my part. Sorry about that.

> 2) what it does is taking mount_lock.lock.  I.e. the same
> thing as the second retry in __d_path().  _If_ it shows
> up in profiles, we can switch it to read_seqbegin_or_lock(),
> but I'd like to see the profiling data first.

Sure, I'll switch it to use path_is_under().

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--tdpm54ekpnomwcqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvBumYACgkQnhiqJn3b
jbT2oA/8Dm/EBSA4DrGPauqXWpfU9wnpoF4LIaqtaAsPIVRsmt149Pe/XLvjGhvG
uTQR5R43kWVcZUbhDGNiTLLemWMHsClDsNyY08WE9SI7dGt1nwVmvJMxQU9RetW8
lzQqdU2iuUL2CPAupyJqTAy5GZz6OoDVY3db3qsANzCPvmJbDDdTRJ4SMQnxvGZL
iajDMWEwzt9SDDOiY/AAjmag+U/dY7WoO/K6MKi3J8y1+qYpgWD2gI7hJLzlfGlx
+BZgXTu5+P77kyNNg6MhcINYD9HSfaAPooCQlAjyOdjqAlPuwa8roe/o4McUoH4r
4SGI2tvMxUgJTl+xfL/06K+w4k8bmii8LlX2Bj59jeq/IUVj24cbW4MU8lFvwakV
kvi9bY+o+GYOlR5v5LmS/FZ9Urycn/dN3qtXRL/fEuoPs5ZRW7ikDLELWEs1qM66
r8IZHDE8wlGMwKP9HzNp40Abn1prfuBCU8jm2enRfm3JK/xxOasVaJwoB0LY/pfy
AL6+8AK4jARdJvBsGTmpcGrPgGuswT/5Oo5SXp6MErpC11S7kZXVBSJ/E3SLSZvm
np99T3DjQG+F2HyBUhrcTxcG3Gcs7sxs+xqXGVmephY5c0KqTsnv702k/ZiYCmKh
Q6sd9EmSXoQUm225ZDIyaSf5nJpHEUiN11LzG0KgJw+N99ZA41U=
=CD2O
-----END PGP SIGNATURE-----

--tdpm54ekpnomwcqn--
