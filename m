Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EC7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D9B20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D9B20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeH2Tqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:46:45 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37468 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeH2Tqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:46:45 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fv2iU-0000Ia-J9; Wed, 29 Aug 2018 11:49:10 -0400
Message-ID: <041532109326b7bd3e67087808fee9d3289f9682.camel@surriel.com>
Subject: Re: [PATCH v2] x86/nmi: Fix some races in NMI uaccess
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Date:   Wed, 29 Aug 2018 11:49:10 -0400
In-Reply-To: <CALCETrXjH175OLPRCwA8=Stbq1KmJwwvkZ36Y74=hF_i8GFWCw@mail.gmail.com>
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
         <20180828135647.6d516048@imladris.surriel.com>
         <CALCETrX2v_g_+TpX1DEZasHGi=8Y3w3ka=yYEaTxgFDnPy67nw@mail.gmail.com>
         <e9d62b33d43f99570b14c73e1519b13021ea3a95.camel@surriel.com>
         <CALCETrXjH175OLPRCwA8=Stbq1KmJwwvkZ36Y74=hF_i8GFWCw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MHChQH5XfA1BmXdm9y1S"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MHChQH5XfA1BmXdm9y1S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-08-29 at 08:36 -0700, Andy Lutomirski wrote:
> On Wed, Aug 29, 2018 at 8:17 AM, Rik van Riel <riel@surriel.com>
> wrote:
> > On Tue, 2018-08-28 at 20:46 -0700, Andy Lutomirski wrote:
> > > On Tue, Aug 28, 2018 at 10:56 AM, Rik van Riel <riel@surriel.com>
> > > wrote:
> > > > On Mon, 27 Aug 2018 16:04:16 -0700
> > > > Andy Lutomirski <luto@kernel.org> wrote:
> > > >=20
> > > > > The 0day bot is still chewing on this, but I've tested it a
> > > > > bit
> > > > > locally
> > > > > and it seems to do the right thing.
> > > >=20
> > > > Hi Andy,
> > > >=20
> > > > the version of the patch below should fix the bug we talked
> > > > about
> > > > in email yesterday.  It should automatically cover kernel
> > > > threads
> > > > in lazy TLB mode, because current->mm will be NULL, while the
> > > > cpu_tlbstate.loaded_mm should never be NULL.
> > > >=20
> > >=20
> > > That's better than mine.  I tweaked it a bit and added some
> > > debugging,
> > > and I got this:
> > >=20
> > >=20
> >=20
> >=20
https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=3D=
x86/fixes&id=3Ddd956eba16646fd0b15c3c0741269dfd84452dac
> > >=20
> > > I made the loaded_mm handling a little more conservative to make
> > > it
> > > more obvious that switch_mm_irqs_off() is safe regardless of
> > > exactly
> > > when it gets called relative to switching current.
> >=20
> > I am not convinced that the dance of writing
> > cpu_tlbstate.loaded_mm twice, with a barrier on
> > each end, is useful or necessary.
> >=20
> > At the time switch_mm_irqs_off returns, nmi_uaccess_ok()
> > will still return false, because we have not switched
> > "current" to the task that owns the next mm_struct yet.
> >=20
> > We just have to make sure to:
> > 1) Change cpu_tlbstate.loaded_mm before we manipulate
> >    CR3, and
> > 2) Change "current" only once enough of the mm stuff has
> >    been switched, __switch_to seems to get that right.
> >=20
> > Between the time switch_mm_irqs_off() sets cpu_tlbstate
> > to the next mm, and __switch_to moves() over current,
> > nmi_uaccess_ok() will return false.
>=20
> All true, but I think it stops working as soon as someone starts
> calling switch_mm_irqs_off() for some other reason, such as during
> text_poke().  And that was the original motivation for this patch.

How does calling switch_mm_irqs_off() for text_poke()
change around current->mm and cpu_tlbstate.loaded_mm?

Does current->mm stay the same throughout the entire
text_poke() chain, while cpustate.loaded_mm is the
only thing that is changed out?

If so, then yes the double assignment is indeed
necessary. Good point.

--=20
All Rights Reversed.

--=-MHChQH5XfA1BmXdm9y1S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluGwHYACgkQznnekoTE
3oNlowf/XQWXK7Q3sSPELmvzEDF/f1z9iK4Gwiuzgzv5gwJpHsTsiMCaCD6PnQiU
FnlmxBbSTVsYhW4f8KBfJq1cCO/ddx9VpMQ5ZT294f7m+CRdGrrGqb+ozccCXC/x
gdACYZxo7JludqpZ61/r2ogYnxPCa2FsEmHG0MBk5Z+I9I26UimAKHYtVAPbUegE
8pJcn+5TfTDiV7x/16YoT6Akjg7UP7feIcHP4ZBO/sdxd5ziLo9NWy3Khn8d/EVE
ycgBMKzXNMyEi5YabzImp5Vwf4ja+P7E8mGp8Dr7eEPhZDfYHH6x0HqK2ENpe+4S
zE5QbPNb9uZ3ld7NDFGtTs2vHys6BA==
=iIgu
-----END PGP SIGNATURE-----

--=-MHChQH5XfA1BmXdm9y1S--

