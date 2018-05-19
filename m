Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbeESHAN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 03:00:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40615 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESHAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 03:00:12 -0400
Date: Sat, 19 May 2018 09:00:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Subject: "interesting" entry in hibernation code was Re: [lkp-robot]
 [x86/asm] 51bad67ffb: int3:#[##]
Message-ID: <20180519070008.GC30676@amd>
References: <20180515080033.GA7714@yexl-desktop>
 <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2>
 <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
 <20180515224354.zmygmsnlqj5lrdbo@treble>
 <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
 <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Side note: doing some grepping, I find some other sequences that are a bit
> scary, like this:
>=20
> arch/x86/kernel/acpi/wakeup_32.S-.data
> arch/x86/kernel/acpi/wakeup_32.S-ALIGN
> arch/x86/kernel/acpi/wakeup_32.S:ENTRY(saved_magic)     .long   0
> arch/x86/kernel/acpi/wakeup_32.S:ENTRY(saved_eip)       .long   0
>=20
> so apparently people are using ENTRY() for data too (the same pattern
> exists in wakeup_64.S).
>=20
> So we end up having those odd 0x90 bytes (now 0xcc) in the data section as
> "padding" between those two values. Crazy.

Sorry about that. I'm pretty sure intention was simply to use the
variable from C code.. and ENTRY() worked. I was not aware that it has
side effect of padding...

Let me see how this can be improved... (untested).

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup=
_32.S
index 0c26b1b..d6f477f 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -89,8 +89,8 @@ ret_point:
=20
 .data
 ALIGN
-ENTRY(saved_magic)	.long	0
-ENTRY(saved_eip)	.long	0
+GLOBAL(saved_magic)	.long	0
+saved_eip:	.long	0
=20
 # saved registers
 saved_idt:	.long	0,0


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr/y3gACgkQMOfwapXb+vK5DQCgm0W/piplkNmZpougS2ZoBuo+
y4wAoL7WJcAuG3J28+jWH4zqDBbDaz+B
=/D+M
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
