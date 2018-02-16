Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423013AbeBPAWY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:22:24 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:45442 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422716AbeBPAWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:22:23 -0500
X-Google-Smtp-Source: AH8x224fPI6KzSDH/Jh1myRAd3SaoxOGSW1oJAjK9P9oZSOyWaJgB9Q660xSJSWpWY6GT2khaRAuEA==
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <B723A40E-EFA4-4CCE-80F6-65960213761F@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_530BEB66-AC1A-415E-86FC-5727FF7DFE2D";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC v2 4/6] x86: Disable PTI on compatibility mode
Date: Thu, 15 Feb 2018 16:22:17 -0800
In-Reply-To: <CA+55aFypED6i6pESAnk_RPUon_cyvdP3g-QZg2gspEBNAQWvmQ@mail.gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@parallels.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-5-namit@vmware.com>
 <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com>
 <9EB804CA-0EC9-4CBB-965A-F3C8520201E7@gmail.com>
 <CALCETrVP3BaOapL3eS8Tf=KFeM8VFPqvMoECGRkFa7WPLq=Asw@mail.gmail.com>
 <CA+55aFypED6i6pESAnk_RPUon_cyvdP3g-QZg2gspEBNAQWvmQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_530BEB66-AC1A-415E-86FC-5727FF7DFE2D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Feb 15, 2018 at 3:29 PM, Andy Lutomirski <luto@kernel.org> =
wrote:
>> It's possible we could get away with adding the prctl but making the
>> default be that only the bitness that matches the program being run =
is
>> allowed.  After all, it's possible that CRIU is literally the only
>> program that switches bitness using the GDT.  (DOSEMU2 definitely =
does
>> cross-bitness stuff, but it uses the LDT as far as I know.)  And I've
>> never been entirely sure that CRIU fully counts toward the Linux
>> "don't break ABI" guarantee.
>=20
> Ugh.
>=20
> There are just _so_ many reasons to dislike that.
>=20
> It's not that I don't think we could try to encourage it, but this
> whole "security depends on it being in sync" seems really like a
> fundamentally bad design.
>=20
>> Linus, how would you feel about, by default, preventing 64-bit
>> programs from long-jumping to __USER32_CS and vice versa?
>=20
> How? It's a standard GDT entry. Are you going to start switching the
> GDT around every context switch?
>=20
> I *thought* that user space can just do a far jump on its own. But
> it's so long since I had to care that I may have forgotten all the
> requirements for going between "compatibility mode" and real long
> mode.
>=20
> I just feel this all is a nightmare. I can see how you would want to
> think that compatibility mode doesn't need PTI, but at the same time
> it feels like a really risky move to do this.
>=20
> I can see one thread being in compatibiilty mode, and another being in
> long mode, and sharing the address space. But even with just one
> thread, I'm not seeing how you keep user mode from going from
> compatibility mode to L mode with just a far jump.
>=20
> But maybe you have some clever scheme in mind that guarantees that
> there are no issues, or maybe I've just forgotten all the details of
> long mode vs compat mode.

It is not too pretty, I agree, but it should do the work. There is only =
one
problematic descriptor that can be used to switch from =
compatibility-mode to
long-mode in the GDT (LDT descriptors always have the L-bit cleared).
Changing the descriptor's present bit on context switch when needed can =
do
the work.

I tried to do it transparently, and if long-mode is entered, by any =
thread,
restore PTI. There is one corner case I did not cover (LAR) and Andy =
felt
this scheme is too complicated. Unfortunately, I don=E2=80=99t have a =
better scheme
in mind.


--Apple-Mail=_530BEB66-AC1A-415E-86FC-5727FF7DFE2D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE0YCJM4pMIpzxUdmOK4dOkxJsY0AFAlqGJDkACgkQK4dOkxJs
Y0CMxRAA2JOCasXtFF9WAdCuTiKnLh2sQNY64ztpEnZL2cXoyl6QFetHK1vgq9vT
+qzDs5zRjoFgseNXj11ARVwt5SJky+d2CT2vp2FPJBmBDgvZ5hDtcoUmnk5v1ur3
WNYqIO1qMEnd7k27x4AGaknOU3eHJCOvvrYyI9tHfeTw40wYIXxDzkcH886+56f8
/xVYq/q6JGfX44ndyW/bDLLdzbZjIUNEXlVuyAHpeptVzP7ij4fG31hpL3XLJ7oJ
ZD7w6lTavTNvsya0f88ctPe2prAcTIxuWaew2SPJetdh5Las/zCF5K6e6OHlnRg5
W0c5DVDY3FNMWjEJkmxeax48PgI3Vjrl518wpxvNGf6RKKwrVXXeCxctpM7I5mq3
ox1FXs4ea/t4gF6akUWH2wseuQglHD6teRoTKoJj5La8yAwynfUFEKbCcjL4iQSR
yGXmHrHPlr3dIV8WyU4eHdkAPjKIOTtWZCtGgsvr0aJSd88j/R75MTWcBfFKEbLA
F4WlzXvQpltdI0uqBJjJgZeL6AcppR81OUrbUEFYsh7FB8PqHgwM79uVTyG4km1Q
hm/8qnk8cCQ6P5w6yJm2nM/3zZd6tD/oFDm6XLKy87XlGOCKIMyo9rmFk5raci04
0x272gIhwbMP7hqOkiSWNT7qW1MP2a2yKV3J8dDagOvI4WCOiOM=
=gOjl
-----END PGP SIGNATURE-----

--Apple-Mail=_530BEB66-AC1A-415E-86FC-5727FF7DFE2D--
