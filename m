Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55490C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45592087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45592087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeH1Rmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:42:49 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34262 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeH1Rms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:42:48 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fueOT-0000pk-UR; Tue, 28 Aug 2018 09:50:53 -0400
Message-ID: <9f09dcbfa27004fc69dccf8039857f06438018f5.camel@surriel.com>
Subject: Re: [PATCH] x86/nmi: Fix some races in NMI uaccess
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Date:   Tue, 28 Aug 2018 09:50:53 -0400
In-Reply-To: <CALCETrUMeV=P89msPuVuiWEw-MdZQZ9t0rTMgY8P91Q8tQvnXQ@mail.gmail.com>
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
         <7e33326ecf792c1a2297d162735b3e63ac185ad0.camel@surriel.com>
         <CALCETrUMeV=P89msPuVuiWEw-MdZQZ9t0rTMgY8P91Q8tQvnXQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OAcaxnDOmS6hudnrMKu0"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OAcaxnDOmS6hudnrMKu0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-08-27 at 19:10 -0700, Andy Lutomirski wrote:
> On Mon, Aug 27, 2018 at 6:31 PM, Rik van Riel <riel@surriel.com>
> wrote:
>=20
> > What is special about this path wrt nmi_uaccess_ok that is
> > not also true for the need_flush branch right above it?
> >=20
> > What am I missing?
>=20
> Nothing.  My patch is buggy.  ETOLITTLESLEEP.
>=20
> I could drop this part of the patch entirely.  Or I could drop the
> loaded_mm->pgd =3D=3D __va(read_cr3_pa() check and instead make sure that
> loaded_mm is NULL at any point at which loaded_mm might not match
> CR3.
> The latter will be faster in any (hypothetical) virtualization
> environment where CR3 reads trap.  I don't know if we have any such
> cases where perf works and we care about performance, though.

Moving that loaded_mm =3D NULL assignment up a few
lines, so it comes before the "if (need_flush)"
test and covers both branches should cover that,
indeed.

--=20
All Rights Reversed.

--=-OAcaxnDOmS6hudnrMKu0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluFUz0ACgkQznnekoTE
3oN0Owf+JJ9jlT2DA8XLamyAx9KuCURmyabM/XvQzYRGVsGHOiIpGB5zwZWJkW5V
ba2mtnQ1d+R4rTLFOxvc3YZkphmef+bw7YtVSQ0luYgsFBjLiU+4IXS3wEvUv7sj
9MgwM6kqmDZdHEGgbH2XBpe9i4ybSYzHBA1Vwd5SgLQeWaUXlGvsKQQjSEBl++Qm
+Ss++oZ4k7HNDs8AigN5Y6XKlXTykfYpdjBIb6OnfhO8ih6X8/ys/uN0ADrKCFku
0tR/4ER/jSEq+02okEBxJ2DCuV8foeV6bOro3ceFQ6qAWBLO/4n6qN8OLSTQ0qdz
MFxdGH1MnrIpRmCLBlDeCFHUcoYxBg==
=Nr4X
-----END PGP SIGNATURE-----

--=-OAcaxnDOmS6hudnrMKu0--

