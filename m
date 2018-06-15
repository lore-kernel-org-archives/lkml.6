Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9127EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F5F208E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F5F208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756503AbeFOSkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:40:07 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34162 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756418AbeFOSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:40:05 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fTtdj-0003xb-07; Fri, 15 Jun 2018 14:40:03 -0400
Message-ID: <1529088002.7898.156.camel@surriel.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Date:   Fri, 15 Jun 2018 14:40:02 -0400
In-Reply-To: <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
         <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HGSaphGtUIGmRKIBrJtn"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HGSaphGtUIGmRKIBrJtn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-15 at 11:31 -0700, Andy Lutomirski wrote:
> On Fri, Jun 15, 2018 at 6:11 AM Jason A. Donenfeld <Jason@zx2c4.com>
> wrote:
> >=20
> > Hi Andy & folks,
> >=20
> > Lots of crypto routines look like this:
> >=20
> > kernel_fpu_begin();
> > encrypt();
> > kernel_fpu_end();
> >=20
> > If you call such a routine twice, you get:
> >=20
> > kernel_fpu_begin();
> > encrypt();
> > kernel_fpu_end();
> > kernel_fpu_begin();
> > encrypt();
> > kernel_fpu_end();
> >=20
> > In a loop this looks like:
> >=20
> > for (thing) {
> >   kernel_fpu_begin();
> >   encrypt(thing);
> >   kernel_fpu_end();
> > }
> >=20
> > This is obviously very bad, because begin() and end() are slow, so
> > WireGuard does the obvious:
> >=20
> > kernel_fpu_begin();
> > for (thing)
> >   encrypt(thing);
> > kernel_fpu_end();
> >=20
> > This is fine and well, and the crypto API I'm working on will
> > enable
> > this to be done in a clear way, but I do wonder if maybe this is
> > not
> > something that should be happening at the level of the caller, but
> > rather in the fpu functions themselves. Namely, what are your
> > thoughts
> > on modifying kernel_fpu_end() so that it doesn't actually restore
> > the
> > state, but just reenables preemption and marks that on the next
> > context switch, the state should be restored? Then, essentially,
> > kernel_fpu_begin() and end() become free after the first usage of
> > kernel_fpu_begin().
> >=20
> > Is this something feasible? I know that performance-wise, I'm
> > really
> > gaining a lot from hoisting those functions out of the loops, and
> > API
> > wise, it'd be slightly simpler to implement if I didn't have to all
> > for that hoisting.
>=20
> Hi Jason-
>=20
> Funny you asked.  This has been discussed a few times, although not
> quite in the form you imagined.  The idea that we've tossed around is
> to restore FPU state on return to user mode.  Roughly, we'd introduce
> a new thread flag TIF_FPU_UNLOADED (name TBD).
> prepare_exit_to_usermode() would notice this flag, copy the fpstate
> to
> fpregs, and clear the flag.  (Or maybe exit_to_usermode_loop() -- No
> one has quite thought it through, but I think it should be outside
> the
> loop.)  We'd update all the FPU accessors to understand the flag.
> We'd probably have a helper like:
>=20
> void unload_user_fpstate(void)
>=20
> that would do nothing if TIF_FPU_UNLOADED is set.  If
> TIF_FPU_UNLOADED
> is clear, it would move the state to memory and set TIF_FPU_UNLOADED.
> We'd call unload_user_fpstate() during context switch in the prev
> task
> context and in kernel_fpu_begin().
>=20
> The one major complication I know of is that PKRU is different from
> all other FPU state in that it needs to be loaded when *kernel* code
> does any user memory access.  So we'd need to make sure that context
> switches load the new task's PKRU eagerly.  Using WRPKRU is easy,
> but,
> unless we do something very clever, actually finding PKRU in the
> in-memory fpstate image may be slightly nontrivial.

IIRC the in-kernel FPU state always has every FPU field
at a constant location.

> I suppose we could eagerly load the new FPU state on context
> switches,
> but I'm not sure I see any point.  We'd still have to load it when we
> switch back to user mode, so it would be slower but not necessarily
> any simpler.
>=20
> I'd love to review patches to make this change, but I don't have the
> bandwidth to write them right now.

I can take a look at this, I am already looking at
some context switch code right now, anyway.

I also should still have the TIF_FPU_UNLOADED patches
(or whatever the flag was called) code around somewhere.

--=20
All Rights Reversed.
--=-HGSaphGtUIGmRKIBrJtn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlskCAIACgkQznnekoTE
3oMjuwf/SbbTYUatQ9ktCLm9yg78ti/RzOTxPZ25MNwDw9k8n5eUM5LBlxGYrG7o
IyNccVyzBaihjGtFNiorjyV7/p5TuAdKZEk6GZYTO7xaGSsH5XVH+tc2TpZ/I4IS
HqDtBKU6vWOcweCHtiZW9xunMLm+UBcWky1zyfAwfq14FY77OM4jpNSxKEv7bFgp
wDoHm3GCXKKv7QqmIEBm6X93Wa5jpNkxmHzKZx4VET34YMSvPVVNu6YQGMerJ5Id
0D0F2Cj3RD478xbjDC/E3lNZD7a5AEq8AA8iQvAmVDD4dKTyNDl8SHIAHP0XNbmB
OplSYr0nVHf5PtYa4oGxAfUkzQttGQ==
=g/fG
-----END PGP SIGNATURE-----

--=-HGSaphGtUIGmRKIBrJtn--

