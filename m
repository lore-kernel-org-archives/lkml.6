Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbeCLXMi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbeCLXMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:12:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A7B2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 12 Mar 2018 23:12:11 +0000
From: James Hogan <jhogan@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "Michael, Alice" <alice.michael@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>
Subject: Re: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
Message-ID: <20180312231211.GF21642@saruman>
References: <1518475021-3337-1-git-send-email-linux@roeck-us.net>
 <20180212234201.GB4290@saruman>
 <20180212235655.GC5199@roeck-us.net>
 <CD14C679C9B9B1409B02829D9B523C297C4D61@ORSMSX101.amr.corp.intel.com>
 <02874ECE860811409154E81DA85FBB5882CDAA1C@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <02874ECE860811409154E81DA85FBB5882CDAA1C@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 09:36:33PM +0000, Keller, Jacob E wrote:
> > -----Original Message-----
> > From: Michael, Alice
> > Sent: Wednesday, February 14, 2018 1:03 PM
> > To: Guenter Roeck <linux@roeck-us.net>; James Hogan <jhogan@kernel.org>;
> > Keller, Jacob E <jacob.e.keller@intel.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>; linux-mips@linux-mips.org; linu=
x-
> > kernel@vger.kernel.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com=
>; Shannon
> > Nelson <shannon.nelson@oracle.com>
> > Subject: RE: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
> >=20
> > As has previously been said, we're going to be removing the need for cm=
pxchg64.
> > But it takes a little bit of time and work to do so.  I'm adding the de=
v that is taking
> > care of the work back onto this email thread as well so he can see any =
concerns with
> > it.
> >=20
> > Alice
> >=20
> > -----Original Message-----
> > From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roe=
ck
> > Sent: Monday, February 12, 2018 3:57 PM
> > To: James Hogan <jhogan@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>; linux-mips@linux-mips.org; linu=
x-
> > kernel@vger.kernel.org; Michael, Alice <alice.michael@intel.com>; Kirsh=
er, Jeffrey T
> > <jeffrey.t.kirsher@intel.com>; Shannon Nelson <shannon.nelson@oracle.co=
m>
> > Subject: Re: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
> >=20
> > On Mon, Feb 12, 2018 at 11:42:02PM +0000, James Hogan wrote:
> > > Hi Guenter,
> > >
> > > On Mon, Feb 12, 2018 at 02:37:01PM -0800, Guenter Roeck wrote:
> > > > Since commit 60f481b970386 ("i40e: change flags to use 64 bits"),
> > > > the i40e driver uses cmpxchg64(). This causes mips:allmodconfig
> > > > builds to fail with
> > > >
> > > > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
> > > > 	In function 'i40e_set_priv_flags':
> > > > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4443:2: error:
> > > > 	implicit declaration of function 'cmpxchg64'
> > > >
> > > > Implement a poor-mans-version of cmpxchg64() to fix the problem for
> > > > 32-bit mips builds. The code is derived from sparc32, but only uses
> > > > a single spinlock.
> > >
> > > Will this be implemened for all 32-bit architectures which are
> > > currently missing cmpxchg64()?
> > >
> > No idea.
> >=20
> > > If so, any particular reason not to do it in generic code?
> > >
> > Again, no idea. When the problem was previously seen on sparc32, it was
> > implemented there.
> >=20
> > > If not then I think that driver should be fixed to either depend on
> > > some appropriate Kconfig symbol or to not use this API since it
> > > clearly isn't portable at the moment.
> > >
> > Good point.
> >=20
> > > See also Shannon's comment about that specific driver:
> > > https://lkml.kernel.org/r/e7c934d7-e5f4-ee1b-0647-c31a98d9e944@oracle.
> > > com
> > >
> >=20
> > Well, this was an RFC only. Feel free to ignore it.
> >=20
> > FWIW, this is the second time that the call was introduced in the i40 d=
river.
> > After the first time the code was rewritten to avoid the problem, but n=
ow it came
> > back. Someone must really like it ;-). For my part, I may just blacklis=
t the offending
> > driver in my builds; that is less than perfect, but much easier than ha=
ving to deal with
> > the same problem over and over again. Guess I'll wait for a while and d=
o just that if
> > the problem isn't fixed in a later RC.
> >=20
> > Guenter
>=20
> Hi,
>=20
> I've been working on re-writing some of the code so that the need for a c=
ompare-and-exchange in the i40e_set_priv_flags() is not necessary. This mos=
tly involved moving many flags out into an atomic bitops field instead, it =
should be posted to IWL soon.

Any update on this? Will a fix to the driver make it into 4.16 or is it
going to be too big a change?

As far as I can tell from grepping around, of the architectures which
support 32-bit SMP with PCI, these ones implement cmpxchg64 on 32-bit:

arch/arm
arch/ia64
arch/x86
arch/riscv (blindly implements using 64-bit instructions, broken?)
arch/parisc (with spinlock)
arch/sparc (with spinlock)

And these don't:

arch/arc
arch/mips
arch/powerpc
arch/sh
arch/xtensa

(I've excluded arches which are already being removed)

Cheers
James

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqnCUoACgkQbAtpk944
dnpCww/8CMyW684xDLU8KR1rinwnLH8gC5pisFMuCsYszz09+p0dfhcZq6blGj0/
yWzY6otfKnEArp224WULyD8MGDymtWYjvLgLeysyNOiKwwhFfUI3HymLUyr0A5BG
VKnZiXrm9RyK1F3wgpDnGIcPEn1FuZOJShvBaqNoKkRpnrJ6rmClCQe2co01kOHr
wuf89irWRy6A5T1wDMUOesQKz3Zc7FZbb8PbQDU1rPHKvCIpSIPqvlCO5qdBHh6X
Oc5tlpc+j2GCGW2GpfyYzRLT3tjKyvYVTVg4uNvH2cSaRdX43S8EFtObkpFKOzwX
2FIqPPdocoT+7KnPmHI8Is3YjUgRfhodCvNUrgi9/EF+My2ut/6EODsUTKrkB6Sg
zYg2esqZ2JUGHmobHnk4UbX1EFNC9M/S2gx3bbuIL7JXYgp+8EqbHvZiMRZucHZ6
0HWLWCOMn/ZuRfhesswvSX1qW8btTUZhSF7xF0I1yKjnD19+mN8B8L70HU/RxFmo
3k9a4s6iIQgr2lycj3II9FhW3HR6eIjU8dbYXZGwVD7ijqu29GBNSiRRslNz/6pF
mw5XAtzPrJrAB9Ar/I/tdcV8Rt0CPE1qyWToEAqzo70aEZHby6/xon6OD/LQ50kc
KCxRyL038IaX65gJlidCyVGle0grv5QvhTV0Ql/7mIcoWpyqD3k=
=+h2q
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
