Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeBVN5Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:57:16 -0500
Received: from ozlabs.org ([103.22.144.67]:59831 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753657AbeBVN5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:57:14 -0500
Date: Fri, 23 Feb 2018 00:56:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180223005626.79c471dd@canb.auug.org.au>
In-Reply-To: <20180222071100.GB30681@dhcp22.suse.cz>
References: <20180222143057.3a1b3746@canb.auug.org.au>
        <20180222071100.GB30681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Mxf8cbvvT1_bbX3P.npWFK4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Mxf8cbvvT1_bbX3P.npWFK4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Thu, 22 Feb 2018 08:11:00 +0100 Michal Hocko <mhocko@kernel.org> wrote:
>
> This is interesting. I thought that IS_ENABLED(CONFIG_HAVE_MEMBLOCK)
> would have the same meaning as ifdef CONFIG_HAVE_MEMBLOCK so the branch
> will never be considered. If that is not the case then I would rather
> reintroduce that ifdef. We already have those in the function anyway.

Actually, you don't need a definition of memblock_next_valid_pfn() in the
!CONFIG_HAVE_MEMBLOCK case, just a declaration, so the minimal fix is
to move the declaration out of the #ifdef CONFIG_HAVE_MEMBLOCK in the
header file.  That way if there is any use of memblock_next_valid_pfn()
introduced that is no guarded by IS_ENABLED(CONFIG_HAVE_MEMBLOCK) the
build will fail to link.  I like IS_ENABLED() being used wherever
possible because it allows us better compiler coverage (in the face of
CONFIG options) even if the compiler then elides the actual code.  It
also breaks the code up less than #ifdef's.

Your choice, of course.

--=20
Cheers,
Stephen Rothwell

--Sig_/Mxf8cbvvT1_bbX3P.npWFK4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqOzAoACgkQAVBC80lX
0GyrKwgAgf3/4do0Zmt9gKmuxQMUkGvnpaieRHyVWkdi2Xc9RPGnexWpUGn899I1
CiJGcdk98yW4ve+PFMhKXMRPQSW0dU//msllA9tCDBc3XoOLUJ9maYrIKDIxNjRX
3qtWadNYFoYMYXDzTUy/1V2M4ItDGTOsdOqE4xpycH5gp11ZAonXkw+V+HRRJRLP
BnHLn3TklLAsXKwz4wZC+rtkaVsybR0vdO7k+TOzKAiYkb5uDHO2IZgfZz4zr/X5
+hUoB7Yo0Q/+LucBHgh7S3TCscXqNlVdv7GNJnjU3iFT2Boy6gOsXvmZYqUR2+VP
gvdcOUCxwnE2pr497w2MaaKkYEb0bg==
=EU5h
-----END PGP SIGNATURE-----

--Sig_/Mxf8cbvvT1_bbX3P.npWFK4--
