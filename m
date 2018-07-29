Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF260FF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9547820862
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9547820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeG2NmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:42:17 -0400
Received: from shelob.surriel.com ([96.67.55.147]:46958 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeG2NmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:42:17 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjkYJ-0004zH-OG; Sun, 29 Jul 2018 08:11:59 -0400
Message-ID: <1532866319.28585.12.camel@surriel.com>
Subject: Re: [PATCH 10/10] mm,sched: conditionally skip lazy TLB mm
 refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>, will.daecon@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sun, 29 Jul 2018 08:11:59 -0400
In-Reply-To: <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-11-riel@surriel.com>
         <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jPUjgOFaXwY+aPEJEyBz"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jPUjgOFaXwY+aPEJEyBz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-07-28 at 21:21 -0700, Andy Lutomirski wrote:
> On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com>
> wrote:
> > Conditionally skip lazy TLB mm refcounting. When an architecture
> > has
> > CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING enabled, an mm that is used in
> > lazy TLB mode anywhere will get shot down from exit_mmap, and there
> > in no need to incur the cache line bouncing overhead of refcounting
> > a lazy TLB mm.
>=20
> Unless I've misunderstood something, this patch results in idle tasks
> whose active_mm has been freed still having active_mm pointing at
> freed memory.=20

Patch 9/10 is supposed to ensure that the lazy TLB CPUs get
switched to init_mm before an mm is freed. No CPU should ever
have its active_mm pointing at a freed mm.

Your message made me re-read the code, and now I realize that
leave_mm does not actually do that.

Looking at the other callers of leave_mm, I might not be the
only one surprised by that; xen_drop_mm_ref comes to mind.

I guess I should some code to leave_mm to have it actually
clear active_mm and call the conditional refcount drop helper
function.

Does that clear up the confusion?

--=20
All Rights Reversed.
--=-jPUjgOFaXwY+aPEJEyBz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltdrw8ACgkQznnekoTE
3oNpnwf/egonoGu2+wuvX0k2JIE5dU8FQJQtQTVhPucY1/BjG0pfT4vSVcV9kYs9
I6glsUA+12cV2O6tghL3W3SwvaxzrltjVohdbj1fec+JiE+FUG76VjNkreMPpTas
BB2vGYEPruBlqllMuOTG+ZfhORIxzAQxb8CxlqlB6T1CrIigdSn7Iynk75oaw5fZ
BBk72RV88OJaQEvQc7+iOvJzhu/Z4KTWnmtsZGJ90OA5OIvisDso9+4CHT/N4OB4
6dKBHEQx72d0Xkw/zwWnT6ac0YbbHu0Rudj732v/OIIPkRbhY+HpNH5Z+I0i0qaG
QmRbBHdpWfs/4iAar4aG+3d4YqVFxA==
=hxfm
-----END PGP SIGNATURE-----

--=-jPUjgOFaXwY+aPEJEyBz--

