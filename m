Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeFAS4c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:56:32 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45048 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeFAS4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:56:31 -0400
Message-ID: <1527879389.7898.84.camel@surriel.com>
Subject: Re: 4.13..4.14 scheduling overhead regression (bisected  -
 b956575bed91)
From: Rik van Riel <riel@surriel.com>
To: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>
Date: Fri, 01 Jun 2018 14:56:29 -0400
In-Reply-To: <20180601132055.GT12198@hirez.programming.kicks-ass.net>
References: <1527857873.4674.11.camel@gmx.de>
         <20180601132055.GT12198@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ib3fbF7sKiIwG+QUOToN"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ib3fbF7sKiIwG+QUOToN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-01 at 15:20 +0200, Peter Zijlstra wrote:
> On Fri, Jun 01, 2018 at 02:57:53PM +0200, Mike Galbraith wrote:
> > b956575bed91ecfb136a8300742ecbbf451471ab is the first bad commit
> > commit b956575bed91ecfb136a8300742ecbbf451471ab
> > Author: Andy Lutomirski <luto@kernel.org>
> > Date:   Mon Oct 9 09:50:49 2017 -0700
> >=20
> >     x86/mm: Flush more aggressively in lazy TLB mode
>=20
> Oh boy... Maybe we should start looking at that optimization Andy
> mentioned.
>=20
> IIRC all page freeing does indeed go through tlb_remove_page(), it
> shouldn't be too hard to make that work.

Page freeing does. However, page table freeing
does not, and might need to be done in a different
way.

I wonder how expensive/effective it would be to free
page tables with RCU, and have the RCU code flush the
TLB if it notices the ctx_id is wrong?

Also, I need to go find Andy's optimization, and
see how it works :)

--=20
All Rights Reversed.
--=-ib3fbF7sKiIwG+QUOToN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsRlt0ACgkQznnekoTE
3oOcxggAukRp10h7m2BYQNVEleXsqhmQGT+TzLluK21kjfVqUoRfvrEChQP327v6
D2Adxy1siRPPUNI6v3LymUXHhrtgV0Xy3A11oNvMRFNI1R2C9+1u/ULLH3coWvdS
1DSsEQbU08SFAH9cY+dCR+dQkVyN65iZuNCModupSI21cyJgYk5yHtsDzpLgrgKF
/OSE92cMS0PQppCarnNIqEhPP9ptFI0tcUDBz4DKF+YNU//yJayEeCDVN1Idn4kM
rvTXNqQQ2JjPbsdfWqQWclLHR0q5rAxwV/cQkqY+1pVhc7X16/Yvjo0G9KyoXQmc
rZ+iAeMbehSH1SwPbtr998TV8UtOcQ==
=vOa3
-----END PGP SIGNATURE-----

--=-ib3fbF7sKiIwG+QUOToN--
