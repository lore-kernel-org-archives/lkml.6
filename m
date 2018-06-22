Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E435AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED8D2487D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED8D2487D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754331AbeFVUTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:19:06 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60500 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeFVUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:19:05 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fWSWJ-0003Kn-Ir; Fri, 22 Jun 2018 16:18:59 -0400
Message-ID: <1529698739.7898.206.camel@surriel.com>
Subject: Re: [PATCH 7/7] x86,idle: do not leave mm in idle state
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>
Date:   Fri, 22 Jun 2018 16:18:59 -0400
In-Reply-To: <CALCETrXJzhwXkEi5oC9XY58B8fYT26WhMT+KBt-8m2M+foQvsw@mail.gmail.com>
References: <20180620195652.27251-1-riel@surriel.com>
         <20180620195652.27251-8-riel@surriel.com>
         <CALCETrXfHhPNe9J0NEabxdtKGRV+XOX=n6vtL7rbOY6e2GXMqA@mail.gmail.com>
         <1529682813.7898.195.camel@surriel.com>
         <CALCETrXJzhwXkEi5oC9XY58B8fYT26WhMT+KBt-8m2M+foQvsw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FOgcyJ4rmpbsNcsMzLOR"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FOgcyJ4rmpbsNcsMzLOR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 09:01 -0700, Andy Lutomirski wrote:
> Hmm, fair enough.  I think a better heuristic would be if the
> estimated idle duration is more than, say, 10ms.  I *think* the code
> has been cleaned up enough that this is easy now.  (Using time
> instead
> of C6 will make it a lot less dependent on which idle driver is in
> use.)

This particular bit of code is only in intel_idle
though, and not every cpuidle governor estimates
an idle duration, nor does it get passed up the
stack (presumably because it not always exists).

I will just drop this patch for now, and see if
adding back in the patch that skips manipulation
of the mm_cpumask(&init_mm), since that might make
leave_mm() a little cheaper.

We would still have excess manipulation of the
bitmask when re-entering the task from what should
have been lazy TLB mode, but total cache line
contention would likely still be down from where
it is before that patch.

--=20
All Rights Reversed.
--=-FOgcyJ4rmpbsNcsMzLOR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlstWbMACgkQznnekoTE
3oPXIwf/YCCJ5jn5eqnX+bve6nrCkkiTM/403Blkcna9riUkVfjr0QjYIWlMIQnl
d3z44p1v1ZdtYYP3cqCXJignzKwc9PFjjKw51VEVyJnOecyJra3HvX9bfl+/c2eb
K+LhHlf8nmpnCXnwTbDshzIZ151QNbIdnS8Oi+gj26B/tBiwsR2I5/NLXMzuW33q
QJAOZ47W/gIWZ98ClnNgT9Ig4PizRrNi0yfPdXOXF/hm43joC0N+riDqDaetIdSA
+k+Imj1ip+8zqCrrrf0wN8+6mLrq4Kj+6EcjGpf2igc324LCLCgq+qjdk8nMNqcr
E4sH0axuzOMA91wMOjQbMglXQcRsiQ==
=17gQ
-----END PGP SIGNATURE-----

--=-FOgcyJ4rmpbsNcsMzLOR--

