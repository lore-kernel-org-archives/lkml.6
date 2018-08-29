Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E256FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D672054F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D672054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbeH2TPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:15:11 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37314 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbeH2TPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:15:11 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fv2Dx-000056-Q6; Wed, 29 Aug 2018 11:17:37 -0400
Message-ID: <e9d62b33d43f99570b14c73e1519b13021ea3a95.camel@surriel.com>
Subject: Re: [PATCH v2] x86/nmi: Fix some races in NMI uaccess
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Date:   Wed, 29 Aug 2018 11:17:37 -0400
In-Reply-To: <CALCETrX2v_g_+TpX1DEZasHGi=8Y3w3ka=yYEaTxgFDnPy67nw@mail.gmail.com>
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
         <20180828135647.6d516048@imladris.surriel.com>
         <CALCETrX2v_g_+TpX1DEZasHGi=8Y3w3ka=yYEaTxgFDnPy67nw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nQ3BFmGlEsXzGK2XeTic"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nQ3BFmGlEsXzGK2XeTic
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-08-28 at 20:46 -0700, Andy Lutomirski wrote:
> On Tue, Aug 28, 2018 at 10:56 AM, Rik van Riel <riel@surriel.com>
> wrote:
> > On Mon, 27 Aug 2018 16:04:16 -0700
> > Andy Lutomirski <luto@kernel.org> wrote:
> >=20
> > > The 0day bot is still chewing on this, but I've tested it a bit
> > > locally
> > > and it seems to do the right thing.
> >=20
> > Hi Andy,
> >=20
> > the version of the patch below should fix the bug we talked about
> > in email yesterday.  It should automatically cover kernel threads
> > in lazy TLB mode, because current->mm will be NULL, while the
> > cpu_tlbstate.loaded_mm should never be NULL.
> >=20
>=20
> That's better than mine.  I tweaked it a bit and added some
> debugging,
> and I got this:
>=20
>=20
https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=3D=
x86/fixes&id=3Ddd956eba16646fd0b15c3c0741269dfd84452dac
>=20
> I made the loaded_mm handling a little more conservative to make it
> more obvious that switch_mm_irqs_off() is safe regardless of exactly
> when it gets called relative to switching current.

I am not convinced that the dance of writing
cpu_tlbstate.loaded_mm twice, with a barrier on
each end, is useful or necessary.

At the time switch_mm_irqs_off returns, nmi_uaccess_ok()
will still return false, because we have not switched
"current" to the task that owns the next mm_struct yet.

We just have to make sure to:
1) Change cpu_tlbstate.loaded_mm before we manipulate
   CR3, and
2) Change "current" only once enough of the mm stuff has
   been switched, __switch_to seems to get that right.

Between the time switch_mm_irqs_off() sets cpu_tlbstate
to the next mm, and __switch_to moves() over current,
nmi_uaccess_ok() will return false.

--=20
All Rights Reversed.

--=-nQ3BFmGlEsXzGK2XeTic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluGuREACgkQznnekoTE
3oNHxgf/fMOKljECrqIqz+mcdgJd/L88eMzgQOldU1ptheYLGqsOhR2r7NkOQ21/
XaXKbLuV6BqEaWeWTVDuZU7HdfEekXw1XhmRra7XNbCv1ODV8u2ALWUSvD+vzdYS
dGkkQeQ10UNo0+7gbpZbwhY5WaEO3xK4Z0gyKYJMH6Pz0Z2ooN2HogZvlWA+UVf+
oQd8QPYqnn6z3F4oKqq/vCaTHD0XwW471JJGgQ6aIr1rvj2wBBnrtL0i32of10cg
Ch1Hm3RpJaJgXkv3x2sPk1k8KCscMYwV2N7c64t/Fhk8DJMftAWFVNzstVJ7g9B7
nylLDGuN3uy/hQ7GLDNhRZjs505H6w==
=zik5
-----END PGP SIGNATURE-----

--=-nQ3BFmGlEsXzGK2XeTic--

