Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeEZEpo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 00:45:44 -0400
Received: from ozlabs.org ([203.11.71.1]:34085 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932079AbeEZEpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 00:45:42 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 26 May 2018 14:45:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Greg KH <greg@kroah.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alan Cox <alan@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: linux-next: manual merge of the staging tree with the v4l-dvb
 tree
Message-ID: <20180526144539.242ec752@canb.auug.org.au>
In-Reply-To: <20180517070657.642d3784@vento.lan>
References: <20180517141727.3119e1da@canb.auug.org.au>
        <20180517070657.642d3784@vento.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K2ngPDwybejZ=SdgVNohLTh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K2ngPDwybejZ=SdgVNohLTh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

On Thu, 17 May 2018 07:06:57 -0300 Mauro Carvalho Chehab <mchehab+samsung@k=
ernel.org> wrote:
>
> What do you use in order to check it? Maybe we could have some git
> hook running such check, in order to prevent merging patches without
> the right SOBs.

I run the script below on the range of new commits each time a fetch a
tree ...

--=20
Cheers,
Stephen Rothwell

------------------------------------------------------------------------
#!/bin/bash

if [ "$#" -lt 1 ]; then
	printf "Usage: %s <commit range>\n", "$0" 1>&2
	exit 1
fi

commits=3D$(git rev-list --no-merges "$@")
if [ -z "$commits" ]; then
	printf "No commits\n"
	exit 0
fi

for c in $commits; do
	ae=3D$(git log -1 --format=3D'%ae' "$c")
	aE=3D$(git log -1 --format=3D'%aE' "$c")
	an=3D$(git log -1 --format=3D'%an' "$c")
	aN=3D$(git log -1 --format=3D'%aN' "$c")
	ce=3D$(git log -1 --format=3D'%ce' "$c")
	cE=3D$(git log -1 --format=3D'%cE' "$c")
	cn=3D$(git log -1 --format=3D'%cn' "$c")
	cN=3D$(git log -1 --format=3D'%cN' "$c")
	sob=3D$(git log -1 --format=3D'%b' "$c" | grep -i '^[[:space:]]*Signed-off=
-by:')

	am=3Dfalse
	cm=3Dfalse
	grep -i -q "<$ae>" <<<"$sob" ||
		grep -i -q "<$aE>" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$an[[:space:]]*<" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$aN[[:space:]]*<" <<<"$sob" ||
		am=3Dtrue
	grep -i -q "<$ce>" <<<"$sob" ||
		grep -i -q "<$cE>" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$cn[[:space:]]*<" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$cN[[:space:]]*<" <<<"$sob" ||
		cm=3Dtrue

	if "$am" || "$cm"; then
		printf "Commit %s\n" "$c"
		"$am" && printf "\tauthor SOB missing\n"
		"$cm" && printf "\tcommitter SOB missing\n"
		printf "%s %s\n%s\n" "$ae" "$ce" "$sob"
	fi
done

exec gitk "$@"
------------------------------------------------------------------------

--Sig_/K2ngPDwybejZ=SdgVNohLTh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsI5nMACgkQAVBC80lX
0GyOfAf+I9bNLP9pH2jc8zi8IrajqxRQOb3szaQfFGzAGmEEJw9IWcb55srOrtjp
v9/TToFHMYjuFdyocEcBueau5Hi61aYfeTGp87K1dX80nUkyJcEPJdUa+EZnDYWE
Djm6aQDys2j5QdwXg4x19lLSiNqZTWbPStIfCmsBWddzq/pNaUcE5SUTaBQQl0vZ
OcpZBDJ4au7VlXm41N0DTGJSXTeNqfbOPITzPSPQHIVXdh5k4VqfsyBPVk/vuPPW
qhQIhcxRxcDFKnk7s+L0vQAugyRHPWUoV3UlALqsLWTIogDCE0WIb6j5p4yngS5d
NbZOCyAmZvPgetz8fBFJl/JcRjVc5A==
=xVEf
-----END PGP SIGNATURE-----

--Sig_/K2ngPDwybejZ=SdgVNohLTh--
