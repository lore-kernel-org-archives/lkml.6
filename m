Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCD2C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF12F21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF12F21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHTLVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 07:21:13 -0400
Received: from sauhun.de ([88.99.104.3]:57120 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbeHTLVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 07:21:12 -0400
Received: from localhost (p54B33943.dip0.t-ipconnect.de [84.179.57.67])
        by pokefinder.org (Postfix) with ESMTPSA id D36B82D3E19;
        Mon, 20 Aug 2018 10:06:32 +0200 (CEST)
Date:   Mon, 20 Aug 2018 10:06:29 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        sedat.dilek@credativ.de, Jean Delvare <jdelvare@suse.de>,
        linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Message-ID: <20180820080629.i7y4cx4wewmcyqpk@ninjato>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
 <CA+55aFxv5_8C5ApV4cDjpvAmZbn1aiKebc7yrRWBskQQbz9=Hw@mail.gmail.com>
 <1d2a7c56cc44ff639ef2943366f4868e6e5ecdfe.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tee3kciyjjipcgdi"
Content-Disposition: inline
In-Reply-To: <1d2a7c56cc44ff639ef2943366f4868e6e5ecdfe.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tee3kciyjjipcgdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 12:12:47PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2018-08-19 at 09:46 -0700, Linus Torvalds wrote:
> > On Sun, Aug 19, 2018 at 6:51 AM Sedat Dilek <sedat.dilek@credativ.de> w=
rote:
> > >=20
> > > This can be dropped with commit 771c035372a036f83353eef46dbb829780330=
234
> > > ("deprecate the '__deprecated' attribute warnings entirely and for go=
od")
> > > now in upstream.
> >=20
> > Could we please just remove the __deprecated use in i2c entirely?
> >=20
> > As fat as I can tell, it's used for one thing, which is the
> > "attach_adapter" function pointer member in 'struct i2c_driver'.
> >=20
> > And I think there is _one_ remaining driver using it, namely the
> > powermac "therm_windtunnel" driver.
> >=20
> > Could somebody who knows the i2c probing just a bit convert that *one*
> > remaining driver, then remove the "attach_adapter" entirely, and also
> > remove this thing?
> >=20
> > Alternatively, perhaps the driver should be removed? The last actual
> > powermac change to that driver seems to be from August 2009.
> > Everything since has been just cleanup unrelated to that driver code
> > itself (ie spelling fixes, automated coccinelle scripts etc).
> >=20
> > Added a few people either because they're still officially maintainers
> > of that file, or because they touched the code ten years ago.
>=20
> Some people still use those old machines, I'll give a try at fixing the
> driver.

I did this here a while ago [1] ("macintosh: therm_windtunnel: drop
using attach adapter")...

> Paul: Do you still have one of these machines ?

=2E.. but this was the main problem. I couldn't find anyone to test this.
Even asked on PPC lists of various distributions.

Note that we did apply the same approach of patch [1] already in commit
ac397c80de89 ("ALSA: ppc: keywest: drop using attach adapter"). This has
been tested on HW. I also have a hack to make this driver probe on one
of my ARM boards. Of course, no real HW present there, but shows that
the new probing works at least there.

This is very interesting timing, too. Because I wanted to use the
tentative version jump to 5.0 to finally get rid of this deprecated
feature independently of the discussion here. Which would have meant
resending the patch and arguing we have enough indications that the
patch [1] is sane. And then I could finally remove this callback.

Thanks,

   Wolfram

[1] http://patchwork.ozlabs.org/patch/461759/


--tee3kciyjjipcgdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt6doAACgkQFA3kzBSg
KbZk/A//cpCMtKUwztdNTPu70z0HxMxBpdMhItbKcxDHV2VcssC57fLeNla+1Ng1
uT/4/Xni1TZOf+srO50veerXDZadQydAwp9rVw4N0567T859tmB09aXP4PQKXTB7
H6j/pUQOYWJek3drbWaW3jeDVOhQRQL13IwYfjeHq335NePYcD/kqWRkM7FMNaQ+
nl1MRVDXAYfLPmXW++YQNKwEQ9dsiC62+mnAFqUjm6mlel9wHUKMMMfTdUd+fPjD
NwpQDBRV8nCJJWs/MZMSWGVfr+8sEcNyqomfvNuTZYLMJ7Tu2TkaKAeCUyNl2BZc
GTVqdYgsLL9cW3N92Qs0Kr+tg6E4adUEajuwn7kRgPv2Y9x1a9bNvP5NxWKV+Qm9
TBFrr0f9PQuJAG5UyVQR61+HN4WHiV0RfVgNtO/6k3qt9kfIjnu6Wdiyt9iyHLI6
RBKBWqVAI6p5kiaEBP2yzQmMskOODH1hTdN4FJ3joFRFKVW17/pf341DP5WeLlZT
7Vlq1OPHMWbx5Y+iyziTkKAgLfhgLHo9qXLZP33WJlhNPDAvI3/VhN9N3MoyKoq5
vCALiLDQkQ0LL9xQV7ntV0Dd3iXh3FH5niaLzJI3qYcO9FRh280CJtrtx1+U63Ei
ssuGQ6Y2gRv+w7BkYiLf6v2XBAJCDAIFtP5pUUe4x0RSbyX2AI4=
=9/e0
-----END PGP SIGNATURE-----

--tee3kciyjjipcgdi--
